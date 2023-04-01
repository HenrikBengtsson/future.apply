source("incl/start.R")

library("datasets") ## warpbreaks, iris

options(future.debug = FALSE)
message("*** future_tapply() ...")

for (strategy in supportedStrategies()[1]) {
  message(sprintf("*** strategy = %s ...", sQuote(strategy)))
  plan(strategy)

  message("- From example(tapply) ...")

  message("  - Example #1")
  library("stats")  ## rbinom()
  groups <- as.factor(stats::rbinom(32, n = 5, prob = 0.4))
  t <- table(groups)
  print(t)
  y0 <- tapply(groups, INDEX = groups, FUN = length)
  print(y0)
  y1 <- future_tapply(groups, INDEX = groups, FUN = length)
  print(y1)
  stopifnot(all.equal(y1, y0))
  y2 <- future_tapply(groups, INDEX = groups, FUN = "length")
  print(y2)
  stopifnot(all.equal(y2, y0))

  message("  - Example #2")
  ## contingency table from data.frame : array with named dimnames
  y0 <- tapply(warpbreaks$breaks, INDEX = warpbreaks[,-1], FUN = sum)
  print(y0)
  y1 <- future_tapply(warpbreaks$breaks, INDEX = warpbreaks[,-1], FUN = sum)
  print(y1)
  stopifnot(all.equal(y1, y0))

  message("  - Example #3")
  y0 <- tapply(warpbreaks$breaks, warpbreaks[, 3, drop = FALSE], sum)
  print(y0)
  y1 <- future_tapply(warpbreaks$breaks, warpbreaks[, 3, drop = FALSE], sum)
  print(y1)
  stopifnot(all.equal(y1, y0))
  
  message("  - Example #4")
  n <- 17
  fac <- factor(rep_len(1:3, n), levels = 1:5)
  t <- table(fac)  
  y0 <- tapply(1:n, fac, sum)
  print(y0)
  y1 <- future_tapply(1:n, fac, sum)
  print(y1)
  stopifnot(all.equal(y1, y0))
  
  message("  - Example #5")
  if ("default" %in% names(formals(tapply))) {
    y0 <- tapply(1:n, fac, sum, default = 0) # maybe more desirable
    print(y0)
    y1 <- future_tapply(1:n, fac, sum, default = 0) # maybe more desirable
    print(y1)
    stopifnot(all.equal(y1, y0))
  }
  
  message("  - Example #6")
  y0 <- tapply(1:n, fac, sum, simplify = FALSE)
  print(y0)
  y1 <- future_tapply(1:n, fac, sum, simplify = FALSE)
  print(y1)
  stopifnot(all.equal(y1, y0))
  
  message("  - Example #7")
  y0 <- tapply(1:n, fac, range)
  print(y0)
  y1 <- future_tapply(1:n, fac, range)
  print(y1)
  stopifnot(all.equal(y1, y0))
  
  message("  - Example #8")
  y0 <- tapply(1:n, fac, quantile)
  print(y0)
  y1 <- future_tapply(1:n, fac, quantile)
  print(y1)
  stopifnot(all.equal(y1, y0))
  
  message("  - Example #9")
  y0 <- tapply(1:n, fac, length) ## NA's
  print(y0)
  y1 <- future_tapply(1:n, fac, length) ## NA's
  print(y1)
  stopifnot(all.equal(y1, y0))
  
  message("  - Example #10")
  if ("default" %in% names(formals(tapply))) {
    y0 <- tapply(1:n, fac, length, default = 0) # == table(fac)
    print(y0)
    y1 <- future_tapply(1:n, fac, length, default = 0) # == table(fac)
    print(y1)
    stopifnot(all.equal(y1, y0))
  }
  
  message("  - Example #11")
  ## example of ... argument: find quarterly means
  y0 <- tapply(presidents, cycle(presidents), mean, na.rm = TRUE)
  print(y0)
  y1 <- future_tapply(presidents, cycle(presidents), mean, na.rm = TRUE)
  print(y1)
  stopifnot(all.equal(y1, y0))
  
  message("  - Example #12")
  ind <- list(c(1, 2, 2), c("A", "A", "B"))
  t <- table(ind)
  print(t)
  y0 <- tapply(1:3, ind) #-> the split vector
  print(y0)
  y1 <- future_tapply(1:3, ind) #-> the split vector
  print(y1)
  stopifnot(all.equal(y1, y0))
  
  message("  - Example #13")
  y0 <- tapply(1:3, ind, sum)
  print(y0)
  y1 <- future_tapply(1:3, ind, sum)
  print(y1)
  stopifnot(all.equal(y1, y0))
  
  ## Some assertions (not held by all patch propsals):
  message("  - Example #14")
  nq <- names(quantile(1:5))
  y_truth <- c(1L, 2L, 4L)
  stopifnot(identical(tapply(1:3, ind), y_truth))
  stopifnot(identical(future_tapply(1:3, ind), y_truth))
  
  message("  - Example #15")
  y_truth <- matrix(c(1L, 2L, NA, 3L), nrow = 2L,
                    dimnames = list(c("1", "2"), c("A", "B")))
  stopifnot(identical(tapply(1:3, ind, sum), y_truth))
  stopifnot(identical(future_tapply(1:3, ind, sum), y_truth))
  
  message("  - Example #16")
  y_truth <- array(list(
    `2` = structure(c(2, 5.75, 9.5, 13.25, 17), .Names = nq),
    `3` = structure(c(3, 6, 9, 12, 15), .Names = nq),
    `4` = NULL, `5` = NULL),
    dim = 4L, dimnames = list(as.character(2:5)))
  stopifnot(identical(tapply(1:n, fac, quantile)[-1], y_truth))
  stopifnot(identical(future_tapply(1:n, fac, quantile)[-1], y_truth))

  if (getRversion() >= "4.3.0") {
    data <- iris[, c("Sepal.Length", "Sepal.Width")]
    y_truth <- tapply(data, INDEX = iris$Species, FUN = sum)
    y <- future_tapply(data, INDEX = iris$Species, FUN = sum)
    stopifnot(identical(y, y_truth))
    
    y_truth2 <- tapply(data, INDEX = ~ iris$Species + iris$Petal.Width, FUN = sum)
    y2 <- future_tapply(data, INDEX = ~ iris$Species + iris$Petal.Width, FUN = sum)
    stopifnot(identical(y2, y_truth2))
  }

  plan(sequential)
  message(sprintf("*** strategy = %s ... done", sQuote(strategy)))
} ## for (strategy in ...) 


message("*** exceptions ...")

## Error: 'INDEX' is of length zero
res <- tryCatch({
  y <- future_tapply(1L, INDEX = list())
}, error = identity)
stopifnot(inherits(res, "error"))

## Error: total number of levels >= 2^31
res <- tryCatch({
  y <- future_tapply(1:216, INDEX = rep(list(1:216), times = 4L))
}, error = identity)
stopifnot(inherits(res, "error"))

## Error: arguments must have same length
res <- tryCatch({
  y <- future_tapply(1L, INDEX = list(1:2))
}, error = identity)
stopifnot(inherits(res, "error"))

message("*** future_tapply() ... DONE")

source("incl/end.R")
