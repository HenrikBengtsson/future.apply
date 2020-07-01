# future.apply: Apply Function to Elements in Parallel using Futures

## Introduction

The purpose of this package is to provide worry-free parallel alternatives to base-R "apply" functions, e.g. `apply()`, `lapply()`, and `vapply()`.  The goal is that one should be able to replace any of these in the core with its futurized equivalent and things will just work.  For example, instead of doing:
```r
library("stats")
x <- 1:10
y <- lapply(x, FUN = quantile, probs = 1:3/4)
```
one can do:
```r
library("future.apply")
plan(multisession) ## Run in parallel on local computer

library("stats")
x <- 1:10
y <- future_lapply(x, FUN = quantile, probs = 1:3/4)
```

Reproducibility is part of the core design, which means that perfect, parallel random number generation (RNG) is supported regardless of the amount of chunking, type of load balancing, and future backend being used.  _To enable parallel RNG, use argument `future.seed = TRUE`._


## Role

Where does the [future.apply] package fit in the software stack?  You can think of it as a sibling to [foreach], [furrr], [BiocParallel], [plyr], etc.  Just as parallel provides `parLapply()`, foreach provides `foreach()`, BiocParallel provides `bplapply()`, and plyr provides `llply()`, future.apply provides `future_lapply()`.  Below is a table summarizing this idea:

<table>
<tr>
<th>Package</th>
<th>Functions</th>
<th>Backends</th>
</tr>

<tr style="vertical-align: top">
<td>
<a href="https://cran.r-project.org/package=future.apply">future.apply</a><br>
<br>
</td>
<td>
Future-versions of common goto <code>*apply()</code> functions available in base R (of the 'base' package):<br>
<code>future_apply()</code>, 
<code>future_by()</code>, 
<code>future_eapply()</code>, 
<code>future_lapply()</code>, 
<code>future_Map()</code>, 
<code>future_mapply()</code>, 
<code>future_.mapply()</code>, 
<code>future_replicate()</code>,
<code>future_sapply()</code>,
<code>future_tapply()</code>, and 
<code>future_vapply()</code>.
<br>
<em>The following function is yet not implemented:</em><br>
<code>future_rapply()</code><br>
</td>
<td>
All future backends
</td>
</tr>

<tr style="vertical-align: top">
<td>
parallel
</td>
<td>
<code>mclapply()</code>, <code>mcmapply()</code>,
<code>clusterMap()</code>, <code>parApply()</code>, <code>parLapply()</code>, <code>parSapply()</code>, ...
</td>
<td>
Built-in and conditional on operating system</a>
</td>
</tr>

<tr style="vertical-align: top">
<td>
<a href="https://cran.r-project.org/package=foreach">foreach</a>
</td>
<td>
<code>foreach()</code>,
<code>times()</code>
</td>
<td>
All future backends via <a href="https://cran.r-project.org/package=doFuture">doFuture</a>
</td>
</tr>

<tr style="vertical-align: top">
<td>
<a href="https://cran.r-project.org/package=furrr">furrr</a>
</td>
<td>
<code>future_imap()</code>,
<code>future_map()</code>,
<code>future_pmap()</code>,
<code>future_map2()</code>,
...
</td>
<td>
All future backends
</td>
</tr>

<tr style="vertical-align: top">
<td>
<a href="https://bioconductor.org/packages/release/bioc/html/BiocParallel.html">BiocParallel</a>
</td>
<td>
Bioconductor's parallel mappers:<br>
<code>bpaggregate()</code>,
<code>bpiterate()</code>,
<code>bplapply()</code>, and
<code>bpvec()</code>
</td>
<td>
All future backends via <a href="https://cran.r-project.org/package=doFuture">doFuture</a> (because it supports foreach) or via <a href="https://github.com/HenrikBengtsson/BiocParallel.FutureParam">BiocParallel.FutureParam</a> (direct BiocParallelParam support; prototype)
</td>
</tr>


<tr style="vertical-align: top">
<td>
<a href="https://cran.r-project.org/package=plyr">plyr</a>
</td>
<td>
<code>**ply(..., .parallel = TRUE)</code> functions:<br>
<code>aaply()</code>,
<code>ddply()</code>,
<code>dlply()</code>,
<code>llply()</code>, ...
</td>
<td>
All future backends via <a href="https://cran.r-project.org/package=doFuture">doFuture</a> (because it uses foreach internally)
</td>
</tr>

</table>

Note that, except for the built-in parallel package, none of these higher-level APIs implement their own parallel backends, but they rather enhance existing ones.  The foreach framework leverages backends such as [doParallel], [doMC] and [doFuture], and the future.apply framework leverages the [future] ecosystem and therefore backends such as built-in parallel, [future.callr], and [future.batchtools].

