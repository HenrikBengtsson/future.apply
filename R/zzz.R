.package <- new.env()

## covr: skip=all
.onLoad <- function(libname, pkgname) {
  .package[["version"]] <- utils::packageVersion(pkgname)

  update_package_option("future.apply.debug", mode = "logical")
  debug <- getOption("future.apply.debug", FALSE)

  if (debug) {
    envs <- Sys.getenv()
    envs <- envs[grep("R_FUTURE_APPLY_", names(envs), fixed = TRUE)]
    envs <- sprintf("- %s=%s", names(envs), sQuote(envs))
    mdebug(paste(c("Rnvironment variables specific to future.apply:", envs), collapse = "\n"))
  }

  ## Set future options based on environment variables
  update_package_options(debug = debug)
}
