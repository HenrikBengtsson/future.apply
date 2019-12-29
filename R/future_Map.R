#' @inheritParams future_mapply
#' 
#' @param f A function of the arity \eqn{k} if `future_Map()` is called with
#' \eqn{k} arguments. 
#' 
#' @return
#' `future_Map()` is a simple wrapper to `future_mapply()` which does not
#' attempt to simplify the result.
#' See [base::Map()] for details.
#'
#' @export
#'
#' @author
#' The implementations of `future_Map()` is adopted from the source code
#' of the corresponding base \R function `Map()`, which is licensed under
#' GPL (>= 2) with 'The R Core Team' as the copyright holder.
#' 
#' @rdname future_mapply
future_Map <- function(f, ..., future.label = "future_Map-%d") {
  f <- match.fun(f)
  future_mapply(FUN = f, ..., SIMPLIFY = FALSE, future.label = future.label)
}
