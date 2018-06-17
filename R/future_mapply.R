#' Apply a Function to Multiple List or Vector Arguments
#'
#' `future_mapply()` implements [base::mapply()] using futures, where
#' `mapply()` is a multivariate version of `sapply()`.
#' It applies `FUN` to the first elements of each \ldots argument,
#' the second elements, the third elements, and so on.
#' Arguments are recycled if necessary.
#' 
#' @inheritParams future_lapply
#' 
#' @param FUN  A function to apply, found via [base::match.fun()].
#' 
#' @param \ldots  Arguments to vectorize over (vectors or lists of strictly
#' positive length, or all of zero length).
#'
#' @param MoreArgs  A list of other arguments to `FUN`.
#'
#' @param SIMPLIFY  A logical or character string; attempt to reduce the
#' result to a vector, matrix or higher dimensional array; see the simplify
#' argument of [base::sapply()].
#' 
#' @param USE.NAMES A logical; use names if the first \ldots argument has
#' names, or if it is a character vector, use that character vector as the
#' names.
#'
#' @return
#' `future_mapply() returns a list, or for `SIMPLIFY = TRUE`, a vector,
#' array or list.  See [base::mapply()] for details.
#'
#' @example incl/future_mapply.R
#'
#' @keywords manip programming iteration
#'
#' @importFrom globals globalsByName
#' @importFrom future future resolve values as.FutureGlobals nbrOfWorkers getGlobalsAndPackages FutureError
#' @importFrom utils capture.output head str
#' @export
future_mapply <- function(FUN, ..., MoreArgs = NULL, SIMPLIFY = TRUE, USE.NAMES = TRUE, future.globals = TRUE, future.packages = NULL, future.seed = FALSE, future.lazy = FALSE, future.scheduling = 1.0, future.chunk.size = NULL) {
  objectSize <- import_future("objectSize")
  
  FUN <- match.fun(FUN)
  stop_if_not(is.function(FUN))

  dots <- list(...)
  
  ## Nothing to do?
  if (length(dots) == 0L) return(list())
  
  ns <- lengths(dots)
  
  ## Nothing to do?
  if (all(ns == 0L)) return(list())

  stop_if_not(all(ns > 0L))
  
  ## Recycle?
  nX <- max(ns)
  stretch <- which(ns < nX)
  if (length(stretch) > 0L) {
    for (kk in stretch) dots[[kk]] <- rep(dots[[kk]], length.out = nX)
    ns <- lengths(dots)
  }
  stop_if_not(all(ns == nX))
  
  stop_if_not(is.null(MoreArgs) || is.list(MoreArgs))

  stop_if_not(is.logical(future.lazy))

  stop_if_not(!is.null(future.seed))
  
  stop_if_not(length(future.scheduling) == 1, !is.na(future.scheduling),
            is.numeric(future.scheduling) || is.logical(future.scheduling))

  debug <- getOption("future.debug", FALSE)
  
  if (debug) mdebug("future_mapply() ...")

  ## NOTE TO SELF: We'd ideally have a 'future.envir' argument also for
  ## future_mapply(), cf. future().  However, it's not yet clear to me how
  ## to do this, because we need to have globalsOf() to search for globals
  ## from the current environment in order to identify the globals of 
  ## arguments 'FUN' and '...'. /HB 2017-03-10
  future.envir <- environment()  ## Not used; just to clarify the above.
  
  envir <- future.envir
  
  ## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  ## 1. Global variables
  ## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  ## The default is to gather globals
  if (is.null(future.globals)) future.globals <- TRUE

  packages <- NULL
  globals <- future.globals
  scanForGlobals <- FALSE
  if (is.logical(globals)) {
    ## Gather all globals?
    if (globals) {
      if (debug) mdebug("Finding globals ...")
      scanForGlobals <- TRUE
      expr <- do.call(call, args = c(list("FUN"), MoreArgs))
      gp <- getGlobalsAndPackages(expr, envir = envir, globals = TRUE)
      globals <- gp$globals
      packages <- gp$packages
      gp <- NULL
      
      if (debug) {
        mdebug(" - globals found: [%d] %s", length(globals), hpaste(sQuote(names(globals))))
        mdebug(" - needed namespaces: [%d] %s", length(packages), hpaste(sQuote(packages)))
        mdebug("Finding globals ... DONE")
      }
    } else {
      ## globals = FALSE
      globals <- c("FUN", "MoreArgs", "...")
      globals <- globalsByName(globals, envir = envir, mustExist = FALSE)
    }
  } else if (is.character(globals)) {
    globals <- unique(c(globals, "FUN", "MoreArgs", "..."))
    globals <- globalsByName(globals, envir = envir, mustExist = FALSE)
  } else if (is.list(globals)) {
    names <- names(globals)
    if (length(globals) > 0 && is.null(names)) {
      stop("Invalid argument 'future.globals'. All globals must be named.")
    }
  } else {
    stop("Invalid argument 'future.globals': ", mode(globals))
  }
  globals <- as.FutureGlobals(globals)
  stop_if_not(inherits(globals, "FutureGlobals"))
  
  names <- names(globals)
  if (!is.element("FUN", names)) {
    globals <- c(globals, FUN = FUN)
  }
  if (!is.element("MoreArgs", names)) {
    globals <- c(globals, list(MoreArgs = MoreArgs))
  }
  
  if (!is.element("...", names)) {
    if (debug) mdebug("Getting '...' globals ...")
    dotdotdot <- globalsByName("...", envir = envir, mustExist = TRUE)
    dotdotdot <- as.FutureGlobals(dotdotdot)
    dotdotdot <- resolve(dotdotdot)
    attr(dotdotdot, "total_size") <- objectSize(dotdotdot)
    if (debug) mdebug("Getting '...' globals ... DONE")
    globals <- c(globals, dotdotdot)
  }

  ## Assert there are no reserved variables names among globals
  reserved <- intersect(c("...future.FUN", "...future.dots_ii",
                          "...future.seeds_ii"), names)
  if (length(reserved) > 0) {
    stop("Detected globals using reserved variables names: ",
         paste(sQuote(reserved), collapse = ", "))
  }
 
  ## Avoid FUN() clash with mapply(..., FUN) below.
  names <- names(globals)
  names[names == "FUN"] <- "...future.FUN"
  names(globals) <- names

  if (debug) {
    mdebug("Globals to be used in all futures (excluding any globals in '...'):")
    mdebug(paste(capture.output(str(globals)), collapse = "\n"))
  }
  

  ## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  ## 2. Packages
  ## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  if (!is.null(future.packages)) {
    stop_if_not(is.character(future.packages))
    future.packages <- unique(future.packages)
    stop_if_not(!anyNA(future.packages), all(nzchar(future.packages)))
    packages <- unique(c(packages, future.packages))
  }
  
  if (debug) {
    mdebug("Packages to be attached in all futures:")
    mdebug(paste(capture.output(str(packages)), collapse = "\n"))
  }


  ## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  ## 3. Reproducible RNG (for sequential and parallel processing)
  ## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  seeds <- make_rng_seeds(nX, seed = future.seed, debug = debug)
  
  ## If RNG seeds are used (given or generated), make sure to reset
  ## the RNG state afterward
  if (!is.null(seeds)) {
    oseed <- next_random_seed()
    on.exit(set_random_seed(oseed))
  }

  
  ## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  ## 4. Load balancing ("chunking")
  ## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  chunks <- makeChunks(nX, nbrOfWorkers = nbrOfWorkers(),
                       scheduling = future.scheduling,
                       chunkSize = future.chunk.size)
  if (debug) mdebug("Number of chunks: %d", length(chunks))
  
  
  ## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  ## 5. Create futures
  ## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  ## Add argument placeholders
  globals_extra <- as.FutureGlobals(list(...future.dots_ii = NULL, ...future.seeds_ii = NULL))
  attr(globals_extra, "resolved") <- TRUE
  attr(globals_extra, "total_size") <- 0
  globals <- c(globals, globals_extra)

  ## At this point a globals should be resolved and we should know their total size
