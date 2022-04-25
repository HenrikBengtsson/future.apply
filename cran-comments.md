# CRAN submission future.apply 1.9.0

on 2022-04-25

I've verified this submission has no negative impact on any of the 102 reverse package dependencies available on CRAN (n=97) and Bioconductor (n=5).

Thanks in advance


## Notes not sent to CRAN

### R CMD check validation

The package has been verified using `R CMD check --as-cran` on:

| R version     | GitHub | R-hub    | mac/win-builder |
| ------------- | ------ | -------- | --------------- |
| 3.4.x         | L      |          |                 |
| 4.0.x         | L      |          |                 |
| 4.1.x         | L M W  |          |                 |
| 4.2.x         | L M W  | L M M1 W | M1 W            |
| devel         |   M W  | L        |    W            |

_Legend: L = Linux, M = macOS, M1 = macOS M1, W = Windows_


R-hub checks:

```r
res <- rhub::check(platform = c(
  "debian-clang-devel", "debian-gcc-patched", "linux-x86_64-centos-epel",
  "macos-highsierra-release-cran", "macos-m1-bigsur-release",
  "windows-x86_64-release"))
print(res)
```

gives

```
── future.apply 1.8.1-9003: OK

  Build ID:   future.apply_1.8.1-9003.tar.gz-3caf239071d34aa3852289c349c61129
  Platform:   Debian Linux, R-devel, clang, ISO-8859-15 locale
  Submitted:  10m 27.6s ago
  Build time: 7m 37.1s

0 errors ✔ | 0 warnings ✔ | 0 notes ✔

── future.apply 1.8.1-9003: OK

  Build ID:   future.apply_1.8.1-9003.tar.gz-30d60f81de2148b0b94225c52d30a41b
  Platform:   Debian Linux, R-patched, GCC
  Submitted:  10m 27.6s ago
  Build time: 6m 33.7s

0 errors ✔ | 0 warnings ✔ | 0 notes ✔

── future.apply 1.8.1-9003: OK

  Build ID:   future.apply_1.8.1-9003.tar.gz-5cc3d3f58d274f989736d72d1d99d279
  Platform:   CentOS 8, stock R from EPEL
  Submitted:  10m 27.6s ago
  Build time: 5m 47.2s

0 errors ✔ | 0 warnings ✔ | 0 notes ✔

── future.apply 1.8.1-9003: OK

  Build ID:   future.apply_1.8.1-9003.tar.gz-fe910352b2f0447db56ce3408f37624a
  Platform:   macOS 10.13.6 High Sierra, R-release, CRAN's setup
  Submitted:  10m 27.6s ago
  Build time: 3m 59.8s

0 errors ✔ | 0 warnings ✔ | 0 notes ✔

── future.apply 1.8.1-9003: OK

  Build ID:   future.apply_1.8.1-9003.tar.gz-3b4c7a6585e2449fb4893a70bdf2d73c
  Platform:   Apple Silicon (M1), macOS 11.6 Big Sur, R-release
  Submitted:  10m 27.6s ago
  Build time: 2m 0.3s

0 errors ✔ | 0 warnings ✔ | 0 notes ✔

── future.apply 1.8.1-9003: OK

  Build ID:   future.apply_1.8.1-9003.tar.gz-075e37a9e9394e90b662921e3b561cef
  Platform:   Windows Server 2008 R2 SP1, R-release, 32/64 bit
  Submitted:  10m 27.6s ago
  Build time: 4m 37s

0 errors ✔ | 0 warnings ✔ | 0 notes ✔
```
