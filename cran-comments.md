# CRAN submission future.apply 1.11.1

on 2023-12-19

I've verified this submission has no negative impact on any of the 123 reverse package dependencies available on CRAN (n=116) and Bioconductor (n=7).

Thanks in advance


Follow up on 2023-12-20:

Would you mind re-checking 'sentopics' to see if it is a glitch?  I suspect this is false positive.  I also believe the segfault is due to problem independent of the future.apply package.

I believe this, because:

1. I cannot reproduce this in my reverse dependency checks on Rocky 8 and Ubuntu 22.04 running R 4.3.2.

2. The only change in this submission, future.apply 1.11.1, is that R option 'future.globals.maxSize' is passed down as a *rescaled* value to parallel workers. The submission was a bug fix, because in previous version it was not rescaled.

  (a) That option is just a gatekeeper, which calls stop() if object.size(x) overrides this limit. If this change would have an effect, I cannot see how an error condition could cause a segfault.
  
  (b) I've search 'sentopics', and it does not make use of this option, so there is also no hack that they do that someone could be affected by this submission.

  (c) The same 'future.globals.maxSize' rescaling approach has been in place for years in the 'furrr' and the 'doFuture' packages, where it has had zero impacts like this.  The 'sentopics' package used 'doFuture' in 'sentopics' (< 0.7.0; 2022-05-09), when they switched to 'future.apply'.

  (d) I went through the source code and the units tests of 'sentopics' and the only parallelization technique they use is effectively a traditional PSOCK cluster with at most two parallel workers. They do *not* use forked parallelization, which otherwise could lead to sporradic segfaults if misused.


## Notes not sent to CRAN

### R CMD check validation

The package has been verified using `R CMD check --as-cran` on:

| R version     | GitHub | R-hub  | mac/win-builder |
| ------------- | ------ | ------ | --------------- |
| 3.5.x         | L      |        |                 |
| 4.1.x         | L      |        |                 |
| 4.2.x         | L M W  |        |                 |
| 4.3.x         | L M W  | L   W  | M1 W            |
| devel         | L M W  | L      |    W            |

*Legend: OS: L = Linux, M = macOS, M1 = macOS M1, W = Windows*


R-hub checks:

```r
res <- rhub::check(platforms = c(
  "debian-clang-devel", 
  "debian-gcc-patched", 
  "fedora-gcc-devel",
  "windows-x86_64-release"
))
print(res)
```

gives


```
── future.apply 1.11.1: OK

  Build ID:   future.apply_1.11.1.tar.gz-5cd79dbfbcb041fc959af977a12afc14
  Platform:   Debian Linux, R-devel, clang, ISO-8859-15 locale
  Submitted:  2h 53m 12.3s ago
  Build time: 45m 37s

0 errors ✔ | 0 warnings ✔ | 0 notes ✔

── future.apply 1.11.1: OK

  Build ID:   future.apply_1.11.1.tar.gz-47b28360833c41398e8717d067ff3627
  Platform:   Debian Linux, R-patched, GCC
  Submitted:  2h 53m 12.3s ago
  Build time: 41m 3.1s

0 errors ✔ | 0 warnings ✔ | 0 notes ✔

── future.apply 1.11.1: OK

  Build ID:   future.apply_1.11.1.tar.gz-9109cf477a814b65a836f085e94091d3
  Platform:   Fedora Linux, R-devel, GCC
  Submitted:  2h 53m 54.5s ago
  Build time: 28m 6.4s

0 errors ✔ | 0 warnings ✔ | 0 notes ✔

── future.apply 1.11.1: OK

  Build ID:   future.apply_1.11.1.tar.gz-59486dfc2fa34201974f298c8ec4dfe0
  Platform:   Windows Server 2022, R-release, 32/64 bit
  Submitted:  2h 53m 12.3s ago
  Build time: 6m 10s

0 errors ✔ | 0 warnings ✔ | 0 notes ✔
```
