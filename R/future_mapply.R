#' Apply a Function to Multiple List or Vector Arguments
#'
#' `future_mapply()` implements [base::mapply()] using futures with perfect
#' replication of results, regardless of future backend used.
#' Analogously to `mapply()`, `future_mapply()` is a multivariate version of
#' `future_sapply()`.
#' It applies `FUN` to the first elements of each `\ldots` argument,
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
#' @param USE.NAMES A logical; use names if the first `\ldots` argument has
#' names, or if it is a character vector, use that character vector as the
#' names.
#'
#' @param future.globals A logical, a character vector, or a named list for
#'        controlling how globals are handled.
#'        For details, see [future_lapply()].
#'
#' @param future.seed A logical or an integer (of length one or seven), or
#'        a list of `max(lengths(list(...)))` with pre-generated random seeds.
#'        For details, see [future_lapply()].
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
#' @importFrom future Future future resolve values as.FutureGlobals nbrOfWorkers getGlobalsAndPackages FutureError
#' @importFrom utils head str
#' @export
future_mapply <- function(FUN, ..., MoreArgs = NULL, SIMPLIFY = TRUE, USE.NAMES = TRUE, future.stdout = TRUE, future.conditions = NULL, future.globals = TRUE, future.packages = NULL, future.lazy = FALSE, future.seed = FALSE, future.scheduling = 1.0, future.chunk.size = NULL) {
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

  stop_if_not(is.logical(future.stdout), length(future.stdout) == 1L)

  ## FIXME: Memoize the result
  if (is.null(future.conditions)) {
    future.conditions <- eval(formals(Future)[["conditions"]])
  }
  
  stop_if_not(is.logical(future.lazy), length(future.lazy) == 1L)

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
  ## 1. Globals and Packages
  ## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  gp <- getGlobalsAndPackagesXApply(FUN = FUN,
                                    MoreArgs = MoreArgs,
                                    envir = envir,
                                    future.globals = future.globals,
                                    future.packages = future.packages,
                                    debug = debug)
  packages <- gp$packages
  globals <- gp$globals
  scanForGlobals <- gp$scanForGlobals
  gp <- NULL

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
  chunks <- makeChunks(nX,
                       nbrOfWorkers = nbrOfWorkers(),
                       future.scheduling = future.scheduling,
                       future.chunk.size = future.chunk.size)
  if (debug) mdebugf("Number of chunks: %d", length(chunks))
  
  ## Process elements in a custom order?
  ordering <- attr(chunks, "ordering")
  if (!is.null(ordering)) {
    if (debug) mdebugf("Index remapping (attribute 'ordering'): [n = %d] %s", length(ordering), hpaste(ordering))
    chunks <- lapply(chunks, FUN = function(idxs) .subset(ordering, idxs))
  }


  ## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  ## 5. Create futures
  ## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  ## Add argument placeholders
  globals_extra <- as.FutureGlobals(list(
    ...future.elements_ii = NULL,
    ...future.seeds_ii = NULL,
    ...future.globals.maxSize = NULL
  ))
  attr(globals_extra, "resolved") <- TRUE
  attr(globals_extra, "total_size") <- 0
  globals <- c(globals, globals_extra)

  ## At this point a globals should be resolved and we should know their total size
