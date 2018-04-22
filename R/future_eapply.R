#' @inheritParams future_lapply
#' 
#' @param env An \R environment.
#' 
#' @param all.names If `TRUE`, the function will also be applied to variables
#' that start with a period (`.`), otherwise not.
#' See [base::eapply()] for details.
#'
#' @return
#' A named (unless `USE.NAMES = FALSE`) list.
#' See [base::eapply()] for details.
#'
#' @export
#'
#' @rdname future_lapply
future_eapply <- function(env, FUN, ..., all.names = FALSE, USE.NAMES = TRUE) {
  names <- ls(envir = env, all.names = all.names, sorted = FALSE)
  X <- mget(names, envir = env, inherits = FALSE)
  if (!USE.NAMES) names(X) <- NULL
  future_lapply(X = X, FUN = FUN, ...)
}