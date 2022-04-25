#' Apply Functions Over Array Margins via Futures
#'
#' `future_apply()` implements [base::apply()] using future with perfect
#' replication of results, regardless of future backend used.
#' It returns a vector or array or list of values obtained by applying a
#' function to margins of an array or matrix.
#'
#' @inheritParams future_lapply
#' 
#' @param X an array, including a matrix.
#' 
#' @param MARGIN A vector giving the subscripts which the function will be
#' applied over. For example, for a matrix `1` indicates rows, `2` indicates
#' columns, `c(1, 2)` indicates rows and columns.
#' Where `X` has named dimnames, it can be a character vector selecting
#' dimension names.
#' 
#' @param \ldots  (optional) Additional arguments passed to `FUN()`, except
#' `future.*` arguments, which are passed on to [future_lapply()] used
#' internally.
#' 
#' @param simplify a logical indicating whether results should be simplified
#' if possible.
#'
#' @return
#' Returns a vector or array or list of values obtained by applying a
#' function to margins of an array or matrix.
#' See [base::apply()] for details.
#'
#' @author
#' The implementations of `future_apply()` is adopted from the source code
#' of the corresponding base \R function, which is licensed under GPL (>= 2)
#' with 'The R Core Team' as the copyright holder.
#'
#' @example incl/future_apply.R
#'
#' @importFrom future nbrOfWorkers
#' @export
future_apply <- function(X, MARGIN, FUN, ..., simplify = TRUE, future.envir = parent.frame(), future.stdout = TRUE, future.conditions = "condition", future.globals = TRUE, future.packages = NULL, future.seed = FALSE, future.scheduling = 1.0, future.chunk.size = NULL, future.label = "future_apply-%d") {
    debug <- getOption("future.apply.debug", getOption("future.debug", FALSE))

    FUN <- match.fun(FUN)
    simplify <- isTRUE(simplify)

    ## Ensure that X is an array object
    dl <- length(dim(X))
    if(!dl) stop("dim(X) must have a positive length")
    if(is.object(X))
	X <- if(dl == 2L) as.matrix(X) else as.array(X)
    ## now record dim as coercion can change it
    ## (e.g. when a data frame contains a matrix).
    d <- dim(X)
    dn <- dimnames(X)
    ds <- seq_len(dl)

    ## Extract the margins and associated dimnames

    if (is.character(MARGIN)) {
        if(is.null(dnn <- names(dn))) # names(NULL) is NULL
           stop("'X' must have named dimnames")
        MARGIN <- match(MARGIN, dnn)
        if (anyNA(MARGIN))
            stop("not all elements of 'MARGIN' are names of dimensions")
    }
    s.call <- ds[-MARGIN]
    s.ans  <- ds[MARGIN]
    d.call <- d[-MARGIN]
    d.ans <- d[MARGIN]
    dn.call <- dn[-MARGIN]
    dn.ans <- dn[MARGIN]
    ## dimnames(X) <- NULL

    ## do the calls

    d2 <- prod(d.ans)
    if(d2 == 0L) {
        ## arrays with some 0 extents: return ``empty result'' trying
        ## to use proper mode and dimension:
        ## The following is still a bit `hackish': use non-empty X
        newX <- array(vector(typeof(X), 1L), dim = c(prod(d.call), 1L))
        ans <- forceAndCall(1, FUN, if(length(d.call) < 2L) newX[,1] else
                   array(newX[, 1L], d.call, dn.call), ...)
        return(if(is.null(ans)) ans else if(length(d.ans) < 2L) ans[1L][-1L]
               else array(ans, d.ans, dn.ans))
    }


    ## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    ## Globals and Packages
    ## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    gp <- getGlobalsAndPackagesXApply(
      FUN,
      args = list(X = X, ...),
      envir = environment(),
      future.globals = future.globals,
      future.packages = future.packages,
      debug = debug
    )
    globals <- gp$globals
    packages <- gp$packages
    gp <- NULL

    ## Check size of global variables?
    ## Doing it here, on the matrix object, is much faster than doing it for
    ## the list elements passed to future_lapply()
    oldMaxSize <- maxSize <- getOption("future.globals.maxSize")
    if (is.null(maxSize) || is.finite(maxSize)) {
      if (is.null(maxSize)) maxSize <- 500 * 1024^2
      objectSize <- import_future("objectSize")
      size <- objectSize(X)
      nWorkers <- nbrOfWorkers()
      chunk_size <- size / nWorkers
      other_size <- attr(globals, "total_size")
      if (is.numeric(other_size)) chunk_size <- chunk_size + other_size
      if (chunk_size > maxSize) {
        asIEC <- import_future("asIEC")
        msg <- sprintf("The total size of %s (of class %s and type %s) is %s and the total size of the other argument is %s. With %d workers, this translates to %s per worker needed for future_apply(), which exceeds the maximum allowed size of %s (option 'future.globals.maxSize').", sQuote("X"), sQuote(class(X)[1]), sQuote(typeof(X)), asIEC(size), asIEC(other_size), nWorkers, asIEC(chunk_size), asIEC(maxSize))
        if (debug) mdebug(msg)
        stop(msg)
      }
      on.exit(options(future.globals.maxSize = oldMaxSize), add = TRUE)
      options(future.globals.maxSize = +Inf)
    }

    newX <- aperm(X, c(s.call, s.ans))
    dim(newX) <- c(prod(d.call), d2)

    if(length(d.call) < 2L) {# vector
        if (length(dn.call)) dimnames(newX) <- c(dn.call, list(NULL))
        newX <- lapply(1L:d2, FUN = function(i) newX[,i])
    } else
        newX <- lapply(1L:d2, FUN = function(i)
                       array(newX[,i], dim = d.call, dimnames = dn.call))

    globals$...future.FUN <- NULL
    ans <- future_lapply(
      X = newX,
      FUN = FUN,
      ...,
      future.envir = future.envir,
      future.stdout = future.stdout,
      future.conditions = future.conditions,
      future.seed = future.seed,
      future.scheduling = future.scheduling,
      future.chunk.size = future.chunk.size,
      future.globals = globals,
      future.packages = packages,
      future.label = future.label
    )
    
    ## answer dims and dimnames

    ans.list <- !simplify || is.recursive(ans[[1L]])
    l.ans <- length(ans[[1L]])

    ans.names <- names(ans[[1L]])
    if(!ans.list)
	ans.list <- any(lengths(ans) != l.ans)
    if(!ans.list && length(ans.names)) {
        all.same <- vapply(ans, function(x) identical(names(x), ans.names), NA)
        if (!all(all.same)) ans.names <- NULL
    }
    len.a <- if(ans.list) d2 else length(ans <- unlist(ans, recursive = FALSE))
    if(length(MARGIN) == 1L && len.a == d2) {
	names(ans) <- if(length(dn.ans[[1L]])) dn.ans[[1L]] # else NULL
	ans
    }
    else if(len.a == d2)
	array(ans, d.ans, dn.ans)
    else if(len.a && len.a %% d2 == 0L) {
        if(is.null(dn.ans)) dn.ans <- vector(mode="list", length(d.ans))
	dn1 <- list(ans.names)
	if(length(dn.call) && !is.null(n1 <- names(dn <- dn.call[1])) &&
	   nzchar(n1) && length(ans.names) == length(dn[[1]]))
	    names(dn1) <- n1
	dn.ans <- c(dn1, dn.ans)
	array(ans, c(len.a %/% d2, d.ans),
	      if(!is.null(names(dn.ans)) || !all(vapply(dn.ans, is.null, NA)))
		  dn.ans)
    } else
	ans
}
