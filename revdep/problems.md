# AIPW

<details>

* Version: 0.6.3.2
* GitHub: https://github.com/yqzhong7/AIPW
* Source code: https://github.com/cran/AIPW
* Date/Publication: 2021-06-11 09:30:02 UTC
* Number of recursive dependencies: 99

Run `revdep_details(, "AIPW")` for more info

</details>

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘Rsolnp’ ‘SuperLearner’ ‘future.apply’ ‘ggplot2’ ‘progressr’ ‘stats’
      ‘utils’
      All declared Imports should be used.
    ```

# altdoc

<details>

* Version: 0.3.0
* GitHub: https://github.com/etiennebacher/altdoc
* Source code: https://github.com/cran/altdoc
* Date/Publication: 2024-02-21 16:00:06 UTC
* Number of recursive dependencies: 84

Run `revdep_details(, "altdoc")` for more info

</details>

## In both

*   checking tests ...
    ```
      Running ‘spelling.R’
      Running ‘testthat.R’
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 50 lines of output:
      v Setting active project to '<no active project>'
      v Setting active project to '/scratch/henrik/1734856/Rtmp4zaexs/testpkg26e50316e2aed'
      v Setting active project to '<no active project>'
      v Setting active project to '/scratch/henrik/1734856/Rtmp4zaexs/testpkg26e503ae1d67b'
      v Setting active project to '<no active project>'
    ...
      Error in `render_docs(path = getwd())`: There were some failures when rendering vignettes.
      Backtrace:
          ▆
       1. └─altdoc::render_docs(path = getwd()) at test-update.R:111:5
       2.   └─cli::cli_abort("There were some failures when rendering vignettes.")
       3.     └─rlang::abort(...)
      
      [ FAIL 5 | WARN 0 | SKIP 7 | PASS 56 ]
      Error: Test failures
      Execution halted
    ```

# arkdb

<details>

* Version: 0.0.18
* GitHub: https://github.com/ropensci/arkdb
* Source code: https://github.com/cran/arkdb
* Date/Publication: 2024-01-16 00:20:02 UTC
* Number of recursive dependencies: 96

Run `revdep_details(, "arkdb")` for more info

</details>

## In both

*   checking tests ...
    ```
      Running ‘spelling.R’
      Running ‘testthat.R’
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 50 lines of output:
       6.           ├─ParquetFileWriter$create(...)
       7.           │ └─arrow:::parquet___arrow___ParquetFileWriter__Open(...)
       8.           └─ParquetWriterProperties$create(...)
       9.             └─arrow:::parquet___WriterProperties___Builder__create()
      ── Error ('test-arkdb.R:315:3'): e2e with filter for flights month = 12: parquet ──
    ...
      3: Database is garbage-collected, use dbDisconnect(con, shutdown=TRUE) or duckdb::duckdb_shutdown(drv) to avoid this. 
      4: Database is garbage-collected, use dbDisconnect(con, shutdown=TRUE) or duckdb::duckdb_shutdown(drv) to avoid this. 
      5: Connection is garbage-collected, use dbDisconnect() to avoid this. 
      6: Database is garbage-collected, use dbDisconnect(con, shutdown=TRUE) or duckdb::duckdb_shutdown(drv) to avoid this. 
      7: Database is garbage-collected, use dbDisconnect(con, shutdown=TRUE) or duckdb::duckdb_shutdown(drv) to avoid this. 
      8: Database is garbage-collected, use dbDisconnect(con, shutdown=TRUE) or duckdb::duckdb_shutdown(drv) to avoid this. 
      Execution halted
      Warning messages:
      1: Database is garbage-collected, use dbDisconnect(con, shutdown=TRUE) or duckdb::duckdb_shutdown(drv) to avoid this. 
      2: Database is garbage-collected, use dbDisconnect(con, shutdown=TRUE) or duckdb::duckdb_shutdown(drv) to avoid this. 
    ```

# BAMBI

<details>

* Version: 2.3.5
* GitHub: https://github.com/c7rishi/BAMBI
* Source code: https://github.com/cran/BAMBI
* Date/Publication: 2023-03-08 23:10:05 UTC
* Number of recursive dependencies: 53

Run `revdep_details(, "BAMBI")` for more info

</details>

## In both

*   checking whether package ‘BAMBI’ can be installed ... WARNING
    ```
    Found the following significant warnings:
      /c4/home/henrik/repositories/future.apply/revdep/library/BAMBI/RcppArmadillo/include/armadillo_bits/fn_reshape.hpp:63:13: warning: ‘arma::Mat<typename T1::elem_type> arma::reshape(const arma::Base<typename T1::elem_type, T1>&, arma::uword, arma::uword, arma::uword)’ is deprecated: don't use this form: it will be removed [-Wdeprecated-declarations]
      /c4/home/henrik/repositories/future.apply/revdep/library/BAMBI/RcppArmadillo/include/armadillo_bits/fn_reshape.hpp:65:7: warning: ‘arma::Mat<typename T1::elem_type> arma::reshape(const arma::Base<typename T1::elem_type, T1>&, arma::uword, arma::uword, arma::uword)’ is deprecated: don't use this form: it will be removed [-Wdeprecated-declarations]
      /c4/home/henrik/repositories/future.apply/revdep/library/BAMBI/RcppArmadillo/include/armadillo_bits/fn_reshape.hpp:74:9: warning: ‘arma::Mat<typename T1::elem_type> arma::reshape(const arma::Base<typename T1::elem_type, T1>&, arma::uword, arma::uword, arma::uword)’ is deprecated: don't use this form: it will be removed [-Wdeprecated-declarations]
    See ‘/c4/home/henrik/repositories/future.apply/revdep/checks/BAMBI/new/BAMBI.Rcheck/00install.out’ for details.
    ```

*   checking installed package size ... NOTE
    ```
      installed size is  7.3Mb
      sub-directories of 1Mb or more:
        libs   6.8Mb
    ```

# BEKKs

<details>

* Version: 1.4.4
* GitHub: NA
* Source code: https://github.com/cran/BEKKs
* Date/Publication: 2024-01-14 15:50:09 UTC
* Number of recursive dependencies: 86

Run `revdep_details(, "BEKKs")` for more info

</details>

## In both

*   checking whether package ‘BEKKs’ can be installed ... WARNING
    ```
    Found the following significant warnings:
      /c4/home/henrik/repositories/future.apply/revdep/library/BEKKs/RcppArmadillo/include/armadillo_bits/fn_reshape.hpp:63:13: warning: ‘arma::Mat<typename T1::elem_type> arma::reshape(const arma::Base<typename T1::elem_type, T1>&, arma::uword, arma::uword, arma::uword)’ is deprecated: don't use this form: it will be removed [-Wdeprecated-declarations]
      /c4/home/henrik/repositories/future.apply/revdep/library/BEKKs/RcppArmadillo/include/armadillo_bits/fn_reshape.hpp:65:7: warning: ‘arma::Mat<typename T1::elem_type> arma::reshape(const arma::Base<typename T1::elem_type, T1>&, arma::uword, arma::uword, arma::uword)’ is deprecated: don't use this form: it will be removed [-Wdeprecated-declarations]
      /c4/home/henrik/repositories/future.apply/revdep/library/BEKKs/RcppArmadillo/include/armadillo_bits/fn_reshape.hpp:74:9: warning: ‘arma::Mat<typename T1::elem_type> arma::reshape(const arma::Base<typename T1::elem_type, T1>&, arma::uword, arma::uword, arma::uword)’ is deprecated: don't use this form: it will be removed [-Wdeprecated-declarations]
    See ‘/c4/home/henrik/repositories/future.apply/revdep/checks/BEKKs/new/BEKKs.Rcheck/00install.out’ for details.
    ```

*   checking installed package size ... NOTE
    ```
      installed size is 18.5Mb
      sub-directories of 1Mb or more:
        libs  17.6Mb
    ```

# bigDM

<details>

* Version: 0.5.3
* GitHub: https://github.com/spatialstatisticsupna/bigDM
* Source code: https://github.com/cran/bigDM
* Date/Publication: 2023-10-17 12:50:02 UTC
* Number of recursive dependencies: 128

Run `revdep_details(, "bigDM")` for more info

</details>

## In both

*   checking package dependencies ... NOTE
    ```
    Package suggested but not available for checking: ‘INLA’
    ```

*   checking data for non-ASCII characters ... NOTE
    ```
      Note: found 940 marked Latin-1 strings
    ```

# blavaan

<details>

* Version: 0.5-3
* GitHub: https://github.com/ecmerkle/blavaan
* Source code: https://github.com/cran/blavaan
* Date/Publication: 2024-01-19 22:50:02 UTC
* Number of recursive dependencies: 98

Run `revdep_details(, "blavaan")` for more info

</details>

## In both

*   checking package dependencies ... NOTE
    ```
    Package suggested but not available for checking: ‘cmdstanr’
    ```

*   checking installed package size ... NOTE
    ```
      installed size is 196.2Mb
      sub-directories of 1Mb or more:
        R           1.2Mb
        libs      193.4Mb
        testdata    1.4Mb
    ```

*   checking for GNU extensions in Makefiles ... NOTE
    ```
    GNU make is a SystemRequirements.
    ```

# brms

<details>

* Version: 2.21.0
* GitHub: https://github.com/paul-buerkner/brms
* Source code: https://github.com/cran/brms
* Date/Publication: 2024-03-20 12:30:08 UTC
* Number of recursive dependencies: 201

Run `revdep_details(, "brms")` for more info

</details>

## In both

*   checking package dependencies ... NOTE
    ```
    Package suggested but not available for checking: ‘cmdstanr’
    ```

*   checking installed package size ... NOTE
    ```
      installed size is  8.4Mb
      sub-directories of 1Mb or more:
        R     3.7Mb
        doc   3.5Mb
    ```

# clickR

<details>

* Version: 0.9.39
* GitHub: NA
* Source code: https://github.com/cran/clickR
* Date/Publication: 2023-08-07 17:40:06 UTC
* Number of recursive dependencies: 9

Run `revdep_details(, "clickR")` for more info

</details>

## In both

*   checking data for non-ASCII characters ... NOTE
    ```
      Note: found 1 marked UTF-8 string
    ```

# collinear

<details>

* Version: 1.1.1
* GitHub: NA
* Source code: https://github.com/cran/collinear
* Date/Publication: 2023-12-08 08:50:02 UTC
* Number of recursive dependencies: 55

Run `revdep_details(, "collinear")` for more info

</details>

## In both

*   checking data for non-ASCII characters ... NOTE
    ```
      Note: found 89 marked Latin-1 strings
      Note: found 1203 marked UTF-8 strings
    ```

# cSEM

<details>

* Version: 0.5.0
* GitHub: https://github.com/M-E-Rademaker/cSEM
* Source code: https://github.com/cran/cSEM
* Date/Publication: 2022-11-24 17:50:05 UTC
* Number of recursive dependencies: 127

Run `revdep_details(, "cSEM")` for more info

</details>

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘Rdpack’
      All declared Imports should be used.
    ```

