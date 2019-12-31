source("incl/start.R")
library("listenv")

message("*** future_lapply() ...")

x_a <- list(a = "integer", b = "numeric", c = "character", c = "list")
str(list(x_a = x_a))
y_a <- lapply(x_a, FUN = base::vector, length = 2L)
str(list(y_a = y_a))

x_b <- list(a = c("hello", b = 1:100))
str(list(x_b = x_b))
y_b <- lapply(x_b, FUN = future:::hpaste, collapse = "; ", maxHead = 3L)
str(list(y_b = y_b))

x_c <- list()
y_c <- listenv()
y_c$A <- 3L
x_c$a <- y_c
y_c<- listenv()
y_c$A <- 3L
y_c$B <- c("hello", b = 1:100)
x_c$b <- y_c
print(x_c)
y_c <- lapply(x_c, FUN = listenv::map)
str(list(y_c = y_c))

for (cores in 1:availCores) {
  message(sprintf("Testing with %d cores ...", cores))
  options(mc.cores = cores)
  strategies <- supportedStrategies(cores)

  for (strategy in supportedStrategies()) {
    message(sprintf("- plan('%s') ...", strategy))
    plan(strategy)

    for (scheduling in list(FALSE, TRUE, structure(TRUE, ordering = "random"), structure(TRUE, ordering = function(n) rev(seq_len(n))))) {
      message("- future_lapply(x, FUN = vector, ...) ...")
      y <- future_lapply(x_a, FUN = vector, length = 2L, future.scheduling = scheduling)
      str(list(y = y))
      stopifnot(identical(y, y_a))
      
      message("- future_lapply(x, FUN = base::vector, ...) ...")
      y <- future_lapply(x_a, FUN = base::vector, length = 2L, future.scheduling = scheduling)
      str(list(y = y))
      stopifnot(identical(y, y_a))

      message("- future_lapply(x, FUN = future:::hpaste, ...) ...")
      y <- future_lapply(x_b, FUN = future:::hpaste, collapse = "; ", maxHead = 3L, future.scheduling = scheduling)
      str(list(y = y))
      stopifnot(identical(y, y_b))

      message("- future_lapply(x, FUN = listenv::listenv, ...) ...")
      y <- future_lapply(x_c, FUN = listenv::map, future.scheduling = scheduling)
      str(list(y = y))
      stopifnot(identical(y, y_c))
    } ## for (scheduling ...)

    message("- future_lapply(x, FUN, ...) for large length(x) ...")
    a <- 3.14
    x_d <- 1:1e4
    y <- future_lapply(x_d, FUN = function(z) sqrt(z + a))
    y <- unlist(y, use.names = FALSE)
    stopifnot(all.equal(y, sqrt(x_d + a)))

    message("- future_lapply(x, FUN = table, ...) ...")
    x <- list(a = 1:4, b = 5:8)
    y0 <- lapply(x, FUN = table)
    y1 <- future_lapply(x, FUN = table)
    stopifnot(all.equal(y1, y0, check.attributes = FALSE)) ## FIXME

    message("- future_lapply(x, ...) where length(x) != length(as.list(x)) ...")
    x <- structure(list(a = 1, b = 2), class = "Foo")
    as.list.Foo <- function(x, ...) c(x, c = 3)
    y0 <- lapply(x, FUN = length)
    y1 <- future_lapply(x, FUN = length)
    stopifnot(identical(y1, y0))
    
  } ## for (strategy ...)

  message(sprintf("Testing with %d cores ... DONE", cores))
} ## for (cores ...)


message("*** future_lapply() - special cases ...")

X <- list()
names(X) <- character(0L)
y <- future_lapply(X, FUN = identity)
stopifnot(length(y) == 0L, !is.null(names(y)), identical(y, X))

X <- character(0L)
y0 <- lapply(X, FUN = identity)
y <- future_lapply(X, FUN = identity)
stopifnot(identical(y, y0))

X <- character(0L)
names(X) <- character(0L)
y0 <- lapply(X, FUN = identity)
y <- future_lapply(X, FUN = identity)
stopifnot(identical(y, y0))

message("*** future_lapply() - special cases ... DONE")


message("*** future_lapply() - exceptions ...")

res <- tryCatch({
  future_lapply(1:3, FUN = identity, future.chunk.size = structure(1L, ordering = "invalid"))
}, error = identity)
stopifnot(inherits(res, "error"))

message("*** future_lapply() - exceptions ... DONE")

message("*** future_lapply() ... DONE")

source("incl/end.R")
