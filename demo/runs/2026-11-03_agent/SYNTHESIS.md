# Synthesis — Sample Size Estimation: DEMO-TKA, app-guided home exercise versus supervised physiotherapy after total knee arthroplasty (DEMO-01, Version 1.0, 15 September 2026)

Verification: OPEN · 8 not established / 3 narrower / 9 hold

## Status

`INTERIM`, depth `standard`, data mode `none`.

**Why interim.** The module walk fired six diagnostic modules: simulation, sample-size,
regression-model, estimand, missing-data and rct diagnostics. The operator waived all
six for this test run on 2026-11-03, and none ran (review/statements-REPORT.md, Status;
analysis/code-and-data/module-walk.md). The code-and-data and statements stages are
`INTERIM` for that reason. Seven rows of the statement ledger are `INTERIM`:
- the effect, the SD and the loss rate, because their warrant against the independent
  literature was not graded;
- the data-generating model;
- the estimand;
- the analysis set;
- the randomisation.

**What is open.** Each item is the work of a waived module:
- the warrant and supported range of the effect, the SD, the loss rate and the
  correlation;
- the N the design needs at supported planning values;
- robustness of the power to a skewed or bounded 6MWD;
- the estimand, missing-data and randomisation passes.

**Challenge.** The challenge stage ran (review/challenge-REPORT.md) and rebuilt every
primary row. At the product's own inputs it settled the N under the stated test at
adequate Monte Carlo precision. A worker re-ran the load-bearing script of every WRONG
and STANDS WITH CHANGES ruling, and the logs were identical apart from timestamps. The
page that the analysis-set ruling cites was opened (work/challenge/recheck/RECHECK.md).

**Data mode.** In mode `none`, an SSE needs no patient data, and the mode leaves no
check unverified. The protocol, the SAP and the two internal sources of the planning
values are not in the job. The checks against them are `unverified-here` (Limits of
this review).

## What the product establishes and what it does not

**What it establishes.**
- **Design and planned analysis.** The trial is a single-centre, two-arm, 1:1
  superiority trial (Study design, p. 1). Its primary analysis is an ANCOVA of the
  6-month 6MWD adjusted for the pre-operative value, tested two-sided at 5% with 80%
  target power (Table 1, p. 1; Sample size and Analysis, pp. 1–2).
- **The calculation's model.** The power calculation simulates the same model as the
  planned analysis.
- **Reproducibility.** In R 4.3.3, the delivered source and seed reproduce exactly:
  - 55 evaluable per group;
  - 81.5%;
  - 66 per group and 132 in total;
  - all 13 values plotted in Figure 1.

  Sources: work/challenge/s3.log L18–L20, L24; work/challenge/s6.log L38.
- **The gain from adjustment.** Adjusting for baseline lowers the N under the stated
  test from 106 per group with no correlation to 80 at the code's correlation of 0.5
  (work/challenge/s2.log L31).
- **What the stated test needs at the product's own inputs.** The inputs are Table 1's
  effect of 35 m and SD of 90 m and the code's correlation of 0.5. The stated test then
  needs 80 evaluable participants per group (work/challenge/s2.log L21;
  work/challenge/s4.log L25, L29), shown two ways:
  - analytically;
  - by the product's own code at 4,000 trials per grid point.

  By N / (1 − 0.20), that is 100 randomised per group and 200 in total
  (work/challenge/s1.log L36).

**What it does not establish.** It does not establish its sample size.
- **The test behind the printed numbers (F1).** The printed 55 evaluable per group and
  its 81.5% power come from a simulation that counts a one-sided 5% test
  (DEMO-TKA_SSE.qmd:65). The product states a two-sided 5% test. Under the stated test
  at 55 per group, the power is:
  - 66.5% on the product's own trials;
  - 63.6% at 4,000 trials.

  This alone removes all three primary statements: the evaluable N, its power, and the
  randomised N of 66 per group (132 in total).
- **The correlation (F2).** Each primary statement also rests on a correlation of 0.5
  that is in the code but not in Table 1, and that has no source. Under the stated test,
  55 per group suffices only at a correlation of about 0.70 or more.
- **Monte Carlo selection (F3).** Even under the one-sided test the code runs, 55 is an
  upward Monte Carlo deviation. It was chosen as the first grid point whose single
  200-trial estimate reached 80%. At 4,000 trials, the coded test first reaches 80% at
  65 per group.
- **Figure 1 (F4).** Figure 1 hides the raw estimates below 80% at 60 and 65 per group.
- **The dropout allowance (F5).** The randomised N under-inflates for the stated 20%
  loss. 66 randomised yield 52.8 evaluable, and 55 evaluable need 69 per group, 138 in
  total.

The supporting statements tied to the calculation are not established either (G1):
- the test behind the calculation;
- the planning values the simulation uses;
- the Monte Carlo design;
- Figure 1.

Three statements hold only in narrower form (G2):
- the dropout allowance;
- the estimand;
- the analysis set.

The product does not tie the 35 m or the 20% allowance to how participants without a
6-month value will be analysed.

The printed comparison with an unadjusted t-test (94 per group) does not follow from
Table 1, which gives 105 (F7).

Whether 80 evaluable per group (100 randomised) is itself adequate turns on the
correlation, the SD and the effect. Their sources are not in the job, and their
grading against the literature was not done.

## Cross-cutting findings

### G1. The printed 55 evaluable per group comes from three departures that all run in the product's favour
bears on: ST01, ST02, ST03, ST05, ST08, ST13, ST14

**The three departures.** The printed 55 and 81.5% reproduce exactly from the delivered
code (work/logs/cd_reconcile.log; work/challenge/s3.log L18–L19). Three departures from
the stated design produce them:
- **A one-sided rejection rule.** The product states two-sided (F1).
- **An unsourced correlation.** The code uses 0.5, which is not in Table 1 and has no
  source (F2).
- **A single 200-trial estimate.** N is the first grid point whose estimate reaches 80%
  (F3). Figure 1 hides the neighbouring estimates that fall below 80% (F4).

Each departure is anti-conservative.

**Together.** At the product's own inputs, the stated two-sided test needs 80 evaluable
per group, not 55:
- 80 analytically (work/challenge/s2.log L21);
- 80 by the product's own code at 4,000 trials per grid point, with 81.6% at 80 and
  77.6% at 75 (work/challenge/s4.log L25, L29).

Under the coded one-sided test at adequate precision, the code needs 65 per group
(work/challenge/s4.log L24). Under the stated test, 55 suffices only at a correlation of
0.696 or more (work/challenge/s2.log L28). With the dropout correction (F5), 80
evaluable become 100 randomised per group and 200 in total (work/challenge/s1.log L36),
against the planned 66 and 132.

**What it removes.** These rows are not established:
- the evaluable N (ST01);
- its power (ST02);
- the randomised N (ST03);
- the test behind the calculation (ST05);
- the planning values the simulation uses (ST08);
- the Monte Carlo design and the rule for choosing N (ST13);
- Figure 1 (ST14).