# deseats

<details>

* Version: 1.0.0
* GitHub: NA
* Source code: https://github.com/cran/deseats
* Date/Publication: 2023-11-08 19:50:02 UTC
* Number of recursive dependencies: 108

Run `revdep_details(, "deseats")` for more info

</details>

## In both

*   checking whether package ‘deseats’ can be installed ... WARNING
    ```
    Found the following significant warnings:
      /c4/home/henrik/repositories/future.apply/revdep/library/deseats/RcppArmadillo/include/armadillo_bits/fn_reshape.hpp:63:13: warning: ‘arma::Mat<typename T1::elem_type> arma::reshape(const arma::Base<typename T1::elem_type, T1>&, arma::uword, arma::uword, arma::uword)’ is deprecated: don't use this form: it will be removed [-Wdeprecated-declarations]
      /c4/home/henrik/repositories/future.apply/revdep/library/deseats/RcppArmadillo/include/armadillo_bits/fn_reshape.hpp:65:7: warning: ‘arma::Mat<typename T1::elem_type> arma::reshape(const arma::Base<typename T1::elem_type, T1>&, arma::uword, arma::uword, arma::uword)’ is deprecated: don't use this form: it will be removed [-Wdeprecated-declarations]
      /c4/home/henrik/repositories/future.apply/revdep/library/deseats/RcppArmadillo/include/armadillo_bits/fn_reshape.hpp:74:9: warning: ‘arma::Mat<typename T1::elem_type> arma::reshape(const arma::Base<typename T1::elem_type, T1>&, arma::uword, arma::uword, arma::uword)’ is deprecated: don't use this form: it will be removed [-Wdeprecated-declarations]
    See ‘/c4/home/henrik/repositories/future.apply/revdep/checks/deseats/new/deseats.Rcheck/00install.out’ for details.
    ```

*   checking installed package size ... NOTE
    ```
      installed size is  8.3Mb
      sub-directories of 1Mb or more:
        libs   7.6Mb
    ```

# dipsaus

<details>

* Version: 0.2.8
* GitHub: https://github.com/dipterix/dipsaus
* Source code: https://github.com/cran/dipsaus
* Date/Publication: 2023-07-03 20:00:03 UTC
* Number of recursive dependencies: 69

Run `revdep_details(, "dipsaus")` for more info

</details>

## In both

*   checking installed package size ... NOTE
    ```
      installed size is  5.9Mb
      sub-directories of 1Mb or more:
        doc    1.1Mb
        libs   3.5Mb
    ```

# EFAtools

<details>

* Version: 0.4.4
* GitHub: https://github.com/mdsteiner/EFAtools
* Source code: https://github.com/cran/EFAtools
* Date/Publication: 2023-01-06 14:50:40 UTC
* Number of recursive dependencies: 93

Run `revdep_details(, "EFAtools")` for more info

</details>

## In both

*   checking whether package ‘EFAtools’ can be installed ... WARNING
    ```
    Found the following significant warnings:
      /c4/home/henrik/repositories/future.apply/revdep/library/EFAtools/RcppArmadillo/include/armadillo_bits/fn_reshape.hpp:63:13: warning: ‘arma::Mat<typename T1::elem_type> arma::reshape(const arma::Base<typename T1::elem_type, T1>&, arma::uword, arma::uword, arma::uword)’ is deprecated: don't use this form: it will be removed [-Wdeprecated-declarations]
      /c4/home/henrik/repositories/future.apply/revdep/library/EFAtools/RcppArmadillo/include/armadillo_bits/fn_reshape.hpp:65:7: warning: ‘arma::Mat<typename T1::elem_type> arma::reshape(const arma::Base<typename T1::elem_type, T1>&, arma::uword, arma::uword, arma::uword)’ is deprecated: don't use this form: it will be removed [-Wdeprecated-declarations]
      /c4/home/henrik/repositories/future.apply/revdep/library/EFAtools/RcppArmadillo/include/armadillo_bits/fn_reshape.hpp:74:9: warning: ‘arma::Mat<typename T1::elem_type> arma::reshape(const arma::Base<typename T1::elem_type, T1>&, arma::uword, arma::uword, arma::uword)’ is deprecated: don't use this form: it will be removed [-Wdeprecated-declarations]
    See ‘/c4/home/henrik/repositories/future.apply/revdep/checks/EFAtools/new/EFAtools.Rcheck/00install.out’ for details.
    ```

*   checking C++ specification ... NOTE
    ```
      Specified C++11: please drop specification unless essential
    ```

*   checking installed package size ... NOTE
    ```
      installed size is  7.2Mb
      sub-directories of 1Mb or more:
        libs   6.0Mb
    ```

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘progress’
      All declared Imports should be used.
    ```

# EpiNow2

<details>

* Version: 1.4.0
* GitHub: https://github.com/epiforecasts/EpiNow2
* Source code: https://github.com/cran/EpiNow2
* Date/Publication: 2023-09-26 12:00:02 UTC
* Number of recursive dependencies: 130

Run `revdep_details(, "EpiNow2")` for more info

</details>

## In both

*   checking installed package size ... NOTE
    ```
      installed size is 223.7Mb
      sub-directories of 1Mb or more:
        help    2.0Mb
        libs  220.8Mb
    ```

*   checking for GNU extensions in Makefiles ... NOTE
    ```
    GNU make is a SystemRequirements.
    ```

# forecastML

<details>

* Version: 0.9.0
* GitHub: https://github.com/nredell/forecastML
* Source code: https://github.com/cran/forecastML
* Date/Publication: 2020-05-07 15:10:17 UTC
* Number of recursive dependencies: 104

Run `revdep_details(, "forecastML")` for more info

</details>

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘dtplyr’
      All declared Imports should be used.
    ```

# genBaRcode

<details>

* Version: 1.2.7
* GitHub: NA
* Source code: https://github.com/cran/genBaRcode
* Date/Publication: 2023-12-11 13:10:05 UTC
* Number of recursive dependencies: 160

Run `revdep_details(, "genBaRcode")` for more info

</details>

## In both

