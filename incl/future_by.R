## ---------------------------------------------------------
## by()
## ---------------------------------------------------------
library(datasets) ## warpbreaks
library(stats)    ## lm()

y0 <- by(warpbreaks, warpbreaks[,"tension"],
         function(x) lm(breaks ~ wool, data = x))

plan(multisession)
y1 <- future_by(warpbreaks, warpbreaks[,"tension"],
                function(x) lm(breaks ~ wool, data = x))

plan(sequential)
y2 <- future_by(warpbreaks, warpbreaks[,"tension"],
                function(x) lm(breaks ~ wool, data = x))
