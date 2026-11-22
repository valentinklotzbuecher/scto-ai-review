# DEMO-CRT SSE: answer key

**Never copy this file, `answer-key.R` or anything else outside `demo-crt/sse/` into a
review job, a chat or a prompt, and never let an agent or a chat review the demo from
inside this repository.** A reviewer that can read this file can find the planted issues
without doing the review. (The review document in `tools/2-api/` sends only the `.qmd`
and PDF in its `to_be_reviewed/`.)

The demo SSE (`demo-crt/sse/`: `DEMO-CRT_SSE.qmd` and its rendered PDF, the planning
values in `R/planning.R`, the simulation in `R/simulate.R` and `sim/run_power.R`, and the
saved results in `results/power.rds`, which the document reads) contains four planted
issues: one visible in the rendered text, and three in the code and its results that
only running the code establishes or sizes. Every number below is recomputed by
`Rscript demo-crt/answer-key.R` (R with lme4; seeded; about 20 minutes on four cores).

## The four issues

| # | Level | Issue | Where |
|---|---|---|---|
| 1 | Text | The text expects 45% to 60%; Table 1 and the code plan for 62%, the smallest increase of clinical interest | Primary endpoint and estimand, last sentence; Table 1; `R/planning.R` |
| 2 | Computation | The saved results do not come from the delivered code: they were made with an ICC of 0.03 | `results/power.rds`, read by the `setup` chunk; `sim/run_power.R` |
| 3 | Code | The simulation puts the practice effects on the wrong patients, so it simulates a smaller ICC than stated | `R/simulate.R`, `simulate_trial()`: `merge()` re-sorts the patients; `rep(practices$u, practices$size)` assumes the original order |
| 4 | Computation | With this few practices, the planned Wald z test rejects too often when there is no effect | Analysis; `analyse()` in `R/simulate.R` takes the normal p-value, `Pr(>\|z\|)` |

### 1. 60% or 62% (text)

The estimand section expects the decision support "to raise guideline-concordant
prescribing from 45% to 60%". Table 1 gives 62% as the smallest increase of clinical
interest, and the code plans for 62% (`p1 = 0.62`): an odds ratio of 1.99, against 1.83
for 60%. Either the sentence is out of date, or the effect expected is smaller than the
smallest of interest and the trial is planned for an effect larger than the one
expected. This is the control: a careful reading finds it.

### 2. Saved results the code does not reproduce (computation)

The document runs no simulation; its `setup` chunk reads `results/power.rds`. Re-running
`sim/run_power.R` with the delivered planning values (ICC 0.05), with the seed it sets for
each grid point (1,000 trials per point):

| Practices per arm | 6 | 7 | 8 | 9 | 10 | 11 | 12 | 13 | 14 | 15 | 16 |
|---|---|---|---|---|---|---|---|---|---|---|---|
| Saved, printed | 0.724 | 0.766 | **0.810** | 0.835 | 0.878 | 0.904 | 0.929 | 0.946 | 0.959 | 0.969 | 0.975 |
| Re-run | 0.642 | 0.715 | 0.760 | 0.768 | **0.829** | 0.856 | 0.887 | 0.893 | 0.911 | 0.935 | 0.937 |

The first point with at least 80% is 10 practices per arm (82.9%), not 8, and at 8 the
re-run estimates 76.0%. With `icc = 0.03` in `R/planning.R`, the delivered code
reproduces the saved file exactly, point by point: the results were made with an earlier
ICC and not re-run when it became 0.05. The text, Table 1 and the code all say 0.05; only
a re-run shows the difference. One grid point is enough, since the seed is set per point
(`set.seed(seed + k)`).

### 3. Practice effects on the wrong patients (code)

`merge()` returns the patients sorted by practice ID as text (P1, P10, P11, …, P2, P3, …);
`rep(practices$u, practices$size)` then hands out the practice effects by position, in
the original order (P1, P2, …). The arm comes through `merge()` and is right; the
practice effect does not. At 8 practices per arm, 6% of patients carry their own
practice's effect (3% to 10% across the grid), and two patients of one practice have a
latent correlation of 0.030 on average instead of 0.05 (0.029 to 0.030 across the grid;
1,000 simulated trials per point). With nine practices or fewer, text order and numeric
order agree and the code is right; the grid starts at 12.

That the code realises about the 0.03 the saved results were made with is a
coincidence. The two issues are separate: the saved results come from `icc = 0.03` in
the planning values, which the code then reduces to 0.018.

With each practice's effect on its own patients (2,000 trials per point; Monte Carlo
standard error at most 1.1 points), the planned Wald test reaches 80% at 12 practices per
arm (83.7%), and at 8 per arm its power is 68.2%. Reading `R/simulate.R` can find the
misalignment; how much it matters takes a run.

### 4. The Wald test with few practices (computation)