**What survives.**
- **The plan.** The planned test (two-sided 5%, 80% power) and the planned analysis
  (ANCOVA on baseline) stand, and the calculation simulates the same model (ST06, ST07).
- **The code.** It is reproducible (ST20).
- **The direction of the gain.** Adjusting for baseline does increase precision (ST19).
- **The size at the product's inputs.** The design needs 80 evaluable per group. That
  holds only on two conditions:
  - the code's unsourced correlation;
  - Table 1's effect and SD, whose sources were not checked.

### G2. How loss to follow-up enters the design is not tied to the analysis set
bears on: ST03, ST04, ST11, ST15, ST16

**What the calculation does.**
- It counts evaluable participants with complete data.
- It inflates by a formula that keeps 52.8 of the 55 evaluable at the stated 20% loss
  (F5; work/challenge/s1.log L08).

**What the estimand and analysis sections say** (F6).
- All randomised participants are analysed as allocated.
- No intercurrent events are named.
- The handling of missing outcomes is deferred to the SAP.

**Together.** The product ties neither the number randomised nor the meaning of
"evaluable" to how participants without a 6-month value will be analysed.

**What it removes.** Three rows narrow:
- the dropout allowance, which covers 16.7% loss rather than 20% (ST04);
- the estimand (ST15);
- the analysis set (ST16).

It adds to the reasons the randomised N is not established (ST03).

**What survives.**
- The analysis set is stated: all randomised, as allocated.
- The 20% loss is cited to a named source (ST11), which is not in the job.

## Statement ledger

