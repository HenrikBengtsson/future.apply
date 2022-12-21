<div id="badges"><!-- pkgdown markup -->
<a href="https://CRAN.R-project.org/web/checks/check_results_future.apply.html"><img border="0" src="https://www.r-pkg.org/badges/version/future.apply" alt="CRAN check status"/></a>
<a href="https://github.com/HenrikBengtsson/future.apply/actions?query=workflow%3AR-CMD-check"><img border="0" src="https://github.com/HenrikBengtsson/future.apply/actions/workflows/R-CMD-check.yaml/badge.svg?branch=develop" alt="R CMD check status"/></a>
<a href="https://app.codecov.io/gh/HenrikBengtsson/future.apply"><img border="0" src="https://codecov.io/gh/HenrikBengtsson/future.apply/branch/develop/graph/badge.svg" alt="Coverage Status"/></a> 
</div>

# future.apply: Apply Function to Elements in Parallel using Futures 

## Introduction

The purpose of this package is to provide worry-free parallel alternatives to base-R "apply" functions, e.g. `apply()`, `lapply()`, and `vapply()`.  The goal is that one should be able to replace any of these in the core with its futurized equivalent and things will just work.  For example, instead of doing:
```r
library(datasets)
library(stats)
y <- lapply(mtcars, FUN = mean, trim = 0.10)
```
one can do:
```r
library(future.apply)
plan(multisession) ## Run in parallel on local computer

library(datasets)
library(stats)
y <- future_lapply(mtcars, FUN = mean, trim = 0.10)
```

Reproducibility is part of the core design, which means that perfect, parallel random number generation (RNG) is supported regardless of the amount of chunking, type of load balancing, and future backend being used.  To enable parallel RNG, use argument `future.seed = TRUE`.


## Role

Where does the **[future.apply]** package fit in the software stack?  You can think of it as a sibling to **[foreach]**, **[furrr]**, **[BiocParallel]**, **[plyr]**, etc.  Just as parallel provides `parLapply()`, **foreach** provides `foreach()`, **BiocParallel** provides `bplapply()`, and **plyr** provides `llply()`, **future.apply** provides `future_lapply()`.  Below is a table summarizing this idea:

<table>
<tr>
<th>Package</th>
<th>Functions</th>
<th>Backends</th>
</tr>

<tr style="vertical-align: top">
<td>
<a href="https://cran.r-project.org/package=future.apply"><strong>future.apply</strong></a><br>
<br>
</td>
<td>
Future-versions of common goto <code>*apply()</code> functions available in base R (of the <strong>base</strong> package):<br>
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
<em>The following function is not implemented:</em><br>
<code>future_rapply()</code><br>
</td>
<td>
All <strong>future</strong> backends
</td>
</tr>

<tr style="vertical-align: top">
<td>
<strong>parallel</strong>
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
<a href="https://cran.r-project.org/package=foreach"><strong>foreach</strong></a>
</td>
<td>
<code>foreach()</code>,
<code>times()</code>
</td>
<td>
All <strong>future</strong> backends via <a href="https://cran.r-project.org/package=doFuture"><strong>doFuture</strong></a>
</td>
</tr>

<tr style="vertical-align: top">
<td>
<a href="https://cran.r-project.org/package=furrr"><strong>furrr</strong></a>
</td>
<td>
<code>future_imap()</code>,
<code>future_map()</code>,
<code>future_pmap()</code>,
<code>future_map2()</code>,
...
</td>
<td>
All <strong>future</strong> backends
</td>
</tr>

<tr style="vertical-align: top">
<td>
<a href="https://bioconductor.org/packages/release/bioc/html/BiocParallel.html"><strong>BiocParallel</strong></a>
</td>
<td>
Bioconductor's parallel mappers:<br>
<code>bpaggregate()</code>,
<code>bpiterate()</code>,
<code>bplapply()</code>, and
<code>bpvec()</code>
</td>
<td>
All <strong>future</strong> backends via <a href="https://cran.r-project.org/package=doFuture"><strong>doFuture</strong></a> (because it supports <strong>foreach</strong>) or via <a href="https://github.com/HenrikBengtsson/BiocParallel.FutureParam"><strong>BiocParallel.FutureParam</strong></a> (direct BiocParallelParam support; prototype)
</td>
</tr>


<tr style="vertical-align: top">
<td>
<a href="https://cran.r-project.org/package=plyr"><strong>plyr</strong></a>
</td>
<td>
<code>**ply(..., .parallel = TRUE)</code> functions:<br>
<code>aaply()</code>,
<code>ddply()</code>,
<code>dlply()</code>,
<code>llply()</code>, ...
</td>
<td>
All <strong>future</strong> backends via <a href="https://cran.r-project.org/package=doFuture"><strong>doFuture</strong></a> (because it uses <strong>foreach</strong> internally)
</td>
</tr>

</table>

Note that, except for the built-in **parallel** package, none of these higher-level APIs implement their own parallel backends, but they rather enhance existing ones.  The **foreach** framework leverages backends such as **[doParallel]**, **[doMC]** and **[doFuture]**, and the **future.apply** framework leverages the **[future]** ecosystem and therefore backends such as built-in **parallel**, **[future.callr]**, and **[future.batchtools]**.

By separating `future_lapply()` and friends from the **[future]** package, it helps clarifying the purpose of the **future** package, which is to define and provide the core Future API, which higher-level parallel APIs can build on and for which any futurized parallel backends can be plugged into.

The API and identity of the **future.apply** package will be kept close to the `*apply()` functions in base R.  In other words, it will _neither_ keep growing nor be expanded with new, more powerful apply-like functions beyond those core ones in base R.  Such extended functionality should be part of a separate package.


[batchtools]: https://cran.r-project.org/package=batchtools
[BiocParallel]: https://bioconductor.org/packages/BiocParallel/
[doFuture]: https://cran.r-project.org/package=doFuture
[doMC]: https://cran.r-project.org/package=doMC
[doParallel]: https://cran.r-project.org/package=doParallel
[foreach]: https://cran.r-project.org/package=foreach
[future]: https://cran.r-project.org/package=future
[future.apply]: https://cran.r-project.org/package=future.apply
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

<!-- pkgdown-drop-below -->


## Contributing

To contribute to this package, please see [CONTRIBUTING.md](CONTRIBUTING.md).