*   checking re-building of vignette outputs ... WARNING
    ```
    Error(s) in re-building vignettes:
    --- re-building ‘genBaRcode_GUI_Vignette.Rmd’ using rmarkdown
    ! LaTeX Error: File `iftex.sty' not found.
    
    ! Emergency stop.
    <read *> 
    
    Error: processing vignette 'genBaRcode_GUI_Vignette.Rmd' failed with diagnostics:
    LaTeX failed to compile /c4/home/henrik/repositories/future.apply/revdep/checks/genBaRcode/new/genBaRcode.Rcheck/vign_test/genBaRcode/vignettes/genBaRcode_GUI_Vignette.tex. See https://yihui.org/tinytex/r/#debugging for debugging tips. See genBaRcode_GUI_Vignette.log for more info.
    --- failed re-building ‘genBaRcode_GUI_Vignette.Rmd’
    ...
    
    Error: processing vignette 'genBaRcode_Vignette.Rmd' failed with diagnostics:
    LaTeX failed to compile /c4/home/henrik/repositories/future.apply/revdep/checks/genBaRcode/new/genBaRcode.Rcheck/vign_test/genBaRcode/vignettes/genBaRcode_Vignette.tex. See https://yihui.org/tinytex/r/#debugging for debugging tips. See genBaRcode_Vignette.log for more info.
    --- failed re-building ‘genBaRcode_Vignette.Rmd’
    
    SUMMARY: processing the following files failed:
      ‘genBaRcode_GUI_Vignette.Rmd’ ‘genBaRcode_Vignette.Rmd’
    
    Error: Vignette re-building failed.
    Execution halted
    ```

# geocmeans

<details>

* Version: 0.3.4
* GitHub: https://github.com/JeremyGelb/geocmeans
* Source code: https://github.com/cran/geocmeans
* Date/Publication: 2023-09-12 03:10:02 UTC
* Number of recursive dependencies: 197

Run `revdep_details(, "geocmeans")` for more info

</details>

## In both

*   checking whether package ‘geocmeans’ can be installed ... WARNING
    ```
    Found the following significant warnings:
      /c4/home/henrik/repositories/future.apply/revdep/library/geocmeans/RcppArmadillo/include/armadillo_bits/fn_reshape.hpp:63:13: warning: ‘arma::Mat<typename T1::elem_type> arma::reshape(const arma::Base<typename T1::elem_type, T1>&, arma::uword, arma::uword, arma::uword)’ is deprecated: don't use this form: it will be removed [-Wdeprecated-declarations]
      /c4/home/henrik/repositories/future.apply/revdep/library/geocmeans/RcppArmadillo/include/armadillo_bits/fn_reshape.hpp:65:7: warning: ‘arma::Mat<typename T1::elem_type> arma::reshape(const arma::Base<typename T1::elem_type, T1>&, arma::uword, arma::uword, arma::uword)’ is deprecated: don't use this form: it will be removed [-Wdeprecated-declarations]
      /c4/home/henrik/repositories/future.apply/revdep/library/geocmeans/RcppArmadillo/include/armadillo_bits/fn_reshape.hpp:74:9: warning: ‘arma::Mat<typename T1::elem_type> arma::reshape(const arma::Base<typename T1::elem_type, T1>&, arma::uword, arma::uword, arma::uword)’ is deprecated: don't use this form: it will be removed [-Wdeprecated-declarations]
    See ‘/c4/home/henrik/repositories/future.apply/revdep/checks/geocmeans/new/geocmeans.Rcheck/00install.out’ for details.
    ```

*   checking installed package size ... NOTE
    ```
      installed size is 13.5Mb
      sub-directories of 1Mb or more:
        extdata   3.0Mb
        libs      8.2Mb
    ```

# geohabnet

<details>

* Version: 2.0.0
* GitHub: https://github.com/GarrettLab/HabitatConnectivity
* Source code: https://github.com/cran/geohabnet
* Date/Publication: 2024-02-27 19:50:02 UTC
* Number of recursive dependencies: 134

Run `revdep_details(, "geohabnet")` for more info

</details>

## In both

*   checking re-building of vignette outputs ... ERROR
    ```
    Error(s) in re-building vignettes:
    --- re-building ‘LinkWeightsAnalysis.Rmd’ using rmarkdown
    trying URL 'https://s3.us-east-2.amazonaws.com/earthstatdata/HarvestedAreaYield175Crops_Indvidual_Geotiff/potato_HarvAreaYield_Geotiff.zip'
    Content type 'application/zip' length 10812124 bytes (10.3 MB)
    ==================================================
    downloaded 10.3 MB
    
    trying URL 'https://geohabnet.s3.us-east-2.amazonaws.com/util-rasters/ZeroRaster.tif'
    Content type 'image/tiff' length 1056851 bytes (1.0 MB)
    ==================================================
    ...
    Quitting from lines 108-109 [unnamed-chunk-5] (analysis.Rmd)
    Error: processing vignette 'analysis.Rmd' failed with diagnostics:
    (/c4/home/henrik/.config/R/geohabnet/parameters.yaml) Duplicate map key: 'default'
    --- failed re-building ‘analysis.Rmd’
    
    SUMMARY: processing the following file failed:
      ‘analysis.Rmd’
    
    Error: Vignette re-building failed.
    Execution halted
    ```

# hackeRnews

<details>

* Version: 0.1.0
* GitHub: https://github.com/szymanskir/hackeRnews
* Source code: https://github.com/cran/hackeRnews
* Date/Publication: 2019-12-13 13:20:05 UTC
* Number of recursive dependencies: 68

Run `revdep_details(, "hackeRnews")` for more info

</details>

## In both

*   checking LazyData ... NOTE
    ```
      'LazyData' is specified without a 'data' directory
    ```

# hbamr

<details>

* Version: 2.2.1
* GitHub: https://github.com/jbolstad/hbamr
* Source code: https://github.com/cran/hbamr
* Date/Publication: 2024-02-23 12:30:02 UTC
* Number of recursive dependencies: 90

Run `revdep_details(, "hbamr")` for more info

</details>

## In both

*   checking installed package size ... NOTE
    ```
      installed size is 353.1Mb
      sub-directories of 1Mb or more:
        libs  351.6Mb
    ```

*   checking for GNU extensions in Makefiles ... NOTE
    ```
    GNU make is a SystemRequirements.
    ```

# hero

<details>

* Version: 0.6
* GitHub: NA
* Source code: https://github.com/cran/hero
* Date/Publication: 2023-07-15 21:10:09 UTC
* Number of recursive dependencies: 160

Run `revdep_details(, "hero")` for more info

</details>

## In both

*   checking dependencies in R code ... NOTE
    ```
    [c4-n1:91644] OPAL ERROR: Not initialized in file pmix2x_client.c at line 109
    --------------------------------------------------------------------------
    The application appears to have been direct launched using "srun",
    but OMPI was not built with SLURM's PMI support and therefore cannot
    execute. There are several options for building PMI support under
    SLURM, depending upon the SLURM version you are using:
    
      version 16.05 or later: you can use SLURM's PMIx support. This
      requires that you configure and build SLURM --with-pmix.
    
      Versions earlier than 16.05: you must use either SLURM's PMI-1 or
      PMI-2 support. SLURM builds PMI-1 by default, or you can manually
      install PMI-2. You must then build Open MPI using --with-pmi pointing
      to the SLURM PMI library location.
    
    Please configure as appropriate and try again.
    --------------------------------------------------------------------------
    ```

# InPAS

<details>

* Version: 2.10.0
* GitHub: NA
* Source code: https://github.com/cran/InPAS
* Date/Publication: 2023-10-24
* Number of recursive dependencies: 171

Run `revdep_details(, "InPAS")` for more info

</details>

## In both

*   checking dependencies in R code ... NOTE
    ```
    There are ::: calls to the package's namespace in its code. A package
      almost never needs to use ::: for its own objects:
      ‘adjust_distalCPs’ ‘adjust_proximalCPs’ ‘adjust_proximalCPsByNBC’
      ‘adjust_proximalCPsByPWM’ ‘calculate_mse’ ‘find_valleyBySpline’
      ‘get_PAscore’ ‘get_PAscore2’ ‘remove_convergentUTR3s’
      ‘search_distalCPs’ ‘search_proximalCPs’
    ```

# ivmte

<details>

* Version: 1.4.0
* GitHub: NA
* Source code: https://github.com/cran/ivmte
* Date/Publication: 2021-09-17 12:20:07 UTC
* Number of recursive dependencies: 112

Run `revdep_details(, "ivmte")` for more info

</details>

## In both

*   checking package dependencies ... NOTE
    ```
    Packages suggested but not available for checking: 'gurobi', 'cplexAPI'
    ```

# keyATM

<details>

* Version: 0.5.1
* GitHub: https://github.com/keyATM/keyATM
* Source code: https://github.com/cran/keyATM
* Date/Publication: 2024-02-04 23:30:02 UTC
* Number of recursive dependencies: 107

Run `revdep_details(, "keyATM")` for more info

</details>

## In both

*   checking installed package size ... NOTE
    ```
      installed size is 24.7Mb
      sub-directories of 1Mb or more:
        libs  24.3Mb
    ```

# MAI

<details>

* Version: 1.8.0
* GitHub: https://github.com/KechrisLab/MAI
* Source code: https://github.com/cran/MAI
* Date/Publication: 2023-10-24
* Number of recursive dependencies: 178

Run `revdep_details(, "MAI")` for more info

</details>

## In both

*   checking top-level files ... NOTE
    ```
    File
      LICENSE
    is not mentioned in the DESCRIPTION file.
    ```

# metabolomicsR

<details>

* Version: 1.0.0
* GitHub: https://github.com/XikunHan/metabolomicsR
* Source code: https://github.com/cran/metabolomicsR
* Date/Publication: 2022-04-29 07:40:02 UTC
* Number of recursive dependencies: 182

Run `revdep_details(, "metabolomicsR")` for more info

</details>

## In both

*   checking dependencies in R code ... WARNING
    ```
    Missing or unexported object: ‘future::multiprocess’
    ```

*   checking package dependencies ... NOTE
    ```
    Package suggested but not available for checking: ‘genuMet’
    ```

# MineICA

<details>

* Version: 1.42.0
* GitHub: NA
* Source code: https://github.com/cran/MineICA
* Date/Publication: 2023-10-24
* Number of recursive dependencies: 215

Run `revdep_details(, "MineICA")` for more info

</details>

## In both

*   checking dependencies in R code ... WARNING
    ```
    Namespace in Imports field not imported from: ‘lumiHumanAll.db’
      All declared Imports should be used.
    Packages in Depends field not imported from:
      ‘GOstats’ ‘Hmisc’ ‘JADE’ ‘RColorBrewer’ ‘Rgraphviz’ ‘annotate’
      ‘biomaRt’ ‘cluster’ ‘colorspace’ ‘fastICA’ ‘foreach’ ‘ggplot2’
      ‘graph’ ‘gtools’ ‘igraph’ ‘marray’ ‘mclust’ ‘methods’ ‘plyr’ ‘scales’
      ‘xtable’
      These packages need to be imported from (in the NAMESPACE file)
      for when this namespace is loaded but not attached.
    Missing or unexported object: ‘GOstats::geneIdsByCategory’
    ':::' calls which should be '::':
      ‘Biobase:::annotation<-’ ‘Biobase:::validMsg’ ‘fpc:::pamk’
      ‘lumi:::getChipInfo’ ‘mclust:::adjustedRandIndex’
      See the note in ?`:::` about the use of this operator.
    Unexported object imported by a ':::' call: ‘Biobase:::isValidVersion’
      See the note in ?`:::` about the use of this operator.
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

