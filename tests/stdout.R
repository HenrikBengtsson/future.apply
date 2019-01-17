source("incl/start.R")

message("*** future_*apply() and 'future.stdout' ...")

options(future.debug = FALSE)

truth <- list()
out <- utils::capture.output({
  y <- future_lapply(1:0, FUN = function(x) {
    print(x)
  })
})
truth[["lapply"]] <- list(value = y, stdout = out)
out <- utils::capture.output({
  y <- future_mapply(1:0, 0:1, FUN = function(x, y) {
    print(list(x = x, y = y))
  })
})
truth[["mapply"]] <- list(value = y, stdout = out)

for (cores in 1:availCores) {
  message(sprintf("  - Testing with %d cores ...", cores))
  options(mc.cores = cores)
  
  for (strategy in supportedStrategies(cores)) {
    message(sprintf("* plan('%s') ...", strategy))
    plan(strategy)

    for (fun in c("lapply", "mapply")) {
      for (stdout in c(FALSE, TRUE, NA)) {
        message(sprintf("* future_%s(x, ..., future.stdout = %s) ...", fun, stdout))
  
        out <- utils::capture.output({
          if (fun == "lapply") {
            y <- future_lapply(1:0, FUN = function(x) {
              Sys.sleep(x / 2)
	      print(x)
            }, future.stdout = stdout)
	  } else if (fun == "mapply") {
            y <- future_mapply(1:0, 0:1, FUN = function(x, y) {
              Sys.sleep(x / 2)
              print(list(x = x, y = y))
            }, future.stdout = stdout)
	  }
        })
        stopifnot(identical(y, truth[[fun]]$value))
  
        if (isTRUE(stdout)) {
          stopifnot(identical(out, truth[[fun]]$stdout))
        } else if (is.na(stdout)) {
        } else {
          ## Due to https://github.com/HenrikBengtsson/future/issues/271
          ## stdout = TRUE for workers = 1L and multicore/multisession
          if (!strategy %in% c("multicore", "multisession") || packageVersion("future") > "1.10.0") {
            stopifnot(nchar(out) == 0)
          }
        }
      
        message(sprintf("* future_%s(x, ..., future.stdout = %s) ... DONE", fun, stdout))
      } ## for (stdout ...)
    } ## for (fun ...)
    
    message(sprintf("* plan('%s') ... DONE", strategy))
  }
  
  message(sprintf("  - Testing with %d cores ... DONE", cores))
}

message("*** future_*apply() and 'future.stdout' ... DONE")

source("incl/end.R")
