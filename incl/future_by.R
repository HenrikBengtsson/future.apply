## ---------------------------------------------------------
## by()
## ---------------------------------------------------------
library(datasets) ## warpbreaks
library(stats)    ## lm()

y0 <- by(warpbreaks[, 1:2], warpbreaks[,"tension"], summary)
y1 <- by(warpbreaks[, 1],   warpbreaks[, -1],       summary)
y2 <- by(warpbreaks, warpbreaks[,"tension"],
         function(x) lm(breaks ~ wool, data = x))

## now suppose we want to extract the coefficients by group
tmp <- with(warpbreaks,
            by(warpbreaks, tension,
               function(x) lm(breaks ~ wool, data = x)))
y3 <- sapply(tmp, coef)


plan(multiprocess)

y0f <- future_by(warpbreaks[, 1:2], warpbreaks[,"tension"], summary)
y1f <- future_by(warpbreaks[, 1],   warpbreaks[, -1],       summary)
y2f <- future_by(warpbreaks, warpbreaks[,"tension"],
                 function(x) lm(breaks ~ wool, data = x))

## now suppose we want to extract the coefficients by group
tmp <- with(warpbreaks,
            future_by(warpbreaks, tension,
                      function(x) lm(breaks ~ wool, data = x)))
y3f <- sapply(tmp, coef)

stopifnot(all.equal(y0f, y0, check.attributes = FALSE))
stopifnot(all.equal(y1f, y1, check.attributes = FALSE))
stopifnot(all.equal(y2f, y2, check.attributes = FALSE))
stopifnot(all.equal(y3f, y3, check.attributes = FALSE))
