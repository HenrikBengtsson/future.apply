#' Parallelize a Vector Map Function using Forking
#'
#' @param v The vector to operate on.
#'
#' @param FUN The function to call on each partion of the vector `v`.
#' This function must return the same number of elements as the input,
#' and it must support one or more elements as input.
#'
#' @param \dots Any further arguments passed to `FUN()` after each
#' vector element.
#'
#' @return The value of `FUN(v, ...)`.
#'
#' @export
future_pvec <- function(v, FUN, ...) {
  if (!is.vector(v)) {
    stop("'v' must be a vector")
  }
  FUN <- match.fun(FUN)
  
  nworkers <- nbrOfWorkers()
  if (nworkers == 1L) {
    return(FUN(v, ...))
  }
  
  n <- length(v)
  l <- if (n <= nworkers) {
    as.list(v)
  } else {
    il <- as.integer(n / nworkers)
    xc <- n - il * nworkers
    sl <- rep(il, times = nworkers)
    if (xc > 0L) sl[1:xc] <- il + 1L
    si <- cumsum(c(1L, sl))
    se <- si + c(sl, 0L) - 1L
    lapply(seq_len(nworkers), function(ix) v[si[ix]:se[ix]])
  }
  ns0 <- vapply(l, FUN.VALUE = NA_integer_, FUN = length)
  fs <- lapply(seq_len(min(n, nworkers)), function(i) {
    future(FUN(l[[i]], ...))
  })
  l <- NULL ## Not needed anymore
  res <- value(fs)
  names(res) <- NULL
  fs <- NULL ## Not needed anymore

  ## Validate that length(FUN(x)) == length(x) is met
  ns <- vapply(res, FUN.VALUE = NA_integer_, FUN = length)
  if (any(ns != ns0)) {
    stop("Argument 'FUN' appears not to meet the requirements for future_pvec(), because some of the y <- FUN(x) calls did not result in length(y) == length(x)")
  }
  ns <- ns0 <- NULL  ## Not needed anymore

  ## Combine
  res <- do.call(c, args = res)
  
  res
}
