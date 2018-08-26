#' future.apply: Apply Function to Elements in Parallel using Futures
#'
#' The \pkg{future.apply} packages provides parallel implementations of
#' common "apply" functions provided by base \R.  The parallel processing
#' is performed via the \pkg{future} ecosystem, which provides a large
#' number of parallel backends, e.g. on the local machine, a remote cluster,
#' and a high-performance compute cluster.
#' 
#' Currently implemented functions are:
#'
#' * [future_apply()]: a parallel version of [apply()][base::apply]
#' * [future_eapply()]: a parallel version of [eapply()][base::lapply]
#' * [future_lapply()]: a parallel version of [lapply()][base::lapply]
#' * [future_mapply()]: a parallel version of [mapply()][base::mapply]
#' * [future_sapply()]: a parallel version of [sapply()][base::sapply]
#' * [future_tapply()]: a parallel version of [tapply()][base::tapply]
#' * [future_vapply()]: a parallel version of [vapply()][base::vapply]
#' * [future_Map()]: a parallel version of [Map()][base::Map]
#' * [future_replicate()]: a parallel version of [replicate()][base::replicate]
#'
#' Reproducibility is part of the core design, which means that perfect,
#' parallel random number generation (RNG) is supported regardless of the
#' amount of chunking, type of load balancing, and future backend being used.
#' 
#' Since these `future_*()` functions have the same arguments as the
#' corresponding base \R function, start using them is often as simple as
#' renaming the function in the code.  For example, after attaching the package:
#' ```r
#' library(future.apply)
#' ```
#' code such as:
#' ```r
#' x <- list(a = 1:10, beta = exp(-3:3), logic = c(TRUE,FALSE,FALSE,TRUE))
#' y <- lapply(x, quantile, probs = 1:3/4)
#' ```
#' can be updated to:
#' ```r
#' y <- future_lapply(x, quantile, probs = 1:3/4)
#' ```
#'
#' The default settings in the \pkg{future} framework is to process code
#' _sequentially_.  To run the above in parallel on the local machine
#' (on any operating system), use:
#' ```r
#' plan(multiprocess)
#' ```
#' first.  That's it!
#'
#' To go back to sequential processing, use `plan(sequential)`.
#' If you have access to multiple machines on your local network, use:
#' ```r
#' plan(cluster, workers = c("n1", "n2", "n2", "n3"))
#' ```
#' This will set up four workers, one on `n1` and `n3`, and two on `n2`.
#' If you have SSH access to some remote machines, use:
#' ```r
#' plan(cluster, workers = c("m1.myserver.org", "m2.myserver.org))
#' ```
#' See the \pkg{future} package and [future::plan()] for more examples.
#'
#' The \pkg{future.batchtools} package provides support for high-performance
#' compute (HPC) cluster schedulers such as SGE, Slurm, and TORQUE / PBS.
#' For example,
#'
#' * `plan(batchtools_slurm)`:
#'      Process via a Slurm scheduler job queue.
#' * `plan(batchtools_torque)`:
#'      Process via a TORQUE / PBS scheduler job queue.
#' 
#' This builds on top of the queuing framework that the \pkg{batchtools}
#' package provides. For more details on backend configuration, please see
#' the \pkg{future.batchtools} and \pkg{batchtools} packages.
#'
#' These are just a few examples of parallel/distributed backend for the
#' future ecosystem.  For more alternatives, see the 'Reverse dependencies'
#' section on the
#' [future CRAN package page](https://cran.r-project.org/package=future).
#'
#' @author
#' Henrik Bengtsson, except for the implementations of `future_apply()`,
#' `future_Map()`, `future_replicate()`, `future_sapply()`, and
#' `future_tapply()`, which are adopted from the source code of the
#' corresponding base \R functions, which are licensed under GPL (>= 2)
#' with 'The R Core Team' as the copyright holder.
#' Because of these dependencies, the license of this package is GPL (>= 2).
#' 
#' @keywords manip programming iteration
#'
#' @docType package
#' @name future.apply
NULL
