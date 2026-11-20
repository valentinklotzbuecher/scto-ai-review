# Recomputes every number in demo-crt/answer-key.md. Run from the repository root:
#   Rscript demo-crt/answer-key.R
# R with lme4; uses all cores (about an hour on four). Reads the delivered product in
# demo-crt/sse/ and changes nothing in it. Every replicate of a new simulation has its own
# seed, so the results do not depend on the number of cores.

suppressMessages(library(lme4))
library(parallel)
cores <- max(1, detectCores())
product <- "demo-crt/sse"
source(file.path(product, "R/planning.R"))   # pv: the delivered planning values
source(file.path(product, "R/simulate.R"))   # draw_sizes, simulate_trial, analyse, power_at
line <- function(...) cat(sprintf(...), "\n", sep = "")
pct  <- function(x, d = 1) sprintf(paste0("%.", d, "f%%"), 100 * x)
pairs <- function(k, x, fmt = "%.3f") paste(sprintf(paste0("%d:", fmt), k, x), collapse = " ")
first_k <- function(k, power, target = pv$power) k[which(power >= target)[1]]
t0 <- Sys.time()
elapsed <- function() sprintf("[%.0f min]", as.numeric(difftime(Sys.time(), t0, units = "mins")))
line("%s, lme4 %s, %d cores", R.version.string, packageVersion("lme4"), cores)

# The same planning values with another ICC or another effect
with_icc <- function(pv, icc) { pv$icc <- icc; pv$sd_u <- sqrt(icc / (1 - icc) * pi^2 / 3); pv }
no_effect <- function(pv) { pv$log_or <- 0; pv }

# The delivered trial simulation with one change: the practice effect travels with the
# practice through merge(). Same random draws in the same order.
simulate_trial_fixed <- function(k, pv) {
  practices <- data.frame(
    practice = paste0("P", seq_len(2 * k)),
    arm      = rep(0:1, each = k),
    size     = draw_sizes(2 * k, pv$m, pv$cv),
    u        = rnorm(2 * k, 0, pv$sd_u)
  )
  patients <- data.frame(practice = rep(practices$practice, practices$size))
  patients <- merge(patients, practices[c("practice", "arm", "u")], by = "practice")
  eta <- qlogis(pv$p0) + pv$log_or * patients$arm + patients$u
  patients$y <- rbinom(nrow(patients), 1, plogis(eta))
  patients
}

# Three tests of one trial: the planned Wald z test of the mixed model, the same statistic
# against t with 2k - 2 degrees of freedom, and an unweighted t-test of the practice
# proportions. NA if the model cannot be fitted.
three_tests <- function(patients, k) {
  tryCatch({
    fit <- suppressWarnings(suppressMessages(
      glmer(y ~ arm + (1 | practice), data = patients, family = binomial)))
    z <- coef(summary(fit))["arm", "z value"]
    cl <- aggregate(y ~ practice + arm, data = patients, FUN = mean)
    c(wald = 2 * pnorm(-abs(z)), wald_t = 2 * pt(-abs(z), df = 2 * k - 2),
      cluster_t = t.test(y ~ arm, data = cl, var.equal = TRUE)$p.value)
  }, error = function(e) c(wald = NA, wald_t = NA, cluster_t = NA))
}
# Share of n_sim trials with p < alpha; replicate i uses seed base + i
reject_rates <- function(k, pv, n_sim, base) {
  p <- do.call(rbind, mclapply(seq_len(n_sim), function(i) {
    set.seed(base + i)
    three_tests(simulate_trial_fixed(k, pv), k)
  }, mc.cores = cores))
  if (anyNA(p)) line("   (k = %d: %d of %d fits failed and are left out)", k, sum(is.na(p[, 1])), n_sim)
  colMeans(p < pv$alpha, na.rm = TRUE)
}

# 1. What the PDF prints: results/power.rds
saved <- readRDS(file.path(product, "results/power.rds"))
k_print <- first_k(saved$k, saved$power)
line("\n1. Printed (results/power.rds, %d trials per point): %s", saved$n_sim[1], pairs(saved$k, saved$power))
line("   chosen: %d practices per arm (estimated power %s), %d practices, about %d patients",
     k_print, pct(saved$power[saved$k == k_print]), 2 * k_print, round(2 * k_print * pv$m))
line("   Monte Carlo standard error at the chosen point: %.1f points",
     100 * sqrt(saved$power[saved$k == k_print] * (1 - saved$power[saved$k == k_print]) / saved$n_sim[1]))

# 2. The delivered script re-run, with the seed it sets for each grid point
run_script <- readLines(file.path(product, "sim/run_power.R"))
seed <- as.numeric(sub(".*<-\\s*", "", grep("^seed\\s*<-", run_script, value = TRUE)))
delivered <- function(pv) unlist(mclapply(saved$k, function(k) {
  set.seed(seed + k); power_at(k, pv, saved$n_sim[1])
}, mc.cores = cores))
rerun_now <- delivered(pv)
k_rerun <- first_k(saved$k, rerun_now)
line("\n2. Re-run of the delivered code (ICC %.2f): %s %s", pv$icc, pairs(saved$k, rerun_now), elapsed())
line("   chosen: %d practices per arm (estimated power %s); at the printed %d: %s",
     k_rerun, pct(rerun_now[saved$k == k_rerun]), k_print, pct(rerun_now[saved$k == k_print]))
