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
#' @rdname future_lapply
future_sapply <- function(X, FUN, ..., simplify = TRUE, USE.NAMES = TRUE) {
  answer <- future_lapply(X = X, FUN = FUN, ...)
  if (USE.NAMES && is.character(X) && is.null(names(answer))) {
    names(answer) <- X
  }
  
  if (!identical(simplify, FALSE) && length(answer)) {
    simplify2array(answer, higher = (simplify == "array"))
  } else {
    answer
  }  
}
