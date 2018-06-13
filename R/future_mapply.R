#' Apply a Function to Multiple List or Vector Arguments
#'
#' future_mapply()` is a multivariate version of `future_sapply().
#' It applies `FUN` to the first elements of each \ldots argument,
#' the second elements, the third elements, and so on.
#' Arguments are recycled if necessary.
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
#' @param future.globals A logical, a character vector, or a named list for
#'        controlling how globals are handled. For details, see below section.
#'
#' @param future.packages (optional) a character vector specifying packages
#'        to be attached in the R environment evaluating the future.
#' 
#' @param future.seed A logical or an integer (of length one or seven),
#'        or a list of `length(X)` with pre-generated random seeds.
#'        For details, see below section.
#'  
#' @param future.lazy Specifies whether the futures should be resolved
#'        lazily or eagerly (default).
#' 
#' @param future.scheduling Average number of futures ("chunks") per worker.
#'        If `0.0`, then a single future is used to process all elements
#'        of `X`.
#'        If `1.0` or `TRUE`, then one future per worker is used.
#'        If `2.0`, then each worker will process two futures
#'        (if there are enough elements in `X`).
#'        If `Inf` or `FALSE`, then one future per element of
#'        `X` is used.
#'
#' @return
#' A list, or for `SIMPLIFY = TRUE`, a vector, array or list.
#' See [base::sapply()] for details.
#'
#' @example incl/future_mapply.R
#'
#' @keywords manip programming iteration
#'
#' @importFrom globals globalsByName cleanup
#' @importFrom future future resolve values as.FutureGlobals nbrOfWorkers getGlobalsAndPackages FutureError
#' @importFrom parallel nextRNGStream nextRNGSubStream splitIndices
#' @importFrom utils capture.output head str
#' @export
future_mapply <- function(FUN, ..., MoreArgs = NULL, SIMPLIFY = TRUE, USE.NAMES = TRUE, future.globals = TRUE, future.packages = NULL, future.seed = FALSE, future.lazy = FALSE, future.scheduling = 1.0) {
  objectSize <- import_future("objectSize")
  
  FUN <- match.fun(FUN)
  stop_if_not(is.function(FUN))

  dots <- list(...)
  stop_if_not(length(dots) > 0L)
  ns <- lengths(dots)
  
  ## Nothing to do?
  if (all(ns == 0L)) {
    return(list())
  }
  stop_if_not(all(ns > 1L))
  
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
  if (is.logical(globals)) {
    ## Gather all globals?
    if (globals) {
      if (debug) mdebug("Finding globals ...")

      expr <- do.call(call, args = c(list("FUN"), dots, MoreArgs))
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
      globals <- c("FUN", "MoreArgs", names(dots), "...")
      globals <- globalsByName(globals, envir = envir, mustExist = FALSE)
    }
  } else if (is.character(globals)) {
    globals <- unique(c(globals, "FUN", "MoreArgs", names(dots), "..."))
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
    mdebug("Globals to be used in all futures:")
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
  seed <- future.seed

  ## Placeholder for all RNG stream seeds.
  seeds <- NULL
  
  ## Don't use RNGs? (seed = FALSE)
  if (is.logical(seed) && !is.na(seed) && !seed) seed <- NULL

  # Use RNGs?
  if (!is.null(seed)) {
    if (debug) mdebug("Generating random seeds ...")

    ## future_mapply() should return with the same RNG state regardless of
    ## future strategy used. This is be done such that RNG kind is preserved
    ## and the seed is "forwarded" one step from what it was when this
    ## function was called. The forwarding is done by generating one random
    ## number. Note that this approach is also independent on nX and
    ## the diffent FUN() calls.
    oseed <- next_random_seed()
    on.exit(set_random_seed(oseed))    

    ## A pregenerated sequence of random seeds?
    if (is.list(seed)) {
      if (debug) mdebug("Using a pre-define stream of random seeds ...", nX)
      
      nseed <- length(seed)
      if (nseed != nX) {
        stop("Argument 'seed' is a list, which specifies the sequence of seeds to be used for each subelement in '...', but length(seed) != nX: ", nseed, " != ", nX)
      }

      ## Assert same type of RNG seeds?
      ns <- unique(unlist(lapply(seed, FUN = length), use.names = FALSE))
      if (length(ns) != 1) {
        stop("The elements of the list specified in argument 'seed' are not all of the same lengths (did you really pass RNG seeds?): ", hpaste(ns))
      }

      ## Did use specify scalar integers as meant for set.seed()?
      if (ns == 1L) {
        stop("Argument 'seed' is invalid. Pre-generated random seeds must be valid .Random.seed seeds, which means they should be all integers and consists of two or more elements, not just one.")
      }

      types <- unlist(lapply(seed, FUN = typeof), use.names = FALSE)
      if (!all(types == "integer")) {
        stop("The elements of the list specified in argument 'seed' are not all integers (did you really pass RNG seeds?): ", hpaste(unique(types)))
      }
      
      ## Check if valid random seeds are specified.
      ## For efficiency, only look at the first one.
      if (!is_valid_random_seed(seed[[1]])) {
        stop("The list in argument 'seed' does not seem to hold elements that are valid .Random.seed values: ", capture.output(str(seeds[[1]])))
      }

      seeds <- seed
      
      if (debug) mdebug("Using a pre-define stream of random seeds ... DONE", nX)
    } else {
      if (debug) mdebug("Generating random seed streams for %d elements ...", nX)
      
      ## Generate sequence of _all_ RNG seeds starting with an initial seed
      ## '.seed' that is based on argument 'seed'.
      .seed <- as_lecyer_cmrg_seed(seed)

      seeds <- vector("list", length = nX)
      for (ii in seq_len(nX)) {
        ## RNG substream seed used in call FUN(x[[ii]], y[[ii]], ...):
        ## This way each future can in turn generate further seeds, also
        ## recursively, with minimal risk of generating the same seeds as
        ## another future. This should make it safe to recursively call
        ## future_mapply(). /HB 2017-01-11
        seeds[[ii]] <- nextRNGSubStream(.seed)
        
        ## Main random seed for next iteration (= ii + 1)
        .seed <- nextRNGStream(.seed)
      }
  
      if (debug) mdebug("Generating random seed streams for %d elements ... DONE", nX)
    }
    
    if (debug) mdebug("Generating random seeds ... DONE")
  } ## if (!is.null(seed))

  
  ## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  ## 4. Load balancing ("chunking")
  ## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  if (is.logical(future.scheduling)) {
    if (future.scheduling) {
      nbr_of_futures <- nbrOfWorkers()
      if (nbr_of_futures > nX) nbr_of_futures <- nX
    } else {
      nbr_of_futures <- nX
    }
  } else {
    ## Treat 'future.scheduling' as the number of futures per worker.
    stop_if_not(future.scheduling >= 0)
    nbr_of_workers <- nbrOfWorkers()
    if (nbr_of_workers > nX) nbr_of_workers <- nX
    nbr_of_futures <- future.scheduling * nbr_of_workers
    if (nbr_of_futures < 1) {
      nbr_of_futures <- 1L
    } else if (nbr_of_futures > nX) {
      nbr_of_futures <- nX
    }
  }

  chunks <- splitIndices(nX, ncl = nbr_of_futures)
  if (debug) mdebug("Number of chunks: %d", length(chunks))
#  str(list(nX = nX, nbr_of_futures = nbr_of_futures, chunks = chunks))
  
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
#    str(list(chunk = chunk, dots = dots))
    ## Subsetting outside future is more efficient
    globals_ii <- globals
    ...future.dots_ii <- lapply(dots, FUN = .subset, chunk)
#    str(list(...future.dots_ii = ...future.dots_ii))
    globals_ii[["...future.dots_ii"]] <- ...future.dots_ii
    ...future.dots_ii <- NULL
##    stop_if_not(attr(globals_ii, "resolved"))
    
    ## Using RNG seeds or not?
    if (is.null(seeds)) {
      if (debug) mdebug(" - seeds: <none>")
      fs[[ii]] <- future({
        args <- c(list(FUN = ...future.FUN), ...future.dots_ii, MoreArgs, SIMPLIFY = FALSE, USE.NAMES = FALSE)
        do.call(mapply, args = args)
      }, envir = envir, lazy = future.lazy, globals = globals_ii, packages = packages)
    } else {
      if (debug) mdebug(" - seeds: [%d] <seeds>", length(chunk))
      globals_ii[["...future.seeds_ii"]] <- seeds[chunk]
      fs[[ii]] <- future({
        lapply(seq_along(...future.dots_ii[[1L]]), FUN = function(jj) {
           ...future.dots_jj <- ...future.dots_ii[[jj]]
           assign(".Random.seed", ...future.seeds_ii[[jj]], envir = globalenv(), inherits = FALSE)
           ## FIXME: Add MoreArgs
           do.call(...future.FUN, args = list(...future.dots_jj))
        })
      }, envir = envir, lazy = future.lazy, globals = globals_ii, packages = packages)
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

 isFALSE <- function(x) is.logical(x) && length(x) == 1L && !is.na(x) && !x
  
  if (!isFALSE(SIMPLIFY) && length(values) > 0L) {
    values <- simplify2array(values, higher = (SIMPLIFY == "array"))
  } 
  
  if (debug) mdebug("Reducing values from %d chunks ... DONE", nchunks)
  
  if (debug) mdebug("future_mapply() ... DONE")
  
  values
}
