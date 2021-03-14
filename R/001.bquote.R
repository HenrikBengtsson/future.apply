#' @importFrom utils globalVariables
globalVariables(c(".", ".."))

## bquote_compile() and bquote_apply() are only available in future (>= 1.22.0)
bquote_compile <- import_future("bquote_compile", default = function(expr, substitute = TRUE) {
    if (substitute) expr <- substitute(expr)
    
    tmpl <- list()
    
    unquote <- function(e, at = integer(0L)) {
        n <- length(e)
        if (n == 0L) return()

        if (is.pairlist(e)) {
          for (kk in 1:n) unquote(e[[kk]], at = c(at, kk))
          return()
        }

        if (!is.call(e)) return()
        
        ## .(<name>)?
        if (is.name(e[[1L]]) && as.character(e[[1]]) == ".") {
            ## Record location in expression tree
            entry <- list(
              expression = e[[2L]],
              at         = at
            )
            tmpl <<- c(tmpl, list(entry))
            return()
        }
        
        ## `{`, `+`, ...
        for (kk in 1:n) unquote(e[[kk]], at = c(at, kk))
    }

    dummy <- unquote(expr)
    attr(tmpl, "expression") <- expr
    tmpl
})


bquote_apply <- import_future("bquote_apply", default = function(tmpl, envir = parent.frame()) {
  expr <- attr(tmpl, "expression")
  
  for (kk in seq_along(tmpl)) {
    entry <- tmpl[[kk]]
    value <- eval(entry$expression, envir = envir)
    at <- entry$at
    
    ## Special case: Result becomes just a value
    nat <- length(at)
    if (nat == 0) return(value)

    ## Inject a NULL (needs special care) or a regular value?
    if (is.null(value)) {
      head <- if (nat == 1L) NULL else at[-nat]
      e <- if (is.null(head)) expr else expr[[head]]
      if (is.call(e)) {
        f <- as.list(e)
        f[at[nat]] <- list(NULL)
        e <- as.call(f)
      } else if (is.pairlist(e)) {
        e[1] <- list(NULL)
        e <- as.pairlist(e)
      } else {
        stop("Unknown type of expression (please report to the maintainer): ",
             sQuote(paste(deparse(e), collapse = "\\n")))
      }
      if (is.null(head)) {
        expr <- e
      } else {
        expr[[head]] <- e
      }
    } else {
      expr[[at]] <- value
    }
  }

  expr
})


bquote2 <- import_future("bquote2", default = function(expr, where = parent.frame(), splice = FALSE, substitute = TRUE) {
  stop_if_not(!splice)
  if (substitute) expr <- substitute(expr)
  tmpl <- bquote_compile(expr, substitute = FALSE)
  bquote_apply(tmpl, envir = where)
})