| Statement (location) | Kind | Centrality | Holds | Kernel | Not established | Strongest defence | Status |
|---|---|---|---|---|---|---|---|
| "The smallest sample size with at least 80% power is 55 evaluable participants per group", read with "counted the trials in which the treatment effect was statistically significant at the two-sided 5% level" and "5%, two-sided" (Sample size, pp. 1–2; Table 1, row "Significance level", p. 1; ST01) | calculation | primary | not established | 55 per group is the first grid point whose single 200-trial estimate reaches 80% under the one-sided 5% rule the code implements (qmd:65), at the code's unprinted correlation of 0.5 (qmd:45); it reproduces exactly. Under the stated two-sided test at the same inputs, 80 evaluable per group give 80% power: analytically, and by the product's own code at 4,000 trials per grid point (81.6% at 80, 77.6% at 75). 55 per group reach 80% two-sided only at a correlation of about 0.70 or more (0.696). | That 55 evaluable per group give at least 80% power at the stated two-sided 5% level under the planning values in Table 1. Also that 55 is the smallest such N even under the coded one-sided test: at 4,000 trials the coded rule first reaches 80% at 65 (analytic 63). | A correlation of about 0.70 or more would make 55 suffice two-sided; or a one-sided 5% test was intended. Both tested, both failed. The correlation is neither printed nor sourced, and the code uses 0.5. The print states two-sided twice, and even one-sided the code at adequate precision needs 65. | settled |
| "(estimated power 81.5%)" at 55 evaluable per group, as the power of the stated two-sided 5% test (Sample size, p. 2; Figure 1, p. 2; ST02) | result | primary | not established | 81.5% is 163 of 200 trials rejecting under the one-sided 5% rule at 55 per group and correlation 0.5, reproduced exactly; 95% interval 75.4% to 86.6%. On the same trials the stated test rejects 133 of 200 (66.5%, 95% interval 59.5% to 73.0%). At 4,000 trials the power at 55 is 63.6% under the stated test and 74.2% under the coded one. | That 81.5% is the power of the stated two-sided 5% test at 55 per group, or that power at 55 per group reaches 80% under that test. | The number is the product's own reproducible simulation output. Tested: the reproduction shows stability only. The same trials give 66.5% under the stated test, and 81.5% lies 2.36 Monte Carlo SE above the coded test's power at 55. Failed. | settled |
| "we will randomise 55 × 1.2 = 66 participants per group, 132 in total" as the trial size (Sample size, p. 2; ST03) | calculation | primary | not established | 55 × 1.2 = 66 and 2 × 66 = 132 are right and reproduce from the code. At 20% loss, 66 randomised yield 52.8 evaluable. By N / (1 − 0.20), 55 evaluable need 69 per group, 138 in total. The 80 evaluable that the stated test needs at the code's inputs need 100 per group, 200 in total. | That 132 randomised give 80% power at two-sided 5% after 20% loss to follow-up. The evaluable base is not established, and the allowance under-inflates. | The inflation is a planning convention, and 52.8 is close to 55. Tested: the shortfall is small at the printed base (66 against 69), but the base itself fails. Under the stated test the need is 100 per group. Failed. | settled |
| "Allowing for 20% loss to follow-up, we will randomise 55 × 1.2 = 66 participants per group" as the dropout allowance (Sample size, p. 2; Table 1, row "Loss to follow-up at 6 months", p. 1; ST04) | calculation | supporting | narrower | 66 randomised per group keep 55 evaluable for loss up to 16.7% (1 − 55/66). | That the allowance covers the stated 20% loss: at 20%, 66 yield 52.8 evaluable, and N / (1 − 0.20) gives 69 per group (138 in total). The code uses the same formula (qmd:76), so it under-inflates any corrected N: for 80 evaluable, 96 against 100. | Some planners inflate by N × (1 + d). Tested: that formula does not deliver N evaluable at loss d, and the product states 20%, not 16.7%. Failed. | settled |
| "we simulated 200 trials under the planning values in Table 1, fitted the ANCOVA to each and counted the trials in which the treatment effect was statistically significant at the two-sided 5% level", as the test behind the calculation (Sample size, pp. 1–2; ST05) | specification | supporting | not established | The simulation fits the planned ANCOVA (lm(outcome ~ arm + baseline), qmd:63), which is the model of the planned primary analysis. It counts rejections of a one-sided upper-tail 5% test (qmd:65). | That the counted rejections are of the stated two-sided 5% test. The rule rejects when pt(t, df, lower.tail = FALSE) < 0.05, which is the critical value of a two-sided 10% test. | A one-sided test of benefit matches a superiority hypothesis. Tested: the print states two-sided twice, and the code's own t-test comparison is two-sided (qmd:82). The one-sided counterpart of a two-sided 5% test is 2.5%, not 5%. Failed. | settled |
| "Significance level 5%, two-sided"; "Power 80%", as the planned primary test (Table 1, rows "Significance level" and "Power", p. 1; Sample size, p. 2; ST06) | specification | supporting | holds | The planned primary test is two-sided at 5% with 80% target power. Table 1 and the Sample size section state it, and the code's t-test comparison uses the same (qmd:82). The one-sided rule at qmd:65 is the isolated slip, and it is recorded on the calculation rows. | Consistency with the protocol, which is not in the job. | n/a (row holds) | unverified-here |
| "The primary analysis is an analysis of covariance (ANCOVA) of 6MWD at 6 months with treatment group and baseline 6MWD as covariates."; "The primary analysis is the ANCOVA described above." (Sample size, p. 1; Analysis, p. 2; ST07) | specification | supporting | holds | The planned primary analysis is an ANCOVA that adjusts for the pre-operative 6MWD, a covariate measured before randomisation. No stratification factor is named, so none is missing from the model. The calculation simulates the same model (qmd:63). | Consistency with the protocol and the SAP. Neither is in the job, and the SAP is not yet written. | n/a (row holds) | unverified-here |
| "we simulated 200 trials under the planning values in Table 1", as the planning values the simulation uses (Sample size, pp. 1–2; Table 1, p. 1; ST08) | assumption | supporting | not established | The simulation uses Table 1's effect (35 m) and SD (90 m). It also uses a baseline-to-6-month correlation of 0.5 (qmd:45), neither printed nor sourced, which sets the precision of the adjusted comparison. Under the stated test, N is 106, 89, 80, 68 and 55 per group at a correlation of 0, 0.4, 0.5, 0.6 and 0.7. For equal relative changes, N is about three times as sensitive to the SD and to the effect as to the correlation. The correlation matters because it alone has no stated value or source. The baseline mean and SD and the outcome means (qmd:60–61) are also unprinted, but they do not affect the power of the treatment comparison. | That the simulation ran under the planning values in Table 1 only. Also any source or rationale for the correlation of 0.5, which has a code comment only. | A correlation of 0.5 is a common planning default. Not testable from the product's materials: no source is named, so the default shields nothing. Grading it against the literature belongs to the waived sample-size module. | unverifiable |
| "Smallest difference of clinical interest 35 m", "Agreed with the investigators (steering committee, 3 June 2026)" (Table 1, p. 1; ST09) | assumption | supporting | holds | 35 m is stated as the smallest difference of clinical interest, agreed with the investigators on 3 June 2026. The code uses the same value (qmd:43). | That the steering committee decision contains 35 m and a rationale (not in the job). How 35 m stands against published minimal important differences for the 6MWD after TKA (the literature grading was waived). Which estimand strategy 35 m refers to. N is sensitive to it: 98 evaluable per group at 31.5 m, 124 at 28 m (two-sided, correlation 0.5). | A smallest difference agreed with the investigators is a recognised basis for the target difference. Not tested: the decision is not in the job, and the literature check was waived. | INTERIM |
| "SD of 6MWD at 6 months 90 m", "Hospital TKA registry, 2019–2021 (internal report)" (Table 1, p. 1; ST10) | assumption | supporting | holds | 90 m is cited to the hospital TKA registry internal report for 2019–2021. The code uses it for the outcome and the baseline (qmd:44, :60). | That the report contains an SD of 90 m for the 6MWD at 6 months in a population comparable with the trial's (not in the job). Its warrant against the independent literature (waived). N is sensitive to it: 63 evaluable per group at 80 m, 98 at 100 m. | A same-centre registry is the most relevant source for a single-centre trial. Not tested: the report is not in the job, and the literature check was waived. | INTERIM |
| "Loss to follow-up at 6 months 20%", "Hospital TKA registry, 2019–2021 (internal report)" (Table 1, p. 1; ST11) | assumption | supporting | holds | 20% loss at 6 months is cited to the same registry report, and the code uses it (qmd:48). | That the report contains 20% loss at 6 months for a trial-like population (not in the job). Its warrant (waived). What the allowance assumes about participants without a 6-month value. For 80 evaluable, N / (1 − d) gives 89, 100 and 115 randomised per group at 10%, 20% and 30% loss. | Registry follow-up at the same centre is a direct source for loss at 6 months. Not tested: the report is not in the job, and the literature check was waived. | INTERIM |
| "we simulated 200 trials under the planning values in Table 1", as the data-generating model: normal outcomes, linear in baseline, equal SD in both arms, a constant additive effect (Sample size, pp. 1–2; DEMO-TKA_SSE.qmd:60–62; ST12) | assumption | supporting | holds | The generator draws normal baseline and outcome values with SD 90 m, a linear baseline relation and a constant additive effect of 35 m. It implies a within-arm 6-month SD of 90 and a correlation of 0.5. This is the standard planning model for an ANCOVA, and normal-theory analytic power matches the product's own 4,000-trial curves. | That the power holds for a skewed or bounded 6MWD, unequal arm variances or a heterogeneous effect (the regression-model module was waived). | Normal-theory ANCOVA is robust for a continuous outcome at about 50 or more per arm. Not tested: the regression-model module was waived. | INTERIM |
| "For sample sizes of 40 to 100 evaluable participants per group, in steps of 5, we simulated 200 trials" with "The smallest sample size with at least 80% power is 55", as the Monte Carlo design and the rule for choosing N (Sample size, pp. 1–2; Figure 1 caption, p. 2; ST13) | specification | supporting | not established | The 13-point grid and the 200 trials per point are as printed, and they reproduce exactly (seed 20260108). The rule picks the first grid point whose single estimate reaches 80%. The Monte Carlo SE at the chosen estimate is 2.75 points. | That 200 trials per point and a rule taking the first single crossing locate the N with 80% power to within the grid step. The raw one-sided estimates at 60 and 65 are 77.0% and 79.0%. At 4,000 trials, the coded rule first reaches 80% at 65 (crossing 62.4), and the stated test at 80 (crossing 79.3). Under the coded test's curve, the rule lands at 55 or lower with probability 4.4%. | A coarse simulation was used for planning only, and the printed estimate is above 80%. Tested: the interval of 75.4% to 86.6% includes powers below 80%, and at adequate precision the coded rule chooses 65. Failed. | settled |
| "Figure 1: Estimated power by number of evaluable participants per group (200 simulated trials per sample size)." (Figure 1, p. 2; ST14) | result | supporting | not established | All but five of the 13 plotted values are the raw one-sided 200-trial estimates. The dashed line at 80% and the dotted line at 55 are placed as captioned. | That the plotted values are estimated power. Five of them (at 50, 60, 65, 80 and 85 per group) are a running maximum (qmd:73), so 60 and 65 show 81.5% where the raw estimates are 77.0% and 79.0%. Also, the plotted power is that of the coded one-sided test, not the stated test. | A monotone curve is easier to read, and the chosen N is unchanged. Tested: the N is unchanged, but the hidden estimates are the evidence that 81.5% at 55 is an upward deviation. Failed as a defence of the caption. | settled |
| "The primary estimand is the difference in mean 6MWD at 6 months between app-guided home exercise and supervised physiotherapy in adults undergoing primary TKA who are eligible for the trial. All randomised participants are analysed in the group to which they were allocated." (Primary endpoint and estimand, p. 1; ST15) | specification | supporting | narrower | The population, treatment conditions, variable and population-level summary are stated. Analysing all randomised participants as allocated fits a treatment-policy reading. | Which intercurrent events are anticipated, and the strategy for each. Examples are not starting or stopping the app, supervised physiotherapy in the intervention arm, revision surgery or a complication that prevents the walk test, and death. Therefore also that the 35 m and the count of evaluable participants refer to this estimand. If the effect under the chosen strategy is 10% smaller, the evaluable N rises from 80 to 98 per group (two-sided, correlation 0.5). | "All randomised participants are analysed in the group to which they were allocated" signals a treatment-policy strategy for every intercurrent event, and an SSE may leave the full estimand to the protocol. Not tested beyond the page: the protocol is not in the job, and the estimand pass was waived. The product's own sentence supports the defence, which keeps the row from not established. | INTERIM |
| "All randomised participants are analysed in the group to which they were allocated." with the count of "evaluable participants" and "The handling of missing outcome data and any sensitivity analyses will be specified in the statistical analysis plan." (Primary endpoint and estimand, p. 1; Sample size, p. 2; Analysis, p. 2; ST16) | specification | supporting | narrower | The analysis set is stated as all randomised, analysed as allocated, and the handling of missing data is deferred to the SAP. The primary ANCOVA as described and sized includes only participants with a 6-month value: it counts evaluable participants, and the simulation uses complete data (qmd:59–63). | That the primary analysis includes all randomised participants. Also what the 20% allowance assumes about participants without a 6-month value, and how they enter the analysis (the missing-data pass was waived). | Inflating an evaluable N for loss is the conventional planning for an all-randomised analysis whose missing-data handling the SAP will name, and the deferral is disclosed. Tested and failed in part. The defence answers how to size for loss, not whether all randomised enter "the ANCOVA described above". The product also does not use the convention: 66 randomised yield 52.8 evaluable. Moved from holds to narrower on this evidence: the challenge ruling on the analysis set (review/challenge-REPORT.md, section (a)), the pages checked (work/challenge/recheck/RECHECK.md) and work/challenge/recheck/s1.log L08. | INTERIM |
| "participants are randomised 1:1, in permuted blocks of variable size"; "Allocation ratio 1:1" (Study design, p. 1; Table 1, row "Allocation ratio", p. 1; ST17) | specification | supporting | holds | 1:1 allocation is stated twice, and the simulation uses equal arms (qmd:59). There is no stratification named and one centre, so the ANCOVA needs no stratification factor. Nothing in the calculation rests on the block sizes. | The randomisation pass (the rct module was waived). Consistency with the protocol, which is not in the job. | n/a (row holds) | INTERIM |
| "For comparison, an unadjusted two-sample t-test would require 94 participants per group." (Sample size, p. 2; ST18) | calculation | peripheral | not established | With Table 1's values, the unadjusted t-test needs 105 per group (104.77 by power.t.test). The delivered code computes this value (qmd:82) but does not print it. | The printed 94. It does not follow from Table 1 (94 per group give 75.6% power), and the code does not produce it. | 94 may come from other inputs: an SD of 85.2 m, or an effect of 37.0 m. Tested: neither input is stated anywhere in the product. Failed. | settled |
| "Because adjustment for baseline increases precision, we estimated power by simulation." (Sample size, p. 1; ST19) | interpretation | peripheral | holds | Adjustment for a correlated baseline reduces the variance of the effect estimate by the factor 1 − ρ², so the direction holds. Under the stated test, N is 106 per group at a correlation of 0 and 80 at 0.5. Simulation is a valid route to the ANCOVA power. | The size of the gain, which rests on the unstated correlation. | n/a (row holds) | settled |
| "Simulations were run in R version 4.3.3 (2024-02-29). The simulation code and the random seed are part of the source of this document." (Software, p. 2; ST20) | specification | peripheral | holds | The source carries the simulation code and set.seed(20260108) (qmd:70). In R 4.3.3 with the default RNG kind, it reproduces exactly every number it computes and prints. | None. | n/a (row holds) | settled |

