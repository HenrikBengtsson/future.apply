#' @inheritParams future_lapply
#' 
#' @param simplify See [base::sapply()] and [base::tapply()], respectively.
#' 
#' @param USE.NAMES See [base::sapply()].
#'
#' @return
#' For `future_sapply()`, a vector with same length and names as \code{X}.
#' See [base::sapply()] for details.
#'
#' @export
#'
#' @author
#' The implementations of `future_replicate()`, `future_sapply()`, and
#' `future_tapply()` are adopted from the source code of the corresponding
#' base \R functions, which are licensed under GPL (>= 2) with
#' 'The R Core Team' as the copyright holder.
#' 
#' @rdname future_lapply
future_sapply <- function(X, FUN, ..., simplify = TRUE, USE.NAMES = TRUE, future.label = "future_sapply-%d") {
  answer <- future_lapply(X = X, FUN = FUN, ..., future.label = future.label)
  if (USE.NAMES && is.character(X) && is.null(names(answer)))
    names(answer) <- X

  if (!isFALSE(simplify) && length(answer))
    simplify2array(answer, higher = (simplify == "array"))
  else
    answer
}
