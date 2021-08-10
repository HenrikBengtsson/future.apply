# CRAN submission future.apply 1.8.1

on 2021-08-10

Second submission:

This is a resubmission that fixes the following on note on Debian CRAN incoming:

Problems when formatting CITATION entries:
    partial match of 'note' to 'notes'

Thanks


First submission:

I've verified this submission has no negative impact on any of the 82 reverse package dependencies available on CRAN (n=79) and Bioconductor (n=3).

Thanks in advance


## Notes not sent to CRAN

### R CMD check validation

The package has been verified using `R CMD check --as-cran` on:

| R version | GitHub | R-hub   | AppVeyor | win-builder |
| --------- | ------ | ------- | -------- | ----------- |
| 3.3.x     | L      |         |          |             |
| 3.4.x     | L      |         |          |             |
| 3.5.x     | L      |         |          |             |
| 4.0.x     | L M    |         |          |             |
| 4.1.x     | L M W  | L S M   | W        | W           |
| devel     |   M    | L     W |          | W           |

_Legend: L = Linux, S = Solaris, M = macOS, W = Windows_
