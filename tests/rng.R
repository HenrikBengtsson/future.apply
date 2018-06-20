source("incl/start,load-only.R")

message("*** RNG ...")

set_random_seed(seed = NULL)
seed <- get_random_seed()
stopifnot(is.null(seed))

set_random_seed(seed = 42L)
seed <- get_random_seed()
stopifnot(identical(seed, 42L))

res <- tryCatch({
  seed <- as_lecyer_cmrg_seed(seed = FALSE)
}, error = identity)
print(res)
stopifnot(inherits(res, "simpleError"))

seed <- as_lecyer_cmrg_seed(seed = 42L)
str(seed)
set_random_seed(seed = seed)
stopifnot(identical(get_random_seed(), seed))

seed2 <- as_lecyer_cmrg_seed(seed = TRUE)
str(seed2)
stopifnot(identical(seed2, seed))

seed3 <- as_lecyer_cmrg_seed(seed = seed)
str(seed3)
stopifnot(identical(seed3, seed))


message(" - make_rng_seeds ...")

seeds <- make_rng_seeds(2L, seed = FALSE)
stopifnot(is.null(seeds))

seeds <- make_rng_seeds(0L, seed = 42L, debug = TRUE)
stopifnot(length(seeds) == 0L, identical(seeds, list()))

seeds <- make_rng_seeds(2L, seed = TRUE)
stopifnot(length(seeds) == 2L, all(sapply(seeds, FUN = is_lecyer_cmrg_seed)))

seeds <- make_rng_seeds(3L, seed = 42L)
stopifnot(length(seeds) == 3L, all(sapply(seeds, FUN = is_lecyer_cmrg_seed)))

seeds <- make_rng_seeds(1L, seed = 42L, debug = TRUE)
stopifnot(length(seeds) == 1L, all(sapply(seeds, FUN = is_lecyer_cmrg_seed)))

seeds0 <- lapply(1:3, FUN = as_lecyer_cmrg_seed)
seeds <- make_rng_seeds(length(seeds0), seed = seeds0, debug = TRUE)
stopifnot(length(seeds) == length(seeds0),
          all(sapply(seeds, FUN = is_lecyer_cmrg_seed)))


message(" - exceptions ...")

## Invalid L'Ecuyer seed
seed_invalid <- seed + 1L
res <- tryCatch({
  seed <- as_lecyer_cmrg_seed(seed = seed_invalid)
}, error = identity)
print(res)
stopifnot(inherits(res, "simpleError"))

## Invalid seed
res <- tryCatch({
  seed <- as_lecyer_cmrg_seed(seed = 1:2)
}, error = identity)
print(res)
stopifnot(inherits(res, "simpleError"))

## Invalid length
seeds0 <- lapply(1:2, FUN = as_lecyer_cmrg_seed)
res <- tryCatch({
  seeds <- make_rng_seeds(1L, seed = seeds0)
}, error = identity)
print(res)
stopifnot(inherits(res, "simpleError"))

message("*** RNG ... DONE")

source("incl/end.R")
