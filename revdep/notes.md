# Notes

## Setup

```r
> options(Ncpus = 6L)
> install.packages("remotes")
> remotes::install_github("r-lib/revdepcheck")
```

```sh
## Used by R itself
$ revdep/run.R --preinstall RCurl XML
```


## Pre-installation

In order to run these checks successfully on a machine _without internet
access_, make sure to first populate the 'crancache' cache by pre-installing
all packages to be tested plus a few more.

```sh
$ module load jags; revdep/run.R --preinstall runjags

$ module load hdf5; revdep/run.R --preinstall hdf5r

$ module load geos; revdep/run.R --preinstall lwgeom

$ scl enable devtoolset-4 "revdep/run.R --preinstall blavaan"

$ scl enable devtoolset-4 "revdep/run.R --preinstall xgboost"

$ scl enable devtoolset-4 "revdep/run.R --preinstall rstanarm"

# WORKAROUND: https://github.com/pacificclimate/Rudunits2/issues/25
$ Rscript -e "crancache::install_packages('udunits2', configure.args='--with-udunits2-include=/usr/include/udunits2')"


## Update current crancache
$ revdep/run.R --preinstall-update

## All packages to be tested
$ revdep/run.R --preinstall-children
```


Is this why I'm getting the following error when install the 'stars' package on CentOS 7?

```sh
ldconfig -p | grep geos
        libgeos_c.so.1 (libc6,x86-64) => /lib64/libgeos_c.so.1
        libgeos_c.so (libc6,x86-64) => /lib64/libgeos_c.so
        libgeos-3.4.2.so (libc6,x86-64) => /lib64/libgeos-3.4.2.so
```

```r
$ R
R version 4.0.0 alpha (2020-04-03 r78148)
Copyright (C) 2020 The R Foundation for Statistical Computing
Platform: x86_64-pc-linux-gnu (64-bit)
...

> packageVersion("lwgeom")
[1] ‘0.2.1’

> install.packages("stars")
Installing package into ‘/wynton/home/cbi/hb/R/x86_64-pc-linux-gnu-library/4.0-CBI’
(as ‘lib’ is unspecified)
* installing *source* package ‘stars’ ...
** package ‘stars’ successfully unpacked and MD5 sums checked
** using staged installation
** R
** demo
** inst
** byte-compile and prepare package for lazy loading
Error in dyn.load(file, DLLpath = DLLpath, ...) : 
  unable to load shared object '/wynton/home/cbi/hb/R/x86_64-pc-linux-gnu-library/4.0-CBI/lwgeom/libs/lwgeom.so':
  /wynton/home/cbi/hb/R/x86_64-pc-linux-gnu-library/4.0-CBI/lwgeom/libs/lwgeom.so: undefined symbol: GEOSClipByRect
Calls: <Anonymous> ... asNamespace -> loadNamespace -> library.dynam -> dyn.load
** help
*** installing help indices
** building package indices
** installing vignettes
** testing if installed package can be loaded from temporary location
Error: package or namespace load failed for ‘stars’ in dyn.load(file, DLLpath = DLLpath, ...):
 unable to load shared object '/wynton/home/cbi/hb/R/x86_64-pc-linux-gnu-library/4.0-CBI/lwgeom/libs/lwgeom.so':
  /wynton/home/cbi/hb/R/x86_64-pc-linux-gnu-library/4.0-CBI/lwgeom/libs/lwgeom.so: undefined symbol: GEOSClipByRect
Error: loading failed
** testing if installed package can be loaded from final location
Error: package or namespace load failed for ‘stars’ in dyn.load(file, DLLpath = DLLpath, ...):
 unable to load shared object '/wynton/home/cbi/hb/R/x86_64-pc-linux-gnu-library/4.0-CBI/lwgeom/libs/lwgeom.so':
  /wynton/home/cbi/hb/R/x86_64-pc-linux-gnu-library/4.0-CBI/lwgeom/libs/lwgeom.so: undefined symbol: GEOSClipByRect
Error: loading failed
```