No duplicate rows were folded.

## Recomputation table

| Quantity | Printed (location) | Recomputed | Method and inputs | Agreement | Evidence |
|---|---|---|---|---|---|
| Evaluable N per group, as delivered | 55 (Sample size, p. 2) | 55 | The delivered source run unchanged: knitr::purl and Rscript, R 4.3.3, seed 20260108. A rebuttal re-run of the product's own number, which shows stability only. | agrees | work/logs/cd_reconcile.log; work/challenge/s3.log L18 |
| Evaluable N per group for 80% power at the stated two-sided 5% test | 55 (Sample size, p. 2; Table 1, p. 1) | 80 | Two methods, each reusing the product's own inputs: 35 m and SD 90 m (Table 1, p. 1), plus a correlation of 0.5 taken from qmd:45, which is unprinted and unsourced. (1) Exact unconditional ANCOVA power, a noncentral t integrated over covariate imbalance; agrees with the noncentral-t approximation. (2) The product's own code with only n_sim set to 4,000 (qmd:56) and line 65 made two-sided: first grid point at 80% is 80 (81.6%, 95% interval 80.3% to 82.7%); 77.6% at 75; fitted crossing 79.3. | disagrees | work/challenge/s2.log L21; work/challenge/s4.log L22, L25, L29; work/challenge/s5.log L25 |
| Evaluable N per group under the one-sided rule the code implements | 55 (Sample size, p. 2) | 65 (fitted crossing 62.4); analytic 63 | The product's own code with only n_sim set to 4,000. The analytic method as above, one-sided 5%, reusing the product's inputs and correlation of 0.5. | disagrees | work/challenge/s4.log L21, L24; work/challenge/s5.log L24; work/challenge/s2.log L22 |
| Power at 55 evaluable per group, stated two-sided test | 81.5% (Sample size, p. 2; Figure 1, p. 2) | 63.6% (95% interval 62.1% to 65.1%); analytic 64.2%; 66.5% on the delivered 200 trials | The product's code at 4,000 trials, two-sided rule. The analytic method. The delivered trials with only line 65 changed (133 of 200). All reuse the product's inputs and correlation of 0.5. | disagrees | work/challenge/s4.log L26, L28; work/challenge/s2.log L23; work/challenge/s3.log L29–L30 |
| Power at 55 evaluable per group, coded one-sided test | 81.5% (Sample size, p. 2) | 74.2% (95% interval 72.8% to 75.6%); analytic 75.3% | The product's code at 4,000 trials, rule as coded. The analytic method, one-sided. The delivered 200-trial run reproduces 81.5% (163 of 200), 2.36 Monte Carlo SE above the 4,000-trial value. | disagrees | work/challenge/s4.log L26–L27; work/challenge/s2.log L24; work/challenge/s5.log L43; work/challenge/s1.log L27 |
| Randomised per group | 66 (Sample size, p. 2) | 69 for 55 evaluable; 100 for 80 evaluable | N / (1 − 0.20), rounded up. Loss of 20% from Table 1, row "Loss to follow-up at 6 months", p. 1. The product's own formula 55 × 1.2 reproduces 66. | disagrees | work/challenge/s1.log L06, L10, L36; analysis/document/arithmetic-checks.csv A01, A03 |
| Randomised in total | 132 (Sample size, p. 2) | 138 for 55 evaluable; 200 for 80 evaluable | 2 × the randomised N per group by N / (1 − 0.20). The product's own 2 × 66 reproduces 132. | disagrees | work/challenge/s1.log L07, L11, L36–L37; analysis/document/arithmetic-checks.csv A02, A04 |
| Expected effect (smallest difference of clinical interest) | 35 m (Table 1, p. 1) | not recomputed | — | not recomputed (planning value; its source, the steering committee decision of 3 June 2026, is not in the job, and the literature grading was waived) | analysis/code-and-data/assumption-ledger.csv AL01 |
| SD of 6MWD at 6 months | 90 m (Table 1, p. 1) | not recomputed | — | not recomputed (planning value; its source, the registry report 2019–2021, is not in the job, and the literature grading was waived) | analysis/code-and-data/assumption-ledger.csv AL02 |
| Unadjusted two-sample t-test N per group (comparison) | 94 (Sample size, p. 2) | 105 (104.77) | stats::power.t.test with Table 1's inputs only (35 m, SD 90 m, two-sided 5%, 80%). The delivered code's own n_ttest (qmd:82) gives the same value. | disagrees | work/challenge/s1.log L14; work/challenge/s3.log L21; analysis/document/arithmetic-checks.csv A06 |

