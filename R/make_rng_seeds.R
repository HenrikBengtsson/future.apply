#' Produce Reproducible Seeds for Parallel Random Number Generation
#'
#' @param count The number of RNG seeds to produce.
#'
#' @param seed A logical specifying whether RNG seeds should be generated
#' or not.  (`seed = NULL` corresponds to `seed = FALSE`).
#' If a list, then it should be of length `count` and each element should
#' consist of a valid RNG seed.
#'
#' @return Returns a non-named list of `count` independent `L'Ecuyer-CMRG`
#' random seeds.
#' If `seed` is `NULL` or `FALSE`, then `NULL` is returned.
#' 
#' @example incl/make_rng_seeds.R
#'
#' @details
#' This function generates `count` independent `L'Ecuyer-CMRG` random seeds
#' that can be used as `.Random.seed` for parallel processing.  These seeds
#' are produced with help of [parallel::nextRNGSubStream()] and
#' [parallel::nextRNGStream()] using a strategy that 
#'
#' ```r
#' seed <- <initial RNG seed>
#' for (ii in seq_len(count)) {
#'   seeds[[ii]] <- parallel::nextRNGSubStream(seed)
#'   seed <- parallel::nextRNGStream(seed)
#' }
#' ```
#' This function forwards the RNG state `1 + count` times if `seed = TRUE`.
#' 
#' @importFrom parallel nextRNGStream nextRNGSubStream splitIndices
#' @importFrom utils capture.output str
#' @noRd
make_rng_seeds <- function(count, seed = FALSE) {
  ## Don't use RNGs? (seed = {FALSE, NULL})
  if (is.null(seed)) return(NULL)
  if (is.logical(seed) && !is.na(seed) && !seed) return(NULL)

  stop_if_not(is.numeric(count), length(count) == 1L, !is.na(count),
              count >= 0L)

  debug <- getOption("future.debug", FALSE)

  ## Placeholder for all RNG stream seeds.
  seeds <- NULL
  
  # Use RNGs?
  if (debug) mdebug("Generating random seeds ...")

  ## A pregenerated sequence of random seeds?
  if (is.list(seed)) {
    if (debug) mdebugf("Using a pre-define stream of %d random seeds ...", count)

    seeds <- seed
    nseeds <- length(seeds)
    if (nseeds != count) {
      stopf("Argument 'seed' is a list, which specifies the sequence of seeds to be used for each element iterated over, but length(seed) != number of elements: %.0f != %.0f", nseeds, count)
    }

    ## Assert same type of RNG seeds?
    ns <- unique(unlist(lapply(seeds, FUN = length), use.names = FALSE))
    if (length(ns) != 1L) {
      stopf("The elements of the list specified in argument 'seed' are not all of the same lengths (did you really pass RNG seeds?): %s", hpaste(ns))
    }

    ## Did use specify scalar integers as meant for set.seed()?
    if (ns == 1L) {
      stop("Argument 'seed' is invalid. Pre-generated random seeds must be valid .Random.seed seeds, which means they should be all integers and consists of two or more elements, not just one.")
    }

    types <- unlist(lapply(seeds, FUN = typeof), use.names = FALSE)
    if (!all(types == "integer")) {
      stopf("The elements of the list specified in argument 'seed' are not all integers (did you really pass RNG seeds?): %s", hpaste(unique(types)))
    }
    
    ## Check if valid random seeds are specified.
    ## For efficiency, only look at the first one.
    if (!is_valid_random_seed(seeds[[1]])) {
      stopf("The list in argument 'seed' does not seem to hold elements that are valid .Random.seed values: %s", capture.output(str(seeds[[1]])))
    }

    if (debug) {
      mdebugf("Using a pre-define stream of %d random seeds ... DONE", count)
      mdebug("Generating random seeds ... DONE")
    }
    
    return(seeds)
  }

  
  if (debug) mdebugf("Generating random seed streams for %d elements ...", count)
    
  ## Generate sequence of _all_ RNG seeds starting with an initial seed
  ## '.seed' that is based on argument 'seed'.
  .seed <- as_lecyer_cmrg_seed(seed)

  ## future_*apply() should return with the same RNG state regardless of
  ## future strategy used. This is be done such that RNG kind is preserved
  ## and the seed is "forwarded" one step from what it was when this
  ## function was called. The forwarding is done by generating one random
  ## number. Note that this approach is also independent on the number of
  ## elements iterated over and the different FUN() calls.
  oseed <- next_random_seed()
##  for (kk in seq_len(count)) {
##    sample.int(n = 1L, size = 1L, replace = FALSE)
##  }
##  oseed <- get_random_seed()
  on.exit(set_random_seed(oseed))

  seeds <- vector("list", length = count)
  for (ii in seq_len(count)) {
    ## RNG substream seed used when calling FUN() for element(s) 'ii':
    ## This way each future can in turn generate further seeds, also
    ## recursively, with minimal risk of generating the same seeds as
    ## another future. This should make it safe to recursively call
    ## future_*apply(). /HB 2017-01-11
    seeds[[ii]] <- nextRNGSubStream(.seed)
    
    ## Main random seed for next iteration (= ii + 1)
    .seed <- nextRNGStream(.seed)
  }
  
  if (debug) {
    mdebugf("Generating random seed streams for %d elements ... DONE", count)
    mdebug("Generating random seeds ... DONE")
  }

  seeds
}
