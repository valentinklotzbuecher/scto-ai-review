# DEMO-TKA SSE: answer key

**Never copy this file, `answer-key.R` or anything else outside `demo/sse/` into a review
job, a chat or a prompt, and never let an agent or a chat review the demo from inside this
repository.** A reviewer that can read this file can find the planted issues without
doing the review. (The API starters in `tools/3-api/` send only the files named on their
command line.)

The demo SSE (`demo/sse/DEMO-TKA_SSE.qmd` and its rendered PDF) contains six planted
issues: two visible in the rendered text, two visible only in the source code, and two
that need a calculation or a re-run to establish. Every number below is recomputed by
`Rscript demo/answer-key.R` (base R; seeded; about a minute).

## The six issues

| # | Level | Issue | Where |
|---|---|---|---|
| 1 | Text | Dropout inflation multiplies by 1.2 instead of dividing by 0.8 | Sample size, last paragraph |
| 2 | Text | The estimand names no intercurrent events and no strategies for them | Primary endpoint and estimand |
| 3 | Code | The simulation tests one-sided; the text and Table 1 state a two-sided 5% level | `simulate-power` chunk: `pt(t_arm, ..., lower.tail = FALSE) < alpha` |
| 4 | Code | The baseline–outcome correlation that drives the ANCOVA gain appears only in the code, unstated and unsourced | `setup` chunk: `rho <- 0.5`; absent from the text and Table 1 |
| 5 | Computation | Figure 1 plots a running maximum of noisy estimates, and the sample size is the first grid point where that maximum crosses 80% | `simulate-power` chunk: `cummax(power_raw)` and `which(power_curve >= target)[1]` |
| 6 | Computation | The typed *t*-test comparison (94 per group) is not what the code computes (105) | Sample size, second-last paragraph; `ttest-comparison` chunk |

### 1. Dropout inflation (text)

The SSE randomises 55 × 1.2 = 66 per group (132 in total). Inflating for 20% loss to
follow-up divides by 0.8: 55 / 0.8 = 68.75, so 69 per group (138 in total). As written,
the trial expects 66 × 0.8 = 52.8 evaluable participants per group, fewer than the 55
the calculation requires.

### 2. Estimand without intercurrent events (text)

The estimand names population, treatment conditions, variable and summary measure, but
no intercurrent events (for example revision surgery, discontinuation of the exercise
programme, contralateral knee arthroplasty, death) and no strategy for any of them, as
ICH E9(R1) requires. "All randomised participants are analysed in the group to which
they were allocated" is an analysis-set statement, not a strategy.

### 3. One-sided test in the simulation (code)

`pt(t_arm, df = fit$df.residual, lower.tail = FALSE) < alpha` with `alpha <- 0.05` is a
one-sided test at 5%, roughly a two-sided test at 10%. At 55 per group the power of the
two-sided test the text states is 64.2% (exact; 64.3% in 20,000 simulated trials), not
at least 80%.

### 4. The unstated correlation (code)

`rho <- 0.5` sets the correlation between baseline and 6-month 6MWD. It determines how
much the ANCOVA gains over an unadjusted comparison, yet the text never states it and
gives no source. The two-sided sample size per group for 80% power:

| Correlation | 0 | 0.3 | 0.5 | 0.7 |
|---|---|---|---|---|
| Evaluable per group | 106 | 96 | 80 | 55 |

55 per group give 80% power only from a correlation of 0.696 (0.585 with the code's
one-sided test).

### 5. Running maximum and first crossing on noise (computation)

The raw estimates at 55, 60 and 65 per group are 81.5%, 77.0% and 79.0%. `cummax()`
turns them into a flat 81.5%, so Figure 1 shows a curve that was never simulated, and the
first crossing of 80% is selected on Monte Carlo noise: with 200 trials per point the
Monte Carlo standard error at 80% is 2.8 percentage points. Even with the code's own
one-sided test, the power at 55 per group is 75.3% (exact; 75.6% in 20,000 simulated
trials); the one-sided test would need 63 per group.

