# Synthesis — DEMO-TKA sample size estimation: app-guided home exercise versus supervised physiotherapy after total knee arthroplasty (DEMO-01, Version 1.0, 15 September 2026)

Verification: OPEN · 4 not established / 5 narrower / 4 hold

## Status

`COMPLETE` — depth `quick`: no challenge stage ran. Data mode `none`; the product
reads no data, so the data mode leaves nothing unverified. Unverified here: the sources
of the target effect, SD and loss rate, and the protocol (not provided; Limits).

## What the product establishes and what it does not

The calculation simulates the analysis the product plans, an ANCOVA of 6-month 6MWD on
arm and baseline 6MWD (DEMO-TKA_SSE.qmd:63). Design, allocation, endpoint, time point
and baseline are stated consistently wherever printed. The delivered source reproduces
every printed number exactly in R 4.3.3: 55 evaluable per group, estimated power 81.5%
(163 of 200 trials), 66 randomised per group, 132 in total, and all 13 points of
Figure 1 (work/results/inline-values.csv).

The sample size itself is not established. The simulation rejects one-sided at 5%
where Table 1 and the text state two-sided 5% (DEMO-TKA_SSE.qmd:65). At the stated
two-sided 5%, the printed planning values (35 m, SD 90 m, 80% power) and the
correlation of 0.5 the code assumes, an independent closed-form calculation needs 80
evaluable participants per group (power 80.3%; 78.8% ± 0.9 in an independent
simulation), and the printed 55 per group has 64.2% power
(work/logs/ss_ancova_recompute.log). The recomputation contradicts the statement that
55 gives at least 80% power: even under the code's one-sided rule power at 55 is 75.3%;
the printed 81.5% is a Monte Carlo high from 200 trials. The dropout allowance
multiplies (55 × 1.2 = 66) where dividing is needed: 66 randomised gives 52.8 expected
evaluable (62.3% power). For 80 evaluable, N / (1 − d) gives 100 per group, 200 in
total, against the printed 132.

All of this rests on a correlation of baseline and 6-month 6MWD that the product
neither prints nor sources: evaluable N runs from 96 to 55 per group as it runs from
0.3 to 0.7 (work/results/ss_sensitivity.csv).

The primary estimand holds only in narrower form: it names no intercurrent events or
strategies, and the evaluable-set calculation matches analysing all randomised
participants only if missing 6-month 6MWD is missing at random given baseline and arm,
which the product does not state.

## Cross-cutting findings

### G1. The target sample size understates what the stated design needs
bears on: ST01, ST02, ST03, ST04; Q1

Three slips compound at the product's values and a correlation of 0.5
(work/logs/ss_ancova_recompute.log 1a–1h; analysis/statements/driver-matrix.csv): the
first 200-trial crossing understates N by 8 under the code's one-sided rule (55 against
63; F3); one-sided instead of two-sided 5% costs 17 more (63 against 80; F1); the
multiplicative allowance leaves randomised N short (66 against 69 at 55; F4). Removes
the evaluable N, the randomised N and the stated test; narrows the 81.5% to an estimate
under the one-sided rule. Survives: 80 evaluable and 100 randomised per group, 200 in
total, conditional on the correlation (G2).

### G2. The decisive planning value is unstated and two others are not argued for this trial
bears on: ST07, ST05, ST06, ST01, ST08

The correlation N depends on most is in code only, unsourced (F2); 35 m is not argued
as a plausible superiority effect, and the 20% registry loss is applied to trial
follow-up without adaptation (F6). N per group moves 108 to 62 for 30 to 40 m, 63 to 98
for SD 80 to 100 m; randomised N for 80 evaluable 89 to 115 for 10% to 30% loss
(analysis/code-and-data/assumption-ledger.csv; work/results/ss_sensitivity.csv).
Removes the correlation; narrows 35 m, 90 m and 20% to values as cited. Survives: the
recomputed N, conditional on the stated values.

## Statement ledger

