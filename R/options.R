#' Options used for future.apply
#'
#' Below are the \R options and environment variables that are used by the
#' \pkg{future.apply} package and packages enhancing it.\cr
#' \cr
#' _WARNING: Note that the names and the default values of these options may
#'  change in future versions of the package.  Please use with care until
#'  further notice._
#'
#' For settings specific to the \pkg{future} package, see
#' [future::future.options] page.
#'
#' @section Options for debugging future.apply:
#' \describe{
#'  \item{\option{future.apply.debug}:}{(logical) If `TRUE`, extensive debug messages are generated. (Default: `FALSE`)}
#' }
#'
#'
#' @section Environment variables that set R options:
#' All of the above \R \option{future.apply.*} options can be set by
#' corresponding environment variable \env{R_FUTURE_APPLY_*} _when the
#' \pkg{future.apply} package is loaded_.
#' For example, if `R_FUTURE_APPLY_DEBUG=TRUE`, then option
#' \option{future.apply.debug} is set to `TRUE` (logical).
#'
#' @examples
#' \dontrun{
#' options(future.apply.debug = TRUE)
#' }
#'
#' @seealso
#' To set \R options or environment variables when \R starts (even before the \pkg{future} package is loaded), see the \link[base]{Startup} help page.  The \href{https://cran.r-project.org/package=startup}{\pkg{startup}} package provides a friendly mechanism for configuring \R's startup process.
#'
#' @aliases
#' future.apply.debug
#' R_FUTURE_APPLY_DEBUG
#'
#' @name future.apply.options
NULL




# Set an R option from an environment variable
update_package_option <- function(name, mode = "character", default = NULL, split = NULL, trim = TRUE, disallow = c("NA"), force = FALSE, debug = FALSE) {
  ## Nothing to do?
  value <- getOption(name, NULL)
  if (!force && !is.null(value)) return(getOption(name, default = default))

  ## name="future.plan.disallow" => env="R_FUTURE_PLAN_DISALLOW"
  env <- gsub(".", "_", toupper(name), fixed = TRUE)
  env <- paste("R_", env, sep = "")

  env_value <- value <- Sys.getenv(env, unset = NA_character_)
  ## Nothing to do?
  if (is.na(value)) {  
    if (debug) mdebugf("Environment variable %s not set", sQuote(env))
    return(getOption(name, default = default))
  }
  
  if (debug) mdebugf("%s=%s", env, sQuote(value))

  ## Trim?
  if (trim) value <- trim(value)

  ## Nothing to do?
  if (!nzchar(value)) return(getOption(name, default = default))

  ## Split?
  if (!is.null(split)) {
    value <- strsplit(value, split = split, fixed = TRUE)
    value <- unlist(value, use.names = FALSE)
    if (trim) value <- trim(value)
  }

  ## Coerce?
  mode0 <- storage.mode(value)
  if (mode0 != mode) {
    suppressWarnings({
      storage.mode(value) <- mode
    })
    if (debug) {
      mdebugf("Coercing from %s to %s: %s", mode0, mode, commaq(value))
    }
  }

  if (length(disallow) > 0) {
    if ("NA" %in% disallow) {
      if (any(is.na(value))) {
        stopf("Coercing environment variable %s=%s to %s would result in missing values for option %s: %s", sQuote(env), sQuote(env_value), sQuote(mode), sQuote(name), commaq(value))
      }
    }
    if (is.numeric(value)) {
      if ("non-positive" %in% disallow) {
        if (any(value <= 0, na.rm = TRUE)) {
          stopf("Environment variable %s=%s specifies a non-positive value for option %s: %s", sQuote(env), sQuote(env_value), sQuote(name), commaq(value))
        }
      }
      if ("negative" %in% disallow) {
        if (any(value < 0, na.rm = TRUE)) {
          stopf("Environment variable %s=%s specifies a negative value for option %s: %s", sQuote(env), sQuote(env_value), sQuote(name), commaq(value))
        }
      }
    }
  }
  
  if (debug) {
    mdebugf("=> options(%s = %s) [n=%d, mode=%s]",
            dQuote(name), commaq(value),
            length(value), storage.mode(value))
  }

  do.call(options, args = structure(list(value), names = name))
  
  getOption(name, default = default)
}


## Set future options based on environment variables
update_package_options <- function(debug = FALSE) {
  update_package_option("future.apply.chunkWith", default = "[[", debug = debug)
}
