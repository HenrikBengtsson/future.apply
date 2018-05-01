source("incl/start.R")

message("*** future_replicate() ...")

for (strategy in supportedStrategies()) {
  message(sprintf("*** strategy = %s ...", sQuote(strategy)))
  plan(strategy)
  
  y0 <- replicate(5L, sample(10L, size = 1L))
  y1 <- future_replicate(5L, sample(10L, size = 1L))
  stopifnot(length(y0) == length(y1))
  
  set.seed(0xBEEF)
  y1 <- future_replicate(5L, sample(10L, size = 1L))
  set.seed(0xBEEF)
  y2 <- future_replicate(5L, sample(10L, size = 1L))
  stopifnot(all.equal(y2, y1))
  
  y3 <- future_replicate(5L, sample(10L, size = 1L), future.seed = 0xBEEF)
  y4 <- future_replicate(5L, sample(10L, size = 1L), future.seed = 0xBEEF)
  stopifnot(all.equal(y4, y3))
  
  
  message("- example(replicate) ...")
  
  foo <- function(x = 1, y = 2) c(x, y)
  bar0 <- function(n, x) replicate(n, foo(x = x))
  y0 <- bar0(5, x = 3)
  
  bar1 <- function(n, x) future_replicate(n, foo(x = x))
  y1 <- bar1(5, x = 3)
  stopifnot(all.equal(y1, y0))
  
  plan(sequential)
  message(sprintf("*** strategy = %s ... done", sQuote(strategy)))
} ## for (strategy in ...) 

message("*** future_replicate() ... DONE")

source("incl/end.R")