*   checking R code for possible problems ... NOTE
    ```
    addGenesToGoReport: no visible global function definition for
      ‘conditional’
    addGenesToGoReport: no visible global function definition for
      ‘sigCategories’
    annot2Color: no visible global function definition for ‘brewer.pal’
    annot2Color: no visible global function definition for ‘heat_hcl’
    annot2Color: no visible global function definition for ‘terrain_hcl’
    annot2Color: no visible global function definition for ‘cm.colors’
    annot2Color: no visible global function definition for ‘rainbow_hcl’
    annotFeatures: no visible global function definition for ‘na.omit’
    ...
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

*   checking re-building of vignette outputs ... NOTE
    ```
    Error(s) in re-building vignettes:
    --- re-building ‘MineICA.Rnw’ using Sweave
    Loading required package: BiocGenerics
    
    Attaching package: ‘BiocGenerics’
    
    The following objects are masked from ‘package:stats’:
    
        IQR, mad, sd, var, xtabs
    
    ...
    l.23 \usepackage
                    {subfig}^^M
    !  ==> Fatal error occurred, no output PDF file produced!
    --- failed re-building ‘MineICA.Rnw’
    
    SUMMARY: processing the following file failed:
      ‘MineICA.Rnw’
    
    Error: Vignette re-building failed.
    Execution halted
    ```

# missSBM

<details>

* Version: 1.0.4
* GitHub: https://github.com/grossSBM/missSBM
* Source code: https://github.com/cran/missSBM
* Date/Publication: 2023-10-24 16:00:05 UTC
* Number of recursive dependencies: 113

Run `revdep_details(, "missSBM")` for more info

</details>

## In both

*   checking whether package ‘missSBM’ can be installed ... WARNING
    ```
    Found the following significant warnings:
      /c4/home/henrik/repositories/future.apply/revdep/library/missSBM/RcppArmadillo/include/armadillo_bits/fn_reshape.hpp:63:13: warning: ‘arma::Mat<typename T1::elem_type> arma::reshape(const arma::Base<typename T1::elem_type, T1>&, arma::uword, arma::uword, arma::uword)’ is deprecated: don't use this form: it will be removed [-Wdeprecated-declarations]
      /c4/home/henrik/repositories/future.apply/revdep/library/missSBM/RcppArmadillo/include/armadillo_bits/fn_reshape.hpp:65:7: warning: ‘arma::Mat<typename T1::elem_type> arma::reshape(const arma::Base<typename T1::elem_type, T1>&, arma::uword, arma::uword, arma::uword)’ is deprecated: don't use this form: it will be removed [-Wdeprecated-declarations]
      /c4/home/henrik/repositories/future.apply/revdep/library/missSBM/RcppArmadillo/include/armadillo_bits/fn_reshape.hpp:74:9: warning: ‘arma::Mat<typename T1::elem_type> arma::reshape(const arma::Base<typename T1::elem_type, T1>&, arma::uword, arma::uword, arma::uword)’ is deprecated: don't use this form: it will be removed [-Wdeprecated-declarations]
    See ‘/c4/home/henrik/repositories/future.apply/revdep/checks/missSBM/new/missSBM.Rcheck/00install.out’ for details.
    ```

*   checking installed package size ... NOTE
    ```
      installed size is  9.8Mb
      sub-directories of 1Mb or more:
        libs   7.8Mb
    ```

# MOSS

<details>

* Version: 0.2.2
* GitHub: https://github.com/agugonrey/MOSS
* Source code: https://github.com/cran/MOSS
* Date/Publication: 2022-03-25 15:50:05 UTC
* Number of recursive dependencies: 183

Run `revdep_details(, "MOSS")` for more info

</details>

## In both

*   checking re-building of vignette outputs ... WARNING
    ```
    Error(s) in re-building vignettes:
      ...
    --- re-building ‘MOSS_working_example.Rmd’ using rmarkdown
    ! LaTeX Error: File `iftex.sty' not found.
    
    ! Emergency stop.
    <read *> 
    
    Error: processing vignette 'MOSS_working_example.Rmd' failed with diagnostics:
    LaTeX failed to compile /c4/home/henrik/repositories/future.apply/revdep/checks/MOSS/new/MOSS.Rcheck/vign_test/MOSS/vignettes/MOSS_working_example.tex. See https://yihui.org/tinytex/r/#debugging for debugging tips. See MOSS_working_example.log for more info.
    --- failed re-building ‘MOSS_working_example.Rmd’
    
    SUMMARY: processing the following file failed:
      ‘MOSS_working_example.Rmd’
    
    Error: Vignette re-building failed.
    Execution halted
    ```

# pavo

<details>

* Version: 2.9.0
* GitHub: https://github.com/rmaia/pavo
* Source code: https://github.com/cran/pavo
* Date/Publication: 2023-09-24 10:10:02 UTC
* Number of recursive dependencies: 103

Run `revdep_details(, "pavo")` for more info

</details>

## In both

*   checking whether package ‘pavo’ can be installed ... WARNING
    ```
    Found the following significant warnings:
      Warning: no DISPLAY variable so Tk is not available
    See ‘/c4/home/henrik/repositories/future.apply/revdep/checks/pavo/new/pavo.Rcheck/00install.out’ for details.
    ```

*   checking package dependencies ... NOTE
    ```
    Package suggested but not available for checking: ‘imager’
    ```

# phylolm

<details>

* Version: 2.6.2
* GitHub: https://github.com/lamho86/phylolm
* Source code: https://github.com/cran/phylolm
* Date/Publication: 2020-06-22 05:10:08 UTC
* Number of recursive dependencies: 41

Run `revdep_details(, "phylolm")` for more info

</details>

## In both

*   checking C++ specification ... NOTE
    ```
      Specified C++11: please drop specification unless essential
    ```

*   checking Rd cross-references ... NOTE
    ```
    Packages unavailable to check Rd xrefs: ‘geiger’, ‘caper’
    ```

# PLNmodels

<details>

* Version: 1.2.0
* GitHub: https://github.com/pln-team/PLNmodels
* Source code: https://github.com/cran/PLNmodels
* Date/Publication: 2024-03-05 15:50:03 UTC
* Number of recursive dependencies: 151

Run `revdep_details(, "PLNmodels")` for more info

</details>

## In both

*   checking whether package ‘PLNmodels’ can be installed ... WARNING
    ```
    Found the following significant warnings:
      /c4/home/henrik/repositories/future.apply/revdep/library/PLNmodels/RcppArmadillo/include/armadillo_bits/fn_reshape.hpp:63:13: warning: ‘arma::Mat<typename T1::elem_type> arma::reshape(const arma::Base<typename T1::elem_type, T1>&, arma::uword, arma::uword, arma::uword)’ is deprecated: don't use this form: it will be removed [-Wdeprecated-declarations]
      /c4/home/henrik/repositories/future.apply/revdep/library/PLNmodels/RcppArmadillo/include/armadillo_bits/fn_reshape.hpp:65:7: warning: ‘arma::Mat<typename T1::elem_type> arma::reshape(const arma::Base<typename T1::elem_type, T1>&, arma::uword, arma::uword, arma::uword)’ is deprecated: don't use this form: it will be removed [-Wdeprecated-declarations]
      /c4/home/henrik/repositories/future.apply/revdep/library/PLNmodels/RcppArmadillo/include/armadillo_bits/fn_reshape.hpp:74:9: warning: ‘arma::Mat<typename T1::elem_type> arma::reshape(const arma::Base<typename T1::elem_type, T1>&, arma::uword, arma::uword, arma::uword)’ is deprecated: don't use this form: it will be removed [-Wdeprecated-declarations]
    See ‘/c4/home/henrik/repositories/future.apply/revdep/checks/PLNmodels/new/PLNmodels.Rcheck/00install.out’ for details.
    ```