| Statement (location) | Kind | Centrality | Holds | Kernel | Not established | Strongest defence | Status |
|---|---|---|---|---|---|---|---|
| "The smallest sample size with at least 80% power is 55 evaluable participants per group (estimated power 81.5%)." (p. 2, Sample size; Figure 1; ST01) | calculation | primary | not established | 55 gives 64.2% power (75.3% one-sided); 80% needs 80 per group (63 one-sided), correlation 0.5. | At least 80% power at 55, at either sidedness. | Directional hypothesis; higher correlation. Failed: one-sided needs 63; no correlation supplied. | settled |
| "Allowing for 20% loss to follow-up, we will randomise 55 × 1.2 = 66 participants per group, 132 in total." (p. 2, Sample size; ST02) | calculation | primary | not established | 66 gives 52.8 evaluable; 55 needs 69 (138); 80 needs 100 per group, 200, by N / (1 − d). | That 66 per group (132) delivers the evaluable N. | N × (1 + d) is recognised. Failed: leaves 52.8 < 55. | settled |
| "Significance level 5%, two-sided"; "counted the trials in which the treatment effect was statistically significant at the two-sided 5% level" (Table 1, p. 1; Sample size, p. 1–2; ST03) | specification | primary | not established | Two-sided 5% is the plan; the simulation tests one-sided 5%. | Power computed for two-sided 5%. | One-sided was meant. Failed: text says two-sided twice; one-sided needs 63. | settled |
| "estimated power 81.5%"; Figure 1 caption "Estimated power by number of evaluable participants per group (200 simulated trials per sample size)." (p. 2, Sample size and Figure 1; ST04) | result | supporting | narrower | 163/200 under the one-sided rule; reproduced with all 13 points. | Power ≥ 80% at 55 (interval 76.1% to 86.9%); that Figure 1 shows estimates (running maximum). | Reproducible; shows stability, not correctness. | settled |
| Table 1: "Smallest difference of clinical interest", "35 m", "Agreed with the investigators (steering committee, 3 June 2026)" (Table 1, p. 1; ST05) | assumption | supporting | narrower | The investigators' threshold, as cited. | Minimal important difference or plausible superiority effect; argued in neither sense. | Set on clinical grounds; decision not provided. | unverified-here |
| Table 1: "SD of 6MWD at 6 months", "90 m"; "Loss to follow-up at 6 months", "20%"; both "Hospital TKA registry, 2019–2021 (internal report)" (Table 1, p. 1; ST06) | assumption | supporting | narrower | The values as cited. | That registry loss transports to trial follow-up; that the SD fits the trial population. | Same hospital and endpoint; report not provided. | unverified-here |
| [implicit] Power simulated "under the planning values in Table 1"; the correlation of baseline and 6-month 6MWD (0.5 in the code) is not printed (Sample size, p. 1–2; DEMO-TKA_SSE.qmd:45; ST07) | assumption | supporting | not established | None; the code uses 0.5 unsourced. | Any value or source (55 suffices only near 0.7; 0.3 needs 96). | A common default; shields nothing (not supplied). | unverifiable |
| "Because adjustment for baseline increases precision, we estimated power by simulation." "For comparison, an unadjusted two-sample t-test would require 94 participants per group." (Sample size, p. 1–2; ST08) | interpretation | supporting | narrower | Adjustment increases precision; t-test 105, ANCOVA 80 at 0.5. | The comparator 94 and the gain implied (94 to 55). | Earlier planning values; no earlier version in the job. | settled |
| "The primary estimand is the difference in mean 6MWD at 6 months between app-guided home exercise and supervised physiotherapy in adults undergoing primary TKA who are eligible for the trial. All randomised participants are analysed in the group to which they were allocated." (p. 1, Primary endpoint and estimand; ST09) | specification | primary | narrower | Four attributes stated; treatment policy implied. | Intercurrent events and strategies; "all randomised" against a complete-case calculation (missingness assumption unstated). | Left to the SAP. Narrows only: marked a protocol section. | settled |
| "The primary analysis is an analysis of covariance (ANCOVA) of 6MWD at 6 months with treatment group and baseline 6MWD as covariates." (Sample size, p. 1; Analysis, p. 2; ST10) | specification | supporting | holds | Specified, and the model the simulation fits. | | | settled |
| "a planned single-centre, randomised, controlled, parallel-group superiority trial … randomised 1:1, in permuted blocks of variable size" (p. 1, Study design; ST11) | specification | supporting | holds | Stated consistently; equal arms match; no strata owed. | | | unverified-here |
| "The primary endpoint is the six-minute walk distance (6MWD, in metres) at 6 months after surgery … The pre-operative 6MWD is the baseline value." (p. 1, Primary endpoint and estimand; ST12) | specification | supporting | holds | Stated consistently; baseline pre-randomisation. | | | unverified-here |
| "Simulations were run in R version 4.3.3 (2024-02-29). The simulation code and the random seed are part of the source of this document." (p. 2, Software; ST13) | specification | peripheral | holds | Code and seed reproduce every printed number. | | | settled |

No rows were folded.

## Recomputation table

