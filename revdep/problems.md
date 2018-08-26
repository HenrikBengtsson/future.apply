# BAMBI

Version: 2.0.1

## In both

*   checking installed package size ... NOTE
    ```
      installed size is  5.2Mb
      sub-directories of 1Mb or more:
        libs   4.7Mb
    ```

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
      OK: 436 SKIPPED: 1 FAILED: 1
      1. Failure: error if you try to draw POs at a level using a variable that doesn't exist at that level (@test-potential-outcomes.R#160) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘methods’
      All declared Imports should be used.
    ```

# phylolm

Version: 2.6

## In both

*   checking Rd cross-references ... NOTE
    ```
    Packages unavailable to check Rd xrefs: ‘surface’, ‘bayou’, ‘geiger’, ‘caper’
    ```

# robotstxt

Version: 0.6.2

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘future’
      All declared Imports should be used.
    ```

