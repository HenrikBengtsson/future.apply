getGlobalsAndPackagesXApply <- function(FUN, args = NULL, MoreArgs = NULL, envir, future.globals = TRUE, future.packages = NULL, debug = getOption("future.debug", FALSE)) {
  if (is.null(args)) {
    use_args <- FALSE
  } else {
    use_args <- TRUE
  }
  
  packages <- NULL
  globals <- future.globals
  scanForGlobals <- FALSE
  if (is.logical(globals)) {
    ## Gather all globals?
    if (globals) {
      if (debug) mdebug("Finding globals ...")
      scanForGlobals <- TRUE
      expr <- do.call(call, args = c(list("FUN"),
                                     if (use_args) args else MoreArgs))
      gp <- getGlobalsAndPackages(expr, envir = envir, globals = TRUE)
      globals <- gp$globals
      packages <- gp$packages
      gp <- NULL
      
      if (debug) {
        mdebug(" - globals found: [%d] %s", length(globals), hpaste(sQuote(names(globals))))
        mdebug(" - needed namespaces: [%d] %s", length(packages), hpaste(sQuote(packages)))
        mdebug("Finding globals ... DONE")
      }
    } else {
      ## globals = FALSE
      globals <- c("FUN", if (use_args) "..." else "MoreArgs")
      globals <- globalsByName(globals, envir = envir, mustExist = FALSE)
    }
  } else if (is.character(globals)) {
    globals <- unique(c(globals, "FUN", if (use_args) "..." else "MoreArgs"))
    globals <- globalsByName(globals, envir = envir, mustExist = FALSE)
  } else if (is.list(globals)) {
    names <- names(globals)
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
    if (!is.element("...", names)) {
      objectSize <- import_future("objectSize")
      if (debug) mdebug("Getting '...' globals ...")
      dotdotdot <- globalsByName("...", envir = envir, mustExist = TRUE)
      dotdotdot <- as.FutureGlobals(dotdotdot)
      dotdotdot <- resolve(dotdotdot)
      attr(dotdotdot, "total_size") <- objectSize(dotdotdot)
      if (debug) mdebug("Getting '...' globals ... DONE")
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
    mdebug("Globals to be used in all futures:")
    mdebug(paste(capture.output(str(globals)), collapse = "\n"))
  }

  if (!is.null(future.packages)) {
    stop_if_not(is.character(future.packages))
    future.packages <- unique(future.packages)
    stop_if_not(!anyNA(future.packages), all(nzchar(future.packages)))
    packages <- unique(c(packages, future.packages))
  }
  
  if (debug) {
    mdebug("Packages to be attached in all futures:")
    mdebug(paste(capture.output(str(packages)), collapse = "\n"))
  }

  list(globals = globals, packages = packages, scanForGlobals = scanForGlobals)
} ## findGlobalsStep1()