| Quantity | Printed (location) | Recomputed | Method and inputs | Agreement | Evidence |
|---|---|---|---|---|---|
| Printed values from the delivered code | 55; 81.5%; 66; 132; 13 points of Figure 1 (p. 2) | identical | delivered source run as is (knitr::purl, Rscript, R 4.3.3); reproduces the code, not its correctness | agrees | work/logs/run_product.log; work/results/inline-values.csv; work/results/figure1_points.csv |
| Evaluable N per group, two-sided 5% | 55 (p. 2) | 80 (79 by the 1 − ρ² design factor) | closed-form noncentral t for ANCOVA; 35 m, SD 90 m, 80% from Table 1; correlation 0.5 reused from the product's code (qmd:45) | disagrees | work/logs/ss_ancova_recompute.log 1a |
| Evaluable N per group, the code's one-sided 5% | 55 (p. 2) | 63 | as above, one-sided; fitted crossing 61.6 from 2,000 trials per point | disagrees | work/logs/ss_ancova_recompute.log 1b; work/logs/run_variants.log |
| Power at 55 per group | 81.5% (p. 2) | 64.2% two-sided; 75.3% one-sided | closed form; independent simulation 63.6% ± 1.1 and 74.9% ± 1.0 (2,000 trials); correlation 0.5 from the code | disagrees | work/logs/ss_ancova_recompute.log 1c; work/results/ss_independent_sim.csv |
| Expected evaluable per group from 66 randomised | 55 (p. 2, implied) | 52.8 (power 62.3%) | 66 × (1 − 0.20) | disagrees | analysis/document/arithmetic-checks.csv A3; work/logs/ss_ancova_recompute.log 1d |
| Randomised per group / total | 66 / 132 (p. 2) | 69 / 138 at 55 evaluable; 100 / 200 at 80 | N / (1 − 0.20), rounded up; one-line variant of the delivered code | disagrees | analysis/document/arithmetic-checks.csv A2; work/pkg/variants/V4_dropout_divide.diff; work/logs/ss_ancova_recompute.log 1e |
| Unadjusted t-test N per group | 94 (p. 2) | 105 (104.8) | `power.t.test`, Table 1 values, two-sided | disagrees | analysis/document/arithmetic-checks.csv A5; work/logs/document_arithmetic.log |

## Answers to the assignment questions

### Q1. Is the sample size adequate for the stated design?

No. Under the product's own planning values (35 m, SD 90 m, two-sided 5%, 80% power,
20% loss) and the correlation its code assumes (0.5), the stated ANCOVA design needs 80
evaluable participants per group (closed form; 78.8% ± 0.9 simulated at 80), that is
100 randomised per group and 200 in total by N / (1 − d). The printed 55 evaluable per
group gives 64.2% power, and the printed 66 randomised (52.8 expected evaluable) 62.3%.
Three slips produce the gap: a one-sided rejection rule, a first crossing on 200 noisy
trials, and a multiplicative dropout allowance. The answer also depends on the
correlation of baseline and 6-month 6MWD, which the product does not state: 55 per
group is enough only near 0.7, while 0.3 needs 96. The 35 m and the 90 m could not be
checked against their sources; the answer holds at the product's own values.

basis: G1, G2; F1, F2, F3, F4; ST01, ST02, ST03, ST07 (ST05, ST06 not needed for the answer)
status: answered

## Data and reproducibility

Data mode `none`; the product reads no data and loads no saved results, so no data or
data-contract audit applies. The delivered source was extracted with `knitr::purl()`
and run with Rscript in R 4.3.3 (Quarto is not installed); it ran without repairs or
warnings and reproduced every printed number, the R version line and all 13 points of
Figure 1 exactly (work/logs/run_product.log; work/results/inline-values.csv). The
rendered document matches what the delivered source produces.

Code–text mismatches: one-sided rule against two-sided text (F1); a running maximum
labelled estimated power (F7); a typed 94 against a computed 105 (F8); a typed "× 1.2"
(F4); Table 1 typed separately from the constants at DEMO-TKA_SSE.qmd:43–48 (they agree
today). Quarto mechanics: `warning: false` hid no warning; one seed, no parallel
streams, cache or packages. The checks covered the code against the text (24
specification rows), the run as delivered, four one-change variants, an independent
closed form and simulation, and N's sensitivity to every planning value.

## Findings

