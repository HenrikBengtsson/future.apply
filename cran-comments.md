# CRAN submission future.apply 1.11.2

on 2024-03-27

## Notes not sent to CRAN

### R CMD check validation

The package has been verified using `R CMD check --as-cran` on:

| R version     | GitHub | R-hub | mac/win-builder |
| ------------- | ------ | ----- | --------------- |
| 3.5.x         | L      |       |                 |
| 4.1.x         | L      |       |                 |
| 4.2.x         | L M W  |       |                 |
| 4.3.x         | L M .  | .   . | M1 W            |
| devel         | L M .  | .     |    .            |

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

Skipped.
