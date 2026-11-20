# Power by number of practices per arm, saved for the SSE (results/power.rds).
# Run from the product folder:  Rscript sim/run_power.R   (about half an hour)

library(lme4)
source("R/planning.R")
source("R/simulate.R")

grid  <- 6:16
n_sim <- 1000
seed  <- 20260904

# One seed per grid point, so that each point can be re-run on its own
power <- vapply(grid, function(k) {
  set.seed(seed + k)
  power_at(k, pv, n_sim)
}, numeric(1))

results <- data.frame(k = grid, power = power, n_sim = n_sim)
dir.create("results", showWarnings = FALSE)
saveRDS(results, "results/power.rds")
print(results)
