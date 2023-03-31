`chunkWith[[` <- function(x, subset) {
  if (getOption("future.apply.chunkWith", "[[") == "[") {
    return(x[subset])
  }
  
  ## Make sure to preserve behavior of S3 method-specific
  ## `[[` subsetting like lapply() and mapply() does it
  ny <- length(subset)
  y <- vector("list", length = ny)
  names(y) <- names(x)[subset]
  for (kk in seq_len(ny)) {
    idx <- subset[kk]
    value <- x[[idx]]
    if (is.null(value)) {
      y[kk] <- list(value)
    } else {
      y[[kk]] <- value
    }
  }
  y
}
