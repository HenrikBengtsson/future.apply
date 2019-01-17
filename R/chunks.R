#' Create Chunks of Index Vectors
#'
#' _This is an internal function._
#' 
#' @param nbrOfElements (integer) Total number of elements to iterate over.
#' 
#' @param nbrOfWorker (integer) Number of workers available.
#' 
#' @param future.scheduling (numeric) A strictly positive scalar.
#' Only used if argument `future.chunk.size` is `NULL`.
#'
#' @param future.chunk.size (numeric) The maximum number of elements per
#' chunk, or `NULL`.  If `NULL`, then the chunk sizes are given by the
#' `future.scheduling` argument.
#'
#' @return A list of chunks, where each chunk is an integer vector of
#' unique indices \code{[1, nbrOfElements]}.  The union of all chunks
#' holds `nbrOfElements` elements and equals `1:nbrOfElements`.
#' If `nbrOfElements == 0`, then an empty list is returned.
#'
#' @section Control processing order of elements:
#' Attribute `ordering` of `future.chunk.size` or `future.scheduling` can
#' be used to control the ordering the elements are iterated over, which
#' only affects the processing order _not_ the order values are returned.
#' This attribute can take the following values:
#' * index vector - an numeric vector of length `nbrOfElements` specifying
#'                  how elements are remapped
#' * function     - an function taking one argument which is called as
#'                  `ordering(nbrOfElements)` and which much return an
#'                  index vector of length `nbrOfElements`, e.g.
#'                  `function(n) rev(seq_len(n))` for reverse ordering.
#' * `"random"`   - this will randomize the ordering via random index
#'                  vector `sample.int(nbrOfElements)`.
#' 
#' @importFrom parallel splitIndices
#' @keywords internal
makeChunks <- function(nbrOfElements, nbrOfWorkers,
                       future.scheduling = 1.0, future.chunk.size = NULL) {
  stop_if_not(nbrOfElements >= 0L, nbrOfWorkers >= 1L)

  ## 'future.chunk.size != NULL' takes precedence over 'future.scheduling'
  if (!is.null(future.chunk.size)) {
    stop_if_not(length(future.chunk.size) == 1L, !is.na(future.chunk.size),
                future.chunk.size > 0)
    ## Same definition as parallel:::staticNChunks() in R (>= 3.5.0)
    nbrOfChunks <- max(1, ceiling(nbrOfElements / future.chunk.size))

    ## Customized ordering?
    ordering <- attr(future.chunk.size, "ordering", exact = TRUE)
  } else {
    if (is.logical(future.scheduling)) {
      stop_if_not(length(future.scheduling) == 1L, !is.na(future.scheduling))
      if (future.scheduling) {
        nbrOfChunks <- nbrOfWorkers
        if (nbrOfChunks > nbrOfElements) nbrOfChunks <- nbrOfElements
      } else {
        nbrOfChunks <- nbrOfElements
      }
    } else {
      ## Treat 'future.scheduling' as the number of chunks per worker, i.e.
      ## the number of chunks each worker should process on average.
      stop_if_not(length(future.scheduling) == 1L, !is.na(future.scheduling),
                  future.scheduling >= 0)
      if (nbrOfWorkers > nbrOfElements) nbrOfWorkers <- nbrOfElements
      nbrOfChunks <- future.scheduling * nbrOfWorkers
      if (nbrOfChunks < 1L) {
        nbrOfChunks <- 1L
      } else if (nbrOfChunks > nbrOfElements) {
        nbrOfChunks <- nbrOfElements
      }
    }
    
    ## Customized ordering?
    ordering <- attr(future.scheduling, "ordering", exact = TRUE)
  }

  chunks <- splitIndices(nbrOfElements, ncl = nbrOfChunks)
  
  ## Customized ordering?
  if (nbrOfElements > 1L && !is.null(ordering)) {
    if (is.character(ordering) && ordering == "random") {
      map <- stealth_sample.int(nbrOfElements)
    } else if (is.numeric(ordering)) {
      map <- ordering
    } else if (is.function(ordering)) {
      map <- ordering(nbrOfElements)
    } else {
      stop(sprintf("Unknown value of attribute %s for argument %s: ", "ordering", if (!is.null(future.chunk.size)) "future.chunk.size" else "future.scheduling"), mode(ordering))
    }

    if (!is.null(map)) {
      ## Simple validity check of "ordering".  Looking for NAs, range,
      ## uniqueness is too expensive so skipped.
      stop_if_not(length(map) == nbrOfElements)
      attr(chunks, "ordering") <- map
    }
  }
  
  chunks
}
