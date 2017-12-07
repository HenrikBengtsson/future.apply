source("incl/start,load-only.R")

message("*** utils ...")

message("*** hpaste() ...")

# Some vectors
x <- 1:6
y <- 10:1
z <- LETTERS[x]

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Abbreviation of output vector
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
printf("x = %s.\n", hpaste(x))
## x = 1, 2, 3, ..., 6.

printf("x = %s.\n", hpaste(x, maxHead = 2))
## x = 1, 2, ..., 6.

printf("x = %s.\n", hpaste(x), maxHead = 3) # Default
## x = 1, 2, 3, ..., 6.

# It will never output 1, 2, 3, 4, ..., 6
printf("x = %s.\n", hpaste(x, maxHead = 4))
## x = 1, 2, 3, 4, 5 and 6.

# Showing the tail
printf("x = %s.\n", hpaste(x, maxHead = 1, maxTail = 2))
## x = 1, ..., 5, 6.

# Turning off abbreviation
printf("y = %s.\n", hpaste(y, maxHead = Inf))
## y = 10, 9, 8, 7, 6, 5, 4, 3, 2, 1

## ...or simply
printf("y = %s.\n", paste(y, collapse = ", "))
## y = 10, 9, 8, 7, 6, 5, 4, 3, 2, 1

# Change last separator
printf("x = %s.\n", hpaste(x, lastCollapse = " and "))
## x = 1, 2, 3, 4, 5 and 6.

# No collapse
stopifnot(all(hpaste(x, collapse = NULL) == x))

# Empty input
stopifnot(identical(hpaste(character(0)), character(0)))

message("*** hpaste() ...")


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# debug()
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
message("*** mdebug() ...")

mdebug("Hello #1")
options(future.debug = TRUE)
mdebug("Hello #2")
options(future.debug = FALSE)
mdebug("Hello #3")

message("*** mdebug() ... DONE")

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# import_from()
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
message("*** import_from() ...")

obj <- import_from("non-existing-fcn", default = NA, package = "future")
stopifnot(identical(obj, NA))

res <- tryCatch({
  obj <- import_from("non-existing-fcn", package = "future")
}, error = identity)
print(res)
stopifnot(inherits(res, "simpleError"))

message("*** import_from() ... DONE")


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Random seeds
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
message("*** Random seeds ...")

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

message("*** Random seeds ... DONE")


message("*** utils ... DONE")

source("incl/end.R")
