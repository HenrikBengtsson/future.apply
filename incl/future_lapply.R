## ---------------------------------------------------------
## lapply(), sapply(), tapply()
## ---------------------------------------------------------
x <- list(a = 1:10, beta = exp(-3:3), logic = c(TRUE, FALSE, FALSE, TRUE))
y0 <- lapply(x, FUN = quantile, probs = 1:3/4)
y1 <- future_lapply(x, FUN = quantile, probs = 1:3/4)
print(y1)
stopifnot(all.equal(y1, y0))

y0 <- sapply(x, FUN = quantile)
y1 <- future_sapply(x, FUN = quantile)
print(y1)
stopifnot(all.equal(y1, y0))

y0 <- vapply(x, FUN = quantile, FUN.VALUE = double(5L))
y1 <- future_vapply(x, FUN = quantile, FUN.VALUE = double(5L))
print(y1)
stopifnot(all.equal(y1, y0))


## ---------------------------------------------------------
## Parallel Random Number Generation
## ---------------------------------------------------------
\donttest{
## Regardless of the future plan, the number of workers, and
## where they are, the random numbers produced are identical

plan(multiprocess)
y1 <- future_lapply(1:5, FUN = rnorm, future.seed = 0xBEEF)
str(y1)

plan(sequential)
y2 <- future_lapply(1:5, FUN = rnorm, future.seed = 0xBEEF)
str(y2)

stopifnot(all.equal(y1, y2))
}

\dontshow{
## R CMD check: make sure any open connections are closed afterward
if (!inherits(plan(), "sequential")) plan(sequential)
}