## Answers to the assignment questions

### Q1. Is the sample size adequate for the stated design?

**No.** The product does not establish that 55 evaluable per group (66 randomised, 132
in total) is adequate for the design it states. At its own inputs, that sample size is
too small.

- **The test behind the printed numbers.** The 55 and the 81.5% come from a one-sided
  5% rejection rule in the code (DEMO-TKA_SSE.qmd:65). The design states a two-sided
  5% test. Under the stated test at 55 per group, the power is:
  - 66.5% on the product's own simulated trials (133 of 200; 95% interval 59.5% to
    73.0%);
  - 63.6% at 4,000 trials per grid point.
- **What the stated test needs.** The inputs are Table 1's effect of 35 m and SD of
  90 m and the code's unprinted, unsourced baseline-to-6-month correlation of 0.5. At
  these inputs the stated test needs 80 evaluable per group:
  - analytically;
  - by the product's own code at 4,000 trials per grid point (81.6% at 80, 77.6% at
    75).

  By N / (1 − 0.20), that is 100 randomised per group and 200 in total, against the
  planned 66 and 132.
- **Monte Carlo precision and the choice of N.** At 200 trials per grid point, the
  estimate at 55 has a 95% interval of 75.4% to 86.6%. The rule takes the first grid
  point whose single estimate reaches 80%, so it picks upward deviations. Under the
  coded test it lands at 55 or lower with probability about 4%. At adequate precision,
  even the coded one-sided test first reaches 80% at 65 per group.
- **The dropout allowance.** The 20% allowance under-inflates. 66 randomised yield
  52.8 evaluable, and 55 evaluable need 69 per group, 138 in total.

**What an adequate N depends on.**
- **The correlation.** The product neither states nor sources it. The stated test
  needs 80 evaluable per group at 0.5, and 55 is enough only at about 0.70 or more.
- **The SD and the effect, just as strongly.**
  - The SD: 63 to 98 per group for 80 to 100 m.
  - The effect: 98 per group at 31.5 m and 124 at 28 m.
- **The estimand strategy.** The product does not say which effect the 35 m is under
  the estimand.

**What the review cannot answer here.** It cannot say whether the 35 m, the 90 m, the
20% and a correlation value are supported for this population:
- The cited sources are internal and not in the job.
- Grading the planning values against the literature was waived.

The N the design needs at supported planning values therefore stays open.

basis: ST01, ST02, ST03, ST04, ST05, ST08, ST13, ST15, ST16; G1, G2; F1, F2, F3, F5, F6; work/challenge/s1.log, s2.log, s3.log, s4.log, s5.log, s7.log, s8.log
status: partly answered

## Data and reproducibility

**Data mode `none`.** No data exist or were read, and the source reads no file.
- **The data-contract audit is not applicable.** The data-generating model was checked
  against Table 1 instead: it implies a within-arm 6-month SD of 90 and a
  baseline-to-6-month correlation of 0.5 (work/challenge/s2.log L43).
- **The evidence ladder does not apply** in this mode.

**What ran.** Quarto is not installed. The delivered source was extracted with
`knitr::purl()` and run with Rscript. The environment was R 4.3.3, the version the
product prints, with the default RNG kind and the delivered seed 20260108.
- **The code ran as delivered**, with no repair (work/logs/cd_run_product.log).
- **It reproduces exactly** every inline number it computes: 55, 81.5%, 66, 132 and
  the R version string. It also reproduces the 13 values plotted in Figure 1, read
  from the PDF's vector graphics (work/logs/cd_reconcile.log; work/challenge/s3.log
  L18–L24; work/challenge/s6.log L38).
- **The rendered document matches its source** with one exception: the typed t-test
  number. The print shows 94, and the code computes 105 (F7).
- **Figure 1 was compared numerically**, not as a re-rendered PDF.

**Code–text mismatches.**
- The rejection rule is one-sided, against the stated two-sided test (F1).
- The simulation uses a correlation that is not among "the planning values in Table 1"
  (F2).
- Figure 1 plots a running maximum, captioned as "Estimated power" (F4).
- The t-test number is typed into the prose (F7).

Table 1's values and the factor "× 1.2" are typed into the text rather than drawn from
the code constants (DEMO-TKA_SSE.qmd:112–117 and :147, against :43–48). They agree
today (analysis/code-and-data/spec-map.csv).

**Quarto and R mechanics.** No finding beyond those above.
- The document sets `warning: false` and `message: false` globally (qmd:34–37). A
  re-run with `options(warn = 1)` printed no warning in 2,600 fits
  (work/logs/cd_run_product.log; analysis/code-and-data/battery-manifest.csv CD08).
- Three hidden chunks compute reported numbers, and each has a specification-map row.
- There is no `eval: false`, `error: true`, `cache` or `freeze`.
- The code uses no package beyond base R and `stats`.
- The seed is set once, before the grid.

**What the checks covered.**
- reproduction of the delivered run;
- a two-sided variant on the delivered trials;
- re-runs of the product's own code at 4,000 trials per grid point under both rules, on
  the delivered grid and seed;
- analytic recomputation by two methods.

**What they did not cover.**
- other seeds or RNG streams;
- a grid finer than 5 per group;
- robustness to non-normal outcomes;
- a Quarto re-render.

## Findings

