# blavaan

<details>

* Version: 0.3-9
* Source code: https://github.com/cran/blavaan
* Date/Publication: 2020-03-09 17:20:02 UTC
* Number of recursive dependencies: 102

Run `revdep_details(,"blavaan")` for more info

</details>

## In both

*   checking installed package size ... NOTE
    ```
      installed size is  5.5Mb
      sub-directories of 1Mb or more:
        libs   4.7Mb
    ```

*   checking for GNU extensions in Makefiles ... NOTE
    ```
    GNU make is a SystemRequirements.
    ```

# blockCV

<details>

* Version: 2.1.1
* Source code: https://github.com/cran/blockCV
* URL: https://github.com/rvalavi/blockCV
* Date/Publication: 2020-02-23 20:00:02 UTC
* Number of recursive dependencies: 104

Run `revdep_details(,"blockCV")` for more info

</details>

## In both

*   checking Rd cross-references ... NOTE
    ```
    Package unavailable to check Rd xrefs: ‘biomod2’
    ```

# cSEM

<details>

* Version: 0.2.0
* Source code: https://github.com/cran/cSEM
* URL: https://github.com/M-E-Rademaker/cSEM, https://m-e-rademaker.github.io/cSEM/
* BugReports: https://github.com/M-E-Rademaker/cSEM/issues
* Date/Publication: 2020-03-29 11:00:20 UTC
* Number of recursive dependencies: 110

Run `revdep_details(,"cSEM")` for more info

</details>

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘Rdpack’
      All declared Imports should be used.
    ```

# fabletools

<details>

* Version: 0.1.3
* Source code: https://github.com/cran/fabletools
* URL: http://fabletools.tidyverts.org/, https://github.com/tidyverts/fabletools
* BugReports: https://github.com/tidyverts/fabletools/issues
* Date/Publication: 2020-03-24 07:10:02 UTC
* Number of recursive dependencies: 92

Run `revdep_details(,"fabletools")` for more info

</details>

## In both

*   checking S3 generic/method consistency ... WARNING
    ```
    Failed to query server: Connection timed out
    See section ‘Generic functions and methods’ in the ‘Writing R
    Extensions’ manual.
    ```

*   checking replacement functions ... WARNING
    ```
    Failed to query server: Connection timed out
    The argument of a replacement function which corresponds to the right
    hand side must be named ‘value’.
    ```

*   checking Rd files ... WARNING
    ```
    Failed to query server: Connection timed out
    prepare_Rd: running command 'timedatectl' had status 1
    ```

*   checking for missing documentation entries ... WARNING
    ```
    Failed to query server: Connection timed out
    All user-level objects in a package should have documentation entries.
    See chapter ‘Writing R documentation files’ in the ‘Writing R
    Extensions’ manual.
    ```

*   checking for code/documentation mismatches ... WARNING
    ```
    Failed to query server: Connection timed out
    Failed to query server: Connection timed out
    Failed to query server: Connection timed out
    ```

*   checking for unstated dependencies in examples ... WARNING
    ```
    Failed to query server: Connection timed out
    Warning in system("timedatectl", intern = TRUE) :
      running command 'timedatectl' had status 1
    ```

*   checking package dependencies ... NOTE
    ```
    Package suggested but not available for checking: ‘feasts’
    ```

*   checking dependencies in R code ... NOTE
    ```
    Failed to query server: Connection timed out
    ```

*   checking foreign function calls ... NOTE
    ```
    Failed to query server: Connection timed out
    See chapter ‘System and foreign language interfaces’ in the ‘Writing R
    Extensions’ manual.
    ```

*   checking R code for possible problems ... NOTE
    ```
    Failed to query server: Connection timed out
    ```

*   checking Rd \usage sections ... NOTE
    ```
    Failed to query server: Connection timed out
    The \usage entries for S3 methods should use the \method markup and not
    their full name.
    See chapter ‘Writing R documentation files’ in the ‘Writing R
    Extensions’ manual.
    ```

# forecastML

<details>

* Version: 0.8.0
* Source code: https://github.com/cran/forecastML
* URL: https://github.com/nredell/forecastML/
* Date/Publication: 2020-02-28 22:40:12 UTC
* Number of recursive dependencies: 93

Run `revdep_details(,"forecastML")` for more info

</details>

## In both

*   checking package dependencies ... NOTE
    ```
    Package suggested but not available for checking: ‘xgboost’
    ```

# grattan

<details>

* Version: 1.8.0.1
* Source code: https://github.com/cran/grattan
* URL: https://github.com/HughParsonage/grattan, https://hughparsonage.github.io/grattan/
* BugReports: https://github.com/HughParsonage/grattan/issues
* Date/Publication: 2020-03-16 16:40:09 UTC
* Number of recursive dependencies: 113

Run `revdep_details(,"grattan")` for more info

</details>

## In both

*   checking package dependencies ... NOTE
    ```
    Packages suggested but not available for checking:
      'taxstats', 'taxstats1516'
    ```

# gstat

<details>

* Version: 2.0-5
* Source code: https://github.com/cran/gstat
* URL: https://github.com/r-spatial/gstat/
* BugReports: https://github.com/r-spatial/gstat/issues/
* Date/Publication: 2020-04-04 14:20:02 UTC
* Number of recursive dependencies: 37

Run `revdep_details(,"gstat")` for more info

</details>

## In both

*   checking tests ...
    ```
    ...
      
      > meuse.riv <- SpatialPolygons(list(Polygons(list(Polygon(meuse.riv)),"meuse.riv")))
      
      > proj4string(meuse.riv) <- crs
      
      > data("meuse.area")
      
      > meuse.area = SpatialPolygons(list(Polygons(list(Polygon(meuse.area)), "area")))
      
      > proj4string(meuse.area) <- crs
      > 
      > v = variogram(log(zinc)~1, meuse_sf)
      > (v.fit = fit.variogram(v, vgm(1, "Sph", 900, 1)))
        model      psill    range
      1   Nug 0.05066243   0.0000
      2   Sph 0.59060780 897.0209
      > k_sf = krige(log(zinc)~1, meuse_sf[-(1:5),], meuse_sf[1:5,], v.fit)
      Error in .local(formula, locations, ...) : 
        stars required: install that first
      Calls: krige -> krige -> .local
      Execution halted
    ```

# gWQS

<details>

* Version: 2.0.1
* Source code: https://github.com/cran/gWQS
* Date/Publication: 2020-03-03 12:20:02 UTC
* Number of recursive dependencies: 160

Run `revdep_details(,"gWQS")` for more info

</details>

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘dplyr’
      All declared Imports should be used.
    ```

