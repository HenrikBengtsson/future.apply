library("revdepcheck")
options(warn = 1L)

availableCores <- function() {
  getenv <- function(name) as.integer(Sys.getenv(name, NA_character_))
  getopt <- function(name) as.integer(getOption(name, NA_integer_))
  if (is.finite(n <- getopt("mc.cores") + 1L)) return(n)
  if (is.finite(n <- getopt("Ncpus") + 1L)) return(n)
  if (is.finite(n <- getenv("PBS_NUM_PPN"))) return(n)
  if (is.finite(n <- getenv("SLURM_CPUS_PER_TASK"))) return(n)
  if (is.finite(n <- getenv("NSLOTS"))) return(n)
  1L
}

if (file_test("-f", p <- Sys.getenv("R_CHECK_ENVIRON", "~/.R/check.Renviron"))) {
  cat(sprintf("R CMD check will use env vars from %s\n", sQuote(p)))
  cat(sprintf("To disable, set 'R_CHECK_ENVIRON=false' (a fake pathname)\n"))
}

envs <- grep("^_R_CHECK_", names(Sys.getenv()), value = TRUE)
if (length(envs) > 0L) {
  cat(sprintf("Detected _R_CHECK_* env vars that will affect R CMD check: %s\n", paste(sQuote(envs), collapse = ", ")))
}

## WORKAROUND: The following packages are not automatically installed
## crancache::install_packages(c("forecast", "randomForest", "pacman",
##                               "Ecdat", "cranlogs"))

revdep_check(bioc = TRUE, num_workers = availableCores(),
             timeout = as.difftime(30, units = "mins"), quiet = FALSE)
