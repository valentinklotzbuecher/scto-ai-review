# Recomputes every number in answer-key.md. Run from the repository root:
#   Rscript demo/answer-key.R
# Base R only. The simulation function and planning values are copied unchanged
# from demo/sse/DEMO-TKA_SSE.qmd, except for the `sided` argument.

delta <- 35; sd_y <- 90; rho <- 0.5; alpha <- 0.05; target <- 0.80; dropout <- 0.20

simulate_power <- function(n, n_sim = 200, sided = 1) {
  rejected <- logical(n_sim)
  for (i in seq_len(n_sim)) {
    arm      <- rep(c(0, 1), each = n)
    baseline <- rnorm(2 * n, mean = 380, sd = sd_y)
    outcome  <- 430 + rho * (baseline - 380) + delta * arm +
                rnorm(2 * n, sd = sd_y * sqrt(1 - rho^2))
    fit   <- lm(outcome ~ arm + baseline)
    t_arm <- coef(summary(fit))["arm", "t value"]
    p <- if (sided == 1) pt(t_arm, fit$df.residual, lower.tail = FALSE)
         else 2 * pt(-abs(t_arm), fit$df.residual)
    rejected[i] <- p < alpha
  }
  mean(rejected)
}

# Exact ANCOVA power, given the planning values. The baseline is random, as the SSE
# simulates it: given the baseline values, the t statistic is non-central t with
# non-centrality lambda0 * sqrt(1 - B), where B ~ Beta(1/2, n - 1) comes from the chance
# difference in baseline means between the arms. (Treating the baseline as fixed,
# lambda0 alone, overstates power: 80.1% instead of 79.8% at 79 per group.)
ancova_power <- function(n, sided = 2, r = rho) {
  df <- 2 * n - 3; tc <- qt(1 - alpha / sided, df)
  lam0 <- delta / (sd_y * sqrt(1 - r^2) * sqrt(2 / n))
  given <- function(lam) 1 - pt(tc, df, lam) + (sided == 2) * pt(-tc, df, lam)
  # B = u^2, so that the integrand has no singularity at 0
  integrate(function(u) given(lam0 * sqrt(1 - u^2)) *
              2 * exp((n - 2) * log1p(-u^2) - lbeta(0.5, n - 1)),
            0, 1, rel.tol = 1e-10)$value
}
ancova_n <- function(sided = 2, r = rho)
  uniroot(function(n) ancova_power(n, sided, r) - target, c(5, 500), tol = 1e-8)$root

line <- function(...) cat(sprintf(...), "\n", sep = "")

# 1. The SSE as written (same seed, same code)
set.seed(20260108)
grid      <- seq(40, 100, by = 5)
power_raw <- vapply(grid, simulate_power, numeric(1))
line("SSE grid, raw estimates:   %s", paste(sprintf("%d:%.3f", grid, power_raw), collapse = " "))
line("SSE grid, running maximum: %s", paste(sprintf("%d:%.3f", grid, cummax(power_raw)), collapse = " "))
n_chosen <- grid[which(cummax(power_raw) >= target)[1]]
line("chosen n per group: %d; randomised as written: %d per group, %d total",
     n_chosen, ceiling(n_chosen * 1.2), 2 * ceiling(n_chosen * 1.2))
line("Monte Carlo SE at 80%% with 200 trials: %.1f percentage points", 100 * sqrt(0.8 * 0.2 / 200))

# 2. True power at the chosen n
set.seed(1)
line("power at n = %d, one-sided (the code's test): exact %.3f, 20,000 trials %.3f",
     n_chosen, ancova_power(n_chosen, 1), simulate_power(n_chosen, 20000, sided = 1))
set.seed(2)
line("power at n = %d, two-sided (the stated test): exact %.3f, 20,000 trials %.3f",
     n_chosen, ancova_power(n_chosen, 2), simulate_power(n_chosen, 20000, sided = 2))
line("as planned: %d randomised, %.1f evaluable per group, two-sided power %.3f",
     ceiling(n_chosen * 1.2), ceiling(n_chosen * 1.2) * (1 - dropout),
     ancova_power(ceiling(n_chosen * 1.2) * (1 - dropout), 2))

# 3. Dropout inflation
line("dropout: %d x 1.2 = %d (as written); %d / 0.8 = %.2f -> %d per group, %d total",
     n_chosen, ceiling(n_chosen * 1.2), n_chosen, n_chosen / 0.8,
     ceiling(n_chosen / 0.8), 2 * ceiling(n_chosen / 0.8))

# 4. The design the planning values support
n2 <- ancova_n(2); n_ok <- ceiling(n2)
set.seed(3)
line("two-sided ANCOVA: n = %.2f -> %d evaluable per group; exact power at %d: %.4f, at %d: %.4f",
     n2, n_ok, n_ok - 1, ancova_power(n_ok - 1, 2), n_ok, ancova_power(n_ok, 2))
p_sim <- simulate_power(n_ok, 20000, sided = 2)
line("  20,000 trials at %d: %.3f (Monte Carlo SE %.3f; too few to separate %d from %d)",
     n_ok, p_sim, sqrt(p_sim * (1 - p_sim) / 20000), n_ok - 1, n_ok)
fixed_power <- function(n) {  # the first version of this key: baseline fixed
  df <- 2 * n - 3
  1 - pt(qt(1 - alpha / 2, df), df, delta / (sd_y * sqrt(1 - rho^2) * sqrt(2 / n)))
}
n_fix <- uniroot(function(n) fixed_power(n) - target, c(5, 500), tol = 1e-8)$root
line("  baseline treated as fixed (first version of this key): n = %.2f -> %d; power at %d: %.4f",
     n_fix, ceiling(n_fix), n_ok - 1, fixed_power(n_ok - 1))
line("randomise %d / 0.8 = %.2f -> %d per group, %d total",
     n_ok, n_ok / 0.8, ceiling(n_ok / 0.8), 2 * ceiling(n_ok / 0.8))
line("one-sided ANCOVA (the code's test, infinite replicates): n = %.2f -> %d per group",
     ancova_n(1), ceiling(ancova_n(1)))

# 5. The unstated correlation drives the result
for (r in c(0, 0.3, 0.5, 0.7))
  line("rho = %.1f: two-sided n = %.1f -> %d per group", r, ancova_n(2, r), ceiling(ancova_n(2, r)))
line("correlation at which 55 per group give 80%%: two-sided %.3f, one-sided %.3f",
     uniroot(function(r) ancova_power(55, 2, r) - target, c(0, 0.9))$root,
     uniroot(function(r) ancova_power(55, 1, r) - target, c(0, 0.9))$root)

# 6. The typed t-test number
line("t-test: n = %.2f -> %d per group (typed: 94; SD 85 gives %.2f -> %d)",
     power.t.test(delta = delta, sd = sd_y, power = target)$n,
     ceiling(power.t.test(delta = delta, sd = sd_y, power = target)$n),
     power.t.test(delta = delta, sd = 85, power = target)$n,
     ceiling(power.t.test(delta = delta, sd = 85, power = target)$n))