##  stop_if_not(attr(globals, "resolved"), !is.na(attr(globals, "total_size")))

  ## To please R CMD check
  ...future.FUN <- ...future.elements_ii <- ...future.seeds_ii <-
                   ...future.globals.maxSize <- NULL

  globals.maxSize <- getOption("future.globals.maxSize")
  globals.maxSize.default <- globals.maxSize
  if (is.null(globals.maxSize.default)) globals.maxSize.default <- 500 * 1024^2
  
  nchunks <- length(chunks)
  fs <- vector("list", length = nchunks)
  if (debug) mdebugf("Number of futures (= number of chunks): %d", nchunks)
  
  if (debug) mdebugf("Launching %d futures (chunks) ...", nchunks)
  for (ii in seq_along(chunks)) {
    chunk <- chunks[[ii]]
    if (debug) mdebugf("Chunk #%d of %d ...", ii, length(chunks))
    ## Subsetting outside future is more efficient
    
    dots_ii <- lapply(dots, FUN = `[`, chunk)
    globals_ii <- globals
    ## Subsetting outside future is more efficient
    globals_ii[["...future.elements_ii"]] <- dots_ii
    packages_ii <- packages

    if (scanForGlobals) {
      ## Search for globals in 'dots_ii':
      gp <- getGlobalsAndPackages(dots_ii, envir = envir, globals = TRUE)
      globals_dots <- gp$globals
      packages_dots <- gp$packages
      gp <- NULL

      if (debug) {
        mdebugf(" - globals found in '...' for chunk #%d: [%d] %s", chunk, length(globals_dots), hpaste(sQuote(names(globals_dots))))
        mdebugf(" - needed namespaces for '...' for chunk #%d: [%d] %s", chunk, length(packages_dots), hpaste(sQuote(packages_dots)))
      }
    
      ## Export also globals found in 'dots_ii'
      if (length(globals_dots) > 0L) {
        reserved <- intersect(c("...future.FUN", "...future.elements_ii",
                                "...future.seeds_ii"), names(globals_dots))
        if (length(reserved) > 0) {
          stop("Detected globals in '...' using reserved variables names: ",
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

    ## Adjust option 'future.globals.maxSize' to account for the fact that more
    ## than one element is processed per future.  The adjustment is done by
    ## scaling up the limit by the number of elements in the chunk.  This is
    ## a "good enough" approach.
    ## (https://github.com/HenrikBengtsson/future.apply/issues/8).
    if (length(chunk) > 1L) {
      globals_ii["...future.globals.maxSize"] <- list(globals.maxSize)
      options(future.globals.maxSize = length(chunk) * globals.maxSize.default)
      if (debug) mdebugf(" - Adjusted option 'future.globals.maxSize': %g -> %d * %g = %g (bytes)", globals.maxSize.default, length(chunk), globals.maxSize.default, getOption("future.globals.maxSize"))
      on.exit(options(future.globals.maxSize = globals.maxSize), add = TRUE)
    }
    
    ## Using RNG seeds or not?
    if (is.null(seeds)) {
      if (debug) mdebug(" - seeds: <none>")
      fs[[ii]] <- future({
        ...future.globals.maxSize.org <- getOption("future.globals.maxSize")
        if (!identical(...future.globals.maxSize.org, ...future.globals.maxSize)) {
          oopts <- options(future.globals.maxSize = ...future.globals.maxSize)
          on.exit(options(oopts), add = TRUE)
        }
        args <- c(list(FUN = ...future.FUN), ...future.elements_ii, MoreArgs = list(MoreArgs), SIMPLIFY = FALSE, USE.NAMES = FALSE)
        res <- do.call(mapply, args = args)
        res
      }, envir = envir,
         stdout = future.stdout,
         conditions = future.conditions,
         globals = globals_ii, packages = packages_ii,
         lazy = future.lazy)
    } else {
      if (debug) mdebugf(" - seeds: [%d] <seeds>", length(chunk))
      globals_ii[["...future.seeds_ii"]] <- seeds[chunk]
      fs[[ii]] <- future({
        ...future.globals.maxSize.org <- getOption("future.globals.maxSize")
        if (!identical(...future.globals.maxSize.org, ...future.globals.maxSize)) {
          oopts <- options(future.globals.maxSize = ...future.globals.maxSize)
          on.exit(options(oopts), add = TRUE)
        }
        ...future.FUN2 <- function(..., ...future.seeds_ii_jj) {
          assign(".Random.seed", ...future.seeds_ii_jj, envir = globalenv(), inherits = FALSE)
          ...future.FUN(...)
        }
        args <- c(list(FUN = ...future.FUN2), ...future.elements_ii, list(...future.seeds_ii_jj = ...future.seeds_ii), MoreArgs, SIMPLIFY = FALSE, USE.NAMES = FALSE)
        do.call(mapply, args = args)
      }, envir = envir,
         stdout = future.stdout,
         conditions = future.conditions,
         globals = globals_ii, packages = packages_ii,
         lazy = future.lazy)
    }
    
    ## Not needed anymore
    rm(list = c("chunk", "globals_ii"))

    if (debug) mdebugf("Chunk #%d of %d ... DONE", ii, nchunks)
  } ## for (ii ...)
  if (debug) mdebugf("Launching %d futures (chunks) ... DONE", nchunks)

  ## Not needed anymore
  rm(list = c("chunks", "globals", "envir"))

  ## 4. Resolving futures
  if (debug) mdebugf("Resolving %d futures (chunks) ...", nchunks)
  
  values <- values(fs)
  ## Not needed anymore
  rm(list = "fs")

  if (debug) {
    mdebugf(" - Number of value chunks collected: %d", length(values))
    mdebugf("Resolving %d futures (chunks) ... DONE", nchunks)
  }

  ## Sanity check
  stop_if_not(length(values) == nchunks)
  
  if (debug) mdebugf("Reducing values from %d chunks ...", nchunks)
  values2 <- do.call(c, args = values)
  
  if (debug) {
    mdebugf(" - Number of values collected after concatenation: %d",
           length(values2))
    mdebugf(" - Number of values expected: %d", nX)
  }

  assert_values2(nX, values, values2, fcn = "future_mapply()", debug = debug)
  values <- values2
  rm(list = "values2")
  
  ## Sanity check (this may happen if the future backend is broken)
  stop_if_not(length(values) == nX)

  ## Were elements processed in a custom order?
  if (length(values) > 1L && !is.null(ordering)) {
    invOrdering <- vector(mode(ordering), length = nX)
    idx <- 1:nX
    invOrdering[.subset(ordering, idx)] <- idx
    rm(list = c("ordering", "idx"))
    if (debug) mdebugf("Reverse index remapping (attribute 'ordering'): [n = %d] %s", length(invOrdering), hpaste(invOrdering))
    values <- .subset(values, invOrdering)
    rm(list = c("invOrdering"))
  }

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
  
  if (debug) mdebugf("Reducing values from %d chunks ... DONE", nchunks)
  
  if (debug) mdebug("future_mapply() ... DONE")
  
  values
}