# gWQSRS

<details>

* Version: 1.1.1
* Source code: https://github.com/cran/gWQSRS
* Date/Publication: 2020-03-03 11:40:02 UTC
* Number of recursive dependencies: 112

Run `revdep_details(,"gWQSRS")` for more info

</details>

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘broom’ ‘dplyr’ ‘ggrepel’ ‘kableExtra’ ‘knitr’ ‘nnet’ ‘plotROC’
      All declared Imports should be used.
    ```

# iml

<details>

* Version: 0.10.0
* Source code: https://github.com/cran/iml
* URL: https://github.com/christophM/iml
* BugReports: https://github.com/christophM/iml/issues
* Date/Publication: 2020-03-26 10:20:03 UTC
* Number of recursive dependencies: 155

Run `revdep_details(,"iml")` for more info

</details>

## In both

*   checking dependencies in R code ... NOTE
    ```
    Performing one-time download of h2o.jar from
         http://s3.amazonaws.com/h2o-release/h2o/rel-zahradnik/1/Rjar/h2o.jar 
    (This could take a few minutes, please be patient...)
    Namespace in Imports field not imported from: ‘future’
      All declared Imports should be used.
    ```

# inlinedocs

<details>

* Version: 2019.12.5
* Source code: https://github.com/cran/inlinedocs
* URL: http://github.com/tdhock/inlinedocs
* BugReports: http://github.com/tdhock/inlinedocs/issues
* Date/Publication: 2019-12-05 23:30:07 UTC
* Number of recursive dependencies: 6

Run `revdep_details(,"inlinedocs")` for more info

</details>

## In both

*   checking Rd cross-references ... NOTE
    ```
    Unknown package ‘R.methodsS3’ in Rd xrefs
    ```

# mcp

<details>

* Version: 0.2.0
* Source code: https://github.com/cran/mcp
* URL: http://lindeloev.github.io/mcp/, https://github.com/lindeloev/mcp
* BugReports: https://github.com/lindeloev/mcp/issues
* Date/Publication: 2020-01-09 16:30:02 UTC
* Number of recursive dependencies: 94

Run `revdep_details(,"mcp")` for more info

</details>

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘bayesplot’ ‘methods’ ‘purrr’
      All declared Imports should be used.
    ```

