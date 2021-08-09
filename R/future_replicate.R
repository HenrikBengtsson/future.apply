#' @inheritParams future_lapply
#'
#' @param n The number of replicates.
#'
#' @param expr An \R expression to evaluate repeatedly.
#' 
#' @return
#' `future_replicate()` is a wrapper around `future_sapply()` and return
#' simplified object according to the `simplify` argument.
#' See [base::replicate()] for details.
#' Since `future_replicate()` usually involves random number generation (RNG),
#' it uses `future.seed = TRUE` by default in order produce sound random
#' numbers regardless of future backend and number of background workers used.
#'
#' @export
#'
#' @rdname future_lapply
future_replicate <- function(n, expr, simplify = "array",
                             future.seed = TRUE, ...,
                             future.envir = parent.frame(),
                             future.label = "future_replicate-%d")
  future_sapply(X = integer(n),
                FUN = eval.parent(substitute(function(...)expr)),
                simplify = simplify,
                future.seed = future.seed,
                ...,
                future.envir = future.envir,
                future.label = future.label)
