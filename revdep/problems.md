# BAMBI

<details>

* Version: 2.1.0
* Source code: https://github.com/cran/BAMBI
* URL: https://arxiv.org/abs/1708.07804
* BugReports: https://github.com/c7rishi/BAMBI/issues
* Date/Publication: 2019-03-16 20:43:42 UTC
* Number of recursive dependencies: 51

Run `revdep_details(,"BAMBI")` for more info

</details>

## In both

*   checking installed package size ... NOTE
    ```
      installed size is  5.5Mb
      sub-directories of 1Mb or more:
        libs   4.9Mb
    ```

# blavaan

<details>

* Version: 0.3-8
* Source code: https://github.com/cran/blavaan
* Date/Publication: 2019-11-19 19:20:02 UTC
* Number of recursive dependencies: 103

Run `revdep_details(,"blavaan")` for more info

</details>

## In both

*   checking installed package size ... NOTE
    ```
      installed size is 51.7Mb
      sub-directories of 1Mb or more:
        libs  50.0Mb
    ```

*   checking for GNU extensions in Makefiles ... NOTE
    ```
    GNU make is a SystemRequirements.
    ```

# dipsaus

<details>

* Version: 0.0.3
* Source code: https://github.com/cran/dipsaus
* URL: https://github.com/dipterix/dipsaus
* BugReports: https://github.com/dipterix/dipsaus/issues
* Date/Publication: 2019-11-18 05:40:02 UTC
* Number of recursive dependencies: 59

Run `revdep_details(,"dipsaus")` for more info

</details>

## In both

*   checking for GNU extensions in Makefiles ... NOTE
    ```
    GNU make is a SystemRequirements.
    ```

# genBaRcode

<details>

* Version: 1.2.2
* Source code: https://github.com/cran/genBaRcode
* Date/Publication: 2019-10-25 15:10:02 UTC
* Number of recursive dependencies: 138

Run `revdep_details(,"genBaRcode")` for more info

</details>

## In both

*   checking dependencies in R code ... NOTE
    ```
    Error in eval(`_inherit`, env, NULL) : object 'Stat' not found
    Error in prototype(data = data_frame(), extraInfo = data_frame(), anc_seq = ape::as.DNAbin(character(0)),  : 
      could not find function "prototype"
    ```

# grattan

<details>

* Version: 1.8.0.0
* Source code: https://github.com/cran/grattan
* URL: https://github.com/HughParsonage/grattan, https://hughparsonage.github.io/grattan/
* BugReports: https://github.com/HughParsonage/grattan/issues
* Date/Publication: 2019-11-15 18:50:09 UTC
* Number of recursive dependencies: 114

Run `revdep_details(,"grattan")` for more info

</details>

## In both

*   checking package dependencies ... NOTE
    ```
    Packages suggested but not available for checking:
      'taxstats', 'taxstats1516'
    ```

# GSODR

<details>

* Version: 2.0.0
* Source code: https://github.com/cran/GSODR
* URL: https://docs.ropensci.org/GSODR/
* BugReports: https://github.com/ropensci/GSODR/issues
* Date/Publication: 2019-09-04 20:50:10 UTC
* Number of recursive dependencies: 122

Run `revdep_details(,"GSODR")` for more info

</details>

