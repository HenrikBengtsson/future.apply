#' @inheritParams future_lapply
#' 
#' @param simplify logical or character string. [...]
#' 
#' @param USE.NAMES logical. [...]
#'
#' @importFrom globals globalsByName cleanup
#' @importFrom future as.FutureGlobals resolve nbrOfWorkers future values
#' @importFrom parallel nextRNGStream nextRNGSubStream splitIndices
#' @importFrom utils capture.output str
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
