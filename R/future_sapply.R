#' @inheritParams future_lapply
#' 
#' @param simplify,USE.NAMES See [base::sapply()] for details.
#'
#' @return
#' For `future_sapply()`, a vector with same length and names as \code{X}.
#' See [base::sapply()] for details.
#'
#' @export
#'
#' @author
#' The implementations of `future_replicate()` and `future_sapply()` are
#' adopted from the source code of [base::replicate()] and [base::sapply()],
#' which is licensed under GPL (>= 2) with 'The R Core Team' as the
#' copyright holder.
#' 
#' @rdname future_lapply
future_sapply <- function(X, FUN, ..., simplify = TRUE, USE.NAMES = TRUE) {
  answer <- future_lapply(X = X, FUN = FUN, ...)
  if (USE.NAMES && is.character(X) && is.null(names(answer))) {
    names(answer) <- X
  }
  
  if (!isFALSE(simplify) && length(answer)) {
    simplify2array(answer, higher = (simplify == "array"))
  } else {
    answer
  }  
}
