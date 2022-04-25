## Undo future strategy
future::plan(oplan)


## Undo options
## (a) Added
added <- setdiff(names(options()), names(oopts0))
opts <- vector("list", length = length(added))
names(opts) <- added
options(opts)
## (b) Modified
options(oopts)
## (c) Assert that everything was undone
stopifnot(all.equal(options(), oopts0))


## Undo system environment variables
## (a) Added
cenvs <- Sys.getenv()
added <- setdiff(names(cenvs), names(oenvs0))
for (name in added) Sys.unsetenv(name)
## (b) Missing
missing <- setdiff(names(oenvs0), names(cenvs))
if (length(missing) > 0) {
  values <- oenvs0[missing]
  do.call(Sys.setenv, as.list(values))
  ## WORKAROUND: Most platforms allow setting an environment variable to
  ## "", but Windows does not and there Sys.setenv(FOO = "") unsets FOO.
  if (.Platform$OS.type == "windows") {
    drop <- missing[!nzchar(values)]
    if (length(drop) > 0) {
      oenvs0 <- oenvs0[setdiff(names(oenvs0), drop)]
      ## In case Sys.setenv() supports empty string in the future
      Sys.unsetenv(drop)
    }
  }
}
## (c) Modified?
for (name in intersect(names(cenvs), names(oenvs0))) {
  ## WORKAROUND: On Linux Wine, base::Sys.getenv() may
  ## return elements with empty names. /HB 2016-10-06
  if (nchar(name) == 0) next
  if (!identical(cenvs[[name]], oenvs0[[name]])) {
    do.call(Sys.setenv, as.list(oenvs0[name]))
    ## WORKAROUND: Most platforms allow setting an environment variable to
    ## "", but Windows does not and there Sys.setenv(FOO = "") unsets FOO.
    if (.Platform$OS.type == "windows" && !nzchar(oenvs0[[name]])) {
      oenvs0 <- oenvs0[setdiff(names(oenvs0), name)]
      ## In case Sys.setenv() supports empty string in the future
      Sys.unsetenv(name)
    }
  }
}
## (d) Assert that everything was undone
stopifnot(identical(Sys.getenv(), oenvs0))


## Undo variables
rm(list = c(setdiff(ls(), ovars)))


## Travis CI specific: Explicit garbage collection because it
## looks like Travis CI might run out of memory during 'covr'
## testing and we now have so many tests. /HB 2017-01-11
if ("covr" %in% loadedNamespaces()) gc()
