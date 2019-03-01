source("incl/start.R")
library("listenv")

all_equal_but_call <- function(target, current, ...) {
  attr(target, "call") <- NULL
  attr(current, "call") <- NULL
  all.equal(target = target, current = current, ...)
}

message("*** future_by() ...")

## ---------------------------------------------------------
## by()
## ---------------------------------------------------------
if (require("datasets") && require("stats")) { ## warpbreaks & lm()
  ## Use a local variable to test that it is properly exported, because
  ## 'warpbreaks' is available in all R sessions
  data <- warpbreaks
  
  y0 <- by(data[, 1:2], INDICES = data[,"tension"], FUN = summary)
  y1 <- by(data[, 1], INDICES = data[, -1], FUN = summary, digits = 2L)
  y2 <- by(data, INDICES = data[,"tension"], FUN = function(x, ...) {
    lm(breaks ~ wool, data = x, ...)
  }, singular.ok = FALSE)
  
  ## now suppose we want to extract the coefficients by group
  tmp <- with(data, by(data, INDICES = tension, FUN = function(x) {
    lm(breaks ~ wool, data = x)
  }))
  y3 <- sapply(tmp, coef)

  ## Source: {r-source}/tests/reg-tests-1d.R
  by2 <- function(data, INDICES, FUN) {
    by(data, INDICES = INDICES, FUN = FUN)
  }
  future_by2 <- function(data, INDICES, FUN) {
    future_by(data, INDICES = INDICES, FUN = FUN)
  }
  y4 <- by2(data, INDICES = data[,"tension"], FUN = summary)

  for (cores in 1:availCores) {
    message(sprintf("Testing with %d cores ...", cores))
    options(mc.cores = cores)
    strategies <- supportedStrategies(cores)
  
    for (strategy in supportedStrategies()) {
      message(sprintf("- plan('%s') ...", strategy))
      plan(strategy)
    
      y0f <- future_by(data[, 1:2], INDICES = data[,"tension"], FUN = summary)
      stopifnot(all_equal_but_call(y0f, y0, check.attributes = FALSE))
      
      y1f <- future_by(data[, 1], INDICES = data[, -1], FUN = summary, digits = 2L)
      stopifnot(all_equal_but_call(y1f, y1))
      
      y2f <- future_by(data, INDICES = data[,"tension"], FUN = function(x, ...) {
        lm(breaks ~ wool, data = x, ...)
      }, singular.ok = FALSE)
      stopifnot(all_equal_but_call(y2f, y2))
      
      ## now suppose we want to extract the coefficients by group
      tmp <- with(data, future_by(data, INDICES = tension, FUN = function(x) {
        lm(breaks ~ wool, data = x)
      }))
      y3f <- sapply(tmp, coef)
      stopifnot(all_equal_but_call(y3f, y3))
      
      y4f <- future_by2(data, INDICES = data[,"tension"], FUN = summary)
      stopifnot(all_equal_but_call(y4f, y4))
    } ## for (strategy ...)
    
    message(sprintf("Testing with %d cores ... DONE", cores))
  } ## for (cores ...)
} ## if (require("stats"))

message("*** future_by() ... DONE")

source("incl/end.R")
