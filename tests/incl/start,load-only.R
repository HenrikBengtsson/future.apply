## Record original state
ovars <- ls()
oenvs <- oenvs0 <- Sys.getenv()
oopts0 <- options()

covr_testing <- ("covr" %in% loadedNamespaces())
on_solaris <- grepl("^solaris", R.version$os)

## Default options
oopts <- options(
  warn = 1L,
  mc.cores = 2L,
  future.debug = TRUE,
  ## Reset the following during testing in case
  ## they are set on the test system
  future.availableCores.system = NULL,
  future.availableCores.fallback = NULL
)


## Reset the following during testing in case
## they are set on the test system
oenvs2 <- Sys.unsetenv(c(
  "R_FUTURE_AVAILABLECORES_SYSTEM",
  "R_FUTURE_AVAILABLECORES_FALLBACK",
  ## SGE
  "NSLOTS", "PE_HOSTFILE",
  ## Slurm
  "SLURM_CPUS_PER_TASK",
  ## TORQUE / PBS
  "PBS_NUM_PPN", "PBS_NODEFILE", "PBS_NP", "PBS_NUM_NODES"
))

oplan <- future::plan()

## Use eager futures by default
future::plan("sequential")

## Private future.apply functions
fold <- future.apply:::fold
hpaste <- future.apply:::hpaste
mdebug <- future.apply:::mdebug
mdebugf <- future.apply:::mdebugf
import_from <- future.apply:::import_from
get_random_seed <- future.apply:::get_random_seed
set_random_seed <- future.apply:::set_random_seed
next_random_seed <- future.apply:::next_random_seed
as_lecyer_cmrg_seed <- future.apply:::as_lecyer_cmrg_seed
is_lecyer_cmrg_seed <- future.apply:::is_lecyer_cmrg_seed
make_rng_seeds <- future.apply:::make_rng_seeds

## Local functions for test scripts
printf <- function(...) cat(sprintf(...))
mstr <- function(...) message(paste(capture.output(str(...)), collapse = "\n"))
attachLocally <- function(x, envir = parent.frame()) {
  for (name in names(x)) {
    assign(name, value = x[[name]], envir = envir)
  }
}

supportedStrategies <- function(cores = 1L, excl = c("multiprocess", "cluster"), ...) {
  strategies <- future:::supportedStrategies(...)
  strategies <- setdiff(strategies, excl)
  if (cores > 1) {
    strategies <- setdiff(strategies, c("sequential", "uniprocess"))
  }
  strategies
}

availCores <- min(2L, future::availableCores())