### F1. The simulation counts a one-sided 5% test while the product states a two-sided 5% test; under the stated test its own code and inputs need 80 evaluable participants per group, not 55
bears on: ST01, ST02, ST03, ST05, ST06, ST14
where: code
evidence: DEMO-TKA_SSE.qmd:46, :65; Table 1, row "Significance level", p. 1; Sample size, pp. 1–2; work/challenge/s3.log L09, L28–L31; work/challenge/s4.log L22, L25–L26, L28–L29; work/challenge/s2.log L21, L23; work/challenge/s5.log L25; work/results/cd_twosided.diff; work/logs/cd_run_twosided.log; work/challenge/s1.log L36

**What the print and the code say.** The text says the simulation "counted the trials
in which the treatment effect was statistically significant at the two-sided 5% level"
(Sample size, p. 2). Table 1 gives "5%, two-sided" (p. 1). The code rejects when
`pt(t_arm, df = fit$df.residual, lower.tail = FALSE) < alpha`, with alpha 0.05
(DEMO-TKA_SSE.qmd:65, :46). That is a one-sided upper-tail test at 5%, whose critical
value is that of a two-sided 10% test. Every other mention is two-sided, including the
code's own t-test comparison, which uses the two-sided default of `power.t.test`
(qmd:82). So the planned test holds, and line 65 is the slip.

**What the stated test gives.**
- **On the delivered trials.** A copy of the source with only line 65 changed was run
  on the same 2,600 trials. The stated test rejects in 133 of 200 at 55 per group
  (66.5%; 95% interval 59.5% to 73.0%), against 163 of 200 as coded. Its first grid
  point at 80% is 70 (work/challenge/s3.log L28–L31).
- **At 4,000 trials per grid point.** A copy with only the number of trials raised
  gives, under the stated test (work/challenge/s4.log; work/challenge/s5.log L25):
  - 63.6% at 55 per group (95% interval 62.1% to 65.1%);
  - 77.6% at 75 per group;
  - 81.6% at 80 per group (95% interval 80.3% to 82.7%), the first grid point to reach
    80%;
  - a crossing at 79.3 per group for a curve fitted to these counts.
- **Analytically.** An exact unconditional calculation gives the same 80 per group and
  64.2% at 55 (work/challenge/s2.log L21, L23).

These recomputations reuse the product's own inputs, including its unprinted
correlation of 0.5 (F2). For 80 evaluable, the product's own formula gives 96
randomised per group, and N / (1 − 0.20) gives 100 per group and 200 in total
(work/challenge/s1.log L36).

**What it changes.** The error is anti-conservative. At its own inputs, the design as
printed has about 64% power for the test it states. This finding alone removes all
three primary statements. The planned test itself (two-sided 5%, 80%) holds; this is the
slip that the self-contradiction leaves on that row. Absorbed into the cross-cutting
finding on the printed 55 (G1).

fix: make the rejection rule at line 65 two-sided (`2 * pt(abs(t_arm), df = fit$df.residual, lower.tail = FALSE) < alpha`, or compare `coef(summary(fit))["arm", "Pr(>|t|)"]` with alpha); re-run at 4,000 trials per grid point; correct the evaluable N (80 per group at the current inputs), its power, the randomised N (100 per group, 200 in total by N / (1 − 0.20)) and Figure 1.

### F2. The power rests on a baseline-to-6-month correlation that the product neither prints nor sources
bears on: ST01, ST02, ST03, ST08, ST19
where: text and code
evidence: Table 1, p. 1; Sample size, pp. 1–2; DEMO-TKA_SSE.qmd:45, :60–61; work/challenge/s2.log L25, L28, L31, L33–L34; work/challenge/s8.log L10–L11; work/challenge/s7.log L11–L14, L25, L29; analysis/code-and-data/assumption-ledger.csv AL03; analysis/document/consistency-matrix.csv row "Baseline-to-6-month correlation"

**Why the correlation matters.** The primary analysis is an ANCOVA with baseline 6MWD
as a covariate (Sample size, p. 1). Its power therefore depends on the correlation ρ
between the pre-operative and the 6-month 6MWD: adjustment reduces the variance of the
effect estimate by the factor 1 − ρ².

**What the product says.** Table 1 lists no correlation. Yet the text says the trials
were simulated "under the planning values in Table 1" (Sample size, p. 2). The code
sets `rho <- 0.5`, with a comment and no source (qmd:45).

**N under the stated test.** With Table 1's effect and SD, N per group at each
correlation is (work/challenge/s2.log L31):
- 106 at ρ = 0;
- 89 at 0.4;
- 80 at 0.5;
- 68 at 0.6;
- 55 at 0.7.

55 per group gives 80% only at a correlation of 0.696 or more. At 0.69, the stated test
needs 56 per group, and the power at 55 is 79.4% (work/challenge/s2.log L28;
work/challenge/s8.log L10–L11). The printed 55 is therefore reachable under the stated
test only with a correlation of about 0.70 or more. The product does not state such a
value, and its own code uses 0.5.

**How sensitive N is.** The correlation is not the input N is most sensitive to. For
equal relative changes, N is about three times as sensitive to the SD and to the effect
(work/challenge/s7.log L11–L14):
- the elasticities are −0.67 for ρ, 2 for the SD and −2 for the effect;
- a ±10% move gives N 74 to 85 for ρ, 65 to 96 for the SD and 66 to 98 for the effect.

The correlation matters because it is the only planning value with neither a stated
value nor a source, so the product puts no bound on how far it may move.

**The other unprinted values.** The other unprinted values of the generator are the
baseline mean and SD and the outcome means (qmd:60–61). They do not affect the power of
the treatment comparison. On the same draws, the rejections at 55 per group are 123 of
200 at a baseline SD of 60, 90 and 120 (work/challenge/s7.log L25, L29).

Absorbed into the cross-cutting finding on the printed 55 (G1).

