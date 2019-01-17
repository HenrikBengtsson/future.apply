#' Apply a Function over a List or Vector via Futures
#'
#' `future_lapply()` implements [base::lapply()] using futures with perfect
#' replication of results, regardless of future backend used.
#' Analogously, this is true for all the other `future_nnn()` functions.
#' 
#' @param X  A vector-like object to iterate over.
#' 
#' @param FUN  A function taking at least one argument.
#' 
#' @param \ldots  (optional) Additional arguments passed to `FUN()`.
#' For `future_*apply()` functions and `replicate()`, any `future.*` arguments
#' part of `\ldots` are passed on to `future_lapply()` used internally.
#' 
#' @param future.stdout If `TRUE` (default), then the standard output of the
#'        underlying futures is captured, and re-outputted as soon as possible.
#'        If `FALSE`, any output is silenced (by sinking it to the null device
#'        as it is outputted).
#'        If `NA` (not recommended), output is _not_ intercepted.
#'
#' @param future.conditions A character string of conditions classes to be
#'        captured and relayed.  The default is to relay messages and warnings.
#'        To not intercept conditions, use `conditions = character(0L)`.
#'        Errors are always relayed.
#'
#' @param future.globals A logical, a character vector, or a named list for
#'        controlling how globals are handled. For details, see below section.
#'
#' @param future.packages (optional) a character vector specifying packages
#'        to be attached in the R environment evaluating the future.
#' 
#' @param future.lazy Specifies whether the futures should be resolved
#'        lazily or eagerly (default).
#' 
#' @param future.seed A logical or an integer (of length one or seven),
#'        or a list of `length(X)` with pre-generated random seeds.
#'        For details, see below section.
#'  
#' @param future.scheduling Average number of futures ("chunks") per worker.
#'        If `0.0`, then a single future is used to process all elements
#'        of `X`.
#'        If `1.0` or `TRUE`, then one future per worker is used.
#'        If `2.0`, then each worker will process two futures
#'        (if there are enough elements in `X`).
#'        If `Inf` or `FALSE`, then one future per element of
#'        `X` is used.
#'        Only used if `future.chunk.size` is `NULL`.
#'
#' @param future.chunk.size The average number of elements per future ("chunk").
#'        If `Inf`, then all elements are processed in a single future.
#'        If `NULL`, then argument `future.scheduling` is used.
#' 
#' @return
#' For `future_lapply()`, a list with same length and names as `X`.
#' See [base::lapply()] for details.
#'
#' @section Global variables:
#' Argument `future.globals` may be used to control how globals
#' should be handled similarly how the `globals` argument is used with
#' `future()`.
#' Since all function calls use the same set of globals, this function can do
#' any gathering of globals upfront (once), which is more efficient than if
#' it would be done for each future independently.
#' If `TRUE`, `NULL` or not is specified (default), then globals
#' are automatically identified and gathered.
#' If a character vector of names is specified, then those globals are gathered.
#' If a named list, then those globals are used as is.
#' In all cases, `FUN` and any `\ldots` arguments are automatically
#' passed as globals to each future created as they are always needed.
#'
#' @section Reproducible random number generation (RNG):
#' Unless `future.seed = FALSE`, this function guarantees to generate
#' the exact same sequence of random numbers _given the same initial
#' seed / RNG state_ - this regardless of type of futures, scheduling
#' ("chunking") strategy, and number of workers.
#' 
#' RNG reproducibility is achieved by pregenerating the random seeds for all
#' iterations (over `X`) by using L'Ecuyer-CMRG RNG streams.  In each
#' iteration, these seeds are set before calling `FUN(X[[ii]], ...)`.
#' _Note, for large `length(X)` this may introduce a large overhead._
#' As input (`future.seed`), a fixed seed (integer) may be given, either
#' as a full L'Ecuyer-CMRG RNG seed (vector of 1+6 integers) or as a seed
#' generating such a full L'Ecuyer-CMRG seed.
#' If `future.seed = TRUE`, then \code{\link[base:Random]{.Random.seed}}
#' is returned if it holds a L'Ecuyer-CMRG RNG seed, otherwise one is created
#' randomly.
#' If `future.seed = NA`, a L'Ecuyer-CMRG RNG seed is randomly created.
#' If none of the function calls `FUN(X[[ii]], ...)` uses random number
#' generation, then `future.seed = FALSE` may be used.
#'
#' In addition to the above, it is possible to specify a pre-generated
#' sequence of RNG seeds as a list such that
#' `length(future.seed) == length(X)` and where each element is an
#' integer seed vector that can be assigned to
#' \code{\link[base:Random]{.Random.seed}}.  One approach to generate a
#' set of valid RNG seeds based on fixed initial seed (here `42L`) is:
#' ```r
#' seeds <- future_lapply(seq_along(X), FUN = function(x) .Random.seed,
#'                        future.chunk.size = Inf, future.seed = 42L)
#' ```
#' **Note that `as.list(seq_along(X))` is _not_ a valid set of such
#' `.Random.seed` values.**
#' 
#' In all cases but `future.seed = FALSE`, the RNG state of the calling
#' R processes after this function returns is guaranteed to be
#' "forwarded one step" from the RNG state that was before the call and
#' in the same way regardless of `future.seed`, `future.scheduling`
#' and future strategy used.  This is done in order to guarantee that an \R
#' script calling `future_lapply()` multiple times should be numerically
#' reproducible given the same initial seed.
#'
#' @section Control processing order of elements:
#' Attribute `ordering` of `future.chunk.size` or `future.scheduling` can
#' be used to control the ordering the elements are iterated over, which
#' only affects the processing order and _not_ the order values are returned.
#' This attribute can take the following values:
#' * index vector - an numeric vector of length `length(X)`
#' * function     - an function taking one argument which is called as
#'                  `ordering(length(X))` and which much return an
#'                  index vector of length `length(X)`, e.g.
#'                  `function(n) rev(seq_len(n))` for reverse ordering.
#' * `"random"`   - this will randomize the ordering via random index
#'                  vector `sample.int(length(X))`.
#' For example, `future.scheduling = structure(TRUE, ordering = "random")`.
#'
#' @example incl/future_lapply.R
#'
#' @keywords manip programming iteration
#'
#' @importFrom globals globalsByName
#' @importFrom future future resolve values as.FutureGlobals nbrOfWorkers getGlobalsAndPackages FutureError
#' @importFrom utils capture.output head str
#' @export
future_lapply <- function(X, FUN, ..., future.stdout = TRUE, future.conditions = c("message", "warning"), future.globals = TRUE, future.packages = NULL, future.lazy = FALSE, future.seed = FALSE, future.scheduling = 1.0, future.chunk.size = NULL) {
  stop_if_not(is.function(FUN))
  
  stop_if_not(is.logical(future.stdout), length(future.stdout) == 1L)

  stop_if_not(is.logical(future.lazy), length(future.lazy) == 1L)

  stop_if_not(!is.null(future.seed))
  
  stop_if_not(length(future.scheduling) == 1, !is.na(future.scheduling),
            is.numeric(future.scheduling) || is.logical(future.scheduling))

  ## Coerce to as.list()?
  if (!is.vector(X) || is.object(X)) X <- as.list(X)
  
  ## Nothing to do?
  nX <- length(X)
  if (nX == 0) return(list())

  debug <- getOption("future.debug", FALSE)
  
  if (debug) mdebug("future_lapply() ...")

  ## NOTE TO SELF: We'd ideally have a 'future.envir' argument also for
  ## future_lapply(), cf. future().  However, it's not yet clear to me how
  ## to do this, because we need to have globalsOf() to search for globals
  ## from the current environment in order to identify the globals of 
  ## arguments 'FUN' and '...'. /HB 2017-03-10
  future.envir <- environment()  ## Not used; just to clarify the above.
  
  envir <- future.envir
  
  ## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  ## 1. Globals and Packages
  ## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  gp <- getGlobalsAndPackagesXApply(FUN = FUN,
                                    args = list(...),
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
  if (debug) mdebug("Number of chunks: %d", length(chunks))

  ## Process elements in a custom order?
  ordering <- attr(chunks, "ordering")
  if (!is.null(ordering)) {
    if (debug) mdebug("Index remapping (attribute 'ordering'): [n = %d] %s", length(ordering), hpaste(ordering))
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
  if (debug) mdebug("Number of futures (= number of chunks): %d", nchunks)
  
  if (debug) mdebug("Launching %d futures (chunks) ...", nchunks)
  for (ii in seq_along(chunks)) {
    chunk <- chunks[[ii]]
    if (debug) mdebug("Chunk #%d of %d ...", ii, length(chunks))

    X_ii <- X[chunk]
    globals_ii <- globals
    ## Subsetting outside future is more efficient
    globals_ii[["...future.elements_ii"]] <- X_ii
    packages_ii <- packages

    if (scanForGlobals) {
      mdebug(" - Finding globals in 'X' for chunk #%d ...", ii)
      ## Search for globals in 'X_ii':
      gp <- getGlobalsAndPackages(X_ii, envir = envir, globals = TRUE)
      globals_X <- gp$globals
      packages_X <- gp$packages
      gp <- NULL

      if (debug) {
        mdebug("   + globals found in 'X' for chunk #%d: [%d] %s", chunk, length(globals_X), hpaste(sQuote(names(globals_X))))
        mdebug("   + needed namespaces for 'X' for chunk #%d: [%d] %s", chunk, length(packages_X), hpaste(sQuote(packages_X)))
      }
    
      ## Export also globals found in 'X_ii'
      if (length(globals_X) > 0L) {
        reserved <- intersect(c("...future.FUN", "...future.elements_ii",
                                "...future.seeds_ii"), names(globals_X))
        if (length(reserved) > 0) {
          stop("Detected globals in 'X' using reserved variables names: ",
               paste(sQuote(reserved), collapse = ", "))
        }
        globals_X <- as.FutureGlobals(globals_X)
        globals_ii <- unique(c(globals_ii, globals_X))

        ## Packages needed due to globals in 'X_ii'?
        if (length(packages_X) > 0L)
          packages_ii <- unique(c(packages_ii, packages_X))
      }
      mdebug(" - Finding globals in 'X' for chunk #%d ... DONE", ii)
    }
    
    X_ii <- NULL
##    stop_if_not(attr(globals_ii, "resolved"))

    ## Adjust option 'future.globals.maxSize' to account for the fact that more
    ## than one element is processed per future.  The adjustment is done by
    ## scaling up the limit by the number of elements in the chunk.  This is
    ## a "good enough" approach.
    ## (https://github.com/HenrikBengtsson/future.apply/issues/8).
    if (length(chunk) > 1L) {
      globals_ii["...future.globals.maxSize"] <- list(globals.maxSize)
      options(future.globals.maxSize = length(chunk) * globals.maxSize.default)
      if (debug) mdebug(" - Adjusted option 'future.globals.maxSize': %g -> %d * %g = %g (bytes)", globals.maxSize.default, length(chunk), globals.maxSize.default, getOption("future.globals.maxSize"))
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
        lapply(seq_along(...future.elements_ii), FUN = function(jj) {
           ...future.X_jj <- ...future.elements_ii[[jj]]
           ...future.FUN(...future.X_jj, ...)
        })
      }, envir = envir,
         stdout = future.stdout,
         conditions = future.conditions,
         globals = globals_ii, packages = packages_ii,
         lazy = future.lazy)
    } else {
      if (debug) mdebug(" - seeds: [%d] <seeds>", length(chunk))
      globals_ii[["...future.seeds_ii"]] <- seeds[chunk]
      fs[[ii]] <- future({
        ...future.globals.maxSize.org <- getOption("future.globals.maxSize")
        if (!identical(...future.globals.maxSize.org, ...future.globals.maxSize)) {
          oopts <- options(future.globals.maxSize = ...future.globals.maxSize)
          on.exit(options(oopts), add = TRUE)
        }
        lapply(seq_along(...future.elements_ii), FUN = function(jj) {
           ...future.X_jj <- ...future.elements_ii[[jj]]
           assign(".Random.seed", ...future.seeds_ii[[jj]], envir = globalenv(), inherits = FALSE)
           ...future.FUN(...future.X_jj, ...)
        })
      }, envir = envir,
         stdout = future.stdout,
         conditions = future.conditions,
         globals = globals_ii, packages = packages_ii,
         lazy = future.lazy)
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

  assert_values2(nX, values, values2, fcn = "future_lapply()", debug = debug)
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
    if (debug) mdebug("Reverse index remapping (attribute 'ordering'): [n = %d] %s", length(invOrdering), hpaste(invOrdering))
    values <- .subset(values, invOrdering)
    rm(list = c("invOrdering"))
  }

  names(values) <- names(X)

  if (debug) mdebug("Reducing values from %d chunks ... DONE", nchunks)
  
  if (debug) mdebug("future_lapply() ... DONE")
  
  values
}
