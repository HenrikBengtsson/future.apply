source("incl/start.R")

message("*** future_mapply() - globals ...")

#plan(cluster, workers = "localhost")
plan(sequential)

options(future.debug = FALSE)
a <- 1
b <- 2

globals_set <- list(
  A = FALSE,
  B = TRUE,
  C = c("a", "b"),
  D = list(a = 2, b = 3)
)

x <- list(1)

for (name in names(globals_set)) {
  globals <- globals_set[[name]]
  message("Globals set ", sQuote(name))
  y_truth <- tryCatch({
    mapply(function(x) median(c(x, a, b)), x)
  }, error = identity)
  
  y <- tryCatch({
    future_mapply(function(x) median(c(x, a, b)), x,
                  future.globals = globals, future.packages = "utils")
  }, error = identity)
  print(y)
  stopifnot(identical(y, y_truth))
}

message("*** future_mapply() - globals ... DONE")



## Test adopted from http://stackoverflow.com/questions/42561088/nested-do-call-within-a-foreach-dopar-environment-cant-find-function-passed-w

message("*** future_mapply() - tricky globals ...")

my_add <- function(a, b) a + b

call_my_add <- function(a, b) {
  do.call(my_add, args = list(a = a, b = b))
}

call_my_add_caller <- function(a, b, FUN = call_my_add) {
  do.call(FUN, args = list(a = a, b = b))
}

main <- function(x = 1:2, caller = call_my_add_caller,
                 args = list(FUN = call_my_add)) {
  results <- future_mapply(function(i) {
    do.call(caller, args = c(list(a = i, b = i + 1L), args))
  }, x)
  results
}

x <- list(list(1:2))
z_length <- mapply(do.call, args = x, MoreArgs = list(what = length))
fun <- function(...) sum(...)
z_fun <- mapply(do.call, args = x, MoreArgs = list(what = fun))

y0 <- NULL
for (strategy in supportedStrategies()) {
  plan(strategy)

  y <- main(1:3)
  if (is.null(y0)) y0 <- y
  stopifnot(identical(y, y0))

  message("- future_mapply(do.call, x, ...) ...")
  z <- future_mapply(do.call, args = x, MoreArgs = list(what = length))
  stopifnot(identical(z, z_length))
  z <- future_mapply(do.call, args = x, MoreArgs = list(what = fun))
  stopifnot(identical(z, z_fun))

  message("- future_mapply(FUN, x, ...) - passing arguments via '...' ...")
  ## typeof() == "list"
  obj <- data.frame(a = 1:2)
  stopifnot(typeof(obj) == "list")
  y <- future_mapply(function(a, b) typeof(b), 1L, MoreArgs = list(b = obj))
  stopifnot(identical(y[[1]], typeof(obj)))

  ## typeof() == "environment"
  obj <- new.env()
  stopifnot(typeof(obj) == "environment")
  y <- future_mapply(function(a, b) typeof(b), 1L, MoreArgs = list(b = obj))
  stopifnot(identical(y[[1]], typeof(obj)))

  ## typeof() == "S4"
  if (requireNamespace("methods")) {
    obj <- methods::getClass("MethodDefinition")
    stopifnot(typeof(obj) == "S4")
    y <- future_mapply(function(a, b) typeof(b), 1L, MoreArgs = list(b = obj))
    stopifnot(identical(y[[1]], typeof(obj)))
  }

  message("- future_mapply(FUN, X, ...) - 'X' containing globals ...")
  ## From https://github.com/HenrikBengtsson/future.apply/issues/12
  a <- 42
  b <- 21
  X <- list(
    function(b) 2 * a,
    function() b / 2,
    function() a + b,
    function() 3.14
  )
  z0 <- mapply(function(s, f) f() + s, s = seq_along(X), X)
  str(z0)
  z1 <- future_mapply(function(s, f) f() + s, s = seq_along(X), X)
  str(z1)
  stopifnot(identical(z1, z0))
}

message("*** future_mapply() - tricky globals ... DONE")


message("*** future_mapply() - missing arguments ...")

## Here 'abc' becomes missing, i.e. missing(abc) is TRUE
foo <- function(x, abc) mapply(function(y) y, x)
y0 <- foo(1:2)
foo <- function(x, abc) future_mapply(function(y) y, x)
y <- foo(1:2)
stopifnot(identical(y, y0))

message("*** future_mapply() - missing arguments ... DONE")


message("*** future_mapply() - false positives ...")

## Here 'abc' becomes a promise, which fails to resolve
## iff 'xyz' does not exist. (Issue #161)
suppressWarnings(rm(list = "xyz"))
foo <- function(x, abc) mapply(function(y) y, x)
y0 <- foo(1:2, abc = (xyz >= 3.14))
foo <- function(x, abc) future_mapply(function(y) y, x)
y <- foo(1:2, abc = (xyz >= 3.14))
stopifnot(identical(y, y0))

message("*** future_mapply() - false positives ... DONE")


message("*** future_mapply() - globals exceptions ...")

res <- tryCatch({
  y <- future_mapply(function(x) x, 1, future.globals = 42)
}, error = identity)
stopifnot(inherits(res, "error"))

res <- tryCatch({
  y <- future_mapply(function(x) x, 1, future.globals = list(1))
}, error = identity)
stopifnot(inherits(res, "error"))

res <- tryCatch({
  y <- future_mapply(function(x) x, 1, future.globals = "...future.FUN")
}, error = identity)
stopifnot(inherits(res, "error"))

message("*** future_mapply() - globals exceptions ... DONE")

source("incl/end.R")
