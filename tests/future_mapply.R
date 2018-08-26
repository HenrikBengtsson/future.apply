source("incl/start.R")

message("*** future_mapply() ...")

message("- Parallel RNG truth (for later)...")
plan(sequential)
y_rng_0 <- future_mapply(stats::runif, n = 1:4, max = 2:5,
                         MoreArgs = list(min = 1), future.seed = 0xBEEF)
print(y_rng_0)

for (strategy in supportedStrategies()) {
  message(sprintf("*** strategy = %s ...", sQuote(strategy)))
  plan(strategy)

  message("- From example(mapply) ...")
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


  message("- Subsetting (Issue #17) ...")
  X <- as.Date("2018-06-01")
  y0 <- mapply(FUN = identity, X, SIMPLIFY = FALSE)
  y1 <- future_mapply(FUN = identity, X, SIMPLIFY = FALSE)
  stopifnot(identical(y1, y0))
  
  message("- Recycle arguments to same length ...")
  y0 <- mapply(rep, 1:4, 2:1)
  y1 <- future_mapply(rep, 1:4, 2:1)
  stopifnot(identical(y1, y0))

  
  message("- Parallel RNG ...")
  y_rng_1 <- future_mapply(stats::runif, n = 1:4, max = 2:5,
                           MoreArgs = list(min = 1), future.seed = 0xBEEF)
  print(y_rng_1)
  stopifnot(all.equal(y_rng_1, y_rng_0))

  
  message("- future_Map() ...")
  xs <- replicate(5, stats::runif(10), simplify = FALSE)
  ws <- replicate(5, stats::rpois(10, 5) + 1, simplify = FALSE)
  y0 <- Map(weighted.mean, xs, ws)
  y1 <- future_Map(stats::weighted.mean, xs, ws)
  stopifnot(all.equal(y1, y0))
  
  plan(sequential)
  message(sprintf("*** strategy = %s ... done", sQuote(strategy)))
} ## for (strategy in ...) 

message("- Empty input [non parallel] ...")
y0 <- mapply(search)
y1 <- future_mapply(search)
stopifnot(identical(y1, y0))

y0 <- mapply(list, integer(0L))
y1 <- future_mapply(list, integer(0L))
stopifnot(identical(y1, y0))

message("*** future_mapply() ... DONE")

source("incl/end.R")
