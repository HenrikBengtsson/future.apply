source("incl/start.R")

message("*** future_pvec() ...")

## Tests adopted from example("pvec", package = "parallel")

n <- 1e3
dates <- sprintf('%04d-%02d-%02d', as.integer(2000+rnorm(n)),
                 as.integer(runif(n, min = 1, max = 12)),
                 as.integer(runif(n, min = 1, max = 28)))

for (strategy in supportedStrategies()) {
  message(sprintf("*** strategy = %s ...", sQuote(strategy)))
  plan(strategy)
  
  truth <- sqrt(1:1000)
  y <- future_pvec(1:1000, FUN = sqrt)
  str(y)
  stopifnot(identical(y, truth))

  truth <- as.POSIXct(dates, format = "%Y-%m-%d")
  y <- future_pvec(dates, FUN = as.POSIXct, format = "%Y-%m-%d")
  str(y)
  stopifnot(identical(y, truth))
  
  plan(sequential)
  message(sprintf("*** strategy = %s ... done", sQuote(strategy)))
} ## for (strategy in ...) 

message("*** future_pvec() ... DONE")

source("incl/end.R")