*   checking installed package size ... NOTE
    ```
      installed size is 27.5Mb
      sub-directories of 1Mb or more:
        data   1.4Mb
        doc    2.0Mb
        libs  22.4Mb
    ```

# portvine

<details>

* Version: 1.0.3
* GitHub: https://github.com/EmanuelSommer/portvine
* Source code: https://github.com/cran/portvine
* Date/Publication: 2024-01-18 16:30:02 UTC
* Number of recursive dependencies: 129

Run `revdep_details(, "portvine")` for more info

</details>

## In both

*   checking installed package size ... NOTE
    ```
      installed size is 52.9Mb
      sub-directories of 1Mb or more:
        libs  51.9Mb
    ```

# QDNAseq

<details>

* Version: 1.38.0
* GitHub: https://github.com/ccagc/QDNAseq
* Source code: https://github.com/cran/QDNAseq
* Date/Publication: 2023-10-24
* Number of recursive dependencies: 88

Run `revdep_details(, "QDNAseq")` for more info

</details>

## In both

*   checking re-building of vignette outputs ... NOTE
    ```
    Error(s) in re-building vignettes:
    --- re-building ‘QDNAseq.Rnw’ using Sweave
    EM algorithm started ... 
    
    Warning in allprior/tot :
      Recycling array of length 1 in vector-array arithmetic is deprecated.
      Use c() or as.vector() instead.
    
    Warning in allprior/tot :
      Recycling array of length 1 in vector-array arithmetic is deprecated.
    ...
    l.196 \RequirePackage
                         {parnotes}^^M
    !  ==> Fatal error occurred, no output PDF file produced!
    --- failed re-building ‘QDNAseq.Rnw’
    
    SUMMARY: processing the following file failed:
      ‘QDNAseq.Rnw’
    
    Error: Vignette re-building failed.
    Execution halted
    ```

# receptiviti

<details>

* Version: 0.1.7
* GitHub: https://github.com/Receptiviti/receptiviti-r
* Source code: https://github.com/cran/receptiviti
* Date/Publication: 2024-02-23 23:50:05 UTC
* Number of recursive dependencies: 66

Run `revdep_details(, "receptiviti")` for more info

</details>

## In both

*   checking tests ...
    ```
      Running ‘testthat.R’
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Complete output:
      > library(testthat)
      > library(receptiviti)
      > 
      > test_check("receptiviti")
      Status: ERROR
      Message: 400
    ...
       7. └─receptiviti::receptiviti(...)
      ── Failure ('test-receptiviti_status.R:5:3'): failures works ───────────────────
      receptiviti_status(...) is not NULL
      
      `actual` is a list
      `expected` is NULL
      
      [ FAIL 2 | WARN 0 | SKIP 2 | PASS 6 ]
      Error: Test failures
      Execution halted
    ```

# robotstxt

<details>

* Version: 0.7.13
* GitHub: https://github.com/ropensci/robotstxt
* Source code: https://github.com/cran/robotstxt
* Date/Publication: 2020-09-03 19:30:02 UTC
* Number of recursive dependencies: 69

Run `revdep_details(, "robotstxt")` for more info

</details>

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘future’
      All declared Imports should be used.
    ```

*   checking LazyData ... NOTE
    ```
      'LazyData' is specified without a 'data' directory
    ```

# sctransform

<details>

* Version: 0.4.1
* GitHub: https://github.com/satijalab/sctransform
* Source code: https://github.com/cran/sctransform
* Date/Publication: 2023-10-19 04:40:02 UTC
* Number of recursive dependencies: 68

Run `revdep_details(, "sctransform")` for more info

</details>

## In both

*   checking whether package ‘sctransform’ can be installed ... WARNING
    ```
    Found the following significant warnings:
      /c4/home/henrik/repositories/future.apply/revdep/library/sctransform/RcppArmadillo/include/armadillo_bits/fn_reshape.hpp:63:13: warning: ‘arma::Mat<typename T1::elem_type> arma::reshape(const arma::Base<typename T1::elem_type, T1>&, arma::uword, arma::uword, arma::uword)’ is deprecated: don't use this form: it will be removed [-Wdeprecated-declarations]
      /c4/home/henrik/repositories/future.apply/revdep/library/sctransform/RcppArmadillo/include/armadillo_bits/fn_reshape.hpp:65:7: warning: ‘arma::Mat<typename T1::elem_type> arma::reshape(const arma::Base<typename T1::elem_type, T1>&, arma::uword, arma::uword, arma::uword)’ is deprecated: don't use this form: it will be removed [-Wdeprecated-declarations]
      /c4/home/henrik/repositories/future.apply/revdep/library/sctransform/RcppArmadillo/include/armadillo_bits/fn_reshape.hpp:74:9: warning: ‘arma::Mat<typename T1::elem_type> arma::reshape(const arma::Base<typename T1::elem_type, T1>&, arma::uword, arma::uword, arma::uword)’ is deprecated: don't use this form: it will be removed [-Wdeprecated-declarations]
    See ‘/c4/home/henrik/repositories/future.apply/revdep/checks/sctransform/new/sctransform.Rcheck/00install.out’ for details.
    ```

*   checking package dependencies ... NOTE
    ```
    Package which this enhances but not available for checking: ‘glmGamPoi’
    ```

# sdmApp

<details>

* Version: 0.0.2
* GitHub: https://github.com/Abson-dev/sdmApp
* Source code: https://github.com/cran/sdmApp
* Date/Publication: 2021-07-07 08:30:02 UTC
* Number of recursive dependencies: 173

Run `revdep_details(, "sdmApp")` for more info

</details>

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘sp’
      All declared Imports should be used.
    ```

# sdmTMB

<details>

* Version: 0.4.3
* GitHub: https://github.com/pbs-assess/sdmTMB
* Source code: https://github.com/cran/sdmTMB
* Date/Publication: 2024-02-29 01:40:02 UTC
* Number of recursive dependencies: 115

Run `revdep_details(, "sdmTMB")` for more info

</details>

## In both

*   checking tests ...
    ```
      Running ‘testthat.R’
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 50 lines of output:
        'test-deprecated-args.R:2:3', 'test-deprecated-args.R:67:3',
        'test-dharma.R:3:3', 'test-extra-optimization.R:2:3',
        'test-extra-time.R:3:3', 'test-extra-time.R:42:3', 'test-extra-time.R:116:3',
        'test-factor-levels.R:2:3', 'test-factor-levels.R:37:3',
        'test-factor-levels.R:91:3', 'test-forecasting.R:2:3', 'test-index.R:3:3',
        'test-link-prediction.R:5:3', 'test-link-prediction.R:67:3',
    ...
       [6] -0.37427778 - -0.37427783 [6]             
       [7] -0.01713492 - -0.01713497 [7]             
       [8] 0.14953175  - 0.14953169  [8]             
       [9] -0.51713492 - -0.51713497 [9]             
      [10] 0.08286508  - 0.08286503  [10]            
       ... ...           ...         and 290 more ...
      
      [ FAIL 1 | WARN 0 | SKIP 146 | PASS 151 ]
      Error: Test failures
      Execution halted
    ```

*   checking installed package size ... NOTE
    ```
      installed size is 105.4Mb
      sub-directories of 1Mb or more:
        libs  103.7Mb
    ```

# sentopics

<details>

* Version: 0.7.2
* GitHub: https://github.com/odelmarcelle/sentopics
* Source code: https://github.com/cran/sentopics
* Date/Publication: 2023-05-28 09:50:02 UTC
* Number of recursive dependencies: 173

Run `revdep_details(, "sentopics")` for more info

</details>

## In both