### F1. The simulation tests one-sided at 5%, not two-sided at 5% as printed
bears on: ST03, ST01, ST02; Q1 (G1)
where: code
evidence: DEMO-TKA_SSE.qmd:65; work/pkg/variants/V1_two_sided.diff; work/pkg/variants/V2_two_sided_2000_raw.diff; work/logs/run_variants.log; work/logs/ss_ancova_recompute.log (1a–1e); analysis/code-and-data/simulation-diagnostics-REPORT.md

`pt(t_arm, df = fit$df.residual, lower.tail = FALSE) < alpha` is a one-sided 5% test
(two-sided 10% in effect); Table 1 and the Sample size section state two-sided 5%. At
two-sided 5% and a correlation of 0.5 the design needs 80 evaluable per group (closed
form; fitted crossing 78.7 from 2,000 trials per point); the printed 55 has 64.2%
power. A directional hypothesis does not rescue 55: the text says two-sided twice, and
one-sided 5% still needs 63.

fix: Use `2 * pt(abs(t_arm), df = fit$df.residual, lower.tail = FALSE) < alpha` (or state and justify one-sided 2.5%) and recompute N: 80 evaluable per group at a correlation of 0.5.

### F2. The correlation the ANCOVA power depends on most is set in code only, without a source
bears on: ST07, ST01, ST08; Q1 (G2)
where: text and code
evidence: DEMO-TKA_SSE.qmd:45; analysis/code-and-data/assumption-ledger.csv PV3; work/results/ss_sensitivity.csv; work/logs/ss_ancova_recompute.log

Table 1 lists no correlation of baseline and 6-month 6MWD; the code sets `rho <- 0.5`
with no source. At two-sided 5% the evaluable N per group is 106, 96, 89, 80, 68 and 55
for correlations of 0, 0.3, 0.4, 0.5, 0.6 and 0.7: no other input moves N as much. A
reader cannot reproduce or judge the calculation from the print (SPIRIT item 14).

fix: Add the correlation and its source (pre-operative against 6-month 6MWD in comparable TKA patients) to Table 1, and print N across its plausible range.

### F3. N is chosen as the first grid point reaching 80% in 200 noisy trials
bears on: ST01, ST04 (G1)
where: code
evidence: DEMO-TKA_SSE.qmd:56, 72–74; work/logs/ss_ancova_recompute.log (1f, 1h); work/logs/run_variants.log; analysis/document/arithmetic-checks.csv A9; analysis/code-and-data/results.csv SIM1, SIM4

The 81.5% is 163 of 200 trials (Monte Carlo 95% interval 76.1% to 86.9%). Under the
code's own one-sided rule the power at 55 is 75.3% (closed form; 74.9% ± 1.0
simulated), 2.03 Monte Carlo standard errors below the print. Raw power falls below 80%
again at 60 (77.0%) and 65 (79.0%). The fitted crossing is 60.3 on the product's own
rejections, 61.6 with 2,000 trials, and the closed form gives 63: N is understated by
about 8 per group before the sidedness slip.

fix: Choose N from a closed form, or from a power curve fitted to raw rejections with about 2,000 trials per point near the crossing, and print the Monte Carlo error.

### F4. The dropout allowance multiplies instead of dividing
bears on: ST02; Q1 (G1)
where: text and code
evidence: DEMO-TKA_SSE.qmd:76, 147; analysis/document/arithmetic-checks.csv A1–A3; work/pkg/variants/V4_dropout_divide.diff; work/logs/run_variants.log; work/logs/ss_ancova_recompute.log (1e, section 5)

"55 × 1.2 = 66" (p. 2; `ceiling(n_evaluable * (1 + dropout))`, qmd:76) leaves
66 × 0.8 = 52.8 expected evaluable per group, below the 55 the calculation needs
(62.3% two-sided power at a correlation of 0.5). N / (1 − d) gives 69 per group (138
in total) at 55, and 100 per group (200 in total) at the recomputed 80. The "× 1.2" is
typed into the prose (qmd:147), not computed.

fix: Use `n_rand <- ceiling(n_evaluable / (1 - dropout))` and print the formula inline: 80 / 0.8 = 100 per group, 200 in total.

### F5. The estimand names no intercurrent events, and the calculation's evaluable set is not the stated analysis set
bears on: ST09
where: text
evidence: analysis/code-and-data/estimand-diagnostics-REPORT.md; analysis/code-and-data/missing-data-diagnostics-REPORT.md; analysis/document/consistency-matrix.csv rows "estimand: intercurrent events and strategies", "primary analysis: analysis set and missing data"