Raw estimates by sample size per group (seed 20260108, 200 trials each):

| n | 40 | 45 | 50 | 55 | 60 | 65 | 70 | 75 | 80 | 85 | 90 | 95 | 100 |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| Raw | 0.635 | 0.680 | 0.655 | 0.815 | 0.770 | 0.790 | 0.860 | 0.895 | 0.855 | 0.890 | 0.920 | 0.935 | 0.950 |
| Plotted | 0.635 | 0.680 | 0.680 | 0.815 | 0.815 | 0.815 | 0.860 | 0.895 | 0.895 | 0.895 | 0.920 | 0.935 | 0.950 |

### 6. Stale typed number (computation)

The text says an unadjusted two-sample *t*-test would require 94 participants per group.
The `ttest-comparison` chunk computes `power.t.test(delta = 35, sd = 90, power = 0.8)`:
104.8, so 105 per group. 94 is what an SD of 85 m gives (93.6), so the sentence was
typed for an earlier SD and never updated. The value is computed but never printed, so
only running the code, or doing the calculation, shows the mismatch.

## What the planning values support

With the stated two-sided 5% level, the ANCOVA needs 79.3, so 80 evaluable participants
per group (exact power 79.8% at 79 and 80.3% at 80; 20,000 simulated trials give 79.7%
at 80, with a standard error of 0.3 points, too few to separate 79 from 80). With 20%
loss to follow-up: 80 / 0.8 = **100 per group, 200 in total**, against the SSE's
**132**. As planned (66 randomised and about 52.8 evaluable per group), the trial has
about **62%** power for the two-sided test.

Exact power here treats the baseline as random, as the SSE simulates it: the chance
difference in baseline means between the arms costs about half a participant per group.
The first version of this key treated the baseline as fixed and gave 79 per group (198
in total). The agent's review of 31 October 2026 used the random-baseline power and was
right (`runs/2026-10-31_agent/`).

## Expected findings that were not planted

A thorough review will also report these; they are valid findings, not false alarms:

- the sources for the planning values (steering-committee minutes, registry report)
  are named but not provided, so the values cannot be checked;
- no sensitivity analysis for the SD, the correlation or the dropout rate;
- the handling of missing data is deferred to the statistical analysis plan;
- warnings are suppressed for the whole document (`warning: false`).

## Scoring

An issue counts as **found** when the review names the problem and where it is: for
issue 3 the one-sided test against the stated two-sided level; for issue 4 that the
correlation is unstated or unsourced; for issue 5 the running maximum, or the selection
of the first crossing on Monte Carlo noise, or the power at 55 being below 80% when
re-estimated; for issue 6 that 94 disagrees with the code or with the planning values.
Record **partly** when the review points at the right place without stating the problem,
and **missed** otherwise. A problem the review lists as a lead, a question or a point
for a later code review counts like a finding. Other findings are scored valid or
invalid by the human reviewer.

An issue found is also **sized** when the review states its consequence in participants
or power, within 3 per group or 3 percentage points of this key (exact values, or
simulated values with their Monte Carlo error). Sized counts are out of 5:

| # | Sized when the review states |
|---|---|
| 1 | the evaluable number the planned randomisation leaves (52.8 per group), or the correctly inflated number randomised (69 per group for 55 evaluable, 100 for 80) |
| 2 | not sized: the estimand has no number |
| 3 | the power of the stated two-sided test at 55 per group (64%), or the evaluable number it needs (80 per group) |
| 4 | the number needed at another correlation (106, 96, 80 or 55 per group at 0, 0.3, 0.5 or 0.7), or the correlation that 55 per group needs (0.70) |
| 5 | the power at 55 per group under the code's own one-sided test (75%), the number that test needs (63 per group), or the Monte Carlo error of a 200-trial estimate (2.8 points) |
| 6 | the number per group the planning values give for the *t*-test (105) |
