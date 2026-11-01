# Builds the slide figure power-figure.svg from the demo SSE's own simulation.
# Run from the repository root:  Rscript slides/assets/make-figures.R
# Base R only; colours validated for contrast and colour-vision deficiency
# (USB wine #9B233C, UniBas mint #1EA5A5, neutral greys).

delta <- 35; sd_y <- 90; rho <- 0.5; alpha <- 0.05; target <- 0.80

# The demo SSE's simulation, unchanged (one-sided test as coded)
simulate_power <- function(n, n_sim = 200) {
  rejected <- logical(n_sim)
  for (i in seq_len(n_sim)) {
    arm      <- rep(c(0, 1), each = n)
    baseline <- rnorm(2 * n, mean = 380, sd = sd_y)
    outcome  <- 430 + rho * (baseline - 380) + delta * arm +
                rnorm(2 * n, sd = sd_y * sqrt(1 - rho^2))
    fit   <- lm(outcome ~ arm + baseline)
    t_arm <- coef(summary(fit))["arm", "t value"]
    rejected[i] <- pt(t_arm, df = fit$df.residual, lower.tail = FALSE) < alpha
  }
  mean(rejected)
}
set.seed(20260108)
grid      <- seq(40, 100, by = 5)
power_raw <- vapply(grid, simulate_power, numeric(1))
plotted   <- cummax(power_raw)

# Exact power of the ANCOVA with a random baseline, as in demo/answer-key.R
ancova_power <- function(n, sided) {
  df <- 2 * n - 3; tc <- qt(1 - alpha / sided, df)
  lam0 <- delta / (sd_y * sqrt(1 - rho^2) * sqrt(2 / n))
  given <- function(lam) 1 - pt(tc, df, lam) + (sided == 2) * pt(-tc, df, lam)
  integrate(function(u) given(lam0 * sqrt(1 - u^2)) *
              2 * exp((n - 2) * log1p(-u^2) - lbeta(0.5, n - 1)),
            0, 1, rel.tol = 1e-10)$value
}
n_fine  <- seq(40, 100, by = 0.5)
true_1s <- vapply(n_fine, ancova_power, numeric(1), sided = 1)
true_2s <- vapply(n_fine, ancova_power, numeric(1), sided = 2)

wine <- "#9B233C"; mint <- "#1EA5A5"; grey <- "#8C8C8C"; ink <- "#333333"
muted <- "#666666"; grid_col <- "#E6E6E6"

out <- file.path(dirname(sub("--file=", "", grep("--file=", commandArgs(FALSE), value = TRUE))),
                 "power-figure.svg")
svg(out, width = 10, height = 5.2, pointsize = 15, bg = "white")
par(mar = c(3.6, 4.4, 0.6, 0.6), mgp = c(2.4, 0.7, 0), col.axis = muted, col.lab = ink,
    tcl = -0.3, lend = 1, ljoin = 1)
plot(NA, xlim = c(40, 100), ylim = c(0.5, 1), axes = FALSE,
     xlab = "Evaluable participants per group", ylab = "Power")
abline(h = seq(0.5, 1, by = 0.1), col = grid_col, lwd = 1)
abline(v = seq(40, 100, by = 10), col = grid_col, lwd = 1)
axis(1, at = seq(40, 100, by = 10), col = grid_col, col.ticks = grid_col)
axis(2, at = seq(0.5, 1, by = 0.1), labels = paste0(seq(50, 100, by = 10), "%"),
     las = 1, col = grid_col, col.ticks = grid_col)
abline(h = target, lty = 2, col = ink, lwd = 1.2)
text(100, target, "80% target", adj = c(1, -0.5), col = muted, cex = 0.85)

lines(n_fine, true_1s, col = grey, lwd = 2)
lines(n_fine, true_2s, col = mint, lwd = 2.6)
points(grid, power_raw, pch = 21, bg = "white", col = grey, cex = 1.15, lwd = 1.6)
lines(grid, plotted, col = wine, lwd = 2.6)
points(grid, plotted, pch = 21, bg = wine, col = "white", cex = 1.35, lwd = 1.5)

# Selective direct labels: the claim and the truth at the chosen n
i55 <- which(grid == 55)
points(55, ancova_power(55, 2), pch = 21, bg = mint, col = "white", cex = 1.6, lwd = 1.5)
text(55, plotted[i55], sprintf("SSE: %.1f%% at 55", 100 * plotted[i55]),
     pos = 2, offset = 0.7, col = ink, cex = 0.9)
text(55, ancova_power(55, 2), sprintf("as stated: %.0f%%", 100 * ancova_power(55, 2)),
     pos = 4, offset = 0.7, col = ink, cex = 0.9)
n80 <- uniroot(function(n) ancova_power(n, 2) - target, c(40, 100))$root
points(n80, target, pch = 21, bg = mint, col = "white", cex = 1.6, lwd = 1.5)
text(n80, target, sprintf("80%% needs %d", ceiling(n80)), pos = 1, offset = 0.9,
     col = ink, cex = 0.9)

legend("bottomright", bty = "n", cex = 0.85, text.col = ink, inset = c(0.01, 0.02),
       legend = c("Plotted in the SSE (running maximum)", "Simulated estimates, 200 trials each",
                  "True power, two-sided test (as stated)", "True power, one-sided test (as coded)"),
       col = c(wine, grey, mint, grey), lwd = c(2.6, NA, 2.6, 2), pch = c(21, 21, NA, NA),
       pt.bg = c(wine, "white", NA, NA), pt.cex = c(1.35, 1.15, NA, NA), pt.lwd = 1.5,
       seg.len = 1.8)
invisible(dev.off())
cat("wrote", out, "\n")
