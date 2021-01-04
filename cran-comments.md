# CRAN submission future.apply 1.7.0

on 2021-01-04

I've verified that this submission does not cause issues for the 57 reverse package dependency available on CRAN and Bioconductor.

Thanks in advance


## Notes not sent to CRAN

### R CMD check validation

The package has been verified using `R CMD check --as-cran` on:

| R version          | GitHub Actions | Travis CI | AppVeyor CI | Rhub      | Win-builder | Other  |
| ------------------ | -------------- | --------- | ----------- | --------- | ----------- | ------ |
| 3.3.3              | L              |           |             |           |             |        |
| 3.4.4              | L              |           |             |           |             |        |
| 3.5.3              | L              |           |             |           |             |        |
| 3.6.3              | L, M           | L, M      | W           | L         |             |        |
| 4.0.{0,1,2}        | L              | L, M      | W           |    S      | W           |        |
| devel              |    M           | L         | W (32 & 64) | L     W   | W           |        |

*Legend: OS: L = Linux, S = Solaris, M = macOS, W = Windows.  Architecture: 32 = 32-bit, 64 = 64-bit*
