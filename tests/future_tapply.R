source("incl/start.R")

message("*** future_tapply() ...")

for (strategy in supportedStrategies()) {
  message(sprintf("*** strategy = %s ...", sQuote(strategy)))
  plan(strategy)

  message("- From example(tapply) ...")
  
  library("stats")  ## rbinom()
  
  groups <- as.factor(rbinom(32, n = 5, prob = 0.4))
  t <- table(groups)
  print(t)
  
  y0 <- tapply(groups, INDEX = groups, FUN = length)
  print(y0)
  y1 <- future_tapply(groups, INDEX = groups, FUN = length)
  print(y1)
  stopifnot(all.equal(y1, y0))
  
  
  ## contingency table from data.frame : array with named dimnames
  y0 <- tapply(warpbreaks$breaks, INDEX = warpbreaks[,-1], FUN = sum)
  print(y0)
  y1 <- future_tapply(warpbreaks$breaks, INDEX = warpbreaks[,-1], FUN = sum)
  print(y1)
  stopifnot(all.equal(y1, y0))
  
  y0 <- tapply(warpbreaks$breaks, warpbreaks[, 3, drop = FALSE], sum)
  y1 <- future_tapply(warpbreaks$breaks, warpbreaks[, 3, drop = FALSE], sum)
  stopifnot(all.equal(y1, y0))
  
  n <- 17
  fac <- factor(rep_len(1:3, n), levels = 1:5)
  t <- table(fac)
  
  y0 <- tapply(1:n, fac, sum)
  y1 <- future_tapply(1:n, fac, sum)
  stopifnot(all.equal(y1, y0))
  
  y0 <- tapply(1:n, fac, sum, default = 0) # maybe more desirable
  y1 <- future_tapply(1:n, fac, sum, default = 0) # maybe more desirable
  stopifnot(all.equal(y1, y0))
  
  y0 <- tapply(1:n, fac, sum, simplify = FALSE)
  y1 <- future_tapply(1:n, fac, sum, simplify = FALSE)
  stopifnot(all.equal(y1, y0))
  
  y0 <- tapply(1:n, fac, range)
  y1 <- future_tapply(1:n, fac, range)
  stopifnot(all.equal(y1, y0))
  
  y0 <- tapply(1:n, fac, quantile)
  y1 <- future_tapply(1:n, fac, quantile)
  stopifnot(all.equal(y1, y0))
  
  y0 <- tapply(1:n, fac, length) ## NA's
  y1 <- future_tapply(1:n, fac, length) ## NA's
  stopifnot(all.equal(y1, y0))
  
  y0 <- tapply(1:n, fac, length, default = 0) # == table(fac)
  y1 <- future_tapply(1:n, fac, length, default = 0) # == table(fac)
  stopifnot(all.equal(y1, y0))
  
  ## example of ... argument: find quarterly means
  y0 <- tapply(presidents, cycle(presidents), mean, na.rm = TRUE)
  y1 <- future_tapply(presidents, cycle(presidents), mean, na.rm = TRUE)
  stopifnot(all.equal(y1, y0))
  
  ind <- list(c(1, 2, 2), c("A", "A", "B"))
  t <- table(ind)
  print(t)
  
  y0 <- tapply(1:3, ind) #-> the split vector
  y1 <- future_tapply(1:3, ind) #-> the split vector
  stopifnot(all.equal(y1, y0))
  
  y0 <- tapply(1:3, ind, sum)
  y1 <- future_tapply(1:3, ind, sum)
  stopifnot(all.equal(y1, y0))
  
  ## Some assertions (not held by all patch propsals):
  nq <- names(quantile(1:5))
  y_truth <- c(1L, 2L, 4L)
  stopifnot(identical(tapply(1:3, ind), y_truth))
  stopifnot(identical(future_tapply(1:3, ind), y_truth))
  
  y_truth <- matrix(c(1L, 2L, NA, 3L), nrow = 2L,
                    dimnames = list(c("1", "2"), c("A", "B")))
  stopifnot(identical(tapply(1:3, ind, sum), y_truth))
  stopifnot(identical(future_tapply(1:3, ind, sum), y_truth))
  
  y_truth <- array(list(
    `2` = structure(c(2, 5.75, 9.5, 13.25, 17), .Names = nq),
    `3` = structure(c(3, 6, 9, 12, 15), .Names = nq),
    `4` = NULL, `5` = NULL),
    dim = 4L, dimnames = list(as.character(2:5)))
  stopifnot(identical(tapply(1:n, fac, quantile)[-1], y_truth))
  stopifnot(identical(future_tapply(1:n, fac, quantile)[-1], y_truth))
  
  plan(sequential)
  message(sprintf("*** strategy = %s ... done", sQuote(strategy)))
} ## for (strategy in ...) 

message("*** future_tapply() ... DONE")

source("incl/end.R")
