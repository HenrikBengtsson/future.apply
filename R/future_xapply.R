#' @importFrom future Future nbrOfWorkers future resolve value as.FutureGlobals getGlobalsAndPackages
future_xapply <- function(FUN, nX, chunk_args, args = NULL, MoreArgs = NULL, expr, envir, future.globals, future.packages, future.scheduling, future.chunk.size, future.stdout, future.conditions, future.seed, future.lazy, future.label, get_chunk, fcn_name, args_name, ..., debug) {
  stop_if_not(is.function(FUN))
  
  stop_if_not(is.logical(future.stdout), length(future.stdout) == 1L)

  ## FIXME: Memoize the result
  if (is.null(future.conditions)) {
    future.conditions <- eval(formals(Future)[["conditions"]])
  }
  
  stop_if_not(is.logical(future.lazy), length(future.lazy) == 1L)

  stop_if_not(length(future.scheduling) == 1L, !is.na(future.scheduling),
            is.numeric(future.scheduling) || is.logical(future.scheduling))

  stop_if_not(length(future.label) == 1L, !is.na(future.label),
              is.logical(future.label) || is.character(future.label))


  ## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  ## Reproducible RNG (for sequential and parallel processing)
  ## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  seeds <- make_rng_seeds(nX, seed = future.seed, debug = debug)
  
  ## Future expression (with or without setting the RNG state) and
  ## pass possibly tweaked 'future.seed' to future()
  if (is.null(seeds)) {
    stop_if_not(is.null(future.seed) || isFALSE(future.seed))
    if (isFALSE(future.seed) && future_version() <= "1.15.1") {
      future.seed <- NULL
    }
  } else {
    ## If RNG seeds are used (given or generated), make sure to reset
    ## the RNG state afterward
    oseed <- next_random_seed()    
    on.exit(set_random_seed(oseed))
    ## As seed=FALSE but without the RNG check
    future.seed <- NULL
  }


  ## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  ## Load balancing ("chunking")
  ## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  chunks <- makeChunks(nX,
                       nbrOfWorkers = nbrOfWorkers(),
                       future.scheduling = future.scheduling,
                       future.chunk.size = future.chunk.size)
  if (debug) mdebugf("Number of chunks: %d", length(chunks))

  ## Process elements in a custom order?
  ordering <- attr(chunks, "ordering")
  if (!is.null(ordering)) {
    if (debug) mdebugf("Index remapping (attribute 'ordering'): [n = %d] %s", length(ordering), hpaste(ordering))
    chunks <- lapply(chunks, FUN = function(idxs) .subset(ordering, idxs))
  }
  

  ## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  ## Globals and Packages
  ## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  gp <- getGlobalsAndPackagesXApply(FUN = FUN,
                                    args = args,
				    MoreArgs = MoreArgs,
                                    envir = envir,
                                    future.globals = future.globals,
                                    future.packages = future.packages,
                                    debug = debug)

  packages <- gp$packages
  globals <- gp$globals
  scanForGlobals <- gp$scanForGlobals
  gp <- NULL
  
  ## Add argument placeholders
  globals_extra <- as.FutureGlobals(list(
    ...future.elements_ii = NULL,
    ...future.seeds_ii = NULL,
    ...future.globals.maxSize = NULL
  ))
  attr(globals_extra, "resolved") <- TRUE
  attr(globals_extra, "total_size") <- 0
  globals <- c(globals, globals_extra)

  ## At this point a globals should be resolved and we should know their total size
