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
  y2 <- future_mapply("rep", 1:4, 4:1)
  stopifnot(identical(y2, y0))
  
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

  message("- future_.mapply()")
  dots <- list(c(a =  1, b = 2, c = 3),  # names from first
               c(A = 10, B = 0, C = -10))
  y2 <- .mapply(function(x, y) seq_len(x) + y, dots = dots, MoreArgs = list())
  names(y0) <- NULL  ## .mapply() don't set names
  stopifnot(all.equal(y2, y0))
  y3 <- future_.mapply(function(x, y) seq_len(x) + y, dots = dots, MoreArgs = list())
  stopifnot(all.equal(y3, y2))

  word <- function(C, k) paste(rep.int(C, k), collapse = "")
  for (chunk.size in list(1L, structure(2L, ordering = "random"), structure(3L, ordering = 5:1))) {
    y0 <- mapply(word, LETTERS[1:5], 5:1, SIMPLIFY = FALSE)
    y1 <- future_mapply(word, LETTERS[1:5], 5:1, SIMPLIFY = FALSE, future.chunk.size = chunk.size)
    stopifnot(identical(y1, y0))

    dots <- list(LETTERS[1:5], 5:1)
    MoreArgs <- list()
    y2 <- .mapply(word, dots = dots, MoreArgs = list())
    names(y0) <- NULL  ## .mapply() don't set names
    stopifnot(all.equal(y2, y0))
    y3 <- future_.mapply(word, dots = dots, MoreArgs = list())
    stopifnot(all.equal(y3, y2))
  }

  message("- Subsetting (Issue #17) ...")
  X <- as.Date("2018-06-01")
  y0 <- mapply(FUN = identity, X, SIMPLIFY = FALSE)
  y1 <- future_mapply(FUN = identity, X, SIMPLIFY = FALSE)
  stopifnot(identical(y1, y0))

  dots <- list(X)
  y2 <- .mapply(FUN = identity, dots = dots, MoreArgs = MoreArgs)
  stopifnot(identical(y2, y0))
  y3 <- future_.mapply(FUN = identity, dots = dots, MoreArgs = MoreArgs)
  stopifnot(identical(y3, y2))

  message("- Non-recycling of MoreArgs (Issue #51) ...")
  y0 <- base::mapply(
    function(x, y) y,
    x = 1:2, MoreArgs = list(y = 3:4)
  )
  y1 <- future.apply::future_mapply(
    function(x, y) y,
    x = 1:2, MoreArgs = list(y = 3:4),
    future.seed = FALSE
  )
  stopifnot(identical(y1, y0))
  y2 <- future.apply::future_mapply(
    function(x, y) y,
    x = 1:2, MoreArgs = list(y = 3:4),
    future.seed = TRUE
  )
  stopifnot(identical(y2, y0))

  dots <- list(x = 1:2)
  MoreArgs <- list(y = 3:4)
  y3 <- .mapply(function(x, y) y, dots = dots, MoreArgs = MoreArgs)
  y4 <- future_.mapply(function(x, y) y, dots = dots, MoreArgs = MoreArgs)
  stopifnot(identical(y4, y3))

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

  message("- future_mapply() - 'max-or-0-if' recycling rule ...")
  ## R (>= 4.2.0): mapply() & Map() follow usual "max-or-0-if" recycling rule
  ## and keeps returning a named list in the "empty" case.
  
  truth <- list()
  if (getRversion() >= "4.2.0") {
    y0 <- mapply(`+`, 1:3, NULL)
    stopifnot(identical(y0, truth))
  }
  y <- future_mapply(`+`, 1:3, NULL)
  stopifnot(identical(y, truth))
  
  truth <- setNames(list(), character())
  if (getRversion() >= "4.2.0") {
    y0 <- mapply(paste, character(), NULL)
    stopifnot(identical(y0, truth))
  }
  y <- future_mapply(paste, character(), NULL)
  stopifnot(identical(y, truth))
  
  if (getRversion() >= "4.2.0") {
    y0 <- mapply(paste, character(), letters)
    stopifnot(identical(y0, truth))
  }
  y <- future_mapply(paste, character(), letters)
  stopifnot(identical(y, truth))
  
  if (getRversion() >= "4.2.0") {
    y0 <- mapply(paste, "A", character())
    stopifnot(identical(y0, truth))
  }
  y <- future_mapply(paste, "A", character())
  stopifnot(identical(y, truth))
  
  if (getRversion() >= "4.2.0") {
    y0 <- mapply(paste, character(), letters) 
    stopifnot(identical(y0, truth))
  }
  y <- future_mapply(paste, character(), letters) 
  stopifnot(identical(y, truth))
  
  if (getRversion() >= "4.2.0") {
    y0 <- mapply(paste, character(), NULL)
    stopifnot(identical(y0, truth))
  }
  y <- future_mapply(paste, character(), NULL)
  stopifnot(identical(y, truth))
  
  if (getRversion() >= "4.2.0") {
    y0 <- mapply(paste, character(), letters)
    stopifnot(identical(y0, truth))
  }
  y <- future_mapply(paste, character(), letters)
  stopifnot(identical(y, truth))
  
  if (getRversion() >= "4.2.0") {
    y0 <- mapply(paste, "A", character()) 
    stopifnot(identical(y0, truth))
  }
  y <- future_mapply(paste, "A", character()) 
  stopifnot(identical(y, truth))
  
  if (getRversion() >= "4.2.0") {
    y0 <- mapply(paste, character(), letters) 
    stopifnot(identical(y0, truth))
  }
  y <- future_mapply(paste, character(), letters) 
  stopifnot(identical(y, truth))

  ## Gives an error in R-devel (2021-11-26 r81252)
  if (getRversion() >= "4.2.0" && FALSE) {
    y0 <- mapply(paste, c(a = "A"), character())
    stopifnot(identical(y0, truth))
  }
  y <- future_mapply(paste, c(a = "A"), character())
  stopifnot(identical(y, truth))

  ## R (>= 4.2.0): Map() now recycles similar to basic Ops:
  truth <- as.list(1 + 1:3)
  if (getRversion() >= "4.2.0") {
    y0 <- Map(`+`, 1, 1:3)
    stopifnot(identical(y0, truth))
  }
  y <- future_Map(`+`, 1, 1:3)
  stopifnot(identical(y, truth))
  
  truth <- as.list(numeric() + 1:3)
  if (getRversion() >= "4.2.0") {
    y0 <- Map(`+`, numeric(), 1:3)
    stopifnot(identical(y0, truth))
  }
  y <- future_Map(`+`, numeric(), 1:3)
  stopifnot(identical(y, truth))
  
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

message("*** future_mapply() - special cases ...")

X <- list()
names(X) <- character(0L)

y <- future_mapply(FUN = identity, X)
stopifnot(length(y) == 0L, !is.null(names(y)), identical(y, X))

y <- future_mapply(FUN = identity, X, X)
stopifnot(length(y) == 0L, !is.null(names(y)), identical(y, X))

message("*** future_mapply() - special cases ... DONE")

message("*** future_mapply() ... DONE")

source("incl/end.R")
