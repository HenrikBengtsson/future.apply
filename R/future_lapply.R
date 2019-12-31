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
#'        captured and relayed.  The default is the same as the `condition`
#'        argument of [future::Future()].
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
#' @param future.label If a character string, then each future is assigned
#'        a label `sprintf(future.label, chunk_idx)`.  If TRUE, then the
#'        same as `future.label = "future_lapply-%d"`.  If FALSE, no labels
#'        are assigned.
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
#' _Note_, when elements are processed out of order, then captured standard
#' output and conditions are also relayed in that order, that is out of order.
#'
#' @example incl/future_lapply.R
#'
#' @keywords manip programming iteration
#'
#' @importFrom globals globalsByName
#' @importFrom future future resolve values as.FutureGlobals nbrOfWorkers getGlobalsAndPackages FutureError
#' @importFrom utils head str
#' @export
future_lapply <- function(X, FUN, ..., future.stdout = TRUE, future.conditions = NULL, future.globals = TRUE, future.packages = NULL, future.lazy = FALSE, future.seed = FALSE, future.scheduling = 1.0, future.chunk.size = NULL, future.label = "future_lapply-%d") {
  fcn_name <- "future_lapply"
  args_name <- "X"
  
  stop_if_not(is.function(FUN))
  
  stop_if_not(is.logical(future.stdout), length(future.stdout) == 1L)

  ## FIXME: Memoize the result
  if (is.null(future.conditions)) {
    future.conditions <- eval(formals(Future)[["conditions"]])
  }
  
  stop_if_not(is.logical(future.lazy), length(future.lazy) == 1L)

  stop_if_not(length(future.scheduling) == 1L, !is.na(future.scheduling),
            is.numeric(future.scheduling) || is.logical(future.scheduling))

  stop_if_not(length(future.label) == 1L, !is.na(future.label),
              is.logical(future.label) || is.character(future.label))

  ## Coerce to as.list()?
  if (!is.vector(X) || is.object(X)) X <- as.list(X)
  
  ## Nothing to do?
  nX <- length(X)
  if (nX == 0L) return(X)

  debug <- getOption("future.debug", FALSE)
  
  if (debug) mdebugf("%s() ...", fcn_name)

  ## NOTE TO SELF: We'd ideally have a 'future.envir' argument also for
  ## this function, cf. future().  However, it's not yet clear to me how
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

  ## Future expression (with or without setting the RNG state) and
  ## pass possibly tweaked 'future.seed' to future()
  if (is.null(seeds)) {
    ## Don't set .Random.seed
    seedExpr <- NULL
    
    stop_if_not(is.null(future.seed) || isFALSE(future.seed))
    if (isFALSE(future.seed) && future_version() <= "1.15.1") {
      future.seed <- NULL
    }
  } else {
    ## Set .Random.seed
    seedExpr <- quote(assign(".Random.seed", ...future.seeds_ii[[jj]], envir = globalenv(), inherits = FALSE))
    
    ## If RNG seeds are used (given or generated), make sure to reset
    ## the RNG state afterward
    oseed <- next_random_seed()    
    on.exit(set_random_seed(oseed))
    ## As seed=FALSE but without the RNG check
    future.seed <- NULL
  }
  
  expr <- bquote({
    ...future.globals.maxSize.org <- getOption("future.globals.maxSize")
    if (!identical(...future.globals.maxSize.org, ...future.globals.maxSize)) {
      oopts <- options(future.globals.maxSize = ...future.globals.maxSize)
      on.exit(options(oopts), add = TRUE)
    }
    lapply(seq_along(...future.elements_ii), FUN = function(jj) {
       ...future.X_jj <- ...future.elements_ii[[jj]]
       .(seedExpr)
       ...future.FUN(...future.X_jj, ...)
    })
  })

  args <- X
  get_chunk <- function(X, chunk) X[chunk]
  
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

  ## Create labels?
  if (isTRUE(future.label)) {
    future.label <- sprintf("%s-%%d", fcn_name)
  }
  if (is.character(future.label)) {
    labels <- sprintf(future.label, seq_len(nchunks))
    stopifnot(length(labels) == nchunks)
  } else {
    labels <- NULL
  }
  
  if (debug) mdebugf("Launching %d futures (chunks) ...", nchunks)
  for (ii in seq_along(chunks)) {
    chunk <- chunks[[ii]]
    if (debug) mdebugf("Chunk #%d of %d ...", ii, length(chunks))
 
    args_ii <- get_chunk(args, chunk)
    globals_ii <- globals
    ## Subsetting outside future is more efficient
    globals_ii[["...future.elements_ii"]] <- args_ii
    packages_ii <- packages

    if (scanForGlobals) {
      mdebugf(" - Finding globals in '%s' for chunk #%d ...", args_name, ii)
      gp <- getGlobalsAndPackages(args_ii, envir = envir, globals = TRUE)
      globals_args <- gp$globals
      packages_args <- gp$packages
      gp <- NULL

      if (debug) {
        mdebugf("   + globals found in '%s' for chunk #%d: [%d] %s",
	        args_name, chunk, length(globals_args), hpaste(sQuote(names(globals_args))))
        mdebugf("   + needed namespaces for '%s' for chunk #%d: [%d] %s",
	        args_name, chunk, length(packages_args), hpaste(sQuote(packages_args)))
      }
    
      ## Export also globals found in arguments?
      if (length(globals_args) > 0L) {
        reserved <- intersect(c("...future.FUN", "...future.elements_ii",
                                "...future.seeds_ii"), names(globals_args))
        if (length(reserved) > 0) {
          stop("Detected globals in '%s' using reserved variables names: ",
               args_name, paste(sQuote(reserved), collapse = ", "))
        }
        globals_args <- as.FutureGlobals(globals_args)
        globals_ii <- unique(c(globals_ii, globals_args))

        ## Packages needed due to globals in arguments?
        if (length(packages_args) > 0L)
          packages_ii <- unique(c(packages_ii, packages_args))
      }
      mdebugf(" - Finding globals in '%s' for chunk #%d ... DONE", args_name, ii)
    }
    
    args_ii <- NULL
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
    } else {
      if (debug) mdebugf(" - seeds: [%d] <seeds>", length(chunk))
      globals_ii[["...future.seeds_ii"]] <- seeds[chunk]
    }
    
    fs[[ii]] <- future(
      expr, substitute = FALSE,
      envir = envir,
      stdout = future.stdout,
      conditions = future.conditions,
      globals = globals_ii, packages = packages_ii,
      seed = future.seed,
      lazy = future.lazy,
      label = labels[ii]
    )
    
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

  assert_values2(nX, values, values2, fcn_name = fcn_name, debug = debug)
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

  names(values) <- names(X)

  if (debug) mdebugf("Reducing values from %d chunks ... DONE", nchunks)
  
  if (debug) mdebugf("%s() ... DONE", fcn_name)
  
  values
}
