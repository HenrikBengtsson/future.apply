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
#' @param \ldots  Arguments to vectorize over, will be recycled to common
#' length, or zero if one of them is of length zero.
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
#' `future_mapply()` returns a list, or for `SIMPLIFY = TRUE`, a vector,
#' array or list.  See [base::mapply()] for details.
#'
#' @example incl/future_mapply.R
#'
#' @keywords manip programming iteration
#'
#' @export
future_mapply <- function(FUN, ..., MoreArgs = NULL, SIMPLIFY = TRUE, USE.NAMES = TRUE, future.envir = parent.frame(), future.stdout = TRUE, future.conditions = "condition", future.globals = TRUE, future.packages = NULL, future.seed = FALSE, future.scheduling = 1.0, future.chunk.size = NULL, future.label = "future_mapply-%d") {
  fcn_name <- "future_mapply"
  args_name <- "..."
  
  FUN <- match.fun(FUN)

  dots <- list(...)
  
  ## Nothing to do?
  if (length(dots) == 0L) return(list())
  
  ns <- lengths(dots)
  
  ## Nothing to do?
  ## "max-or-0-if-any" recycling rule was introduced in R (>= 4.2.0)
  if (any(ns == 0L)) {
    if (!USE.NAMES) return(list())
    values <- list()
    first <- dots[[1]]
    names <- names(first)
    if (length(names) > 0L) {
      names <- character(0L)
    } else if (is.null(names) && is.character(first)) {
      names <- character(0L)
    }
    names(values) <- names
    return(values)
  }

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

  debug <- getOption("future.apply.debug", getOption("future.debug", FALSE))
  
  if (debug) mdebugf("%s() ...", fcn_name)

  ## NOTE TO SELF: We'd ideally have a 'future.envir' argument also for
  ## this function, cf. future().  However, it's not yet clear to me how
  ## to do this, because we need to have globalsOf() to search for globals
  ## from the current environment in order to identify the globals of 
  ## arguments 'FUN' and '...'. /HB 2017-03-10
  envir <- future.envir
  envir <- environment()


  ## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  ## Support %globals%, %packages%, %seed%, ...
  ## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  opts <- getOption("future.disposable", NULL)
  for (name in names(opts)) {
    var <- sprintf("future.%s", name)
    assign(var, opts[[name]], envir = environment(), inherits = FALSE)
  }
  options(future.disposable = NULL)


  ## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  ## Future expression
  ## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  ...future.FUN <- NULL ## To please R CMD check
  
  ## Set .Random.seed?
  if (is.null(future.seed) || isFALSE(future.seed) || isNA(future.seed)) {
     expr <- quote({
       args <- c(list(FUN = ...future.FUN), ...future.elements_ii, MoreArgs = list(MoreArgs), SIMPLIFY = FALSE, USE.NAMES = FALSE)
       do.call(mapply, args = args)
     })
  } else {
    expr <- quote({
      ...future.FUN2 <- function(..., ...future.seeds_ii_jj) {
        assign(".Random.seed", ...future.seeds_ii_jj, envir = globalenv(), inherits = FALSE)
        ...future.FUN(...)
      }
      args <- c(list(FUN = ...future.FUN2), ...future.elements_ii, list(...future.seeds_ii_jj = ...future.seeds_ii), MoreArgs = list(MoreArgs), SIMPLIFY = FALSE, USE.NAMES = FALSE)
      do.call(mapply, args = args)
    })
  }


  ## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  ## Process
  ## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  values <- future_xapply(
    FUN = FUN,
    nX = nX,
    chunk_args = dots,
    MoreArgs = MoreArgs,
    get_chunk = function(X, chunk) lapply(X, FUN = `chunkWith[[`, chunk),
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
  
  if (debug) mdebugf("%s() ... DONE", fcn_name)
  
  values
}


#' @param dots A list of arguments to vectorize over (vectors or lists of
#' strictly positive length, or all of zero length).
#'
#' @return
#' `future_.mapply()` returns a list. See [base::.mapply()] for details.
#'
#' @details
#' Note that [base::.mapply()], which `future_.mapply()` is modeled after
#' is listed as an "internal" function in \R despite being exported.
#'
#' @rdname future_mapply
#' @export
future_.mapply <- function(FUN, dots, MoreArgs, ..., future.label = "future_.mapply-%d") {
  args <- c(
    list(FUN = FUN),
    dots,
    list(
      MoreArgs = MoreArgs,
      SIMPLIFY = FALSE,
      USE.NAMES = FALSE,
      ...,
      future.label = future.label
    )
  )
  do.call(future_mapply, args = args, envir = parent.frame())
}
