source("incl/start.R")
library("tools") ## toTitleCase()

message("*** future_lapply() - globals ...")

plan(cluster, workers = "localhost")

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
y_truth <- list(A = NULL, B = list(1), C = list(1), D = list(2))
str(y_truth)

for (name in names(globals_set)) {
  globals <- globals_set[[name]]
  message("Globals set ", sQuote(name))
  y <- tryCatch({
    future_lapply(x, FUN = function(x) {
      median(c(x, a, b))
    }, future.globals = globals, future.packages = "utils")
  }, error = identity)
  print(y)
  stopifnot((name == "A" && inherits(y, "error")) || 
             identical(y, y_truth[[name]]))
}

message("*** future_lapply() - globals ... DONE")


message("*** future_lapply() - manual globals ...")

d <- 42
y <- future_lapply(1:2, FUN = function(x) { x * d },
                   future.globals = structure(FALSE, add = "d"))
stopifnot(identical(y, list(42, 84)))

e <- 42
res <- tryCatch({
  future_lapply(1:2, FUN = function(x) { 2 * e },
                future.globals = structure(TRUE, ignore = "e"))
}, error = identity)
stopifnot(inherits(res, "error"))

message("*** future_lapply() - manual globals ... DONE")



## Test adopted from http://stackoverflow.com/questions/42561088/nested-do-call-within-a-foreach-dopar-environment-cant-find-function-passed-w

message("*** future_lapply() - tricky globals ...")

my_add <- function(a, b) a + b

call_my_add <- function(a, b) {
  do.call(my_add, args = list(a = a, b = b))
}

call_my_add_caller <- function(a, b, FUN = call_my_add) {
  do.call(FUN, args = list(a = a, b = b))
}

main <- function(x = 1:2, caller = call_my_add_caller,
                 args = list(FUN = call_my_add)) {
  results <- future_lapply(x, FUN = function(i) {
    do.call(caller, args = c(list(a = i, b = i + 1L), args))
  })
  results
}

x <- list(list(1:2))
z_length <- lapply(x, FUN = do.call, what = length)
fun <- function(...) sum(...)
z_fun <- lapply(x, FUN = do.call, what = fun)

y0 <- NULL
for (strategy in supportedStrategies()) {
  plan(strategy)

  y <- main(1:3)
  if (is.null(y0)) y0 <- y
  stopifnot(identical(y, y0))

  message("- future_lapply(x, FUN = do.call, ...) ...")
  z <- future_lapply(x, FUN = do.call, what = length)
  stopifnot(identical(z, z_length))
  z <- future_lapply(x, FUN = do.call, what = fun)
  stopifnot(identical(z, z_fun))

  message("- future_lapply(x, ...) - passing arguments via '...' ...")
  ## typeof() == "list"
  obj <- data.frame(a = 1:2)
  stopifnot(typeof(obj) == "list")
  y <- future_lapply(1L, function(a, b) typeof(b), b = obj)
  stopifnot(identical(y[[1]], typeof(obj)))

  ## typeof() == "environment"
  obj <- new.env()
  stopifnot(typeof(obj) == "environment")
  y <- future_lapply(1L, function(a, b) typeof(b), b = obj)
  stopifnot(identical(y[[1]], typeof(obj)))

  ## typeof() == "S4"
  if (requireNamespace("methods")) {
    obj <- methods::getClass("MethodDefinition")
    stopifnot(typeof(obj) == "S4")
    y <- future_lapply(1L, function(a, b) typeof(b), b = obj)
    stopifnot(identical(y[[1]], typeof(obj)))
  }

  message("- future_lapply(X, ...) - 'X' containing globals ...")
  ## From https://github.com/HenrikBengtsson/future.apply/issues/12
  a <- 42
  b <- 21
  X <- list(
    function(b) 2 * a,
    function() b / 2,
    function() a + b,
    function() nchar(toTitleCase("hello world"))
  )
  z0 <- lapply(X, FUN = function(f) f())
  str(z0)
  z1 <- future_lapply(X, FUN = function(f) f())
  str(z1)
  stopifnot(identical(z1, z0))

  ## https://github.com/HenrikBengtsson/future.apply/issues/47
  message("- future_lapply(X, ...) - '{ a <- a + 1; a }' ...")
  a <- 1
  z0 <- lapply(1, function(ii) {
    a <- a + 1
    a
  })
  z1 <- future_lapply(1, function(ii) {
    a <- a + 1
    a
  })
  stopifnot(identical(z1, z0))

  ## https://github.com/HenrikBengtsson/future.apply/issues/47
  message("- future_lapply(X, ...) - '{ a; a <- a + 1 }' ...")
  z2 <- tryCatch(future_lapply(1, function(ii) {
    a
    a <- a + 1
  }), error = identity)
  if (packageVersion("globals") <= "0.12.4" && strategy %in% c("multisession")) {
    stopifnot(inherits(z2, "error"))
  } else {
    stopifnot(identical(z2, z0))
  }
} ## for (strategy ...)

