source("incl/start.R")

message("*** future_apply() ...")

for (strategy in supportedStrategies()) {
  message(sprintf("*** strategy = %s ...", sQuote(strategy)))
  plan(strategy)

  message("- From example(apply) ...")
  X <- matrix(c(1:4, 1, 6:8), nrow = 2L)
  
  Y0 <- apply(X, MARGIN = 1L, FUN = table)
  Y1 <- future_apply(X, MARGIN = 1L, FUN = table)
  print(Y1)
  stopifnot(all.equal(Y1, Y0, check.attributes = FALSE)) ## FIXME
  
  Y0 <- apply(X, MARGIN = 1L, FUN = stats::quantile)
  Y1 <- future_apply(X, MARGIN = 1L, FUN = stats::quantile)
  print(Y1)
  stopifnot(all.equal(Y1, Y0))

  x <- cbind(x1 = 3, x2 = c(4:1, 2:5))
  names(dimnames(x)) <- c("row", "col")
  x3 <- array(x, dim = c(dim(x), 3),
              dimnames = c(dimnames(x), list(C = paste0("cop.", 1:3))))
  
  y0 <- apply(x, MARGIN = 2L, FUN = identity)
  stopifnot(identical(y0, x))
  y1 <- future_apply(x, MARGIN = 2L, FUN = identity)
  print(y1)
  stopifnot(identical(y1, y0))
  
  y0 <- apply(x3, MARGIN = 2:3, FUN = identity)
  stopifnot(identical(y0, x3))
  y1 <- future_apply(x3, MARGIN = 2:3, FUN = identity)
  print(y1)
  stopifnot(identical(y1, y0))

  z <- array(1:24, dim = 2:4)
  y0 <- apply(z, MARGIN = 1:2, FUN = function(x) seq_len(max(x)))
  y1 <- future_apply(z, MARGIN = 1:2, FUN = function(x) seq_len(max(x)))
  print(y1)
  stopifnot(identical(y1, y0))

  message("- exceptions ...")
  
  plan(sequential)
  message(sprintf("*** strategy = %s ... done", sQuote(strategy)))
} ## for (strategy in ...) 


message("*** future_apply() ... DONE")

source("incl/end.R")