Population, treatments, variable and summary measure are stated (p. 1); intercurrent
events and strategies are not, though stopping or switching treatment, revision or
contralateral knee surgery, inability to walk and death are plausible (death truncates
6MWD, which treatment policy cannot cover). "All randomised participants are analysed
in the group to which they were allocated" is an analysis-set statement; the
calculation counts evaluable participants and defers missing data to the SAP (p. 2).
The two agree only if missing 6-month 6MWD is missing at random given baseline and arm,
which is not stated. The source marks this text as a protocol section, where ICH
E9(R1) places the estimand.

fix: Name the intercurrent events with a strategy for each, say whether 35 m is a treatment-policy effect, and state the missing-data assumption the sample size makes (complete-case ANCOVA on evaluable participants, missing at random given baseline and arm).

### F6. The 35 m target and the 20% loss are not argued for this trial
bears on: ST05, ST06 (G2)
where: unresolved
evidence: Table 1, p. 1; analysis/code-and-data/assumption-ledger.csv PV1, PV2, PV4; work/results/ss_sensitivity.csv; work/logs/ss_ancova_recompute.log (section 5)

Table 1 gives 35 m as the "Smallest difference of clinical interest". The print does
not say whether it is the minimal important difference for 6MWD after TKA or the effect
app-guided exercise is expected to achieve over supervised physiotherapy, and argues
neither. The 20% loss is a routine-care registry figure applied to trial follow-up
without saying how it was adapted. N per group runs from 108 to 62 for 30 to 40 m;
randomised N for 80 evaluable from 89 to 115 for 10% to 30% loss.

fix: Ask the author whether 35 m is the minimal important difference or the expected effect; cite the evidence for it and for its plausibility as a superiority effect, and say how registry loss was adapted to trial follow-up.

### F7. Figure 1 plots a running maximum labelled "Estimated power"
bears on: ST04
where: code
evidence: DEMO-TKA_SSE.qmd:73, 137; work/results/figure1_points.csv; work/results/product_power_grid.csv

All 13 plotted points equal `cummax(power_raw)`; 5 lie above the simulated power at
their N (60 per group: 81.5% plotted against 77.0%; 65: 81.5% against 79.0%). The
running maximum does not change the choice of 55 (raw power there is 81.5%) but hides
the Monte Carlo noise, including a 13.5-point rise between 50 and 55 per group.

fix: Plot the raw estimates with Monte Carlo intervals, or a fitted curve, and label the figure accordingly.

### F8. The unadjusted t-test comparator (94 per group) is typed into the prose and not reproduced
bears on: ST08
where: text
evidence: DEMO-TKA_SSE.qmd:82, 145; analysis/document/arithmetic-checks.csv A5; work/logs/document_arithmetic.log; work/logs/run_product.log

Under Table 1's values (35 m, SD 90 m, two-sided 5%, 80%), `power.t.test` gives 104.8,
105 per group; the code computes this as `n_ttest` (qmd:82) but never prints it, and
the text types 94 (qmd:145). 94 follows only from other inputs (SD 85.2 m at 35 m, or
37.0 m at SD 90 m). The comparator understates by 11 per group the gain the text
attributes to baseline adjustment.

fix: Print `n_ttest` inline (105 under Table 1), or state the inputs that give 94.

## Limits of this review

- **No challenge stage** (depth `quick`): no finding was rebuilt in a fresh context.
- **Planning-value sources not provided**: the steering committee decision and the
  registry report were not in the job, and independent literature could not be
  obtained (network policy; check waived by the operator). Leaves the target effect,
  SD and loss rate `unverified-here` (ST05, ST06).
- **Protocol not provided**: design, randomisation and endpoint were checked as the SSE
  prints them, not against the protocol (ST11, ST12 `unverified-here`).
- **Render environment**: Quarto was not installed; values were compared, not the
  typeset layout (ST13). Normality of 6MWD was assumed, not checked.
- **Modules not run at depth `quick`**: multiplicity, regression-model, observational,
  prediction-model and Bayesian diagnostics (analysis/code-and-data/module-walk.md);
  none bears on a ledger row.
- **Simulation size**: the review's simulations and variants used 2,000 trials per
  point (Monte Carlo standard error at most 1.1 points); the closed form decides N.

## Counts

- Rows whose `holds` moved from the statements stage's: none, toward `holds` or
  toward `not established` (13 rows as ruled: 4 not established, 5 narrower, 4 hold).
- Status changes without a move in `holds`: the target effect (ST05) and the SD and
  loss rate (ST06) from `INTERIM` to `unverified-here`, on the operator's waiver of the
  literature check (00_INTAKE.md, Requests for the operator).
- Challenge rulings: none (depth `quick`; no challenge stage ran).
