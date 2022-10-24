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
#' @param future.envir An [environment] passed as argument `envir` to
#'        [future::future()] as-is.
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
#' Unless `future.seed` is `FALSE` or `NULL`, this function guarantees to
#' generate the exact same sequence of random numbers _given the same initial
#' seed / RNG state_ - this regardless of type of futures, scheduling
#' ("chunking") strategy, and number of workers.
#' 
#' RNG reproducibility is achieved by pregenerating the random seeds for all
#' iterations (over `X`) by using L'Ecuyer-CMRG RNG streams.  In each
#' iteration, these seeds are set before calling `FUN(X[[ii]], ...)`.
#' _Note, for large `length(X)` this may introduce a large overhead._
#'
#' If `future.seed = TRUE`, then \code{\link[base:Random]{.Random.seed}}
#' is used if it holds a L'Ecuyer-CMRG RNG seed, otherwise one is created
#' randomly.
#'
#' If `future.seed = FALSE`, it is expected that none of the
#' `FUN(X[[ii]], ...)` function calls use random number generation.
#' If they do, then an informative warning or error is produces depending
#' on settings. See [future::future] for more details.
#' Using `future.seed = NULL`, is like `future.seed = FALSE` but without
#' the check whether random numbers were generated or not.
#'
#' As input, `future.seed` may also take a fixed initial seed (integer),
#' either as a full L'Ecuyer-CMRG RNG seed (vector of 1+6 integers), or
#' as a seed generating such a full L'Ecuyer-CMRG seed. This seed will
#' be used to generated `length(X)` L'Ecuyer-CMRG RNG streams.
#'
#' In addition to the above, it is possible to specify a pre-generated
#' sequence of RNG seeds as a list such that
#' `length(future.seed) == length(X)` and where each element is an
#' integer seed vector that can be assigned to
#' \code{\link[base:Random]{.Random.seed}}.  One approach to generate a
#' set of valid RNG seeds based on fixed initial seed (here `42L`) is:
#'
#' ```r
#' seeds <- future_lapply(seq_along(X), FUN = function(x) .Random.seed,
#'                        future.chunk.size = Inf, future.seed = 42L)
#' ```
#'
#' **Note that `as.list(seq_along(X))` is _not_ a valid set of such
#' `.Random.seed` values.**
#' 
#' In all cases but `future.seed = FALSE` and `NULL`, the RNG state of the
#' calling R processes after this function returns is guaranteed to be
#' "forwarded one step" from the RNG state that was before the call and
#' in the same way regardless of `future.seed`, `future.scheduling`
#' and future strategy used.  This is done in order to guarantee that an \R
#' script calling `future_lapply()` multiple times should be numerically
#' reproducible given the same initial seed.
#'
#'
#' @section Control processing order of elements:
#' Attribute `ordering` of `future.chunk.size` or `future.scheduling` can
#' be used to control the ordering the elements are iterated over, which
#' only affects the processing order and _not_ the order values are returned.
#' This attribute can take the following values:
#' * index vector - an numeric vector of length `length(X)`
#' * function     - an function taking one argument which is called as
#'                  `ordering(length(X))` and which must return an
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
#' @importFrom globals findGlobals
#' @export
future_lapply <- local({
  tmpl_expr <- bquote_compile({
    lapply(seq_along(...future.elements_ii), FUN = function(jj) {
       ...future.X_jj <- ...future.elements_ii[[jj]]
       .(expr_FUN)
    })
  })

  tmpl_expr_with_rng <- bquote_compile({
    lapply(seq_along(...future.elements_ii), FUN = function(jj) {
       ...future.X_jj <- ...future.elements_ii[[jj]]
       assign(".Random.seed", ...future.seeds_ii[[jj]], envir = globalenv(), inherits = FALSE)
       .(expr_FUN)
    })
  })

  function(X, FUN, ..., future.envir = parent.frame(), future.stdout = TRUE, future.conditions = "condition", future.globals = TRUE, future.packages = NULL, future.seed = FALSE, future.scheduling = 1.0, future.chunk.size = NULL, future.label = "future_lapply-%d") {
    fcn_name <- "future_lapply"
    args_name <- "X"
  
    ## Coerce to as.list()?
    if (!is.vector(X) || is.object(X)) X <- as.list(X)
    
    ## Nothing to do?
    nX <- length(X)
    if (nX == 0L) return(as.list(X))

    FUN <- match.fun(FUN)

    debug <- getOption("future.apply.debug", getOption("future.debug", FALSE))
    
    if (debug) mdebugf("%s() ...", fcn_name)
  
    ## NOTE TO SELF: We'd ideally have a 'future.envir' argument also for
    ## this function, cf. future().  However, it's not yet clear to me how
    ## to do this, because we need to have globalsOf() to search for globals
    ## from the current environment in order to identify the globals of 
    ## arguments 'FUN' and '...'. /HB 2017-03-10
    envir <- environment()
    
    ## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    ## Future expression
    ## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    ...future.FUN <- NULL ## To please R CMD check
  
    ## Does FUN() rely on '...' being a global?
    global_dotdotdot <- ("..." %in% findGlobals(FUN, dotdotdot = "return"))
    if (global_dotdotdot) {
      expr_FUN <- quote(...future.FUN(...future.X_jj))
    } else {
      expr_FUN <- quote(...future.FUN(...future.X_jj, ...))
    }
    
    ## With or without RNG?
    expr <- bquote_apply(
      if (is.null(future.seed) || isFALSE(future.seed) || isNA(future.seed)) {
        tmpl_expr
      } else {
        tmpl_expr_with_rng
      }
    )
  
  
    ## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    ## Process
    ## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    values <- future_xapply(
      FUN = FUN,
      nX = nX,
      chunk_args = X,
      args = list(...),
      get_chunk = `[`,
      expr = expr,
      envir = envir,
      future.envir = future.envir,
      future.globals = future.globals,
      future.packages = future.packages,
      future.scheduling = future.scheduling,
      future.chunk.size = future.chunk.size,
      future.stdout = future.stdout,
      future.conditions = future.conditions,
      future.seed = future.seed,
      future.label = future.label,
      fcn_name = fcn_name,
      args_name = args_name,
      debug = debug
    )
  
    ## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    ## Reduce
    ## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    names(values) <- names(X)
  
    if (debug) mdebugf("%s() ... DONE", fcn_name)
    
    values
  }
})