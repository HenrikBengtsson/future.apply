source("incl/start.R")

message("*** future_eapply() ...")

message("- From example(eapply) ...")

for (strategy in supportedStrategies()) {
  message(sprintf("*** strategy = %s ...", sQuote(strategy)))
  plan(strategy)
  
  env <- new.env(hash = FALSE)
  env$a <- 1:10
  env$beta <- exp(-3:3)
  env$logic <- c(TRUE, FALSE, FALSE, TRUE)
  
  y0 <- unlist(eapply(env, mean, USE.NAMES = FALSE))
  y1 <- unlist(future_eapply(env, mean, USE.NAMES = FALSE))
  stopifnot(all.equal(y1, y0))
  
  y0 <- eapply(env, quantile, probs = 1:3/4)
  y1 <- future_eapply(env, quantile, probs = 1:3/4)
  stopifnot(all.equal(y1, y0))
  
  y0 <- eapply(env, quantile)
  y1 <- future_eapply(env, quantile)
  stopifnot(all.equal(y1, y0))
  y2 <- future_eapply(env, "quantile")
  stopifnot(all.equal(y2, y0))

  plan(sequential)
  message(sprintf("*** strategy = %s ... done", sQuote(strategy)))
} ## for (strategy in ...) 

message("*** future_eapply() ... DONE")

source("incl/end.R")