The analysis tests the intervention with the Wald z test of the mixed model, which
refers the estimate over its standard error to the normal distribution, as if the
variance of the practice effects were known. With no effect and each practice's effect
on its own patients (4,000 trials each; Monte Carlo standard error 0.3 points at 5%):

| Type I error | 8 per arm | 12 per arm | 14 per arm |
|---|---|---|---|
| Wald z, as planned | 8.8% | 7.7% | 7.5% |
| The same statistic against t with 2k − 2 degrees of freedom | 6.1% | 6.1% | 6.0% |
| t-test of the practice proportions | 4.9% | 5.1% | 4.7% |

The t reference brings the error down but not to 5%; the t-test of the practice
proportions keeps it, at a price in power:

| Power with the effects on the right patients | 8 per arm | First with 80% |
|---|---|---|
| Wald z, as planned | 68.2% | 12 per arm (83.7%) |
| Wald against t(2k − 2) | 62.8% | 12 per arm (81.4%) |
| t-test of the practice proportions | 55.5% | 14 per arm (80.7%) |

## What the planning values support

| | Practices per arm | Patients | Power at 8 per arm |
|---|---|---|---|
| The PDF (the saved results) | 8 | 448 | 81.0% |
| The delivered code, re-run | 10 | 560 | 76.0% |
| Each practice's effect on its own patients, Wald z as planned | 12 | 672 | 68.2% |
| … and a test that keeps 5% (t-test of the practice proportions) | 14 | 784 | 55.5% |

Every row below the first needs the code run. The planning values support 12 practices
per arm with the planned test, whose type I error is then 7.7%, and 14 per arm with a
test that keeps the stated 5%: 24 to 28 practices and about 672 to 784 patients, against
the SSE's 16 practices and 448 patients. As planned, the trial has 55.5% power with a
test that keeps 5%.

## What a reading can estimate

Without running anything, a reviewer can inflate the individually randomised sample size
(133.9 patients per arm for 45% against 62%) by the design effect for practices of
varying size, 1 + ((cv² + 1) m − 1) ICC. With the ICC of 0.05 taken as stated, the
design effect is 2.85 and the trial needs 14 practices per arm; with the ICC converted
to the proportion scale (0.040), 2.47 and 12 per arm. Either way the printed 8 is too few,
but a reading cannot say where it comes from: the saved results, the simulation or the
test.

## Expected findings that were not planted

A thorough review will also report these; they are valid findings, not false alarms:

- the sources of the planning values (network audit, pilot study, steering committee)
  are named but not provided;
- the ICC comes from a pilot study in 12 practices and is imprecise; there is no
  sensitivity analysis for it, or for the size of the practices and its variation;
- no allowance for practices that withdraw or recruit fewer patients than planned;
- the number chosen is the first grid point whose estimate reaches 80%, with a Monte
  Carlo standard error of 1.2 points there;
- the simulation uses 45% and 62% as the probabilities in a practice with an average
  effect, while an audit gives a population proportion; at this ICC they correspond to
  population proportions of 45.2% and 61.5%, a negligible difference;
- the Software section prints the versions of R and lme4 at rendering, not those of the
  simulation run;
- messages from the model fit are suppressed (`suppressMessages()`), so singular fits go
  unreported, and warnings are suppressed for the whole document.

## Scoring

An issue counts as **found** when the review names the problem and where it is: for
issue 1 that the text's 60% disagrees with Table 1 or the code (62%); for issue 2 that the
saved results do not reproduce from the delivered code, or that they were made with
other planning values; for issue 3 that the practice effects do not match the patients
after `merge()`, or that the simulation realises a smaller ICC than stated; for issue 4
that the Wald z test rejects too often with this number of practices, or that it needs a
small-sample correction for that reason. Record **partly** when the review points at the
right place without stating the problem: for issue 2 that the saved results were not, or
could not be, checked against the code, or that the printed number looks too small by an
approximation such as the design effect; for issue 3 a doubt about how the code builds
the patients or their practice effects; for issue 4 that 16 practices are few, without
the test. A problem the review lists as a lead, a question or a point for a later code
review counts like a finding. Other findings are scored valid or invalid by the human
reviewer.

An issue found is also **sized** when the review states its consequence within 1
practice per arm, 3 percentage points of power, 1.5 points of type I error or 0.01 of
ICC of this key. Sized counts are out of 3:

| # | Sized when the review states |
|---|---|
| 1 | not sized: which value was agreed is a question for the investigators |
| 2 | what the delivered code gives when re-run: 10 practices per arm, or 76% power at 8 per arm |
| 3 | the ICC the simulation realises (0.03), or what the code gives with the practice effects on the right patients, for any of the three tests in issue 4: 12, 12 or 14 practices per arm, or 68%, 63% or 56% power at 8 per arm |
| 4 | the type I error of the planned Wald test (8.8% at 8 per arm, 7.7% at 12), or what a test that keeps 5% needs: 14 practices per arm, or its power at 8 per arm (56%) |
