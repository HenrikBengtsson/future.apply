#' Apply a Function to a Data Frame Split by Factors via Futures
#'
#' @param data An \R object, normally a data frame, possibly a matrix.
#' 
#' @param INDICES A factor or a list of factors, each of length `nrow(data)`.
#'
#' @param FUN a function to be applied to (usually data-frame) subsets of `data`.
#'
#' @param \ldots Additional arguments pass to [future_lapply()] and
#'   then to `FUN()`.
#'
#' @param simplify logical: see [base::tapply].
#' 
#' @return
#' An object of class "by", giving the results for each subset.
#' This is always a list if simplify is false, otherwise a list
#' or array (see [base::tapply]).
#' See also [base::by()] for details.
#'
#' @example incl/future_by.R
#'
#' @details
#' Internally, `data` is grouped by `INDICES` into a list of `data`
#' subset elements which is then processed by [future_lapply()].
#' When the groups differ significantly in size, the processing time
#' may differ significantly between the groups.
#' To correct for processing-time imbalances, adjust the amount of chunking
#' via arguments `future.scheduling` and `future.chunk.size`.
#'
#' @rdname future_by
#' @export
future_by <- function(data, INDICES, FUN, ..., simplify = TRUE) {
  UseMethod("future_by")
}


#' @export
future_by.default <- function(data, INDICES, FUN, ..., simplify = TRUE) {
  ndim <- length(dim(data))
  .SUBSETTER <- if (ndim == 0L) {
     function(row) data[row, , drop = TRUE]
  } else {
     function(row) data[row, , drop = FALSE]
  }

  data <- as.data.frame(data)
  future_by_internal(data = data, INDICES = INDICES, FUN = FUN, ...,
                     simplify = simplify,
		     .INDICES.NAME = deparse(substitute(INDICES))[1L],
		     .CALL = match.call(),
		     .SUBSETTER = .SUBSETTER)
}


#' @export
future_by.data.frame <- function(data, INDICES, FUN, ..., simplify = TRUE) {
  future_by_internal(data = data, INDICES = INDICES, FUN = FUN, ...,
                     simplify = simplify,
		     .INDICES.NAME = deparse(substitute(INDICES))[1L],
		     .CALL = match.call(),
		     .SUBSETTER = function(row) data[row, , drop = FALSE])
}



future_by_internal <- function(data, INDICES, FUN, ..., simplify = TRUE, .SUBSETTER, .CALL, .INDICES.NAME) {
  FUN <- if (!is.null(FUN)) match.fun(FUN)
  stop_if_not(is.function(.SUBSETTER))

  if (!is.list(INDICES)) {
    INDEX <- vector("list", length = 1L)
    INDEX[[1L]] <- INDICES
    names(INDEX) <- .INDICES.NAME
    INDICES <- INDEX
    INDEX <- NULL ## Not needed anymore
  }

  INDICES <- lapply(INDICES, FUN = as.factor)
  nI <- length(INDICES)
  if (!nI) stop("'INDICES' is of length zero")

  nd <- nrow(data)
  if (!all(lengths(INDICES) == nd)) {
    stop("All elements of argument 'INDICES' must have same length as 'data'")
  }

  namelist <- lapply(INDICES, FUN = levels)
  extent <- lengths(namelist, use.names = FALSE)
  cumextent <- cumprod(extent)
  if (cumextent[nI] > .Machine$integer.max) 
    stop("total number of levels >= 2^31")

  storage.mode(cumextent) <- "integer"
  ngroup <- cumextent[nI]
  group <- as.integer(INDICES[[1L]])
  if (nI > 1L) {
    for (i in 2L:nI) {
      group <- group + cumextent[i - 1L] * (as.integer(INDICES[[i]]) - 1L)
    }
  }
  cumextent <- NULL ## Not needed anymore
  
  levels(group) <- as.character(seq_len(ngroup))
  class(group) <- "factor"
  ans <- split(seq_len(nd), f = group)
  names(ans) <- NULL
  index <- as.logical(lengths(ans) > 0L)
  group <- NULL ## Not needed anymore

  grouped_data <- lapply(X = ans[index], FUN = .SUBSETTER)
  ans <- future_lapply(X = grouped_data, FUN = FUN, ...)
  grouped_data <- NULL  ## Not needed anymore

  ansmat <- array({
    if (simplify && all(lengths(ans) == 1L)) {
      ans <- unlist(ans, recursive = FALSE, use.names = FALSE)
      if (!is.null(ans) && is.atomic(ans)) vector(typeof(ans)) else NA
    } else {
      vector("list", length = prod(extent))
    }
  }, dim = extent, dimnames = namelist)
  
  if (length(ans) > 0L) ansmat[index] <- ans
  ans <- NULL ## Not needed anymore
  
  structure(ansmat,
    call = .CALL,
    class = "by"
  )
}
