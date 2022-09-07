## Set up L'Ecuyer-CMRG random seeds for 100 parallel tasks
## based on .Random.seed in the current R process
seeds <- make_rng_seeds(100L, seed = TRUE)
str(seeds)