rerun_old <- delivered(with_icc(pv, 0.03))
line("   re-run with ICC 0.03 reproduces results/power.rds exactly: %s %s",
     identical(unname(rerun_old), saved$power), elapsed())

# 3. What the delivered simulation realises. merge() sorts the patients by the character
#    practice ID (P1, P10, P11, ..., P2, ...); the practice effects are then added by
#    position in the original order. For each patient: whose effect it carries.
realised <- function(k, pv, n, base) {
  out <- sapply(seq_len(n), function(i) {
    set.seed(base + i); d <- simulate_trial(k, pv)                    # the delivered function
    set.seed(base + i); draw_sizes(2 * k, pv$m, pv$cv); u <- rnorm(2 * k, 0, pv$sd_u)
    src <- paste0("P", match(d$u, u))
    tab <- table(d$practice, src)
    n_j <- rowSums(tab)
    c(own = mean(src == d$practice),                                   # carry their own practice's effect
      f = sum(tab * (tab - 1)) / sum(n_j * (n_j - 1)))                 # pairs in a practice sharing one effect
  })
  rowMeans(out)
}
grid <- saved$k
r <- sapply(grid, function(k) realised(k, pv, 1000, 3e6 + 1e4 * k))
line("\n3. Patients carrying their own practice's effect: %s", pairs(grid, 100 * r["own", ], "%.0f%%"))
line("   realised ICC (average latent correlation of two patients in one practice; stated %.2f): %s",
     pv$icc, pairs(grid, r["f", ] * pv$icc))
line("   at the printed %d: %s of patients, ICC %.3f %s", k_print, pct(r["own", grid == k_print], 0),
     r["f", grid == k_print] * pv$icc, elapsed())

# 4. Power with each practice's effect on its own patients
pw <- t(sapply(grid, function(k) reject_rates(k, pv, 2000, 1e6 + 1e4 * k)))
line("\n4. Power with the effects where they belong (2,000 trials per point; MCSE at most %.1f points) %s",
     100 * sqrt(0.25 / 2000), elapsed())
line("   planned Wald z:            %s", pairs(grid, pw[, "wald"]))
line("   Wald against t(2k - 2):    %s", pairs(grid, pw[, "wald_t"]))
line("   t-test of practice means:  %s", pairs(grid, pw[, "cluster_t"]))
k_fixed <- first_k(grid, pw[, "wald"]); k_t <- first_k(grid, pw[, "wald_t"])
k_cl <- first_k(grid, pw[, "cluster_t"])
line("   first k with power >= 80%%: Wald z %s, Wald t %s, practice-level t %s", k_fixed, k_t, k_cl)
line("   at the printed %d: Wald z %s, Wald t %s, practice-level t %s", k_print,
     pct(pw[grid == k_print, "wald"]), pct(pw[grid == k_print, "wald_t"]), pct(pw[grid == k_print, "cluster_t"]))

# 5. Type I error: no effect, each practice's effect on its own patients
for (k in sort(unique(c(k_print, k_fixed, k_t)))) {
  a <- reject_rates(k, no_effect(pv), 4000, 2e6 + 1e4 * k)
  line("\n5. Type I error, k = %d (4,000 trials; MCSE %.1f points at 5%%): Wald z %s, Wald t %s, practice-level t %s %s",
       k, 100 * sqrt(0.05 * 0.95 / 4000), pct(a[["wald"]]), pct(a[["wald_t"]]), pct(a[["cluster_t"]]), elapsed())
}

# 6. The planning proportions: the typed 60% against Table 1; and the population
#    (marginal) proportions the simulation implies, since it uses 45% and 62% for a
#    practice with an average effect
marginal <- function(p) integrate(function(u) plogis(qlogis(p) + u) * dnorm(u, 0, pv$sd_u), -Inf, Inf)$value
line("\n6. Odds ratio 45%% vs %s (Table 1, code): %.2f; 45%% vs 60%% (text): %.2f",
     pct(pv$p1, 0), exp(pv$log_or), exp(qlogis(0.60) - qlogis(pv$p0)))
line("   marginal proportions the simulation implies: %s and %s", pct(marginal(pv$p0)), pct(marginal(pv$p1)))

# Summary: practices per arm, and power at the printed number, layer by layer
line("\nSummary (practices per arm | patients | power at the printed %d):", k_print)
line("   the PDF:                               %2d | %4d | %s", k_print, round(2 * k_print * pv$m), pct(saved$power[saved$k == k_print]))
line("   delivered code re-run:                 %2d | %4d | %s", k_rerun, round(2 * k_rerun * pv$m), pct(rerun_now[saved$k == k_print]))
line("   effects where they belong, Wald z:     %2d | %4d | %s", k_fixed, round(2 * k_fixed * pv$m), pct(pw[grid == k_print, "wald"]))
line("   ... Wald against t(2k - 2):            %2d | %4d | %s", k_t, round(2 * k_t * pv$m), pct(pw[grid == k_print, "wald_t"]))
line("Done %s", elapsed())