# merTools

<details>

* Version: 0.5.0
* Source code: https://github.com/cran/merTools
* BugReports: https://www.github.com/jknowles/merTools
* Date/Publication: 2019-05-13 12:30:06 UTC
* Number of recursive dependencies: 131

Run `revdep_details(,"merTools")` for more info

</details>

## In both

*   checking whether the namespace can be loaded with stated dependencies ... WARNING
    ```
    Error in setClass("balance", representation(rawdata = "data.frame", matched = "data.frame",  : 
      could not find function "setClass"
    Error: unable to load R code in package ‘arm’
    Execution halted
    
    A namespace must be able to be loaded with just the base namespace
    loaded: otherwise if the namespace gets loaded by a saved object, the
    session will be unable to start.
    
    Probably some imports need to be declared in the NAMESPACE file.
    ```

*   checking R code for possible problems ... NOTE
    ```
    Error in setClass("balance", representation(rawdata = "data.frame", matched = "data.frame",  : 
      could not find function "setClass"
    Error: unable to load R code in package ‘arm’
    Execution halted
    ```

# origami

<details>

* Version: 1.0.3
* Source code: https://github.com/cran/origami
* URL: https://tlverse.org/origami
* BugReports: https://github.com/tlverse/origami/issues
* Date/Publication: 2020-01-16 22:40:02 UTC
* Number of recursive dependencies: 82

Run `revdep_details(,"origami")` for more info

</details>

## In both

*   checking Rd cross-references ... NOTE
    ```
    Unknown package ‘glmnet’ in Rd xrefs
    ```

# phylolm

<details>

* Version: 2.6
* Source code: https://github.com/cran/phylolm
* URL: https://CRAN.R-project.org/package=phylolm
* Date/Publication: 2018-05-31 04:51:24 UTC
* Number of recursive dependencies: 33

Run `revdep_details(,"phylolm")` for more info

</details>

## In both

*   checking Rd cross-references ... NOTE
    ```
    Unknown packages ‘surface’, ‘bayou’, ‘geiger’, ‘caper’ in Rd xrefs
    ```

# prewas

<details>

* Version: 1.1.0
* Source code: https://github.com/cran/prewas
* URL: http://github.com/Snitkin-Lab-Umich/prewas
* BugReports: http://github.com/Snitkin-Lab-Umich/prewas/issues
* Date/Publication: 2020-03-21 17:10:06 UTC
* Number of recursive dependencies: 71

Run `revdep_details(,"prewas")` for more info

</details>

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘stats’
      All declared Imports should be used.
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

* Version: 2.3.0
* Source code: https://github.com/cran/qgcomp
* Date/Publication: 2020-04-08 05:50:02 UTC
* Number of recursive dependencies: 116

Run `revdep_details(,"qgcomp")` for more info

</details>

## In both

*   checking for missing documentation entries ... ERROR
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

*   checking whether the package can be unloaded cleanly ... WARNING
    ```
    Error in setClass("balance", representation(rawdata = "data.frame", matched = "data.frame",  : 
      could not find function "setClass"
    Error: package or namespace load failed for ‘qgcomp’:
     unable to load R code in package ‘arm’
    Execution halted
    ```

*   checking whether the namespace can be loaded with stated dependencies ... WARNING
    ```
    Error in setClass("balance", representation(rawdata = "data.frame", matched = "data.frame",  : 
      could not find function "setClass"
    Error: unable to load R code in package ‘arm’
    Execution halted
    
    A namespace must be able to be loaded with just the base namespace
    loaded: otherwise if the namespace gets loaded by a saved object, the
    session will be unable to start.
    
    Probably some imports need to be declared in the NAMESPACE file.
    ```

