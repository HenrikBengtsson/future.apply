#' @inheritParams future_lapply
#' 
#' @param FUN.VALUE A template for the required return value from
#' each `FUN(X[ii], ...)`.
#' Types may be promoted to a higher type within the ordering
#' logical < integer < double < complex, but not demoted.
#' See [base::vapply()] for details.
#'
#' @return
#' For `future_vapply()`, a vector with same length and names as \code{X}.
#' See [base::vapply()] for details.
#'
#' @export
#'
#' @rdname future_lapply
future_vapply <- function(X, FUN, FUN.VALUE, ..., USE.NAMES = TRUE, future.envir = parent.frame(), future.label = "future_vapply-%d") {
  ## Coerce to as.list()?
  if (!is.vector(X) || is.object(X)) X <- as.list(X)
  
  n <- length(X)
  stop_if_not(is.function(FUN))
  stop_if_not(is.vector(FUN.VALUE) || is.array(FUN.VALUE))
  type <- typeof(FUN.VALUE)
  times <- length(FUN.VALUE)
  dim <- dim(FUN.VALUE)
  stop_if_not(is.logical(USE.NAMES), length(USE.NAMES) == 1L, !is.na(USE.NAMES))

  valid_types <- switch(
    type,
    logical =   "logical",
    integer = c("logical", "integer"),
    double  = c("logical", "integer", "double"),
    complex = c("logical", "integer", "double", "complex"),
    type
  )
  
  x_FUN <- FUN
  res <- future_lapply(X, FUN = function(x, ...) {
    value <- x_FUN(x, ...)
    if (length(value) != times) {
      stop(sprintf(
        "values must be length %d, but FUN(X[[ii]]) result is length %d",
        times, length(value)))
    }
    stop_if_not(all(dim(value) == dim), typeof(value) %in% valid_types)
    value
  }, ..., future.envir = future.envir, future.label = future.label)

  if (!is.null(dim)) {
    dim_res <- c(dim, n)
  } else if (times != 1L) {
    dim_res <- c(times, n)
  } else {
    dim_res <- NULL
  }

  if (USE.NAMES && length(res) > 0L) {
    if (is.null(dim)) {
      names_FUN.VALUE <- names(FUN.VALUE)
      if (is.null(names_FUN.VALUE)) names_FUN.VALUE <- names(res[[1]])
    } else {
      names_FUN.VALUE <- dimnames(FUN.VALUE)
      if (is.null(names_FUN.VALUE)) names_FUN.VALUE <- dimnames(res[[1]])
    }
  }
  
  res <- unlist(res, use.names = FALSE)
  if (is.null(res)) res <- vector(mode = type, length = 0L)
  if (!is.null(dim_res)) dim(res) <- dim_res
  
  if (USE.NAMES) {
    if (is.array(res)) {
      n_dim <- length(dim(res))
      dimnames <- vector("list", length = n_dim)
      if (is.null(dim)) {
        names <- names(X)
        if (!is.null(names)) dimnames[[2]] <- names
        names <- names_FUN.VALUE
        if (!is.null(names)) dimnames[[1]] <- names
      } else {
        names <- names(X)
        if (!is.null(names)) dimnames[[n_dim]] <- names
        names <- names_FUN.VALUE
        if (!is.null(names)) dimnames[-n_dim] <- names
      }
      if (!all(unlist(lapply(dimnames, FUN = is.null), use.names = FALSE))) {
        dimnames(res) <- dimnames
      }
    } else {
      names(res) <- names(X)
    }
  }
  
  res  
}