## In both

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      ── 1. Failure: The 'max_missing' parameter filters out improper stations (@test-
      `get_GSOD(years = 1929, max_missing = 1)` threw an error with unexpected message.
      Expected match: "There were no stations that had a max of."
      Actual message: "attempt to set an attribute on NULL"
      Backtrace:
       1. testthat::expect_error(...)
       6. GSODR::get_GSOD(years = 1929, max_missing = 1)
       7. GSODR:::.validate_missing_days(max_missing, file_list)
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 31 | SKIPPED: 9 | WARNINGS: 0 | FAILED: 1 ]
      1. Failure: The 'max_missing' parameter filters out improper stations (@test-get_GSOD.R#128) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

# gWQS

<details>

* Version: 2.0.0
* Source code: https://github.com/cran/gWQS
* Date/Publication: 2019-08-27 12:40:02 UTC
* Number of recursive dependencies: 131

Run `revdep_details(,"gWQS")` for more info

</details>

## In both

*   checking whether the package can be unloaded cleanly ... WARNING
    ```
    Error in globalVariables(c(".", ".id", ".rownames", "ci.lower", "ci.upper",  : 
      could not find function "globalVariables"
    Error: package or namespace load failed for ‘gWQS’:
     unable to load R code in package ‘broom’
    Execution halted
    ```

*   checking whether the namespace can be loaded with stated dependencies ... WARNING
    ```
    Error in globalVariables(c(".", ".id", ".rownames", "ci.lower", "ci.upper",  : 
      could not find function "globalVariables"
    Error: unable to load R code in package ‘broom’
    Execution halted
    
    A namespace must be able to be loaded with just the base namespace
    loaded: otherwise if the namespace gets loaded by a saved object, the
    session will be unable to start.
    
    Probably some imports need to be declared in the NAMESPACE file.
    ```

*   checking dependencies in R code ... NOTE
    ```
    ...
    Call sequence:
    6: stop(msg, call. = FALSE, domain = NA)
    5: value[[3L]](cond)
    4: tryCatchOne(expr, names, parentenv, handlers[[1L]])
    3: tryCatchList(expr, classes, parentenv, handlers)
    2: tryCatch({
           attr(package, "LibPath") <- which.lib.loc
           ns <- loadNamespace(package, lib.loc)
           env <- attachNamespace(ns, pos = pos, deps, exclude, include.only)
       }, error = function(e) {
           P <- if (!is.null(cc <- conditionCall(e))) 
               paste(" in", deparse(cc)[1L])
           else ""
           msg <- gettextf("package or namespace load failed for %s%s:\n %s", 
               sQuote(package), P, conditionMessage(e))
           if (logical.return) 
               message(paste("Error:", msg), domain = NA)
           else stop(msg, call. = FALSE, domain = NA)
       })
    1: library(package, lib.loc = lib.loc, character.only = TRUE, verbose = FALSE)
    Execution halted
    ```

*   checking R code for possible problems ... NOTE
    ```
    Error in globalVariables(c(".", ".id", ".rownames", "ci.lower", "ci.upper",  : 
      could not find function "globalVariables"
    Error: unable to load R code in package ‘broom’
    Execution halted
    ```

# gWQSRS

<details>

* Version: 1.0.0
* Source code: https://github.com/cran/gWQSRS
* Date/Publication: 2019-08-30 09:00:09 UTC
* Number of recursive dependencies: 99

Run `revdep_details(,"gWQSRS")` for more info

</details>

## In both

*   checking whether the package can be unloaded cleanly ... WARNING
    ```
    Error in globalVariables(c(".", ".id", ".rownames", "ci.lower", "ci.upper",  : 
      could not find function "globalVariables"
    Error: package or namespace load failed for ‘gWQSRS’:
     unable to load R code in package ‘broom’
    Execution halted
    ```

*   checking whether the namespace can be loaded with stated dependencies ... WARNING
    ```
    Error in globalVariables(c(".", ".id", ".rownames", "ci.lower", "ci.upper",  : 
      could not find function "globalVariables"
    Error: unable to load R code in package ‘broom’
    Execution halted
    
    A namespace must be able to be loaded with just the base namespace
    loaded: otherwise if the namespace gets loaded by a saved object, the
    session will be unable to start.
    
    Probably some imports need to be declared in the NAMESPACE file.
    ```

*   checking dependencies in R code ... NOTE
    ```
    ...
    Call sequence:
    6: stop(msg, call. = FALSE, domain = NA)
    5: value[[3L]](cond)
    4: tryCatchOne(expr, names, parentenv, handlers[[1L]])
    3: tryCatchList(expr, classes, parentenv, handlers)
    2: tryCatch({
           attr(package, "LibPath") <- which.lib.loc
           ns <- loadNamespace(package, lib.loc)
           env <- attachNamespace(ns, pos = pos, deps, exclude, include.only)
       }, error = function(e) {
           P <- if (!is.null(cc <- conditionCall(e))) 
               paste(" in", deparse(cc)[1L])
           else ""
           msg <- gettextf("package or namespace load failed for %s%s:\n %s", 
               sQuote(package), P, conditionMessage(e))
           if (logical.return) 
               message(paste("Error:", msg), domain = NA)
           else stop(msg, call. = FALSE, domain = NA)
       })
    1: library(package, lib.loc = lib.loc, character.only = TRUE, verbose = FALSE)
    Execution halted
    ```

*   checking R code for possible problems ... NOTE
    ```
    Error in globalVariables(c(".", ".id", ".rownames", "ci.lower", "ci.upper",  : 
      could not find function "globalVariables"
    Error: unable to load R code in package ‘broom’
    Execution halted
    ```

# merTools

<details>

* Version: 0.5.0
* Source code: https://github.com/cran/merTools
* BugReports: https://www.github.com/jknowles/merTools
* Date/Publication: 2019-05-13 12:30:06 UTC
* Number of recursive dependencies: 129

Run `revdep_details(,"merTools")` for more info

</details>

## In both

*   checking whether the namespace can be loaded with stated dependencies ... WARNING
    ```
    Error in globalVariables(c(".", ".id", ".rownames", "ci.lower", "ci.upper",  : 
      could not find function "globalVariables"
    Error: unable to load R code in package ‘broom’
    Execution halted
    
    A namespace must be able to be loaded with just the base namespace
    loaded: otherwise if the namespace gets loaded by a saved object, the
    session will be unable to start.
    
    Probably some imports need to be declared in the NAMESPACE file.
    ```

*   checking R code for possible problems ... NOTE
    ```
    Error in globalVariables(c(".", ".id", ".rownames", "ci.lower", "ci.upper",  : 
      could not find function "globalVariables"
    Error: unable to load R code in package ‘broom’
    Execution halted
    ```

# phylolm

<details>

* Version: 2.6
* Source code: https://github.com/cran/phylolm
* URL: https://CRAN.R-project.org/package=phylolm
* Date/Publication: 2018-05-31 04:51:24 UTC
* Number of recursive dependencies: 31

Run `revdep_details(,"phylolm")` for more info

</details>

## In both

*   checking Rd cross-references ... NOTE
    ```
    Packages unavailable to check Rd xrefs: ‘surface’, ‘bayou’, ‘geiger’, ‘caper’
    ```

# QDNAseq

<details>

* Version: 1.22.0
* Source code: https://github.com/cran/QDNAseq
* URL: https://github.com/ccagc/QDNAseq
* BugReports: https://github.com/ccagc/QDNAseq/issues
* Date/Publication: 2019-10-29
* Number of recursive dependencies: 70

Run `revdep_details(,"QDNAseq")` for more info

</details>

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘future’
      All declared Imports should be used.
    ```

# qgcomp

<details>

* Version: 1.2.0
* Source code: https://github.com/cran/qgcomp
* Date/Publication: 2019-11-12 06:20:03 UTC
* Number of recursive dependencies: 61

Run `revdep_details(,"qgcomp")` for more info

</details>

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘parallel’
      All declared Imports should be used.
    ```

# robotstxt

<details>

* Version: 0.6.2
* Source code: https://github.com/cran/robotstxt
* URL: https://github.com/ropensci/robotstxt
* BugReports: https://github.com/ropensci/robotstxt/issues
* Date/Publication: 2018-07-18 21:30:03 UTC
* Number of recursive dependencies: 63

Run `revdep_details(,"robotstxt")` for more info

</details>

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘future’
      All declared Imports should be used.
    ```

# sctransform

<details>

* Version: 0.2.0
* Source code: https://github.com/cran/sctransform
* URL: https://github.com/ChristophH/sctransform
* BugReports: https://github.com/ChristophH/sctransform/issues
* Date/Publication: 2019-04-12 12:32:38 UTC
* Number of recursive dependencies: 59

Run `revdep_details(,"sctransform")` for more info

</details>

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘Rcpp’ ‘future’
      All declared Imports should be used.
    ```

# Seurat

<details>

* Version: 3.1.1
* Source code: https://github.com/cran/Seurat
* URL: http://www.satijalab.org/seurat, https://github.com/satijalab/seurat
* BugReports: https://github.com/satijalab/seurat/issues
* Date/Publication: 2019-10-03 12:40:02 UTC
* Number of recursive dependencies: 210

Run `revdep_details(,"Seurat")` for more info

</details>

## In both

*   checking package dependencies ... NOTE
    ```
    Package suggested but not available for checking: ‘loomR’
    ```

*   checking installed package size ... NOTE
    ```
      installed size is 10.5Mb
      sub-directories of 1Mb or more:
        libs   8.9Mb
    ```

*   checking dependencies in R code ... NOTE
    ```
    Error in globalVariables(c("et.ref", "et.comp")) : 
      could not find function "globalVariables"
    Error in classVersion("ExpressionSet") : 
      could not find function "classVersion"
    ```

*   checking Rd cross-references ... NOTE
    ```
    Package unavailable to check Rd xrefs: ‘loomR’
    ```

# simglm

<details>

* Version: 0.7.4
* Source code: https://github.com/cran/simglm
* Date/Publication: 2019-05-31 17:10:03 UTC
* Number of recursive dependencies: 90

Run `revdep_details(,"simglm")` for more info

</details>

## In both

*   checking whether the package can be unloaded cleanly ... WARNING
    ```
    Error in globalVariables(c(".", ".id", ".rownames", "ci.lower", "ci.upper",  : 
      could not find function "globalVariables"
    Error: package or namespace load failed for ‘simglm’:
     unable to load R code in package ‘broom’
    Execution halted
    ```

*   checking whether the namespace can be loaded with stated dependencies ... WARNING
    ```
    Error in globalVariables(c(".", ".id", ".rownames", "ci.lower", "ci.upper",  : 
      could not find function "globalVariables"
    Error: unable to load R code in package ‘broom’
    Execution halted
    
    A namespace must be able to be loaded with just the base namespace
    loaded: otherwise if the namespace gets loaded by a saved object, the
    session will be unable to start.
    
    Probably some imports need to be declared in the NAMESPACE file.
    ```

*   checking dependencies in R code ... NOTE
    ```
    ...
    Call sequence:
    6: stop(msg, call. = FALSE, domain = NA)
    5: value[[3L]](cond)
    4: tryCatchOne(expr, names, parentenv, handlers[[1L]])
    3: tryCatchList(expr, classes, parentenv, handlers)
    2: tryCatch({
           attr(package, "LibPath") <- which.lib.loc
           ns <- loadNamespace(package, lib.loc)
           env <- attachNamespace(ns, pos = pos, deps, exclude, include.only)
       }, error = function(e) {
           P <- if (!is.null(cc <- conditionCall(e))) 
               paste(" in", deparse(cc)[1L])
           else ""
           msg <- gettextf("package or namespace load failed for %s%s:\n %s", 
               sQuote(package), P, conditionMessage(e))
           if (logical.return) 
               message(paste("Error:", msg), domain = NA)
           else stop(msg, call. = FALSE, domain = NA)
       })
    1: library(package, lib.loc = lib.loc, character.only = TRUE, verbose = FALSE)
    Execution halted
    ```

*   checking R code for possible problems ... NOTE
    ```
    Error in globalVariables(c(".", ".id", ".rownames", "ci.lower", "ci.upper",  : 
      could not find function "globalVariables"
    Error: unable to load R code in package ‘broom’
    Execution halted
    ```

# solitude

<details>

* Version: 0.2.0
* Source code: https://github.com/cran/solitude
* URL: https://github.com/talegari/solitude
* BugReports: https://github.com/talegari/solitude/issues
* Date/Publication: 2019-08-24 20:00:02 UTC
* Number of recursive dependencies: 40

Run `revdep_details(,"solitude")` for more info

</details>

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘R6’
      All declared Imports should be used.
    ```

# stars

<details>

* Version: 0.4-0
* Source code: https://github.com/cran/stars
* URL: https://r-spatial.github.io/stars/, https://github.com/r-spatial/stars/
* BugReports: https://github.com/r-spatial/stars/issues/
* Date/Publication: 2019-10-10 13:00:02 UTC
* Number of recursive dependencies: 124

Run `revdep_details(,"stars")` for more info

</details>

## In both

*   checking package dependencies ... NOTE
    ```
    Package suggested but not available for checking: ‘starsdata’
    ```

*   checking installed package size ... NOTE
    ```
      installed size is 16.2Mb
      sub-directories of 1Mb or more:
        doc  10.3Mb
        nc    4.5Mb
    ```

# steps

<details>

* Version: 0.2.1
* Source code: https://github.com/cran/steps
* Date/Publication: 2019-04-02 11:30:03 UTC
* Number of recursive dependencies: 58

Run `revdep_details(,"steps")` for more info

</details>

## In both

*   checking dependencies in R code ... NOTE
    ```
    Error in globalVariables("ind") : 
      could not find function "globalVariables"
    ```

# TSstudio

<details>

* Version: 0.1.5
* Source code: https://github.com/cran/TSstudio
* URL: https://github.com/RamiKrispin/TSstudio
* BugReports: https://github.com/RamiKrispin/TSstudio/issues
* Date/Publication: 2019-10-28 19:40:09 UTC
* Number of recursive dependencies: 144

Run `revdep_details(,"TSstudio")` for more info

</details>

## In both

*   checking dependencies in R code ... NOTE
    ```
    Error in prepareTimeseries(y = y) : object 'AirPassengers' not found
    Error in globalVariables(c(".rows")) : 
      could not find function "globalVariables"
    ```

