# DeclareDesign

Version: 0.10.0

## In both

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      > library(DeclareDesign)
      Loading required package: randomizr
      Loading required package: fabricatr
      Loading required package: estimatr
      > 
      > test_check("DeclareDesign")
      ── 1. Failure: error if you try to draw POs at a level using a variable that doe
      `my_potential_outcomes_formula(pop)` did not throw an error.
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      OK: 434 SKIPPED: 2 FAILED: 1
      1. Failure: error if you try to draw POs at a level using a variable that doesn't exist at that level (@test-potential-outcomes.R#160) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

*   checking package dependencies ... NOTE
    ```
    Package suggested but not available for checking: ‘sf’
    ```

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘methods’
      All declared Imports should be used.
    ```

# robotstxt

Version: 0.6.2

## In both

*   checking re-building of vignette outputs ... WARNING
    ```
    Error in re-building vignettes:
      ...
    
     google.com                      Quitting from lines 48-51 (using_robotstxt.Rmd) 
    Error: processing vignette 'using_robotstxt.Rmd' failed with diagnostics:
    Could not resolve host: google.com; Name or service not known
    Execution halted
    ```

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘future’
      All declared Imports should be used.
    ```

# sperrorest

Version: 2.1.5

## In both

*   checking re-building of vignette outputs ... WARNING
    ```
    Error in re-building vignettes:
      ...
    pandoc: Could not fetch https://raw.githubusercontent.com/pat-s/sperrorest/master/man/figures/resamp-plot.png
    FailedConnectionException2 "raw.githubusercontent.com" 443 True getAddrInfo: does not exist (Name or service not known)
    Error: processing vignette 'spatial-modeling-use-case.Rmd' failed with diagnostics:
    pandoc document conversion failed with error 67
    Execution halted
    ```