fix: add the correlation to Table 1 with its source (for example the registry's paired pre-operative and 6-month 6MWD); recompute under the two-sided test; show N over a plausible range of the correlation together with the SD and the effect (at the current effect and SD: 89, 80, 68 and 55 evaluable per group at ρ 0.4, 0.5, 0.6 and 0.7).

### F3. The chosen N is the first grid point whose single 200-trial estimate reached 80%, which selects an upward Monte Carlo deviation
bears on: ST01, ST02, ST13
where: text and code
evidence: Sample size, pp. 1–2; DEMO-TKA_SSE.qmd:56, :73–74; work/challenge/s1.log L27–L32; work/challenge/s3.log L23; work/challenge/s4.log L21, L24, L26–L27; work/challenge/s5.log L17, L24, L43, L48; analysis/document/arithmetic-checks.csv A08, A14

**The printed estimate.** The printed 81.5% is 163 of 200 trials. Its Monte Carlo SE is
2.75 points, and its 95% interval runs from 75.4% to 86.6% (work/challenge/s1.log
L27–L29). N is taken as the first grid point whose single estimate reaches 80%
(qmd:73–74).

**On the coded terms.** Read on its own coded terms (one-sided, correlation 0.5), the
evidence does not support 55 either:
- **On the delivered trials.** The raw estimates at 60 and 65 per group are 77.0% and
  79.0% (work/challenge/s3.log L23). A curve fitted to the 13 raw counts crosses 80% at
  60.3 per group (95% interval 57.6 to 62.8; work/challenge/s5.log L17).
- **At 4,000 trials per grid point.** The coded rule first reaches 80% at 65 per group
  (crossing 62.4). Its power at 55 is 74.2% (95% interval 72.8% to 75.6%)
  (work/challenge/s4.log L24, L26–L27; work/challenge/s5.log L24).

**The printed estimate as a selection.** The printed 81.5% lies 2.36 Monte Carlo SE
above that value. If the 4,000-trial curve is taken as the truth, the product's rule
lands at 55 or lower with probability 4.4% (work/challenge/s5.log L43, L48).

So even under the one-sided test the code runs, 55 is optimistic by 7 to 8 per group.
Under the stated test, the gap is that of the one-sided rule (F1). Absorbed into the cross-cutting finding
on the printed 55 (G1).

fix: run at least 1,600 trials per grid point (Monte Carlo SE at most 1 point at 80%, work/challenge/s1.log L32; 4,000 gives 0.63 points); choose N from a curve fitted to the raw rejection counts, cross-checked with the analytic ANCOVA formula; report the Monte Carlo interval at the chosen N.

### F4. Figure 1 plots the running maximum of the simulated power, not the estimates its caption names
bears on: ST01, ST02, ST14
where: text and code
evidence: Figure 1 and caption, p. 2; DEMO-TKA_SSE.qmd:73, :137; work/challenge/s3.log L23–L25; work/challenge/s6.log L30–L41; analysis/document/arithmetic-checks.csv A10–A14

**What the caption and the plot say.** The caption reads "Estimated power by number of
evaluable participants per group (200 simulated trials per sample size)" (p. 2). Read
from the page:
- the 13 plotted values never decrease;
- they repeat at five adjacent pairs (work/challenge/s6.log L40–L41);
- they equal `cummax(power_raw)` (qmd:73, plotted at :137).

**What is plotted in place of estimates.** Five plotted values are not estimates
(work/challenge/s3.log L23–L25):

| N per group | Raw estimate | Plotted |
|---|---|---|
| 50 | 65.5% | 68.0% |
| 60 | 77.0% | 81.5% |
| 65 | 79.0% | 81.5% |
| 80 | 85.5% | 89.5% |
| 85 | 89.0% | 89.5% |

**What it changes.** The running maximum leaves 55 and 81.5% unchanged. But it hides
that the target is reached at 55 and missed at 60 and 65. That pattern is the evidence
that 81.5% is an upward deviation (F3). The plotted power is also that of the coded
one-sided test (F1). Absorbed into the cross-cutting finding on the printed 55 (G1).

fix: plot `power_raw` at each grid point with its Monte Carlo interval (or a curve fitted to the raw counts with its band), under the two-sided test, and caption what is plotted.

### F5. The randomised sample size under-inflates for the stated 20% loss to follow-up
bears on: ST03, ST04
where: text and code
evidence: Sample size, p. 2; Table 1, row "Loss to follow-up at 6 months", p. 1; DEMO-TKA_SSE.qmd:76, :147; work/challenge/s1.log L06–L11, L36–L37; analysis/document/arithmetic-checks.csv A01–A05

The product states: "Allowing for 20% loss to follow-up, we will randomise
55 × 1.2 = 66 participants per group, 132 in total" (p. 2).
- **The arithmetic** is right.
- **The formula** is not. At 20% loss, 66 randomised yield 52.8 evaluable per group,
  below 55; the allowance covers loss only up to 16.7% (work/challenge/s1.log L08–L09).
  N / (1 − 0.20) gives 69 per group and 138 in total for 55 evaluable
  (work/challenge/s1.log L10–L11).
- **Where it lives.** The code uses the same formula
  (`ceiling(n_evaluable * (1 + dropout))`, qmd:76), and the prose types "× 1.2"
  (qmd:147).

The shortfall carries into any corrected N. For 80 evaluable, the product's formula
gives 96 per group, and N / (1 − d) gives 100 (work/challenge/s1.log L36). The error is
anti-conservative. Absorbed into the cross-cutting finding on loss to follow-up (G2).

fix: randomise ceiling(N_evaluable / (1 − 0.20)) per group in the code (qmd:76) and the text (qmd:147): 55 → 69 per group (138 in total); 80 → 100 per group (200 in total).

### F6. The estimand names no intercurrent events, and the analysis of all randomised participants is not what the calculation sizes
bears on: ST15, ST16, ST09, ST11
where: text
evidence: Primary endpoint and estimand, p. 1; Sample size, pp. 1–2; Analysis, p. 2; DEMO-TKA_SSE.qmd:59–63; analysis/document/consistency-matrix.csv rows "Estimand: intercurrent events and strategies", "Analysis set", "Missing outcome data"; work/challenge/s1.log L08, L34; work/challenge/recheck/RECHECK.md

**The estimand.** It states its population, treatment conditions, variable and
population-level summary, but no intercurrent events, an attribute that ICH E9(R1)
requires (Primary endpoint and estimand, p. 1). Events that plausibly occur here:
- not starting or stopping the app;
- supervised physiotherapy received in the intervention arm;
- revision surgery, or a complication that makes the walk test impossible;
- death.

**The analysis set against the calculation.**
- **The stated set.** The product says "All randomised participants are analysed in the
  group to which they were allocated" (p. 1).
- **What the analysis includes.** The primary analysis is "the ANCOVA described above"
  (Analysis, p. 2). It is sized on "evaluable participants" (p. 2) and simulated on
  complete data (qmd:59–63). An ANCOVA of the 6-month value includes only participants
  who have one.
- **The rest.** The method that would bring in the other participants is deferred to
  the SAP (Analysis, p. 2).

**What the product does not establish.**
- which effect the 35 m refers to: the effect among participants who complete the
  6-month walk test, or a treatment-policy effect;
- what the 20% allowance assumes about participants without a 6-month value.

"All randomised as allocated" is consistent with a treatment-policy reading. That keeps
the estimand row narrower rather than not established.

**Effect on N.** N scales with 1/δ² (work/challenge/s1.log L34):
- an effect 10% smaller under the chosen strategy raises N by 23%;
- an effect 20% smaller raises it by 56%.

Absorbed into the cross-cutting finding on loss to follow-up (G2).

fix: name the intercurrent events and the strategy for each; state that 35 m is the effect under that strategy; state how participants without a 6-month value enter the analysis of all randomised (for example, missing at random given baseline and arm, by a method the SAP will name) and size the 20% allowance on that basis.

### F7. The unadjusted t-test comparison prints 94 participants per group; Table 1 and the delivered code give 105
bears on: ST18
where: text
evidence: Sample size, p. 2; DEMO-TKA_SSE.qmd:82, :145; work/challenge/s1.log L14, L17, L22–L23; work/challenge/s3.log L21; analysis/document/arithmetic-checks.csv A06–A07; work/logs/cd_reconcile.log (section 5)

The product states: "For comparison, an unadjusted two-sample t-test would require 94
participants per group" (Sample size, p. 2).
- **What Table 1 gives.** With 35 m, SD 90 m, two-sided 5% and 80% power,
  `power.t.test` gives 104.77, rounded up to 105 (work/challenge/s1.log L14).
- **What the code computes.** The hidden chunk computes the same 105 (qmd:82;
  work/challenge/s3.log L21), but the sentence types 94 (qmd:145). The print therefore
  carries a number that its own source does not compute.
- **What 94 would need.** At 94 per group, the t-test has 75.6% power. 94 would follow
  from an SD of 85.2 m or an effect of 37.0 m, and the product states neither
  (work/challenge/s1.log L17, L22–L23).

The ANCOVA N is unaffected. The comparison understates the gain the ANCOVA has to
deliver.

fix: write the computed value inline (`` `r n_ttest` ``): 105 per group with Table 1's values.

## Limits of this review

1. **Six fired modules were not run.** The operator waived them on 2026-11-03.
   - **Simulation diagnostics.** Not done: the ADEMP description, other seeds and RNG
     streams, and a grid finer than 5 per group. The challenge re-ran the product's own
     code at 4,000 trials per grid point on the delivered grid and seed. That settles
     the N at the code's inputs to the grid step of 5 (fitted crossing 79.3, 95%
     interval 78.5 to 80.2; work/challenge/s5.log L25). The N at supported planning
     values stays open. The evaluable N (ST01) and the Monte Carlo design (ST13) are
     settled on what they state, and Q1 is partly answered for this reason.
   - **Sample-size diagnostics.** Not done: the warrant and supported range of the
     effect, the SD, the loss rate and the correlation against the independent
     literature. No literature was searched. This leaves the effect, the SD and the
     loss rate `INTERIM` (ST09, ST10, ST11). The correlation row stays `unverifiable`
     (ST08), because the product names no source.
   - **Regression-model diagnostics.** Not done: robustness of the power to a skewed or
     bounded 6MWD, unequal arm variances or a heterogeneous effect. Leaves the
     data-generating model `INTERIM` (ST12).
   - **Estimand diagnostics** (light pass). Leaves the estimand `INTERIM` (ST15).
   - **Missing-data diagnostics** (light pass). Not done: what the 20% allowance assumes
     about participants without a 6-month value. Leaves the analysis set `INTERIM`
     (ST16).
   - **Rct diagnostics.** Leaves the randomisation `INTERIM` (ST17).
