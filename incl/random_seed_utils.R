## This example gives identical results in the two
## approaches only if .Random.seed already exists
seed_org <- next_random_seed()
set.seed(42)

## Draw two random number from 1:100 one after the other
seed_before <- get_random_seed()
x <- sample.int(100L, size = 1L)
y <- sample.int(100L, size = 1L)
seed_after <- get_random_seed()
print(c(x, y))

## Draw two random number from 1:100 at once
set_random_seed(seed_before)
z <- sample.int(100L, size = 2L)
seed_after2 <- get_random_seed()
print(z)

## The RNG state is the same after the second ...
## run as after the first, two-step, approach
stopifnot(identical(seed_after2, seed_after))

## .... and the exact same set of random numbers where
## drawn [only true in R (>= 4.0.0)]
if (getRversion() >= "4.0.0") {
  stopifnot(identical(z, c(x, y)))
} else {
  stopifnot(identical(z[seq_along(x)], x))
}

set_random_seed(seed_org)
stopifnot(identical(get_random_seed(), seed_org))