*   checking S3 generic/method consistency ... WARNING
    ```
    ...
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
    See section ‘Generic functions and methods’ in the ‘Writing R
    Extensions’ manual.
    ```

*   checking replacement functions ... WARNING
    ```
    ...
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
    The argument of a replacement function which corresponds to the right
    hand side must be named ‘value’.
    ```

*   checking for code/documentation mismatches ... WARNING
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

*   checking foreign function calls ... NOTE
    ```
    ...
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
    See chapter ‘System and foreign language interfaces’ in the ‘Writing R
    Extensions’ manual.
    ```

*   checking R code for possible problems ... NOTE
    ```
    Error in setClass("balance", representation(rawdata = "data.frame", matched = "data.frame",  : 
      could not find function "setClass"
    Error: unable to load R code in package ‘arm’
    Execution halted
    ```

*   checking Rd \usage sections ... NOTE
    ```
    ...
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
    The \usage entries for S3 methods should use the \method markup and not
    their full name.
    See chapter ‘Writing R documentation files’ in the ‘Writing R
    Extensions’ manual.
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

# Seurat

<details>

* Version: 3.1.5
* Source code: https://github.com/cran/Seurat
* URL: http://www.satijalab.org/seurat, https://github.com/satijalab/seurat
* BugReports: https://github.com/satijalab/seurat/issues
* Date/Publication: 2020-04-16 11:50:08 UTC
* Number of recursive dependencies: 219

Run `revdep_details(,"Seurat")` for more info

</details>

## In both

*   checking package dependencies ... NOTE
    ```
    Packages suggested but not available for checking: 'loomR', 'SDMTools'
    ```

*   checking Rd cross-references ... NOTE
    ```
    Unknown packages ‘SDMTools’, ‘loomR’ in Rd xrefs
    ```

# solitude

<details>

* Version: 0.2.1
* Source code: https://github.com/cran/solitude
* URL: https://github.com/talegari/solitude
* BugReports: https://github.com/talegari/solitude/issues
* Date/Publication: 2019-12-07 09:00:02 UTC
* Number of recursive dependencies: 38

Run `revdep_details(,"solitude")` for more info

</details>

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘R6’
      All declared Imports should be used.
    ```

# sperrorest

<details>

* Version: 3.0.0
* Source code: https://github.com/cran/sperrorest
* URL: https://giscience-fsu.github.io/sperrorest, https://github.com/giscience-fsu/sperrorest
* BugReports: https://github.com/giscience-fsu/sperrorest/issues
* Date/Publication: 2020-04-13 08:10:02 UTC
* Number of recursive dependencies: 57

Run `revdep_details(,"sperrorest")` for more info

</details>

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘future’
      All declared Imports should be used.
    ```

# stars

<details>

* Version: 0.4-1
* Source code: https://github.com/cran/stars
* URL: https://r-spatial.github.io/stars/, https://github.com/r-spatial/stars/
* BugReports: https://github.com/r-spatial/stars/issues/
* Date/Publication: 2020-04-07 10:00:02 UTC
* Number of recursive dependencies: 127

Run `revdep_details(,"stars")` for more info

</details>

## In both

*   checking package dependencies ... ERROR
    ```
    Package required but not available: ‘lwgeom’
    
    Package suggested but not available for checking: ‘starsdata’
    
    See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
    manual.
    ```

# TSstudio

<details>

* Version: 0.1.6
* Source code: https://github.com/cran/TSstudio
* URL: https://github.com/RamiKrispin/TSstudio
* BugReports: https://github.com/RamiKrispin/TSstudio/issues
* Date/Publication: 2020-01-21 05:30:02 UTC
* Number of recursive dependencies: 136

Run `revdep_details(,"TSstudio")` for more info

</details>

## In both

*   checking dependencies in R code ... NOTE
    ```
    Failed to query server: Connection timed out
    Namespace in Imports field not imported from: ‘forecastHybrid’
      All declared Imports should be used.
    ```