2. **Governing documents and cited sources not in the job.** The missing documents are:
   - the protocol;
   - the SAP, which is not yet written;
   - the hospital TKA registry internal report 2019–2021;
   - the steering committee decision of 3 June 2026.

   Consistency with the protocol is `unverified-here` for:
   - the planned test (ST06);
   - the planned analysis (ST07);
   - the allocation (ST17).

   Whether the cited sources contain the values is `unverified-here` for:
   - the effect (ST09);
   - the SD (ST10);
   - the loss rate (ST11).
3. **No Quarto render.** Quarto is not installed, so the PDF was not regenerated. Figure
   1 was compared with the run numerically, from the PDF's vector graphics. No row is
   left unverified by this.

## Counts

Final ledger, from work/scripts/vd_counts.py and work/logs/vd_counts.log:
- **Holds:** 20 rows: 8 not established, 3 narrower, 9 hold.
- **Status:** 10 settled, 7 `INTERIM`, 2 `unverified-here`, 1 `unverifiable`.
- **Primary rows:** 3, all not established.

**Rows whose Holds moved from the statements stage's.**
- **Toward not established:** one row. The analysis set against the count of evaluable
  participants (ST16) moved from holds to narrower. The defence answers how to size for
  loss, not whether all randomised enter the ANCOVA as described. The evidence is the
  challenge ruling on the analysis set (review/challenge-REPORT.md, section (a)), whose
  load-bearing script was re-run with an identical log and whose pages were opened
  (work/challenge/recheck/RECHECK.md; work/challenge/recheck/s1.log L08).
- **Toward holds:** none.

**Cells that changed without moving Holds.** Each follows a challenge ruling that a
worker re-checked (work/challenge/recheck/RECHECK.md).
- **The evaluable N (ST01).**
  - The correlation threshold is now about 0.70 (0.696), not "about 0.69"; at 0.69 the
    stated test needs 56 (work/challenge/s8.log L10).
  - The N under the stated test at adequate precision is settled at 80, and under the
    coded test at 65 (work/challenge/s4.log L24–L25).
- **The power at 55 (ST02).** The 4,000-trial powers were added (work/challenge/s4.log
  L26).
- **The planning values the simulation uses (ST08).**
  - The claim that the correlation is the input N is most sensitive to was ruled WRONG
    and is replaced by the elasticities (work/challenge/s7.log L11–L14).
  - The baseline SD is dropped from the charge because it does not affect the power
    (work/challenge/s7.log L25, L29).
- **The Monte Carlo design (ST13).** The N at adequate precision is now computed
  (work/challenge/s4.log L24–L25; work/challenge/s5.log L48).
- **The answer to Q1.**
  - The point on Monte Carlo precision is reworded.
  - The ranking "first on the correlation ... then on the SD" was ruled WRONG and is
    replaced.
  - The N under the stated test at adequate precision is now settled at the code's
    inputs.

**Location correction.** The phrases "under the planning values in Table 1" and "at the
two-sided 5% level" are printed on p. 2. Their sentence begins on p. 1, so they are
cited here as Sample size, pp. 1–2.

**Challenge rulings by direction**, from the challenge report's counts
(review/challenge-REPORT.md, section (g)):

| Element rulings (28) | STANDS | STANDS WITH CHANGES | WRONG | ADD |
|---|---|---|---|---|
| against the author | 8 | 7 | 2 | 0 |
| for the author | 9 | 2 | 0 | 0 |

- **Statement rows:** 17 STANDS, 3 STANDS WITH CHANGES (ST01, ST08, ST16), 0 WRONG.
- **The draft answer to Q1:** STANDS WITH CHANGES.
- **Adopted:** every WRONG and STANDS WITH CHANGES ruling. None was set aside.

**Where the stage findings went.**

| Stage findings | Verdict finding |
|---|---|
| C1, S1 | F1 |
| D4 | F2 |
| D5, S2 | F3 |
| D2, C2 | F4 |
| D1 | F5 |
| D6 | F6 |
| D3, C3 | F7 |