*   checking tests ...
    ```
      Running ‘testthat.R’
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Complete output:
      > 
      > library("testthat")
      > library("sentopics")
      > 
      > if (Sys.getenv("R_COVR") != "true") {
      +   test_check("sentopics")
    ...
      }), by = c("date", "doc_id", "title"))`: j doesn't evaluate to the same number of columns for each group
      Backtrace:
          ▆
       1. └─sentopics:::get_ECB_press_conferences(years = 1998) at test-others.R:2:3
       2.   ├─...[]
       3.   └─data.table::`[.data.table`(...)
      
      [ FAIL 1 | WARN 8 | SKIP 1 | PASS 326 ]
      Error: Test failures
      Execution halted
    ```

*   checking whether package ‘sentopics’ can be installed ... WARNING
    ```
    Found the following significant warnings:
      /c4/home/henrik/repositories/future.apply/revdep/library/sentopics/RcppArmadillo/include/armadillo_bits/fn_reshape.hpp:63:13: warning: ‘arma::Mat<typename T1::elem_type> arma::reshape(const arma::Base<typename T1::elem_type, T1>&, arma::uword, arma::uword, arma::uword)’ is deprecated: don't use this form: it will be removed [-Wdeprecated-declarations]
      /c4/home/henrik/repositories/future.apply/revdep/library/sentopics/RcppArmadillo/include/armadillo_bits/fn_reshape.hpp:65:7: warning: ‘arma::Mat<typename T1::elem_type> arma::reshape(const arma::Base<typename T1::elem_type, T1>&, arma::uword, arma::uword, arma::uword)’ is deprecated: don't use this form: it will be removed [-Wdeprecated-declarations]
      /c4/home/henrik/repositories/future.apply/revdep/library/sentopics/RcppArmadillo/include/armadillo_bits/fn_reshape.hpp:74:9: warning: ‘arma::Mat<typename T1::elem_type> arma::reshape(const arma::Base<typename T1::elem_type, T1>&, arma::uword, arma::uword, arma::uword)’ is deprecated: don't use this form: it will be removed [-Wdeprecated-declarations]
    See ‘/c4/home/henrik/repositories/future.apply/revdep/checks/sentopics/new/sentopics.Rcheck/00install.out’ for details.
    ```

*   checking installed package size ... NOTE
    ```
      installed size is  8.1Mb
      sub-directories of 1Mb or more:
        data   1.2Mb
        libs   6.2Mb
    ```

*   checking Rd cross-references ... NOTE
    ```
    Package unavailable to check Rd xrefs: ‘lexicon’
    ```

*   checking data for non-ASCII characters ... NOTE
    ```
      Note: found 3128 marked UTF-8 strings
    ```

# Seurat

<details>

* Version: 5.0.3
* GitHub: https://github.com/satijalab/seurat
* Source code: https://github.com/cran/Seurat
* Date/Publication: 2024-03-18 23:40:02 UTC
* Number of recursive dependencies: 266

Run `revdep_details(, "Seurat")` for more info

</details>

## In both

*   checking package dependencies ... NOTE
    ```
    Packages suggested but not available for checking: 'BPCells', 'presto'
    ```

*   checking installed package size ... NOTE
    ```
      installed size is 16.0Mb
      sub-directories of 1Mb or more:
        R      1.7Mb
        libs  13.5Mb
    ```

*   checking Rd cross-references ... NOTE
    ```
    Package unavailable to check Rd xrefs: ‘Signac’
    ```

# SeuratObject

<details>

* Version: 5.0.1
* GitHub: https://github.com/mojaveazure/seurat-object
* Source code: https://github.com/cran/SeuratObject
* Date/Publication: 2023-11-17 22:40:16 UTC
* Number of recursive dependencies: 102

Run `revdep_details(, "SeuratObject")` for more info

</details>

## In both

*   checking package dependencies ... NOTE
    ```
    Package suggested but not available for checking: ‘BPCells’
    
    Package which this enhances but not available for checking: ‘Seurat’
    ```

*   checking installed package size ... NOTE
    ```
      installed size is  5.4Mb
      sub-directories of 1Mb or more:
        R      1.5Mb
        libs   3.2Mb
    ```

*   checking Rd cross-references ... NOTE
    ```
    Package unavailable to check Rd xrefs: ‘plotly’
    ```

# sharp

<details>

* Version: 1.4.6
* GitHub: https://github.com/barbarabodinier/sharp
* Source code: https://github.com/cran/sharp
* Date/Publication: 2024-02-03 17:30:02 UTC
* Number of recursive dependencies: 156

Run `revdep_details(, "sharp")` for more info

</details>

## In both

*   checking package dependencies ... NOTE
    ```
    Package suggested but not available for checking: ‘rCOSA’
    ```

*   checking Rd cross-references ... NOTE
    ```
    Package unavailable to check Rd xrefs: ‘rCOSA’
    ```

# Signac

<details>

* Version: 1.12.0
* GitHub: https://github.com/stuart-lab/signac
* Source code: https://github.com/cran/Signac
* Date/Publication: 2023-11-08 09:30:02 UTC
* Number of recursive dependencies: 253

Run `revdep_details(, "Signac")` for more info

</details>

## In both

*   checking installed package size ... NOTE
    ```
      installed size is  5.1Mb
      sub-directories of 1Mb or more:
        R      1.1Mb
        libs   2.9Mb
    ```

# signeR

<details>

* Version: 2.4.0
* GitHub: https://github.com/TojalLab/signeR
* Source code: https://github.com/cran/signeR
* Date/Publication: 2023-10-24
* Number of recursive dependencies: 244

Run `revdep_details(, "signeR")` for more info

</details>

## In both

*   checking whether package ‘signeR’ can be installed ... WARNING
    ```
    Found the following significant warnings:
      /c4/home/henrik/repositories/future.apply/revdep/library/signeR/RcppArmadillo/include/armadillo_bits/fn_reshape.hpp:63:13: warning: ‘arma::Mat<typename T1::elem_type> arma::reshape(const arma::Base<typename T1::elem_type, T1>&, arma::uword, arma::uword, arma::uword)’ is deprecated: don't use this form: it will be removed [-Wdeprecated-declarations]
      /c4/home/henrik/repositories/future.apply/revdep/library/signeR/RcppArmadillo/include/armadillo_bits/fn_reshape.hpp:65:7: warning: ‘arma::Mat<typename T1::elem_type> arma::reshape(const arma::Base<typename T1::elem_type, T1>&, arma::uword, arma::uword, arma::uword)’ is deprecated: don't use this form: it will be removed [-Wdeprecated-declarations]
      /c4/home/henrik/repositories/future.apply/revdep/library/signeR/RcppArmadillo/include/armadillo_bits/fn_reshape.hpp:74:9: warning: ‘arma::Mat<typename T1::elem_type> arma::reshape(const arma::Base<typename T1::elem_type, T1>&, arma::uword, arma::uword, arma::uword)’ is deprecated: don't use this form: it will be removed [-Wdeprecated-declarations]
    See ‘/c4/home/henrik/repositories/future.apply/revdep/checks/signeR/new/signeR.Rcheck/00install.out’ for details.
    ```

*   checking C++ specification ... NOTE
    ```
      Specified C++11: please drop specification unless essential
    ```

*   checking installed package size ... NOTE
    ```
      installed size is  6.6Mb
      sub-directories of 1Mb or more:
        R     1.2Mb
        doc   4.5Mb
    ```

*   checking R code for possible problems ... NOTE
    ```
    covariate: no visible binding for global variable ‘.’
    explorepage: no visible binding for global variable ‘.’
    genCountMatrixFromMAF: no visible binding for global variable
      ‘Variant_Type’
    genCountMatrixFromMAF: no visible binding for global variable
      ‘Reference_Allele’
    genCountMatrixFromMAF: no visible binding for global variable
      ‘Tumor_Seq_Allele2’
    genCountMatrixFromMAF: no visible binding for global variable
      ‘Tumor_Seq_Allele1’
    ...
    ExposureCorrelation,SignExp-numeric: no visible binding for global
      variable ‘exposure’
    ExposureCorrelation,matrix-numeric: no visible binding for global
      variable ‘Feature’
    ExposureCorrelation,matrix-numeric: no visible binding for global
      variable ‘exposure’
    Undefined global functions or variables:
      . Col Feature Frequency Reference_Allele Row Samples Signatures
      Tumor_Seq_Allele1 Tumor_Seq_Allele2 Variant_Type alt<- exposure fc
      project sig sig_test
    ```

*   checking Rd files ... NOTE
    ```
    prepare_Rd: cosmic_data.Rd:91-93: Dropping empty section \details
    prepare_Rd: cosmic_data.Rd:98-100: Dropping empty section \references
    prepare_Rd: cosmic_data.Rd:101-102: Dropping empty section \examples
    prepare_Rd: tcga_similarities.Rd:96-98: Dropping empty section \details
    prepare_Rd: tcga_similarities.Rd:99-101: Dropping empty section \source
    prepare_Rd: tcga_similarities.Rd:102-104: Dropping empty section \references
    prepare_Rd: tcga_similarities.Rd:105-106: Dropping empty section \examples
    prepare_Rd: tcga_tumors.Rd:18-20: Dropping empty section \details
    prepare_Rd: tcga_tumors.Rd:21-23: Dropping empty section \source
    prepare_Rd: tcga_tumors.Rd:24-26: Dropping empty section \references
    prepare_Rd: tcga_tumors.Rd:27-28: Dropping empty section \examples
    ```

# SimDesign

<details>

* Version: 2.14
* GitHub: https://github.com/philchalmers/SimDesign
* Source code: https://github.com/cran/SimDesign
* Date/Publication: 2024-01-09 09:10:11 UTC
* Number of recursive dependencies: 123

Run `revdep_details(, "SimDesign")` for more info

</details>

## Newly fixed

*   checking re-building of vignette outputs ... ERROR
    ```
    Error(s) in re-building vignettes:
    --- re-building ‘Catch_errors.Rmd’ using rmarkdown
    --- finished re-building ‘Catch_errors.Rmd’
    
    --- re-building ‘Fixed_obj_fun.Rmd’ using rmarkdown
    
    Quitting from lines 65-69 [unnamed-chunk-5] (Fixed_obj_fun.Rmd)
    Error: processing vignette 'Fixed_obj_fun.Rmd' failed with diagnostics:
    creation of server socket failed: port 11240 cannot be opened
    --- failed re-building ‘Fixed_obj_fun.Rmd’
    ...
    --- finished re-building ‘Saving-results.Rmd’
    
    --- re-building ‘SimDesign-intro.Rmd’ using rmarkdown
    --- finished re-building ‘SimDesign-intro.Rmd’
    
    SUMMARY: processing the following file failed:
      ‘Fixed_obj_fun.Rmd’
    
    Error: Vignette re-building failed.
    Execution halted
    ```

## In both

*   checking installed package size ... NOTE
    ```
      installed size is  5.8Mb
      sub-directories of 1Mb or more:
        doc   5.2Mb
    ```

# smoots

<details>

* Version: 1.1.4
* GitHub: NA
* Source code: https://github.com/cran/smoots
* Date/Publication: 2023-09-11 08:50:02 UTC
* Number of recursive dependencies: 75

Run `revdep_details(, "smoots")` for more info

</details>

## In both

*   checking whether package ‘smoots’ can be installed ... WARNING
    ```
    Found the following significant warnings:
      /c4/home/henrik/repositories/future.apply/revdep/library/smoots/RcppArmadillo/include/armadillo_bits/fn_reshape.hpp:63:13: warning: ‘arma::Mat<typename T1::elem_type> arma::reshape(const arma::Base<typename T1::elem_type, T1>&, arma::uword, arma::uword, arma::uword)’ is deprecated: don't use this form: it will be removed [-Wdeprecated-declarations]
      /c4/home/henrik/repositories/future.apply/revdep/library/smoots/RcppArmadillo/include/armadillo_bits/fn_reshape.hpp:65:7: warning: ‘arma::Mat<typename T1::elem_type> arma::reshape(const arma::Base<typename T1::elem_type, T1>&, arma::uword, arma::uword, arma::uword)’ is deprecated: don't use this form: it will be removed [-Wdeprecated-declarations]
      /c4/home/henrik/repositories/future.apply/revdep/library/smoots/RcppArmadillo/include/armadillo_bits/fn_reshape.hpp:74:9: warning: ‘arma::Mat<typename T1::elem_type> arma::reshape(const arma::Base<typename T1::elem_type, T1>&, arma::uword, arma::uword, arma::uword)’ is deprecated: don't use this form: it will be removed [-Wdeprecated-declarations]
    See ‘/c4/home/henrik/repositories/future.apply/revdep/checks/smoots/new/smoots.Rcheck/00install.out’ for details.
    ```

# solitude

<details>

* Version: 1.1.3
* GitHub: https://github.com/talegari/solitude
* Source code: https://github.com/cran/solitude
* Date/Publication: 2021-07-29 20:00:02 UTC
* Number of recursive dependencies: 131

Run `revdep_details(, "solitude")` for more info

</details>

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘R6’ ‘lgr’
      All declared Imports should be used.
    ```

