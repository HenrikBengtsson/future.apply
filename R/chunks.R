#' @importFrom parallel splitIndices
makeChunks <- function(count, workers, scheduling = 1.0) {
  if (is.logical(scheduling)) {
    if (scheduling) {
      nbr_of_futures <- workers
      if (nbr_of_futures > count) nbr_of_futures <- count
    } else {
      nbr_of_futures <- count
    }
  } else {
    ## Treat 'scheduling' as the number of futures per worker.
    stop_if_not(scheduling >= 0)
    nbr_of_workers <- workers
    if (nbr_of_workers > count) nbr_of_workers <- count
    nbr_of_futures <- scheduling * nbr_of_workers
    if (nbr_of_futures < 1) {
      nbr_of_futures <- 1L
    } else if (nbr_of_futures > count) {
      nbr_of_futures <- count
    }
  }

  splitIndices(count, ncl = nbr_of_futures)
} ## makeChunks()  
