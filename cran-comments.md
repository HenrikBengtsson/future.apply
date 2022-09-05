# CRAN submission future.apply 1.9.1

on 2022-09-05

I've verified this submission has no negative impact on any of the 113 reverse package dependencies available on CRAN (n=108) and Bioconductor (n=5).

Thanks in advance


## Notes not sent to CRAN

### R CMD check validation

The package has been verified using `R CMD check --as-cran` on:

| R version     | GitHub | R-hub    | mac/win-builder |
| ------------- | ------ | -------- | --------------- |
| 3.4.x         | L      |          |                 |
| 3.6.x         | L      |          |                 |
| 4.0.x         | L      |          |                 |
| 4.1.x         | L M W  |          |                 |
| 4.2.x         | L M W  | L M M1 W | M1 W            |
| devel         | L M W  | L        |    W            |

*Legend: OS: L = Linux, M = macOS, M1 = macOS M1, W = Windows*


R-hub checks:

```r
res <- rhub::check(platforms = c(
  "debian-clang-devel", "debian-gcc-patched",
  # "linux-x86_64-rocker-gcc-san", ## PREPERROR
  "macos-highsierra-release-cran", "macos-m1-bigsur-release",
  "windows-x86_64-release"))
print(res)
```

gives

```
── future.apply 1.9.0-9004: OK

  Build ID:   future.apply_1.9.0-9004.tar.gz-4e72f08dae034acc82dde494b65de2ac
  Platform:   Debian Linux, R-devel, clang, ISO-8859-15 locale
  Submitted:  12m 26.3s ago
  Build time: 12m 12s

0 errors ✔ | 0 warnings ✔ | 0 notes ✔

── future.apply 1.9.0-9004: OK

  Build ID:   future.apply_1.9.0-9004.tar.gz-78cf51cb9b9d489a9afb985fa9d51061
  Platform:   Debian Linux, R-patched, GCC
  Submitted:  12m 26.3s ago
  Build time: 11m 32.8s

0 errors ✔ | 0 warnings ✔ | 0 notes ✔

── future.apply 1.9.0-9004: WARNING

  Build ID:   future.apply_1.9.0-9004.tar.gz-c3d32edbafb34ebaadb9851af720bbf1
  Platform:   macOS 10.13.6 High Sierra, R-release, CRAN's setup
  Submitted:  12m 26.3s ago
  Build time: 4m 13.1s

❯ checking whether package ‘future.apply’ can be installed ... WARNING
  Found the following significant warnings:
  Warning: package ‘future’ was built under R version 4.1.2

0 errors ✔ | 1 warning ✖ | 0 notes ✔

── future.apply 1.9.0-9004: OK

  Build ID:   future.apply_1.9.0-9004.tar.gz-267589050b534fb7acc0e28127765adb
  Platform:   Apple Silicon (M1), macOS 11.6 Big Sur, R-release
  Submitted:  12m 26.3s ago
  Build time: 2m 8.7s

0 errors ✔ | 0 warnings ✔ | 0 notes ✔

── future.apply 1.9.0-9004: OK

  Build ID:   future.apply_1.9.0-9004.tar.gz-7d28c9d0787d4c208b46693b792d1d5a
  Platform:   Windows Server 2022, R-release, 32/64 bit
  Submitted:  12m 26.4s ago
  Build time: 10m 30.8s

0 errors ✔ | 0 warnings ✔ | 0 notes ✔
```