# spaMM

<details>

* Version: 4.4.16
* GitHub: NA
* Source code: https://github.com/cran/spaMM
* Date/Publication: 2023-12-20 13:50:02 UTC
* Number of recursive dependencies: 102

Run `revdep_details(, "spaMM")` for more info

</details>

## In both

*   checking package dependencies ... NOTE
    ```
    Packages suggested but not available for checking: 'Infusion', 'blackbox'
    
    Packages which this enhances but not available for checking:
      'multcomp', 'RLRsim', 'lmerTest'
    ```

*   checking installed package size ... NOTE
    ```
      installed size is 56.9Mb
      sub-directories of 1Mb or more:
        R      2.7Mb
        libs  52.9Mb
    ```

# SPARSEMODr

<details>

* Version: 1.2.0
* GitHub: https://github.com/NAU-CCL/SPARSEMODr
* Source code: https://github.com/cran/SPARSEMODr
* Date/Publication: 2022-07-19 20:50:02 UTC
* Number of recursive dependencies: 127

Run `revdep_details(, "SPARSEMODr")` for more info

</details>

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘future’ ‘geosphere’ ‘lubridate’ ‘tidyverse’ ‘viridis’
      All declared Imports should be used.
    ```

# spatialwarnings

<details>

* Version: 3.0.3
* GitHub: https://github.com/spatial-ews/spatialwarnings
* Source code: https://github.com/cran/spatialwarnings
* Date/Publication: 2022-03-21 13:00:02 UTC
* Number of recursive dependencies: 97

Run `revdep_details(, "spatialwarnings")` for more info

</details>

## In both

*   checking whether package ‘spatialwarnings’ can be installed ... WARNING
    ```
    Found the following significant warnings:
      /c4/home/henrik/repositories/future.apply/revdep/library/spatialwarnings/RcppArmadillo/include/armadillo_bits/fn_reshape.hpp:63:13: warning: ‘arma::Mat<typename T1::elem_type> arma::reshape(const arma::Base<typename T1::elem_type, T1>&, arma::uword, arma::uword, arma::uword)’ is deprecated: don't use this form: it will be removed [-Wdeprecated-declarations]
      /c4/home/henrik/repositories/future.apply/revdep/library/spatialwarnings/RcppArmadillo/include/armadillo_bits/fn_reshape.hpp:65:7: warning: ‘arma::Mat<typename T1::elem_type> arma::reshape(const arma::Base<typename T1::elem_type, T1>&, arma::uword, arma::uword, arma::uword)’ is deprecated: don't use this form: it will be removed [-Wdeprecated-declarations]
      /c4/home/henrik/repositories/future.apply/revdep/library/spatialwarnings/RcppArmadillo/include/armadillo_bits/fn_reshape.hpp:74:9: warning: ‘arma::Mat<typename T1::elem_type> arma::reshape(const arma::Base<typename T1::elem_type, T1>&, arma::uword, arma::uword, arma::uword)’ is deprecated: don't use this form: it will be removed [-Wdeprecated-declarations]
    See ‘/c4/home/henrik/repositories/future.apply/revdep/checks/spatialwarnings/new/spatialwarnings.Rcheck/00install.out’ for details.
    ```

*   checking Rd cross-references ... WARNING
    ```
    Missing link or links in documentation object 'indictest.Rd':
      ‘mgcv’
    
    See section 'Cross-references' in the 'Writing R Extensions' manual.
    ```

*   checking installed package size ... NOTE
    ```
      installed size is  7.0Mb
      sub-directories of 1Mb or more:
        libs   6.0Mb
    ```

# spNetwork

<details>

* Version: 0.4.3.8
* GitHub: https://github.com/JeremyGelb/spNetwork
* Source code: https://github.com/cran/spNetwork
* Date/Publication: 2023-08-24 11:20:05 UTC
* Number of recursive dependencies: 143

Run `revdep_details(, "spNetwork")` for more info

</details>

## In both

*   checking whether package ‘spNetwork’ can be installed ... WARNING
    ```
    Found the following significant warnings:
      /c4/home/henrik/repositories/future.apply/revdep/library/spNetwork/RcppArmadillo/include/armadillo_bits/fn_reshape.hpp:63:13: warning: ‘arma::Mat<typename T1::elem_type> arma::reshape(const arma::Base<typename T1::elem_type, T1>&, arma::uword, arma::uword, arma::uword)’ is deprecated: don't use this form: it will be removed [-Wdeprecated-declarations]
      /c4/home/henrik/repositories/future.apply/revdep/library/spNetwork/RcppArmadillo/include/armadillo_bits/fn_reshape.hpp:65:7: warning: ‘arma::Mat<typename T1::elem_type> arma::reshape(const arma::Base<typename T1::elem_type, T1>&, arma::uword, arma::uword, arma::uword)’ is deprecated: don't use this form: it will be removed [-Wdeprecated-declarations]
      /c4/home/henrik/repositories/future.apply/revdep/library/spNetwork/RcppArmadillo/include/armadillo_bits/fn_reshape.hpp:74:9: warning: ‘arma::Mat<typename T1::elem_type> arma::reshape(const arma::Base<typename T1::elem_type, T1>&, arma::uword, arma::uword, arma::uword)’ is deprecated: don't use this form: it will be removed [-Wdeprecated-declarations]
    See ‘/c4/home/henrik/repositories/future.apply/revdep/checks/spNetwork/new/spNetwork.Rcheck/00install.out’ for details.
    ```

*   checking installed package size ... NOTE
    ```
      installed size is 25.5Mb
      sub-directories of 1Mb or more:
        doc       1.0Mb
        extdata   2.6Mb
        libs     20.5Mb
    ```

# stars

<details>

* Version: 0.6-4
* GitHub: https://github.com/r-spatial/stars
* Source code: https://github.com/cran/stars
* Date/Publication: 2023-09-11 11:50:02 UTC
* Number of recursive dependencies: 165

Run `revdep_details(, "stars")` for more info

</details>

## Newly broken

*   checking examples ...sh: line 1: 39634 Aborted                 (core dumped) LANGUAGE=en _R_CHECK_INTERNALS2_=1 '/software/c4/cbi/software/_centos7/R-4.3.3-gcc10/lib64/R/bin/R' --vanilla --encoding=UTF-8 > 'stars-Ex.Rout' 2>&1 < 'stars-Ex.R'
    ```
     ERROR
    Running examples in ‘stars-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: mdim
    > ### Title: Read or write data using GDAL's multidimensional array API
    > ### Aliases: mdim read_mdim write_mdim
    > 
    > ### ** Examples
    > 
    ...
                               dmalloc: no
        Packages w/ extra debug output: none
                           API tracing: no
                  Using memory checker: no
       Memory allocation sanity checks: no
                Function stack tracing: no
                      Use file locking: best-effort
             Strict file format checks: no
          Optimization instrumentation: no
    Bye...
    ```

## Newly fixed

*   checking examples ...sh: line 1: 39641 Aborted                 (core dumped) LANGUAGE=en _R_CHECK_INTERNALS2_=1 '/software/c4/cbi/software/_centos7/R-4.3.3-gcc10/lib64/R/bin/R' --vanilla --encoding=UTF-8 > 'stars-Ex.Rout' 2>&1 < 'stars-Ex.R'
    ```
     ERROR
    Running examples in ‘stars-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: mdim
    > ### Title: Read or write data using GDAL's multidimensional array API
    > ### Aliases: mdim read_mdim write_mdim
    > 
    > ### ** Examples
    > 
    ...
                               dmalloc: no
        Packages w/ extra debug output: none
                           API tracing: no
                  Using memory checker: no
       Memory allocation sanity checks: no
                Function stack tracing: no
                      Use file locking: best-effort
             Strict file format checks: no
          Optimization instrumentation: no
    Bye...
    ```

## In both

*   checking tests ...
    ```
      Running ‘aggregate.R’
      Comparing ‘aggregate.Rout’ to ‘aggregate.Rout.save’ ...4c4
    < Linking to GEOS 3.11.2, GDAL 3.6.4, PROJ 8.2.1; sf_use_s2() is TRUE
    ---
    > Linking to GEOS 3.11.2, GDAL 3.6.2, PROJ 9.2.0; sf_use_s2() is TRUE
      Running ‘align.R’
      Comparing ‘align.Rout’ to ‘align.Rout.save’ ... OK
      Running ‘area.R’
      Comparing ‘area.Rout’ to ‘area.Rout.save’ ... OK
      Running ‘crop.R’
    ...
                                 dmalloc: no
          Packages w/ extra debug output: none
                             API tracing: no
                    Using memory checker: no
         Memory allocation sanity checks: no
                  Function stack tracing: no
                        Use file locking: best-effort
               Strict file format checks: no
            Optimization instrumentation: no
      Bye...
    ```

*   checking package dependencies ... NOTE
    ```
    Package suggested but not available for checking: ‘starsdata’
    ```

*   checking installed package size ... NOTE
    ```
      installed size is  6.1Mb
      sub-directories of 1Mb or more:
        doc   2.4Mb
        nc    1.7Mb
    ```

# stppSim

<details>

* Version: 1.3.2
* GitHub: https://github.com/Manalytics/stppSim
* Source code: https://github.com/cran/stppSim
* Date/Publication: 2023-10-29 21:20:02 UTC
* Number of recursive dependencies: 130

Run `revdep_details(, "stppSim")` for more info

</details>

## In both

*   checking whether package ‘stppSim’ can be installed ... WARNING
    ```
    Found the following significant warnings:
      Warning: no DISPLAY variable so Tk is not available
    See ‘/c4/home/henrik/repositories/future.apply/revdep/checks/stppSim/new/stppSim.Rcheck/00install.out’ for details.
    ```

# targeted

<details>

* Version: 0.5
* GitHub: https://github.com/kkholst/targeted
* Source code: https://github.com/cran/targeted
* Date/Publication: 2024-02-22 10:00:21 UTC
* Number of recursive dependencies: 97

Run `revdep_details(, "targeted")` for more info

</details>

## In both

*   checking whether package ‘targeted’ can be installed ... WARNING
    ```
    Found the following significant warnings:
      /c4/home/henrik/repositories/future.apply/revdep/library/targeted/RcppArmadillo/include/armadillo_bits/fn_reshape.hpp:63:13: warning: ‘arma::Mat<typename T1::elem_type> arma::reshape(const arma::Base<typename T1::elem_type, T1>&, arma::uword, arma::uword, arma::uword)’ is deprecated: don't use this form: it will be removed [-Wdeprecated-declarations]
      /c4/home/henrik/repositories/future.apply/revdep/library/targeted/RcppArmadillo/include/armadillo_bits/fn_reshape.hpp:65:7: warning: ‘arma::Mat<typename T1::elem_type> arma::reshape(const arma::Base<typename T1::elem_type, T1>&, arma::uword, arma::uword, arma::uword)’ is deprecated: don't use this form: it will be removed [-Wdeprecated-declarations]
      /c4/home/henrik/repositories/future.apply/revdep/library/targeted/RcppArmadillo/include/armadillo_bits/fn_reshape.hpp:74:9: warning: ‘arma::Mat<typename T1::elem_type> arma::reshape(const arma::Base<typename T1::elem_type, T1>&, arma::uword, arma::uword, arma::uword)’ is deprecated: don't use this form: it will be removed [-Wdeprecated-declarations]
    See ‘/c4/home/henrik/repositories/future.apply/revdep/checks/targeted/new/targeted.Rcheck/00install.out’ for details.
    ```

*   checking installed package size ... NOTE
    ```
      installed size is 22.4Mb
      sub-directories of 1Mb or more:
        doc    1.1Mb
        libs  20.9Mb
    ```

# TreeMineR

<details>

* Version: 1.0.0
* GitHub: NA
* Source code: https://github.com/cran/TreeMineR
* Date/Publication: 2024-03-22 20:10:06 UTC
* Number of recursive dependencies: 49

Run `revdep_details(, "TreeMineR")` for more info

</details>

## In both

*   checking data for non-ASCII characters ... NOTE
    ```
      Note: found 3 marked UTF-8 strings
    ```

# tsdistributions

<details>

* Version: 1.0.0
* GitHub: https://github.com/tsmodels/tsdistributions
* Source code: https://github.com/cran/tsdistributions
* Date/Publication: 2024-03-17 09:10:05 UTC
* Number of recursive dependencies: 71

Run `revdep_details(, "tsdistributions")` for more info

</details>

## In both

*   checking re-building of vignette outputs ... WARNING
    ```
    Error(s) in re-building vignettes:
      ...
    --- re-building ‘estimation_demo.Rmd’ using rmarkdown
    --- finished re-building ‘estimation_demo.Rmd’
    
    --- re-building ‘location_scale_distributions.Rmd’ using rmarkdown
    ! LaTeX Error: File `iftex.sty' not found.
    
    ! Emergency stop.
    <read *> 
    ...
    --- failed re-building ‘location_scale_distributions.Rmd’
    
    --- re-building ‘profile_demo.Rmd’ using rmarkdown
    --- finished re-building ‘profile_demo.Rmd’
    
    SUMMARY: processing the following file failed:
      ‘location_scale_distributions.Rmd’
    
    Error: Vignette re-building failed.
    Execution halted
    ```

