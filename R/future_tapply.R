#' @inheritParams future_lapply
#'
#' @param X An \R object for which a \code{\link[base]{split}} method
#' exists.  Typically vector-like, allowing subsetting with
#' \code{\link[base]{[}}, or a data frame.
#'  
#' @param INDEX A list of one or more factors, each of same length as `X`.
#' The elements are coerced to \code{\link[base]{factor}}s by
#' \code{\link[base:as.factor]{as.factor()}}. Can also be a formula, which
#' is useful if `X` is a data frame; see the `f` argument in
#' \code{\link[base:split]{split()}} for interpretation.
#' 
#' @param default See [base::tapply()].
#' 
#' @return
#' `future_tapply()` returns an array with mode `"list"`, unless
#' `simplify = TRUE` (default) _and_ `FUN` returns a scalar, in which
#' case the mode of the array is the same as the returned scalars.
#' See [base::tapply()] for details.
#' 
#' @rdname future_lapply
#' @export
future_tapply <- function(X, INDEX, FUN = NULL, ...,
                          default = NA, simplify = TRUE,
			  future.envir = parent.frame(),
                          future.label = "future_tapply-%d") {
  FUN <- if (!is.null(FUN)) 
    match.fun(FUN)
  if (inherits(INDEX, "formula")) {
    if (!is.data.frame(X))
      stop("'X' must be a data frame when 'INDEX' is a formula")
    INDEX <- .formula2varlist(INDEX, X)
  }
  if (!is.list(INDEX)) 
    INDEX <- list(INDEX)
  INDEX <- lapply(INDEX, FUN = as.factor)
  nI <- length(INDEX)
  if (!nI)
    stop("'INDEX' is of length zero")
  
  if (!is.object(X) && !all(lengths(INDEX) == length(X))) 
    stop("arguments must have same length")
  
  namelist <- lapply(INDEX, FUN = levels)
  extent <- lengths(namelist, use.names = FALSE)
  cumextent <- cumprod(extent)
  if (cumextent[nI] > .Machine$integer.max) 
    stop("total number of levels >= 2^31")
  
  storage.mode(cumextent) <- "integer"
  ngroup <- cumextent[nI]
  group <- as.integer(INDEX[[1L]])
  if (nI > 1L) {
    for (i in 2L:nI) {
      group <- group + cumextent[i - 1L] * (as.integer(INDEX[[i]]) - 1L)
    }
  }
  if (is.null(FUN)) return(group)
  
  levels(group) <- as.character(seq_len(ngroup))
  class(group) <- "factor"
  ans <- split(X, f = group)
  names(ans) <- NULL
  index <- as.logical(lengths(ans))
  ans <- future_lapply(X = ans[index], FUN = FUN, ..., future.envir = future.envir, future.label = future.label)
  
  ansmat <- array({
    if (simplify && all(lengths(ans) == 1L)) {
      ans <- unlist(ans, recursive = FALSE, use.names = FALSE)
      if (!is.null(ans) && is.na(default) && is.atomic(ans))
        vector(typeof(ans))
      else
        default
    } else {
      vector("list", prod(extent))
    }
  }, dim = extent, dimnames = namelist)
  
  if (length(ans) > 0L) ansmat[index] <- ans

  ansmat
}


.formula2varlist <- import_base(".formula2varlist", default = local({
  if (!exists("errorCondition", mode = "function", envir = baseenv(), inherits = FALSE)) {
    errorCondition <- function(message, ..., class = NULL, call = NULL) {
      structure(
        list(message = as.character(message), call = call, ...),
        class = c(class, "error", "condition")
      )
    }
  }
  
  function(...) {
    stop(errorCondition("future_tapply(X, INDEX, ...), where 'INDEX' is a formula, requires R (>= 4.3.0"), class = "NotSupportedByThisRVersionError")
  }
}))
