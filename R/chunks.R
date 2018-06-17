#' Create Chunks of Index Vectors
#'
#' _This is an internal function._
#' 
#' @param nbrOfElements (integer) Total number of elements to iterate over.
#' 
#' @param nbrOfWorker (integer) Number of workers available.
#' 
#' @param scheduling (numeric) A strictly positive scalar.
#'
#' @return A list of chunks, where each chunk is an integer vector of
#' unique indices \code{[1, nbrOfElements]}.  The union of all chunks
#' holds `nbrOfElements` elements and equals `1:nbrOfElements`.
#' If `nbrOfElements == 0`, then an empty list is returned.
#' 
#' @importFrom parallel splitIndices
#' @keywords internal
makeChunks <- function(nbrOfElements, nbrOfWorkers, scheduling = 1.0) {
  stop_if_not(nbrOfElements >= 0L, nbrOfWorkers >= 1L)

  if (is.logical(scheduling)) {
    if (scheduling) {
      nbrOfChunks <- nbrOfWorkers
      if (nbrOfChunks > nbrOfElements) nbrOfChunks <- nbrOfElements
    } else {
      nbrOfChunks <- nbrOfElements
    }
  } else {
    ## Treat 'scheduling' as the number of chunks per worker, i.e.
    ## the number of chunks each worker should process on average.
    stop_if_not(scheduling >= 0)
    if (nbrOfWorkers > nbrOfElements) nbrOfWorkers <- nbrOfElements
    nbrOfChunks <- scheduling * nbrOfWorkers
    if (nbrOfChunks < 1L) {
      nbrOfChunks <- 1L
    } else if (nbrOfChunks > nbrOfElements) {
      nbrOfChunks <- nbrOfElements
    }
  }

  splitIndices(nbrOfElements, ncl = nbrOfChunks)
}
