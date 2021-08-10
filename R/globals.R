#' @importFrom globals globalsByName
#' @importFrom future as.FutureGlobals getGlobalsAndPackages resolve
getGlobalsAndPackagesXApply <- function(FUN, args = NULL, MoreArgs = NULL, envir, future.globals = TRUE, future.packages = NULL, debug = NA) {
  use_args <- !is.null(args)
  if (is.na(debug)) debug <- getOption("future.apply.debug", getOption("future.debug", FALSE))

  if (debug) {
    mdebug("getGlobalsAndPackagesXApply() ...")
    on.exit(mdebug("getGlobalsAndPackagesXApply() ... DONE"), add = TRUE)
  }

  packages <- NULL
  globals <- future.globals
  scanForGlobals <- FALSE
  if (is.logical(globals)) {
    if (debug) mdebugf(" - future.globals: %s", globals)
    ## Gather all globals?
    if (globals) {
      scanForGlobals <- TRUE
      expr <- do.call(call, args = c(list("FUN"),
                                     if (use_args) args else MoreArgs))
    } else {
      expr <- NULL
      attr(globals, "add") <- c(attr(globals, "add"),
                                c("FUN", if (use_args) "..." else "MoreArgs"))
    }
    gp <- getGlobalsAndPackages(expr, envir = envir, globals = globals)
    globals <- gp$globals
    packages <- gp$packages
    gp <- NULL
      
    if (debug) {
      mdebugf(" - globals found/used: [n=%d] %s", length(globals), commaq(names(globals)))
      mdebugf(" - needed namespaces: [n=%d] %s", length(packages), commaq(packages))
      mdebug("Finding globals ... DONE")
    }
  } else if (is.character(globals)) {
    if (debug) mdebugf(" - future.globals: %s", commaq(globals))
    globals <- unique(c(globals, "FUN", if (use_args) "..." else "MoreArgs"))
    globals <- globalsByName(globals, envir = envir, mustExist = FALSE)
  } else if (is.list(globals)) {
    names <- names(globals)
    if (debug) mdebugf(" - future.globals: <name-value list> with names %s", commaq(globals))
    if (length(globals) > 0 && is.null(names)) {
      stop("Invalid argument 'future.globals'. All globals must be named.")
    }
  } else {
    stop("Invalid argument 'future.globals': ", mode(globals))
  }
  globals <- as.FutureGlobals(globals)
  stop_if_not(inherits(globals, "FutureGlobals"))
  
  names <- names(globals)
  if (!is.element("FUN", names)) {
    globals <- c(globals, FUN = FUN)
  }
  
  if (use_args) {
    if (debug) mdebug(" - use_args: TRUE")
    if (!is.element("...", names)) {
      if (debug) mdebug(" - Getting '...' globals ...")
      dotdotdot <- globalsByName("...", envir = envir, mustExist = TRUE)
      dotdotdot <- as.FutureGlobals(dotdotdot)
      dotdotdot <- resolve(dotdotdot)
      if (debug) {
        mdebugf("   - '...' content: [n=%d] %s", length(dotdotdot[[1]]), commaq(names(dotdotdot[[1]])))
        mstr(dotdotdot)
      }

      ## Recalculate the total size?
      maxSize <- getOption("future.globals.maxSize")
      if (is.null(maxSize) || is.finite(maxSize)) {
        objectSize <- import_future("objectSize")
        attr(dotdotdot, "total_size") <- objectSize(dotdotdot)
      }
      
      if (debug) mdebug(" - Getting '...' globals ... DONE")
      globals <- c(globals, dotdotdot)
    }
  } else if (!is.element("MoreArgs", names)) {
    globals <- c(globals, list(MoreArgs = MoreArgs))
  }

  ## Assert there are no reserved variables names among globals
  reserved <- intersect(c("...future.FUN", "...future.elements_ii",
                        "...future.seeds_ii"), names)
  if (length(reserved) > 0) {
    stop("Detected globals using reserved variables names: ",
         paste(sQuote(reserved), collapse = ", "))
  }
 
  ## Avoid FUN() clash with mapply(..., FUN) below.
  names <- names(globals)
  names[names == "FUN"] <- "...future.FUN"
  names(globals) <- names
  
  if (debug) {
    mdebugf("Globals to be used in all futures (chunks): [n=%d] %s", length(globals), commaq(names(globals)))
    mstr(globals)
  }

  if (!is.null(future.packages)) {
    stop_if_not(is.character(future.packages))
    future.packages <- unique(future.packages)
    stop_if_not(!anyNA(future.packages), all(nzchar(future.packages)))
    packages <- unique(c(packages, future.packages))
  }
  
  if (debug) {
    mdebugf("Packages to be attached in all futures: [n=%d] %s", length(packages), commaq(packages))
  }

  list(globals = globals, packages = packages, scanForGlobals = scanForGlobals)
} ## findGlobalsStep1()