By separating `future_lapply()` and friends from the [future] package, it helps clarifying the purpose of the future package, which is to define and provide the core Future API, which higher-level parallel APIs can build on and for which any futurized parallel backends can be plugged into.


## Roadmap

1. Implement `future_*apply()` versions for all common `*apply()` functions that exist in base R.  This also involves writing a large set of package tests asserting the correctness and the same behavior as the corresponding `*apply()` functions.

2. Harmonize all `future_*apply()` functions with each other, e.g. the future-specific arguments.

3. Consider additional `future_*apply()` functions and features that fit in this package but don't necessarily have a corresponding function in base R.  Examples of this may be "apply" functions that return futures rather than values, mechanisms for benchmarking, and richer control over load balancing.

The API and identity of the future.apply package will be kept close to the `*apply()` functions in base R.  In other words, it will _neither_ keep growing nor be expanded with new, more powerful apply-like functions beyond those core ones in base R.  Such extended functionality should be part of a separate package.



[BatchJobs]: https://cran.r-project.org/package=BatchJobs
[batchtools]: https://cran.r-project.org/package=batchtools
[BiocParallel]: https://bioconductor.org/packages/BiocParallel/
[doFuture]: https://cran.r-project.org/package=doFuture
[doMC]: https://cran.r-project.org/package=doMC
[doParallel]: https://cran.r-project.org/package=doParallel
[foreach]: https://cran.r-project.org/package=foreach
[future]: https://cran.r-project.org/package=future
[future.apply]: https://cran.r-project.org/package=future.apply
[future.BatchJobs]: https://cran.r-project.org/package=future.BatchJobs
[future.batchtools]: https://cran.r-project.org/package=future.batchtools
[future.callr]: https://cran.r-project.org/package=future.callr
[furrr]: https://cran.r-project.org/package=furrr
[plyr]: https://cran.r-project.org/package=plyr


## Installation
R package future.apply is available on [CRAN](https://cran.r-project.org/package=future.apply) and can be installed in R as:
```r
install.packages("future.apply")
```

### Pre-release version

To install the pre-release version that is available in Git branch `develop` on GitHub, use:
```r
remotes::install_github("HenrikBengtsson/future.apply", ref="develop")
```
This will install the package from source.  



## Contributions

This Git repository uses the [Git Flow](http://nvie.com/posts/a-successful-git-branching-model/) branching model (the [`git flow`](https://github.com/petervanderdoes/gitflow-avh) extension is useful for this).  The [`develop`](https://github.com/HenrikBengtsson/future.apply/tree/develop) branch contains the latest contributions and other code that will appear in the next release, and the [`master`](https://github.com/HenrikBengtsson/future.apply) branch contains the code of the latest release, which is exactly what is currently on [CRAN](https://cran.r-project.org/package=future.apply).

Contributing to this package is easy.  Just send a [pull request](https://help.github.com/articles/using-pull-requests/).  When you send your PR, make sure `develop` is the destination branch on the [future.apply repository](https://github.com/HenrikBengtsson/future.apply).  Your PR should pass `R CMD check --as-cran`, which will also be checked by <a href="https://travis-ci.org/HenrikBengtsson/future.apply">Travis CI</a> and <a href="https://ci.appveyor.com/project/HenrikBengtsson/future-apply">AppVeyor CI</a> when the PR is submitted.


## Software status

| Resource      | CRAN        | GitHub Actions      | Travis CI       | AppVeyor CI      |
| ------------- | ------------------- | ------------------- | --------------- | ---------------- |
| _Platforms:_  | _Multiple_          | _Multiple_          | _Linux & macOS_ | _Windows_        |
| R CMD check   | <a href="https://cran.r-project.org/web/checks/check_results_future.apply.html"><img border="0" src="http://www.r-pkg.org/badges/version/future.apply" alt="CRAN version"></a> | <a href="https://github.com/HenrikBengtsson/future.apply/actions?query=workflow%3AR-CMD-check"><img src="https://github.com/HenrikBengtsson/future.apply/workflows/R-CMD-check/badge.svg?branch=develop" alt="Build status"></a>       | <a href="https://travis-ci.org/HenrikBengtsson/future.apply"><img src="https://travis-ci.org/HenrikBengtsson/future.apply.svg" alt="Build status"></a>   | <a href="https://ci.appveyor.com/project/HenrikBengtsson/future-apply"><img src="https://ci.appveyor.com/api/projects/status/github/HenrikBengtsson/future.apply?svg=true" alt="Build status"></a> |
| Test coverage |                     |                     | <a href="https://codecov.io/gh/HenrikBengtsson/future.apply"><img src="https://codecov.io/gh/HenrikBengtsson/future.apply/branch/develop/graph/badge.svg" alt="Coverage Status"/></a>     |                  |
