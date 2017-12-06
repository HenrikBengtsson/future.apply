# future.apply: Apply Function to Elements in Parallel using Futures

**WARNING: This package is under construction. Use with care.**

## Introduction


[BatchJobs]: https://cran.r-project.org/package=BatchJobs
[batchtools]: https://cran.r-project.org/package=batchtools
[future]: https://cran.r-project.org/package=future
[future.BatchJobs]: https://cran.r-project.org/package=future.BatchJobs
[future.batchtools]: https://cran.r-project.org/package=future.batchtools

## Installation
R package future.apply is only available via [GitHub](https://github.com/HenrikBengtsson/future.apply) and can be installed in R as:
```r
source('http://callr.org/install#HenrikBengtsson/future.apply')
```

### Pre-release version

To install the pre-release version that is available in Git branch `develop` on GitHub, use:
```r
source('http://callr.org/install#HenrikBengtsson/future.apply@develop')
```
This will install the package from source.  



## Contributions

This Git repository uses the [Git Flow](http://nvie.com/posts/a-successful-git-branching-model/) branching model (the [`git flow`](https://github.com/petervanderdoes/gitflow-avh) extension is useful for this).  The [`develop`](https://github.com/HenrikBengtsson/future.apply/tree/develop) branch contains the latest contributions and other code that will appear in the next release, and the [`master`](https://github.com/HenrikBengtsson/future.apply) branch contains the code of the latest release.

Contributing to this package is easy.  Just send a [pull request](https://help.github.com/articles/using-pull-requests/).  When you send your PR, make sure `develop` is the destination branch on the [future.apply repository](https://github.com/HenrikBengtsson/future.apply).  Your PR should pass `R CMD check --as-cran`, which will also be checked by <a href="https://travis-ci.org/HenrikBengtsson/future.apply">Travis CI</a> and <a href="https://ci.appveyor.com/project/HenrikBengtsson/future-apply">AppVeyor CI</a> when the PR is submitted.


## Software status

| Resource:     | GitHub        | Travis CI       | Appveyor         |
| ------------- | ------------------- | --------------- | ---------------- |
| _Platforms:_  | _Multiple_          | _Linux & macOS_ | _Windows_        |
| R CMD check   |  | <a href="https://travis-ci.org/HenrikBengtsson/future.apply"><img src="https://travis-ci.org/HenrikBengtsson/future.apply.svg" alt="Build status"></a>   | <a href="https://ci.appveyor.com/project/HenrikBengtsson/future-apply"><img src="https://ci.appveyor.com/api/projects/status/github/HenrikBengtsson/future.apply?svg=true" alt="Build status"></a> |
| Test coverage |                     | <a href="https://codecov.io/gh/HenrikBengtsson/future.apply"><img src="https://codecov.io/gh/HenrikBengtsson/future.apply/branch/develop/graph/badge.svg" alt="Coverage Status"/></a>     |                  |
