source("incl/start.R")

message("*** future_sapply() ...")

xs <- list(
  A = c(a = 1, b = 2, c = 3),
  B = c(a = 1:2, b = 2:3, c = 3:4),
  C = letters[1:3],
  D = structure(10 * 5:8, names = LETTERS[1:4])
)

FUNS <- list(
  a = identity,
  b = as.matrix,
  c = function(x, y = 2 * 1:5) outer(rep(x, length.out = 3L), y)
)

for (strategy in supportedStrategies()) {
  message(sprintf("*** strategy = %s ...", sQuote(strategy)))
  plan(strategy)
  
  for (x in xs) {
    FUNS_x <- FUNS
    if (!is.numeric(x)) FUNS_x[["c"]] <- NULL
    
    for (USE.NAMES in list(FALSE, TRUE)) {
      for (simplify in list(FALSE, TRUE, "array")) {
        for (FUN in FUNS_x) {
          y0 <-        sapply(x, FUN = FUN,
                              USE.NAMES = USE.NAMES, simplify = simplify)
          y1 <- future_sapply(x, FUN = FUN,
                              USE.NAMES = USE.NAMES, simplify = simplify)
          str(list(y0 = y0, y1 = y1))
          stopifnot(identical(y1, y0))
          if (identical(simplify, FALSE)) {
             y2 <- lapply(x, FUN = FUN)
             str(list(y0 = y0, y2 = y2))
             stopifnot(identical(unname(y2), unname(y0)))
          }
        }
      }
    }
  }

  y0 <- sapply(1:3, FUN = "sqrt")
  y1 <- future_sapply(1:3, FUN = "sqrt")
  stopifnot(identical(y1, y0))
  
  ## https://github.com/HenrikBengtsson/future.apply/issues/61
  compute <- function(a, x_vec) a + x_vec
  call_compute <- function(..., x_vec = 1:2){
    compute_with_dots <- function(x) compute(..., x_vec = x)
    future_sapply(x_vec, FUN = compute_with_dots)
  }
  y <- call_compute(0L)
  print(y)
  stopifnot(identical(y, 1:2))
  
  plan(sequential)
  message(sprintf("*** strategy = %s ... done", sQuote(strategy)))
} ## for (strategy in ...) 

message("*** future_sapply() ... DONE")

source("incl/end.R")