*   checking installed package size ... NOTE
    ```
      installed size is 42.4Mb
      sub-directories of 1Mb or more:
        libs  41.8Mb
    ```

# txshift

<details>

* Version: 0.3.8
* GitHub: https://github.com/nhejazi/txshift
* Source code: https://github.com/cran/txshift
* Date/Publication: 2022-02-09 22:30:02 UTC
* Number of recursive dependencies: 112

Run `revdep_details(, "txshift")` for more info

</details>

## In both

*   checking package dependencies ... NOTE
    ```
    Package which this enhances but not available for checking: ‘sl3’
    ```

# XNAString

<details>

* Version: 1.10.0
* GitHub: NA
* Source code: https://github.com/cran/XNAString
* Date/Publication: 2023-10-24
* Number of recursive dependencies: 105

Run `revdep_details(, "XNAString")` for more info

</details>

## In both

*   checking compiled code ... WARNING
    ```
    File ‘XNAString/libs/XNAString.so’:
      Found ‘rand’, possibly from ‘rand’ (C)
        Object: ‘./ViennaRNA/utils/utils.o’
      Found ‘sprintf’, possibly from ‘sprintf’ (C)
        Objects: ‘./ViennaRNA/part_func_up.o’, ‘./ViennaRNA/RNAstruct.o’,
          ‘./ViennaRNA/model.o’
      Found ‘srand’, possibly from ‘srand’ (C)
        Object: ‘./ViennaRNA/utils/utils.o’
    
    Compiled code should not call entry points which might terminate R nor
    write to stdout/stderr instead of to the console, nor use Fortran I/O
    nor system RNGs nor [v]sprintf.
    
    See ‘Writing portable packages’ in the ‘Writing R Extensions’ manual.
    ```

*   checking C++ specification ... NOTE
    ```
      Specified C++11: please drop specification unless essential
    ```

*   checking installed package size ... NOTE
    ```
      installed size is 11.2Mb
      sub-directories of 1Mb or more:
        doc    1.0Mb
        libs   9.5Mb
    ```

*   checking top-level files ... NOTE
    ```
    File
      LICENSE
    is not mentioned in the DESCRIPTION file.
    ```

