# Simulation of one DEMO-CRT trial and its primary analysis.

# Eligible patients per practice: gamma with mean m and coefficient of variation cv,
# rounded, at least 5
draw_sizes <- function(n, m, cv) {
  pmax(5, round(rgamma(n, shape = 1 / cv^2, scale = m * cv^2)))
}

# One trial with k practices per arm: practice sizes and practice effects, then one
# outcome per patient from the logistic model
simulate_trial <- function(k, pv) {
  practices <- data.frame(
    practice = paste0("P", seq_len(2 * k)),
    arm      = rep(0:1, each = k),
    size     = draw_sizes(2 * k, pv$m, pv$cv),
    u        = rnorm(2 * k, 0, pv$sd_u)
  )
  patients <- data.frame(practice = rep(practices$practice, practices$size))
  patients <- merge(patients, practices[c("practice", "arm")], by = "practice")
  patients$u <- rep(practices$u, practices$size)
  eta <- qlogis(pv$p0) + pv$log_or * patients$arm + patients$u
  patients$y <- rbinom(nrow(patients), 1, plogis(eta))
  patients
}

# The primary analysis: logistic mixed model with a random intercept for practice,
# Wald test of the intervention effect
analyse <- function(patients) {
  fit <- suppressMessages(
    glmer(y ~ arm + (1 | practice), data = patients, family = binomial)
  )
  coef(summary(fit))["arm", "Pr(>|z|)"]
}

# Power with k practices per arm: the share of n_sim simulated trials with p < alpha
power_at <- function(k, pv, n_sim) {
  p <- vapply(seq_len(n_sim), function(i) analyse(simulate_trial(k, pv)), numeric(1))
  mean(p < pv$alpha)
}
