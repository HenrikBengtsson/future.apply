source("incl/start.R")

## Test adopted from http://stackoverflow.com/questions/42561088/nested-do-call-within-a-foreach-dopar-environment-cant-find-function-passed-w

options(future.debug = FALSE)

message("*** Tricky globals requiring recursive search ...")

my_add <- function(a, b) a + b

call_my_add <- function(a, b) {
  do.call(my_add, args = list(a = a, b = b))
}

call_my_add_caller <- function(a, b, FUN = call_my_add) {
  do.call(FUN, args = list(a = a, b = b))
}

main_lapply <- function(x = 1:2, caller = call_my_add_caller,
                               args = list(FUN = call_my_add)) {
  lapply(x, FUN = function(i) {
    do.call(caller, args = c(list(a = i, b = i+1L), args))
  })
}

main_lapply_no_FUN <- function(x = 1:2, caller = call_my_add_caller,
                               args = list(FUN = call_my_add)) {
  lapply(x, FUN = function(i) {
    do.call(caller, args = list(a = i, b = i+1L))
  })
}

main_future_lapply <- function(x = 1:2, caller = call_my_add_caller,
                               args = list(FUN = call_my_add)) {
  future_lapply(x, FUN = function(i) {
    do.call(caller, args = c(list(a = i, b = i + 1L), args))
  })
}

main_future_lapply_no_FUN <- function(x = 1:2, caller = call_my_add_caller,
                               args = list(FUN = call_my_add)) {
  future_lapply(x, FUN = function(i) {
    do.call(caller, args = list(a = i, b = i + 1L))
  })
}

x0 <- y0 <- z0 <- NULL
for (strategy in supportedStrategies()) {
  message(sprintf("*** strategy = %s ...", sQuote(strategy)))
  
  plan(strategy)

  z <- main_lapply()
  str(list(z = z))
  if (is.null(z0)) z0 <- z
  stopifnot(identical(z, z0))

  z2 <- main_lapply_no_FUN()
  str(list(z2 = z2))
  stopifnot(identical(z2, z0))
  
  z3 <- main_future_lapply()
  str(list(z3 = z3))
  stopifnot(identical(z3, z0))

  z4 <- main_future_lapply_no_FUN()
  str(list(z4 = z4))
  stopifnot(identical(z4, z0))
  
  message(sprintf("*** strategy = %s ... DONE", sQuote(strategy)))
}

message("*** Tricky globals requiring recursive search ... DONE")

source("incl/end.R")
