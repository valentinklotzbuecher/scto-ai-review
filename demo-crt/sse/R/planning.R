# Planning values for the DEMO-CRT sample size estimation (Table 1 of the SSE).

pv <- list(
  p0    = 0.45,  # guideline-concordant prescribing with usual care
  p1    = 0.62,  # with decision support, in a practice with an average practice effect
  icc   = 0.05,  # intracluster correlation on the logit scale
  m     = 28,    # eligible patients per practice in the 6-month observation period, mean
  cv    = 0.6,   # coefficient of variation of the number of eligible patients per practice
  alpha = 0.05,  # two-sided
  power = 0.80
)

# The same values on the scale of the logistic mixed model
pv$log_or <- qlogis(pv$p1) - qlogis(pv$p0)
pv$sd_u   <- sqrt(pv$icc / (1 - pv$icc) * pi^2 / 3)