message("*** future_lapply() - tricky globals ... DONE")


message("*** future_lapply() - missing arguments ...")

## Here 'abc' becomes missing, i.e. missing(abc) is TRUE
foo <- function(x, abc) future_lapply(x, FUN = function(y) y)
y <- foo(1:2)
stopifnot(identical(y, as.list(1:2)))

message("*** future_lapply() - missing arguments ... DONE")


message("*** future_lapply() - false positives ...")

## Here 'abc' becomes a promise, which fails to resolve
## iff 'xyz' does not exist. (Issue #161)
suppressWarnings(rm(list = "xyz"))
foo <- function(x, abc) future_lapply(x, FUN = function(y) y)
y <- foo(1:2, abc = (xyz >= 3.14))
stopifnot(identical(y, as.list(1:2)))

message("*** future_lapply() - false positives ... DONE")


message("*** future_lapply() - too large ...")

oMaxSize <- getOption("future.globals.maxSize")
X <- replicate(10L, 1:100, simplify = FALSE)
FUN <- function(x) {
  getOption("future.globals.maxSize")
}

y0 <- lapply(X, FUN = FUN)
stopifnot(all(sapply(y0, FUN = identical, oMaxSize)))

sizes <- unclass(c(FUN = object.size(FUN), X = object.size(X)))
cat(sprintf("Baseline size of globals: %.2f KiB\n", sizes[["FUN"]] / 1024))

message("- true positive ...")
options(future.globals.maxSize = 1L)
res <- tryCatch({
  y <- future_lapply(X, FUN = FUN)
}, error = identity)
stopifnot(inherits(res, "error"))
res <- NULL
options(future.globals.maxSize = oMaxSize)

maxSize <- getOption("future.globals.maxSize")
y <- future_lapply(X, FUN = FUN)
str(y)
stopifnot(all(sapply(y, FUN = identical, oMaxSize)))

message("- approximately invariant to chunk size ...")
maxSize <- sizes[["FUN"]] + sizes[["X"]] / length(X)
options(future.globals.maxSize = maxSize)

for (chunk.size in c(1L, 2L, 5L, 10L)) {
  y <- future_lapply(X, FUN = FUN, future.chunk.size = chunk.size)
  str(y)
  stopifnot(all(unlist(y) == maxSize))
  cat(sprintf("maxSize = %g bytes\nfuture.globals.maxSize = %g bytes\n",
              maxSize, getOption("future.globals.maxSize")))
  stopifnot(getOption("future.globals.maxSize") == maxSize)
}
y <- NULL
options(future.globals.maxSize = oMaxSize)


message("*** future_lapply() - too large ... DONE")


message("*** future_lapply() - globals exceptions ...")

res <- tryCatch({
  y <- future_lapply(1, FUN = function(x) x, future.globals = 42)
}, error = identity)
stopifnot(inherits(res, "error"))

res <- tryCatch({
  y <- future_lapply(1, FUN = function(x) x, future.globals = list(1))
}, error = identity)
stopifnot(inherits(res, "error"))

res <- tryCatch({
  y <- future_lapply(1, FUN = function(x) x, future.globals = "...future.FUN")
}, error = identity)
stopifnot(inherits(res, "error"))

res <- tryCatch({
  y <- future_lapply(1, FUN = function(x) x, future.globals = "...future.FUN")
}, error = identity)
stopifnot(inherits(res, "error"))

...future.elements_ii <- 42L
X <- list(function() 2 * ...future.elements_ii)
res <- tryCatch({
  y <- future_lapply(X, FUN = function(f) f())
}, error = identity)
stopifnot(inherits(res, "error"))

message("*** future_lapply() - globals exceptions ... DONE")

source("incl/end.R")
