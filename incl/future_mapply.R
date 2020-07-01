## ---------------------------------------------------------
## mapply()
## ---------------------------------------------------------
y0 <- mapply(rep, 1:4, 4:1)
y1 <- future_mapply(rep, 1:4, 4:1)
stopifnot(identical(y1, y0))

y0 <- mapply(rep, times = 1:4, x = 4:1)
y1 <- future_mapply(rep, times = 1:4, x = 4:1)
stopifnot(identical(y1, y0))

y0 <- mapply(rep, times = 1:4, MoreArgs = list(x = 42))
y1 <- future_mapply(rep, times = 1:4, MoreArgs = list(x = 42))
stopifnot(identical(y1, y0))

y0 <- mapply(function(x, y) seq_len(x) + y,
             c(a =  1, b = 2, c = 3),  # names from first
             c(A = 10, B = 0, C = -10))
y1 <- future_mapply(function(x, y) seq_len(x) + y,
                    c(a =  1, b = 2, c = 3),  # names from first
                    c(A = 10, B = 0, C = -10))
stopifnot(identical(y1, y0))

word <- function(C, k) paste(rep.int(C, k), collapse = "")
y0 <- mapply(word, LETTERS[1:6], 6:1, SIMPLIFY = FALSE)
y1 <- future_mapply(word, LETTERS[1:6], 6:1, SIMPLIFY = FALSE)
stopifnot(identical(y1, y0))


## ---------------------------------------------------------
## Parallel Random Number Generation
## ---------------------------------------------------------
\donttest{
## Regardless of the future plan, the number of workers, and
## where they are, the random numbers produced are identical

plan(multisession)
y1 <- future_mapply(stats::runif, n = 1:4, max = 2:5,
                    MoreArgs = list(min = 1), future.seed = 0xBEEF)
print(y1)

plan(sequential)
y2 <- future_mapply(stats::runif, n = 1:4, max = 2:5,
                    MoreArgs = list(min = 1), future.seed = 0xBEEF)
print(y2)

stopifnot(all.equal(y1, y2))
}

\dontshow{
## R CMD check: make sure any open connections are closed afterward
if (!inherits(plan(), "sequential")) plan(sequential)
}
