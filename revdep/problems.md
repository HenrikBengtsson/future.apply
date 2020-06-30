# BAMBI

<details>

* Version: 2.3.0
* Source code: https://github.com/cran/BAMBI
* URL: https://arxiv.org/abs/1708.07804
* BugReports: https://github.com/c7rishi/BAMBI/issues
* Date/Publication: 2020-06-19 13:50:07 UTC
* Number of recursive dependencies: 48

Run `revdep_details(,"BAMBI")` for more info

</details>

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘stats4’
      All declared Imports should be used.
    ```

# bcmaps

<details>

* Version: 0.18.1
* Source code: https://github.com/cran/bcmaps
* URL: https://github.com/bcgov/bcmaps
* BugReports: https://github.com/bcgov/bcmaps/issues
* Date/Publication: 2020-04-29 10:30:10 UTC
* Number of recursive dependencies: 83

Run `revdep_details(,"bcmaps")` for more info

</details>

## In both

*   checking tests ...
    ```
    ...
      sf built with old GEOS, lwgeom package required.
      Backtrace:
       1. testthat::expect_message(...)
       7. bcmaps:::fix_geo_problems.sf(st_as_sf(p4))
       8. bcmaps:::make_valid(obj)
      
      Failed with error:  'there is no package called 'lwgeom''
      ── 2. Error: works with other problems: sf (@test-fix_geo_problems.R#106)  ─────
      sf built with old GEOS, lwgeom package required.
      Backtrace:
       1. testthat::expect_message(...)
       7. bcmaps:::fix_geo_problems.sf(st_as_sf(p7))
       8. bcmaps:::make_valid(obj)
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 71 | SKIPPED: 11 | WARNINGS: 0 | FAILED: 2 ]
      1. Error: works with self-intersections: sf (@test-fix_geo_problems.R#94) 
      2. Error: works with other problems: sf (@test-fix_geo_problems.R#106) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

*   checking package dependencies ... NOTE
    ```
    Packages suggested but not available for checking:
      'bcmapsdata', 'rgdal', 'lwgeom'
    ```

# blavaan

<details>

* Version: 0.3-9
* Source code: https://github.com/cran/blavaan
* Date/Publication: 2020-03-09 17:20:02 UTC
* Number of recursive dependencies: 104

Run `revdep_details(,"blavaan")` for more info

</details>

## In both

*   checking installed package size ... NOTE
    ```
      installed size is  5.8Mb
      sub-directories of 1Mb or more:
        libs   4.9Mb
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
* Number of recursive dependencies: 105

Run `revdep_details(,"blockCV")` for more info

</details>

## In both

*   checking tests ...
    ```
    ...
       12. layout$setup_panel_params()
       13. ggplot2:::f(..., self = self)
       14. base::Map(setup_panel_params, scales_x, scales_y)
       15. base::mapply(FUN = f, ..., SIMPLIFY = FALSE)
       17. self$coord$setup_panel_params(scale_x, scale_y, params = self$coord_params)
       18. ggplot2:::f(..., self = self)
       19. sf::st_graticule(...)
       21. sf:::st_transform.sfc(box, datum, partial = TRUE)
       23. sf:::CPL_transform(x, crs, aoi, pipeline, reverse)
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 127 | SKIPPED: 8 | WARNINGS: 7 | FAILED: 6 ]
      1. Error: test spatialAutoRange function with multi-layer raster in parallel (@testSpatialAutoRange.R#19) 
      2. Error: test spatialAutoRange for low-resolution rasters (@testSpatialAutoRange.R#71) 
      3. Error: test spatiaBlock function with systematic assingment and no raster file (@testSpatialBlock.R#65) 
      4. Error: test spatiaBlock function with non-numeric iteration (@testSpatialBlock.R#98) 
      5. Error: test spatiaBlock with checkerboard assingment and only row blocks (@testSpatialBlock.R#132) 
      6. Error: test spatialBlock with no speceis column match (@testSpatialBlock.R#269) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

*   checking Rd cross-references ... NOTE
    ```
    Unknown package ‘biomod2’ in Rd xrefs
    ```

# cSEM

<details>

* Version: 0.2.0
* Source code: https://github.com/cran/cSEM
* URL: https://github.com/M-E-Rademaker/cSEM, https://m-e-rademaker.github.io/cSEM/
* BugReports: https://github.com/M-E-Rademaker/cSEM/issues
* Date/Publication: 2020-03-29 11:00:20 UTC
* Number of recursive dependencies: 112

Run `revdep_details(,"cSEM")` for more info

</details>

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘Rdpack’
      All declared Imports should be used.
    ```

# dipsaus

<details>

* Version: 0.0.8
* Source code: https://github.com/cran/dipsaus
* URL: https://github.com/dipterix/dipsaus
* BugReports: https://github.com/dipterix/dipsaus/issues
* Date/Publication: 2020-06-23 05:30:17 UTC
* Number of recursive dependencies: 65

Run `revdep_details(,"dipsaus")` for more info

</details>

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘yaml’
      All declared Imports should be used.
    ```

# fabletools

<details>

* Version: 0.2.0
* Source code: https://github.com/cran/fabletools
* URL: http://fabletools.tidyverts.org/, https://github.com/tidyverts/fabletools
* BugReports: https://github.com/tidyverts/fabletools/issues
* Date/Publication: 2020-06-15 23:40:08 UTC
* Number of recursive dependencies: 94

Run `revdep_details(,"fabletools")` for more info

</details>

## In both

*   checking examples ... ERROR
    ```
    ...
     1 Adelaide       South Australia    Business 156.   35.6 
     2 Adelaide       South Australia    Holiday  157.   27.1 
     3 Adelaide       South Australia    Other     56.6  17.3 
     4 Adelaide       South Australia    Visiting 205.   32.5 
     5 Adelaide Hills South Australia    Business   2.66  4.30
     6 Adelaide Hills South Australia    Holiday   10.5   6.37
     7 Adelaide Hills South Australia    Other      1.40  1.65
     8 Adelaide Hills South Australia    Visiting  14.2  10.7 
     9 Alice Springs  Northern Territory Business  14.6   7.20
    10 Alice Springs  Northern Territory Holiday   31.9  18.1 
    # … with 294 more rows
    > 
    > # Search and use useful features with `feature_set()`. 
    > if(requireNamespace("feasts")) library(feasts)
    Loading required namespace: feasts
    Failed with error:  ‘there is no package called ‘feasts’’
    > tourism %>% 
    +   features(Trips, features = feature_set(tags = "autocorrelation"))
    Error in .l[[1]] : subscript out of bounds
    Calls: %>% ... features.tbl_ts -> features_impl -> map -> lapply -> FUN -> transpose
    Execution halted
    ```

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
    Namespace in Imports field not imported from: ‘lifecycle’
      All declared Imports should be used.
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

* Version: 0.9.0
* Source code: https://github.com/cran/forecastML
* URL: https://github.com/nredell/forecastML/
* Date/Publication: 2020-05-07 15:10:17 UTC
* Number of recursive dependencies: 93

Run `revdep_details(,"forecastML")` for more info

</details>

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘dtplyr’
      All declared Imports should be used.
    ```

# grattan

<details>

* Version: 1.8.0.1
* Source code: https://github.com/cran/grattan
* URL: https://github.com/HughParsonage/grattan, https://hughparsonage.github.io/grattan/
* BugReports: https://github.com/HughParsonage/grattan/issues
* Date/Publication: 2020-03-16 16:40:09 UTC
* Number of recursive dependencies: 112

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

* Version: 2.1.1
* Source code: https://github.com/cran/GSODR
* URL: https://docs.ropensci.org/GSODR/
* BugReports: https://github.com/ropensci/GSODR/issues
* Date/Publication: 2020-06-13 04:10:03 UTC
* Number of recursive dependencies: 87

Run `revdep_details(,"GSODR")` for more info

</details>

## In both

*   checking tests ...
    ```
    ...
       11. value[[3L]](cond)
      
      ── 2. Error: when year is selected for a station not providing it, error (@test-
      
      The file downloads have failed. Please restart.
      Backtrace:
        1. testthat::expect_message(...)
        6. GSODR::get_GSOD(years = 1950, station = "959360-99999")
        7. GSODR:::.download_files(station, years)
        8. base::tryCatch(...)
        9. base:::tryCatchList(expr, classes, parentenv, handlers)
       10. base:::tryCatchOne(expr, names, parentenv, handlers[[1L]])
       11. value[[3L]](cond)
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 31 | SKIPPED: 9 | WARNINGS: 0 | FAILED: 2 ]
      1. Failure: The 'max_missing' parameter filters out improper stations (@test-get_GSOD.R#126) 
      2. Error: when year is selected for a station not providing it, error (@test-get_GSOD.R#244) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

# gstat

<details>

* Version: 2.0-6
* Source code: https://github.com/cran/gstat
* URL: https://github.com/r-spatial/gstat/
* BugReports: https://github.com/r-spatial/gstat/issues/
* Date/Publication: 2020-05-18 12:30:02 UTC
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

*   checking package dependencies ... NOTE
    ```
    Package suggested but not available for checking: ‘rgdal’
    ```

# gWQS

<details>

* Version: 3.0.0
* Source code: https://github.com/cran/gWQS
* Date/Publication: 2020-06-23 13:00:03 UTC
* Number of recursive dependencies: 103

Run `revdep_details(,"gWQS")` for more info

</details>

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘dplyr’
      All declared Imports should be used.
    ```

# hackeRnews

<details>

* Version: 0.1.0
* Source code: https://github.com/cran/hackeRnews
* URL: https://github.com/szymanskir/hackeRnews
* BugReports: https://github.com/szymanskir/hackeRnews/issues
* Date/Publication: 2019-12-13 13:20:05 UTC
* Number of recursive dependencies: 62

Run `revdep_details(,"hackeRnews")` for more info

</details>

## In both

*   checking examples ... ERROR
    ```
    Running examples in ‘hackeRnews-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: get_best_stories
    > ### Title: Hacker News best stories
    > ### Aliases: get_best_stories
    > 
    > ### ** Examples
    > 
    > # get the best story on Hacker News
    > best_story <- get_best_stories(max_items = 1)
    Error in curl::curl_fetch_memory(url, handle = handle) : 
      Could not resolve host: hacker-news.firebaseio.com; Name or service not known
    Calls: get_best_stories ... request_fetch -> request_fetch.write_memory -> <Anonymous>
    Execution halted
    ```

# iml

<details>

* Version: 0.10.0
* Source code: https://github.com/cran/iml
* URL: https://github.com/christophM/iml
* BugReports: https://github.com/christophM/iml/issues
* Date/Publication: 2020-03-26 10:20:03 UTC
* Number of recursive dependencies: 153

Run `revdep_details(,"iml")` for more info

</details>

## In both

*   checking dependencies in R code ... NOTE
    ```
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

# lgr

<details>

* Version: 0.3.4
* Source code: https://github.com/cran/lgr
* URL: https://s-fleck.github.io/lgr
* BugReports: https://github.com/s-fleck/lgr/issues
* Date/Publication: 2020-03-20 11:50:02 UTC
* Number of recursive dependencies: 79

Run `revdep_details(,"lgr")` for more info

</details>

## In both

*   checking package dependencies ... NOTE
    ```
    Packages suggested but not available for checking: 'RMariaDB', 'RPostgres'
    ```

# MineICA

<details>

* Version: 1.28.0
* Source code: https://github.com/cran/MineICA
* Date/Publication: 2020-04-27
* Number of recursive dependencies: 202

Run `revdep_details(,"MineICA")` for more info

</details>

## In both

*   checking examples ... ERROR
    ```
    ...
    > ###   witGenes<-,IcaSet,character-method refSamples refSamples<-
    > ###   refSamples,IcaSet-method setRefSamples,IcaSet-method
    > ###   getRefSamples,IcaSet-method refSamples<-,IcaSet-method
    > ###   refSamples<-,IcaSet,character-method typeID typeID<-
    > ###   typeID,IcaSet-method typeID<-,IcaSet-method setTypeID,IcaSet-method
    > ###   getTypeID,IcaSet-method typeID<-,IcaSet,list-method chipManu
    > ###   chipManu<- chipManu<-,IcaSet-method
    > ###   chipManu<-,IcaSet,character-method chipManu,IcaSet-method
    > ###   setChipManu,IcaSet-method getChipManu,IcaSet-method
    > ###   Slist,IcaSet-method SlistByGene,IcaSet-method Alist,IcaSet-method
    > ### Keywords: classes
    > 
    > ### ** Examples
    > 
    > # create an instance of IcaSet
    > new("IcaSet")
    Ensembl site unresponsive, trying uswest mirror
    Error in curl::curl_fetch_memory(url, handle = handle) : 
      Could not resolve host: uswest.ensembl.org; Name or service not known
    Calls: new ... request_fetch -> request_fetch.write_memory -> <Anonymous>
    Execution halted
    ```

*   checking running R code from vignettes ...
    ```
      ‘MineICA.Rnw’... failed
     ERROR
    Errors in running code in vignettes:
    when running code in ‘MineICA.Rnw’
      ...
    [28] "hgu133aPROSITE"       "hgu133aREFSEQ"        "hgu133aSYMBOL"       
    [31] "hgu133aUNIGENE"       "hgu133aUNIPROT"       "hgu133a_dbInfo"      
    [34] "hgu133a_dbconn"       "hgu133a_dbfile"       "hgu133a_dbschema"    
    
    > mart <- useMart(biomart = "ensembl", dataset = "hsapiens_gene_ensembl")
    Ensembl site unresponsive, trying uswest mirror
    
      When sourcing ‘MineICA.R’:
    Error: Could not resolve host: uswest.ensembl.org; Name or service not known
    Execution halted
    ```

*   checking whether the namespace can be loaded with stated dependencies ... WARNING
    ```
    ...
      could not find function "setClass"
    Warning: namespace ‘genefilter’ is not available and has been replaced
    by .GlobalEnv when processing object ‘<unknown>’
    Error in setMethod("orgPackageName", "character", function(x) { : 
      could not find function "setMethod"
    Warning: namespace ‘GSEABase’ is not available and has been replaced
    by .GlobalEnv when processing object ‘<unknown>’
    Error in setMethod("orgPackageName", "character", function(x) { : 
      could not find function "setMethod"
    Warning: namespace ‘Category’ is not available and has been replaced
    by .GlobalEnv when processing object ‘<unknown>’
    Error in setClass("rowROC", representation(data = "matrix", ranks = "matrix",  : 
      could not find function "setClass"
    Warning: namespace ‘genefilter’ is not available and has been replaced
    by .GlobalEnv when processing object ‘<unknown>’
    
    A namespace must be able to be loaded with just the base namespace
    loaded: otherwise if the namespace gets loaded by a saved object, the
    session will be unable to start.
    
    Probably some imports need to be declared in the NAMESPACE file.
    ```

*   checking Rd cross-references ... WARNING
    ```
    Missing link or links in documentation object 'Alist.Rd':
      ‘class-IcaSet’
    
    Missing link or links in documentation object 'Slist.Rd':
      ‘class-IcaSet’
    
    Missing link or links in documentation object 'class-IcaSet.Rd':
      ‘class-IcaSet’
    
    Missing link or links in documentation object 'getComp.Rd':
      ‘class-IcaSet’
    
    Missing link or links in documentation object 'runAn.Rd':
      ‘[Category:class-GOHyperGParams]{GOHyperGParams}’
    
    See section 'Cross-references' in the 'Writing R Extensions' manual.
    ```

*   checking for missing documentation entries ... WARNING
    ```
    Undocumented S4 classes:
      ‘MineICAParams’
    All user-level objects in a package (including S4 classes and methods)
    should have documentation entries.
    See chapter ‘Writing R documentation files’ in the ‘Writing R
    Extensions’ manual.
    ```

*   checking package dependencies ... NOTE
    ```
    Package which this enhances but not available for checking: ‘doMC’
    
    Depends: includes the non-default packages:
      'BiocGenerics', 'Biobase', 'plyr', 'ggplot2', 'scales', 'foreach',
      'xtable', 'biomaRt', 'gtools', 'GOstats', 'cluster', 'marray',
      'mclust', 'RColorBrewer', 'colorspace', 'igraph', 'Rgraphviz',
      'graph', 'annotate', 'Hmisc', 'fastICA', 'JADE'
    Adding so many packages to the search path is excessive and importing
    selectively is preferable.
    ```

*   checking DESCRIPTION meta-information ... NOTE
    ```
    Packages listed in more than one of Depends, Imports, Suggests, Enhances:
      ‘biomaRt’ ‘GOstats’ ‘cluster’ ‘mclust’ ‘igraph’
    A package should be listed in only one of these fields.
    ```

*   checking dependencies in R code ... NOTE
    ```
    'library' or 'require' call to ‘GOstats’ which was already attached by Depends.
      Please remove these calls from your code.
    Namespace in Imports field not imported from: ‘lumiHumanAll.db’
      All declared Imports should be used.
    Packages in Depends field not imported from:
      ‘GOstats’ ‘Hmisc’ ‘JADE’ ‘RColorBrewer’ ‘Rgraphviz’ ‘annotate’
      ‘biomaRt’ ‘cluster’ ‘colorspace’ ‘fastICA’ ‘foreach’ ‘ggplot2’
      ‘graph’ ‘gtools’ ‘igraph’ ‘marray’ ‘mclust’ ‘methods’ ‘plyr’ ‘scales’
      ‘xtable’
      These packages need to be imported from (in the NAMESPACE file)
      for when this namespace is loaded but not attached.
    ':::' calls which should be '::':
      ‘Biobase:::annotation<-’ ‘Biobase:::validMsg’ ‘fpc:::pamk’
      ‘lumi:::getChipInfo’ ‘mclust:::adjustedRandIndex’
      See the note in ?`:::` about the use of this operator.
    Unexported object imported by a ':::' call: ‘Biobase:::isValidVersion’
      See the note in ?`:::` about the use of this operator.
    ```

*   checking R code for possible problems ... NOTE
    ```
    ...
      position_jitter pushViewport quantile rainbow_hcl rcorr read.table
      reorder scale_colour_gradientn scale_colour_manual scale_fill_manual
      scale_linetype_manual scale_shape_manual scale_x_continuous
      scale_x_discrete scale_y_continuous shapiro.test sigCategories
      terrain_hcl theme theme_bw title tkplot.fit.to.screen unit useMart
      validObject vcount viewport wilcox.test write.table xlab xtable
    Consider adding
      importFrom("grDevices", "cm.colors", "dev.off", "graphics.off",
                 "heat.colors", "pdf")
      importFrom("graphics", "abline", "axis", "frame", "hist", "layout",
                 "legend", "mtext", "par", "plot.new", "points", "title")
      importFrom("methods", "callNextMethod", "new", "validObject")
      importFrom("stats", "aggregate", "as.dendrogram", "as.dist",
                 "as.hclust", "chisq.test", "cor", "cor.test", "cutree",
                 "dist", "hclust", "kmeans", "kruskal.test", "lm", "median",
                 "na.omit", "order.dendrogram", "p.adjust", "quantile",
                 "reorder", "shapiro.test", "wilcox.test")
      importFrom("utils", "capture.output", "combn", "read.table",
                 "write.table")
    to your NAMESPACE file (and ensure that your DESCRIPTION Imports field
    contains 'methods').
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

* Version: 2.6.2
* Source code: https://github.com/cran/phylolm
* URL: https://github.com/lamho86/phylolm
* BugReports: https://github.com/lamho86/phylolm/issues
* Date/Publication: 2020-06-22 05:10:08 UTC
* Number of recursive dependencies: 33

Run `revdep_details(,"phylolm")` for more info

</details>

## In both

*   checking Rd cross-references ... NOTE
    ```
    Unknown packages ‘geiger’, ‘caper’ in Rd xrefs
    ```

# prewas

<details>

* Version: 1.1.0
* Source code: https://github.com/cran/prewas
* URL: http://github.com/Snitkin-Lab-Umich/prewas
* BugReports: http://github.com/Snitkin-Lab-Umich/prewas/issues
* Date/Publication: 2020-03-21 17:10:06 UTC
* Number of recursive dependencies: 70

Run `revdep_details(,"prewas")` for more info

</details>

## In both

*   checking package dependencies ... ERROR
    ```
    Package required but not available: ‘vcfR’
    
    See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
    manual.
    ```

# QDNAseq

<details>

* Version: 1.24.0
* Source code: https://github.com/cran/QDNAseq
* URL: https://github.com/ccagc/QDNAseq
* BugReports: https://github.com/ccagc/QDNAseq/issues
* Date/Publication: 2020-04-27
* Number of recursive dependencies: 70

Run `revdep_details(,"QDNAseq")` for more info

</details>

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘future’
      All declared Imports should be used.
    ```

# rangeMapper

<details>

* Version: 0.3-7
* Source code: https://github.com/cran/rangeMapper
* URL: https://github.com/valcu/rangeMapper
* Date/Publication: 2019-10-25 18:20:02 UTC
* Number of recursive dependencies: 96

Run `revdep_details(,"rangeMapper")` for more info

</details>

## In both

*   checking package dependencies ... ERROR
    ```
    Package required but not available: ‘rgdal’
    
    See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
    manual.
    ```

# robotstxt

<details>

* Version: 0.7.7
* Source code: https://github.com/cran/robotstxt
* URL: https://docs.ropensci.org/robotstxt, https://github.com/ropensci/robotstxt
* BugReports: https://github.com/ropensci/robotstxt/issues
* Date/Publication: 2020-06-27 07:00:02 UTC
* Number of recursive dependencies: 62

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
* Number of recursive dependencies: 205

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

# spatialwarnings

<details>

* Version: 2.0.0
* Source code: https://github.com/cran/spatialwarnings
* URL: https://github.com/spatial-ews/spatialwarnings
* Date/Publication: 2020-05-14 17:10:06 UTC
* Number of recursive dependencies: 77

Run `revdep_details(,"spatialwarnings")` for more info

</details>

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘tidyr’
      All declared Imports should be used.
    ```

# stars

<details>

* Version: 0.4-1
* Source code: https://github.com/cran/stars
* URL: https://r-spatial.github.io/stars/, https://github.com/r-spatial/stars/
* BugReports: https://github.com/r-spatial/stars/issues/
* Date/Publication: 2020-04-07 10:00:02 UTC
* Number of recursive dependencies: 126

Run `revdep_details(,"stars")` for more info

</details>

## In both

*   checking package dependencies ... ERROR
    ```
    Packages required but not available: 'lwgeom', 'units'
    
    Packages suggested but not available for checking:
      'RNetCDF', 'ncdfgeom', 'ncmeta', 'starsdata'
    
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
* Number of recursive dependencies: 135

Run `revdep_details(,"TSstudio")` for more info

</details>

## In both

*   checking package dependencies ... NOTE
    ```
    Package suggested but not available for checking: ‘UKgrid’
    ```

*   checking dependencies in R code ... NOTE
    ```
    Failed to query server: Connection timed out
    Namespace in Imports field not imported from: ‘forecastHybrid’
      All declared Imports should be used.
    ```

