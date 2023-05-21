# CRAN submission future.apply 1.11.0

on 2023-05-20

I've verified this submission has no negative impact on any of the 123 reverse package dependencies available on CRAN (n=116) and Bioconductor (n=7).

Thanks in advance


## Notes not sent to CRAN

### R CMD check validation

The package has been verified using `R CMD check --as-cran` on:

| R version     | GitHub | R-hub  | mac/win-builder |
| ------------- | ------ | ------ | --------------- |
| 3.4.x         | L      |        |                 |
| 4.1.x         | L      |   M    |                 |
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
  "macos-highsierra-release-cran",
  "windows-x86_64-release"
))
print(res)
```

gives

```
── future.apply 1.10.0-9013: OK

  Build ID:   future.apply_1.10.0-9013.tar.gz-7fc791c13574489cb7d7d255f17e3b33
  Platform:   Debian Linux, R-devel, clang, ISO-8859-15 locale
  Submitted:  10m 9.6s ago
  Build time: 10m 5s

0 errors ✔ | 0 warnings ✔ | 0 notes ✔

── future.apply 1.10.0-9013: OK

  Build ID:   future.apply_1.10.0-9013.tar.gz-c06bf90077fd45ac804e95ff46a51878
  Platform:   Debian Linux, R-patched, GCC
  Submitted:  10m 9.6s ago
  Build time: 9m 33s

0 errors ✔ | 0 warnings ✔ | 0 notes ✔

── future.apply 1.10.0-9013: OK

  Build ID:   future.apply_1.10.0-9013.tar.gz-292df8a7afff46d6ac3895820d235f3e
  Platform:   Fedora Linux, R-devel, GCC
  Submitted:  10m 9.6s ago
  Build time: 7m 9.4s

0 errors ✔ | 0 warnings ✔ | 0 notes ✔

── future.apply 1.10.0-9013: WARNING

  Build ID:   future.apply_1.10.0-9013.tar.gz-8af8f302fb9745ea8d44f41629d76f29
  Platform:   macOS 10.13.6 High Sierra, R-release, CRAN's setup
  Submitted:  10m 9.6s ago
  Build time: 5m 18.4s

❯ checking whether package ‘future.apply’ can be installed ... WARNING
  See below...

0 errors ✔ | 1 warning ✖ | 0 notes ✔

── future.apply 1.10.0-9013: OK

  Build ID:   future.apply_1.10.0-9013.tar.gz-8f95855655754be6b640681d0c8ef60f
  Platform:   Windows Server 2022, R-release, 32/64 bit
  Submitted:  10m 9.6s ago
  Build time: 4m 33.5s

0 errors ✔ | 0 warnings ✔ | 0 notes ✔
```