##  stop_if_not(attr(globals, "resolved"), !is.na(attr(globals, "total_size")))

    ## To please R CMD check
  ...future.FUN <- ...future.dots_ii <- ...future.seeds_ii <- NULL

  nchunks <- length(chunks)
  fs <- vector("list", length = nchunks)
  if (debug) mdebug("Number of futures (= number of chunks): %d", nchunks)
  
  if (debug) mdebug("Launching %d futures (chunks) ...", nchunks)
  for (ii in seq_along(chunks)) {
    chunk <- chunks[[ii]]
    if (debug) mdebug("Chunk #%d of %d ...", ii, length(chunks))
    ## Subsetting outside future is more efficient
    
    dots_ii <- lapply(dots, FUN = .subset, chunk)
    globals_ii <- globals
    ## Subsetting outside future is more efficient
    globals_ii[["...future.dots_ii"]] <- dots_ii
    packages_ii <- packages

    if (scanForGlobals) {
      ## Search for globals in 'dots_ii':
      gp <- getGlobalsAndPackages(dots_ii, envir = envir, globals = TRUE)
      globals_dots <- gp$globals
      packages_dots <- gp$packages
      gp <- NULL

      if (debug) {
        mdebug(" - globals found in '...' for chunk #%d: [%d] %s", chunk, length(globals_dots), hpaste(sQuote(names(globals_dots))))
        mdebug(" - needed namespaces for '...' for chunk #%d: [%d] %s", chunk, length(packages_dots), hpaste(sQuote(packages_dots)))
      }
    
      ## Export also globals found in 'dots_ii'
      if (length(globals_dots) > 0L) {
        reserved <- intersect(c("...future.FUN", "...future.dots_ii",
                                "...future.seeds_ii"), names(globals_dots))
        if (length(reserved) > 0) {
          stop("Detected globals using reserved variables names: ",
               paste(sQuote(reserved), collapse = ", "))
        }
        globals_dots <- as.FutureGlobals(globals_dots)
        globals_ii <- unique(c(globals_ii, globals_dots))

        ## Packages needed due to globals in 'dots_ii'?
        if (length(packages_dots) > 0L)
          packages_ii <- unique(c(packages_ii, packages_dots))
      }
    }
    

##    stop_if_not(attr(globals_ii, "resolved"))
    
    ## Using RNG seeds or not?
    if (is.null(seeds)) {
      if (debug) mdebug(" - seeds: <none>")
      fs[[ii]] <- future({
        args <- c(list(FUN = ...future.FUN), ...future.dots_ii, MoreArgs = list(MoreArgs), SIMPLIFY = FALSE, USE.NAMES = FALSE)
        res <- do.call(mapply, args = args)
        res
      }, envir = envir, lazy = future.lazy, globals = globals_ii, packages = packages_ii)
    } else {
      if (debug) mdebug(" - seeds: [%d] <seeds>", length(chunk))
      globals_ii[["...future.seeds_ii"]] <- seeds[chunk]
      fs[[ii]] <- future({
        ...future.FUN2 <- function(..., ...future.seeds_ii_jj) {
          assign(".Random.seed", ...future.seeds_ii_jj, envir = globalenv(), inherits = FALSE)
          ...future.FUN(...)
        }
        args <- c(list(FUN = ...future.FUN2), ...future.dots_ii, list(...future.seeds_ii_jj = ...future.seeds_ii), MoreArgs, SIMPLIFY = FALSE, USE.NAMES = FALSE)
        do.call(mapply, args = args)
      }, envir = envir, lazy = future.lazy, globals = globals_ii, packages = packages_ii)
    }
    
    ## Not needed anymore
    rm(list = c("chunk", "globals_ii"))

    if (debug) mdebug("Chunk #%d of %d ... DONE", ii, nchunks)
  } ## for (ii ...)
  if (debug) mdebug("Launching %d futures (chunks) ... DONE", nchunks)

  ## Not needed anymore
  rm(list = c("chunks", "globals", "envir"))

  ## 4. Resolving futures
  if (debug) mdebug("Resolving %d futures (chunks) ...", nchunks)
  
  values <- values(fs)
  ## Not needed anymore
  rm(list = "fs")

  if (debug) {
    mdebug(" - Number of value chunks collected: %d", length(values))
    mdebug("Resolving %d futures (chunks) ... DONE", nchunks)
  }

  ## Sanity check
  stop_if_not(length(values) == nchunks)
  
  if (debug) mdebug("Reducing values from %d chunks ...", nchunks)
  values2 <- do.call(c, args = values)
  
  if (debug) {
    mdebug(" - Number of values collected after concatenation: %d",
           length(values2))
    mdebug(" - Number of values expected: %d", nX)
  }

  if (length(values2) != nX) {
    chunk_sizes <- sapply(values, FUN = length)
    chunk_sizes <- table(chunk_sizes)
    chunk_summary <- sprintf("%d chunks with %s elements",
                             chunk_sizes, names(chunk_sizes))
    chunk_summary <- paste(chunk_summary, collapse = ", ")
    msg <- sprintf("Unexpected error in future_mapply(): After gathering and merging the values from %d chunks in to a list, the total number of elements (= %d) does not match the number of input elements in 'X' (= %d). There were in total %d chunks and %d elements (%s)", nchunks, length(values2), nX, nchunks, sum(chunk_sizes), chunk_summary)
    if (debug) {
      mdebug(msg)
      message(capture.output(print(chunk_sizes)))
      mdebug("Results before merge chunks:")
      message(capture.output(str(values)))
      mdebug("Results after merge chunks:")
      message(capture.output(str(values2)))
    }
    msg <- sprintf("%s. Example of the first few values: %s", msg,
                   paste(capture.output(str(head(values2, 3L))),
                         collapse = "\\n"))
    ex <- FutureError(msg)
    stop(ex)
  }
  values <- values2
  rm(list = "values2")
  
  ## Sanity check (this may happen if the future backend is broken)
  stop_if_not(length(values) == nX)
#  names(values) <- names(X)

  if (USE.NAMES && length(dots) > 0L) {
    if (is.null(names1 <- names(dots[[1L]])) && is.character(dots[[1L]])) {
      names(values) <- dots[[1L]]
    } else if (!is.null(names1)) {
      names(values) <- names1
    }
  }

  if (!isFALSE(SIMPLIFY) && length(values) > 0L) {
    values <- simplify2array(values, higher = (SIMPLIFY == "array"))
  } 
  
  if (debug) mdebug("Reducing values from %d chunks ... DONE", nchunks)
  
  if (debug) mdebug("future_mapply() ... DONE")
  
  values
}