##  stop_if_not(attr(globals, "resolved"), !is.na(attr(globals, "total_size")))

  ## To please R CMD check
  ...future.FUN <- ...future.elements_ii <- ...future.seeds_ii <-
                   ...future.globals.maxSize <- NULL

  globals.maxSize <- getOption("future.globals.maxSize")
  globals.maxSize.default <- globals.maxSize
  if (is.null(globals.maxSize.default)) globals.maxSize.default <- 500 * 1024^2
  
  nchunks <- length(chunks)
  if (debug) mdebugf("Number of futures (= number of chunks): %d", nchunks)


  ## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  ## Futures
  ## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  expr <- bquote({
    ...future.globals.maxSize.org <- getOption("future.globals.maxSize")
    if (!identical(...future.globals.maxSize.org, ...future.globals.maxSize)) {
      oopts <- options(future.globals.maxSize = ...future.globals.maxSize)
      on.exit(options(oopts), add = TRUE)
    }
    .(expr)
  })

  ## Create labels?
  if (isTRUE(future.label)) {
    future.label <- sprintf("%s-%%d", fcn_name)
  }
  if (is.character(future.label)) {
    labels <- sprintf(future.label, seq_len(nchunks))
    stopifnot(length(labels) == nchunks)
  } else {
    labels <- NULL
  }

  if (debug) mdebugf("Launching %d futures (chunks) ...", nchunks)
  fs <- vector("list", length = nchunks)
  for (ii in seq_along(chunks)) {
    chunk <- chunks[[ii]]
    if (debug) mdebugf("Chunk #%d of %d ...", ii, length(chunks))

    args_ii <- get_chunk(chunk_args, chunk)
    globals_ii <- globals
    ## Subsetting outside future is more efficient
    globals_ii[["...future.elements_ii"]] <- args_ii
    packages_ii <- packages

    if (scanForGlobals) {
      if (debug) mdebugf(" - Finding globals in '%s' for chunk #%d ...", args_name, ii)
      gp <- getGlobalsAndPackages(args_ii, envir = envir, globals = TRUE)
      globals_args <- gp$globals
      packages_args <- gp$packages
      gp <- NULL

      if (debug) {
        mdebugf("   + globals found in '%s' for chunk #%d: [%d] %s",
	        args_name, chunk, length(globals_args), hpaste(sQuote(names(globals_args))))
        mdebugf("   + needed namespaces for '%s' for chunk #%d: [%d] %s",
	        args_name, chunk, length(packages_args), hpaste(sQuote(packages_args)))
      }
    
      ## Export also globals found in arguments?
      if (length(globals_args) > 0L) {
        reserved <- intersect(c("...future.FUN", "...future.elements_ii",
                                "...future.seeds_ii"), names(globals_args))
        if (length(reserved) > 0) {
          stop("Detected globals in '%s' using reserved variables names: ",
               args_name, paste(sQuote(reserved), collapse = ", "))
        }
        globals_args <- as.FutureGlobals(globals_args)
        globals_ii <- unique(c(globals_ii, globals_args))

        ## Packages needed due to globals in arguments?
        if (length(packages_args) > 0L)
          packages_ii <- unique(c(packages_ii, packages_args))
      }
      if (debug) mdebugf(" - Finding globals in '%s' for chunk #%d ... DONE", args_name, ii)
    }
    
    args_ii <- NULL    
##    stop_if_not(attr(globals_ii, "resolved"))

    ## Adjust option 'future.globals.maxSize' to account for the fact that more
    ## than one element is processed per future.  The adjustment is done by
    ## scaling up the limit by the number of elements in the chunk.  This is
    ## a "good enough" approach.
    ## (https://github.com/HenrikBengtsson/future.apply/issues/8).
    if (length(chunk) > 1L) {
      globals_ii["...future.globals.maxSize"] <- list(globals.maxSize)
      options(future.globals.maxSize = length(chunk) * globals.maxSize.default)
      if (debug) mdebugf(" - Adjusted option 'future.globals.maxSize': %g -> %d * %g = %g (bytes)", globals.maxSize.default, length(chunk), globals.maxSize.default, getOption("future.globals.maxSize"))
      on.exit(options(future.globals.maxSize = globals.maxSize), add = TRUE)
    }
    
    ## Using RNG seeds or not?
    if (is.null(seeds)) {
      if (debug) mdebug(" - seeds: <none>")
    } else {
      if (debug) mdebugf(" - seeds: [%d] <seeds>", length(chunk))
      globals_ii[["...future.seeds_ii"]] <- seeds[chunk]
    }

    fs[[ii]] <- future(
      expr, substitute = FALSE,
      envir = envir,
      stdout = future.stdout,
      conditions = future.conditions,
      globals = globals_ii, packages = packages_ii,
      seed = future.seed,
      lazy = future.lazy,
      label = labels[ii]
    )

    ## Not needed anymore
    rm(list = c("chunk", "globals_ii"))

    if (debug) mdebugf("Chunk #%d of %d ... DONE", ii, nchunks)
  } ## for (ii ...)
  if (debug) mdebugf("Launching %d futures (chunks) ... DONE", nchunks)

  ## 4. Resolving futures
  if (debug) mdebugf("Resolving %d futures (chunks) ...", nchunks)

  values <- value(fs)

  ## Not needed anymore
  rm(list = "fs")

  if (debug) {
    mdebugf(" - Number of value chunks collected: %d", length(values))
    mdebugf("Resolving %d futures (chunks) ... DONE", nchunks)
  }

  ## Sanity check
  stop_if_not(length(values) == nchunks)
  
  if (debug) mdebugf("Reducing values from %d chunks ...", nchunks)

  values2 <- do.call(c, args = values)
  
  if (debug) {
    mdebugf(" - Number of values collected after concatenation: %d",
           length(values2))
    mdebugf(" - Number of values expected: %d", nX)
  }

  assert_values2(nX, values, values2, fcn_name = fcn_name, debug = debug)
  values <- values2
  rm(list = "values2")
  
  ## Sanity check (this may happen if the future backend is broken)
  stop_if_not(length(values) == nX)

  ## Were elements processed in a custom order?
  if (length(values) > 1L && !is.null(ordering)) {
    invOrdering <- vector(mode(ordering), length = nX)
    idx <- 1:nX
    invOrdering[.subset(ordering, idx)] <- idx
    rm(list = c("ordering", "idx"))
    if (debug) mdebugf("Reverse index remapping (attribute 'ordering'): [n = %d] %s", length(invOrdering), hpaste(invOrdering))
    values <- .subset(values, invOrdering)
    rm(list = c("invOrdering"))
  }

  if (debug) mdebugf("Reducing values from %d chunks ... DONE", nchunks)

  values
} ## future_xapply()