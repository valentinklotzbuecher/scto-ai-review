# Synthesis — Sample Size Estimation, DEMO-TKA: app-guided home exercise versus supervised physiotherapy after total knee arthroplasty (DEMO-01, Version 1.0, 15 September 2026)

Verification: OPEN · 7 not established / 5 narrower / 7 hold

## Status

`COMPLETE`. Depth `standard`; data mode `none`.

- **Challenge.** The challenge stage ran in two groups: the target-N family, and the
  conditions, the randomised N and the answer to the question (review/challenge-REPORT-N.md,
  review/challenge-REPORT-C.md). The load-bearing scripts of its WRONG and STANDS WITH
  CHANGES rulings re-run to identical logs (one runtime field differs), and the pages they
  cite say what they cite (work/challenge/rerun/RERUN-RECORD.md;
  work/logs/coord_rerun_challenge.log).
- **Decided.** Every statement row is decided and none is `INTERIM`; no computation is
  running.
- **Data mode.** `none` leaves nothing unverified: the product reads no file, and every
  printed number is computed or typed in its source (review/intake-scan.json: 0 file reads).
  What is unverified here comes from documents the assignment does not provide (the
  protocol, the registry report, the steering committee decision; the SAP is not yet
  written) and from literature this environment could not reach (Limits of this review).

## What the product establishes and what it does not

**What the evidence establishes.** The print is what the source produces. Rendered
unmodified under R 4.3.3 with its seed 20260108, the delivered source gives every printed
word and number of both pages and all 13 values plotted in Figure 1 (work/logs/cd_render.log;
work/logs/cd_compare_render.log; work/logs/cd_read_figure1.log).

The design holds as a plan:
- a single-centre, individually randomised, two-arm superiority trial, 1:1 in permuted
  blocks of variable size;
- a primary analysis, the ANCOVA of the 6-month 6MWD on treatment and pre-operative
  6MWD, that is the model the calculation fits (2n − 3 residual df, read from the fitted
  object; analysis/code-and-data/regression-model-diagnostics-REPORT.md);
- 80% power for a smallest difference of clinical interest of 35 m, attributed to a dated
  steering committee decision.

The calculation's exactly equal arms cost nothing against the blocks: at most 0.15 points
of power (work/logs/rct_design.log section 1). The arithmetic 55 × 1.2 = 66 and
2 × 66 = 132 is right.

What the inputs give differs from what is printed. The correlation of pre-operative and
6-month 6MWD is the one input the print omits; the only value in the materials is 0.5, set
in a code comment at DEMO-TKA_SSE.qmd:45. At that value, with 35 m, 90 m and 80% power, the
ANCOVA needs:
- 80 evaluable participants per group under the two-sided 5% test Table 1 states (exact
  power 0.7983 at 79 and 0.8034 at 80);
- 63 under the one-sided 5% test the code runs;
- for 20% loss by N / (1 − d), 100 and 79 randomised per group, 200 and 158 in total.

These come from work/logs/ss_exact_ancova.log sections 2 and 4, rebuilt independently in
work/challenge/s1_N_exact.log lines 12–15 and 26 and work/challenge/s1_C_exact.log line 10.

**What it does not establish.** The product does not establish its sample size.

The evaluable N of 55 per group and its power of 81.5% are removed by three things
together (G1):
- a correlation that is neither printed nor sourced;
- a decision rule that tests one-sided where the print states two-sided;
- one 200-trial estimate per grid point, with the first to reach 80% taken.

At the code's correlation, deciding the one-sided rule moves the printed 55 to 63, and the
printed test moves it to 80. The exact one-sided power at 55 is 75.3%; the printed 81.5%
lies 2.03 standard errors above it. Under the printed test, power at 55 is 64.2%
(work/logs/ss_exact_ancova.log section 2; work/challenge/s4_N_print_checks.log line 16). 55
per group is adequate only if the correlation is at least 0.696 under the printed test or
0.585 under the coded one, and nothing in the product supports either value.

The one-sided rule made every printed number, so the two versions of the test compete. The
planned test itself, "5%, two-sided" in Table 1, is therefore not established until the
statistician says which is meant. Two descriptions of the calculation fall with it:
- "counted the trials in which the treatment effect was statistically significant at the
  two-sided 5% level" (Sample size, p. 2) is contradicted by a run of the code;
- "under the planning values in Table 1" is not established, because the simulation also
  uses the unprinted correlation and applies Table 1's level one-sided.

Figure 1 holds only in narrower form: it plots a running maximum, not the estimates its
caption names.

The randomised N of 66 per group, 132 in total, is not established either (G2). ×1.2
covers a loss of 16.7%, so 66 randomised leave 52.8 evaluable at the stated 20%. At 20%
loss, 66 randomised reach 80% power only from a correlation of 0.712 under the printed
test (0.609 one-sided), above the 0.696 at which 55 evaluable suffice
(work/challenge/s1_C_exact.log lines 9 and 15). N / (1 − d) gives 69 per group for 55
evaluable.

Beyond the printed numbers, the N rests on five conditions the product does not state
(G3):
- which effect 35 m is;
- how death or inability to walk at 6 months enter;
- how the lost are handled;
- whether outcomes cluster by physiotherapist;
- whether 90 m holds in the app arm.

Each condition, failing on its own at a magnitude the review chose, moves the evaluable N
at a correlation of 0.5 from 80 to between 98 and 110 per group; an app-arm SD of 70 m
would lower it to 59. The conditions were not quantified jointly. Four supporting
statements hold only in narrower form:
- the 90 m SD and the 20% loss, which come from a hospital registry of 2019–2021 that
  predates the trial;
- the estimand, which names no intercurrent event;
- the sizing of an analysis of all randomised, which holds only if the lost are handled
  as missing at random.

The comparison with an unadjusted t-test prints 94 per group where the printed values give
105.

## Cross-cutting findings

### G1. The evaluable N of 55 per group and its power of 81.5% come from an unsourced correlation, a one-sided decision rule and a single 200-trial estimate above its own rule's power, together
bears on: ST01 (evaluable N), ST02 (power at 55), ST04 (decision rule), ST05 (simulation inputs), ST07 (Figure 1), ST08 (planned test), ST03 (randomised N, through the inflation)

Four findings bear on one number: the sidedness (F1), the correlation (F2), the Monte Carlo
selection (F5) and Figure 1's running maximum (F8). At the source's correlation of 0.5,
they decompose it:

| Step, at a correlation of 0.5 | Evaluable N per group | Power at 55 | Evidence |
|---|---|---|---|
| As printed: the first grid point whose 200-trial estimate under the one-sided rule reached 80%, at the product's seed | 55 | 81.5% (163 of 200) | work/challenge/s2_N_anchor.log lines 8–10 |
| The same one-sided rule, decided: exact; 10,000 trials per point cross at 62.5 and 63.0, first grid point 65 | 63 | 75.3% | work/logs/ss_exact_ancova.log section 2; work/challenge/s1_N_exact.log lines 20, 26; work/challenge/s5_N_sim.log line 21 |
| The printed two-sided 5% test: exact; 10,000 trials per point cross at 78.5 and 79.2 against the exact 79.3, first grid point 80 | 80 | 64.2% | work/logs/ss_exact_ancova.log section 2; work/challenge/s1_N_exact.log lines 5, 15, 45; work/challenge/s5_N_sim.log line 22 |

The correlation is the third component. N runs from 106 to 39 per group over a
correlation of 0 to 0.8, and 55 is the N only from 0.696 (printed test) or 0.585 (coded
test) (work/challenge/s1_N_exact.log lines 29–42). No input set the product states or uses
gives 55. Figure 1, by plotting a running maximum, shows 81.5% at 55, 60 and 65 per group.
The estimates at 60 and 65 are 77.0% and 79.0%, and the exact power under the coded rule is
below 80% at 55 and 60 (work/challenge/s2_N_anchor.log line 14;
work/challenge/s4_N_print_checks.log lines 23–25).

What it removes:
- the evaluable N (ST01) and its power (ST02) are not established;
- the planned test (ST08) is not established, because the one-sided version made every
  printed number;
- the description of the decision rule (ST04) is contradicted by a run of the code;
- the description of the inputs (ST05) is unverifiable as delivered;
- Figure 1 (ST07) holds only in narrower form;
- through ×1.2, the randomised N (ST03) inherits all of it.

What survives is a conditional sample size: 80 evaluable per group under the printed
two-sided test and 63 under the coded one-sided test, at a correlation of 0.5 that the
product would have to print and source; 55 only from 0.696 (0.585). The simulation's grid,
replicates and model (ST06) and the code's reproduction of its print (ST19) hold.

### G2. The randomised N of 66 per group (132 in total) does not deliver the evaluable N, and the N it inflates is not established
bears on: ST03 (randomised N), ST01 (evaluable N), ST12 (loss), ST15 (analysis set and deferral to the SAP)

Four findings bear on one number: the inflation formula (F9), the evaluable N (G1), the
missing-data assumption (F7) and the registry's loss (F4).
- 66 = 55 × 1.2 covers a loss of 16.7%; at the stated 20% it leaves 52.8 evaluable per
  group (analysis/document/arithmetic-checks.csv A05, A06).
- At 20% loss, 66 randomised reach 80% power only from a correlation of 0.712 under the
  printed test (0.609 one-sided). Even at the 0.696 that makes 55 evaluable exactly
  adequate, 66 randomised give 78.2% (work/challenge/s1_C_exact.log lines 12, 15).
- The 20% itself is transported from a hospital registry (F4).
- The allowance gives an analysis of all randomised the complete-case information only if
  the lost are handled as missing at random (F7).

What it removes: the randomised N (ST03) is not established; the loss (ST12) and the
sizing of the analysis of all randomised (ST15) hold only in narrower form.

What survives:
- the printed arithmetic;
- N / (1 − d), which holds the evaluable N in expectation under binomial loss
  (work/results/md_binomial.csv). It gives 69 per group (138 in total) for 55 evaluable;
  at a correlation of 0.5 and under missing-at-random handling, 100 (200) for the 80 the
  printed test needs and 79 (158) for the 63 the coded test needs.

### G3. The sample size assumes five conditions it does not state; each, failing on its own, raises the evaluable N
bears on: ST01 (evaluable N), ST03 (randomised N), ST10 (target difference), ST11 (SD), ST13 (planned analysis), ST14 (estimand), ST15 (analysis set and deferral to the SAP)

Four findings bear on what the evaluable N assumes: the estimand (F3), the registry SD
(F4), clustering (F6) and the handling of the lost (F7). Each condition is built into the
calculation and stated nowhere in the print (work/challenge/s4_C_print.log lines 13–20).
The calculation adds 35 m to every simulated intervention participant, gives every one a
6MWD, keeps complete data, draws independent residuals and uses one SD for both arms
(DEMO-TKA_SSE.qmd:56–63).

Exact N per group, at a correlation of 0.5 under the printed test, one condition at a time,
at magnitudes the review chose (work/challenge/s1_C_exact.log lines 25–31, 33, 40, 46–48):

| Condition, implicit | How it fails | Evaluable N per group (80 if it holds) |
|---|---|---|
| 35 m is the effect of assignment | 35 m is the effect under full adherence, diluted by 10% | 98 (5%: 88; 20%: 124) |
| No death or inability to walk is scored | 1% of each arm scored 0 m in the difference in means | 107 (0.5%: 93; 2%: 134) |
| The lost are handled as missing at random | J2R for the intervention arm's lost | 110 (138 randomised) |
| Outcomes are independent within arm | control arm shared by 4 physiotherapists, ICC 0.02 | at least 98 |
| 90 m holds in both arms | app-arm SD 110 m (70 m) | 105 (59) |

Under the reading the documents support best, N does not move:
- treatment policy for adherence and switching;
- death and inability to walk handled as missing;
- missing-at-random handling of the lost;
- many physiotherapists with an ICC near 0;
- a common SD.

But the product states none of these, and the conditions were not quantified jointly.
Each raises N on its own except a smaller app-arm SD, so the size of their joint effect is
not established.

What it removes: no primary statement on its own, since all three are already not
established, but the supportable N becomes conditional on all five.
- The SD (ST11), the estimand (ST14) and the sizing of the analysis of all randomised
  (ST15) hold only in narrower form.
- The planned analysis (ST13) holds, with independence within arm as a condition.
- Which effect the 35 m target difference (ST10) is stays open.

What survives: the conditional evaluable and randomised N of the two cross-cutting findings
above (G1, G2) hold under these five conditions.

## Statement ledger

| Statement (location) | Kind | Centrality | Holds | Kernel | Not established | Strongest defence | Status |
|---|---|---|---|---|---|---|---|
| The smallest sample size with at least 80% power is 55 evaluable participants per group (estimated power 81.5%). (Sample size, p. 2; DEMO-TKA_SSE.qmd:74, 143; ST01) | calculation | primary | not established | With a difference of 35 m, an SD of 90 m and 80% power, at the pre-operative to 6-month correlation of 0.5 that only the source sets (qmd:45), the planned ANCOVA needs 80 evaluable participants per group under the two-sided 5% test the print states (power 0.7983 at 79, 0.8034 at 80) and 63 (grid point 65) under the one-sided 5% test the code runs; which test is meant is not established (ST08). 55 suffices only at a correlation of at least 0.696 two-sided (55 is the first grid point for 0.696 to 0.730) or 0.585 one-sided. These are exact; 10,000-trial runs of the product's own simulation agree (two-sided fitted crossings 78.5 and 79.2 in two runs against the exact 79.3, first grid point 80; one-sided 62.5 and 63.0, first grid point 65). 55 is the first grid point whose single 200-trial estimate, at the product's seed, reached 80% under the one-sided rule. | That 55 evaluable per group give at least 80% power for the stated design. The correlation 55 needs is neither printed nor sourced, and the source uses 0.5; the calculation tests one-sided where the print states two-sided, and which is meant is not established; and 55 rests on one 200-trial estimate selected as the first to reach 80% (Monte Carlo SE 2.75 points; the rule picks a grid point below 80% true power in 39% of runs). At the only correlation the materials contain, the exact recomputation contradicts 55 under either test. | (1) The true correlation may be 0.70 or more, at which 55 holds under the printed test (exact power 80.4%). (2) Read as the code runs it, one-sided 5%, the design needs fewer participants. (3) Read narrowly, 55 is what the stated procedure returns. Tested: (1) Rests on a value the product does not supply (not printed, no source) and that its own code contradicts (0.5, qmd:45): shields nothing; the missing source is ST05. (2) Tested and failed: one-sided at the code's correlation needs 63, and 55 would need 0.585, also unprinted and unsourced. (3) True, but it does not deliver the statement's point: exact power at 55 under that rule is 75.3%. | settled |
| (estimated power 81.5%), in: The smallest sample size with at least 80% power is 55 evaluable participants per group (estimated power 81.5%). (Sample size, p. 2; DEMO-TKA_SSE.qmd:75, 144; ST02) | calculation | primary | not established | 163 of 200 trials simulated at 55 per group with the product's seed were significant under the one-sided 5% rule the code runs, at the source's unprinted correlation of 0.5 (reproduced exactly; Monte Carlo SE 2.75 points). The power that estimate is for is 75.3% (exact; 75.5% and 74.9% in two 10,000-trial runs). Under the printed two-sided test, power at 55 is 64.2% at a correlation of 0.5 and 80.4% at 0.7. | That the design has 81.5%, or at least 80%, power at 55 per group: the estimate is a single 200-trial draw under the one-sided rule, selected as the first to reach 80% (expected overstatement at the pick 2.0 points), and lies 2.03 SE above the exact power of its own rule (163 or more of 200 at that power has probability 0.023). | The sentence prints an estimate and labels it as one; 81.5% is exactly what the simulation returned. Tested: Tested and failed: the sentence asserts 'at least 80% power' with the estimate as support, and an estimate stands for the power it estimates, 75.3% under the product's own rule; the Wilson 95% interval of 163/200 (75.5% to 86.3%) excludes it. Reproduction with the seed re-runs the product's own number and cannot count for it. | settled |
| Allowing for 20% loss to follow-up, we will randomise 55 × 1.2 = 66 participants per group, 132 in total. (Sample size, p. 2; DEMO-TKA_SSE.qmd:76, 147-148; ST03) | calculation | primary | not established | 55 x 1.2 = 66 and 2 x 66 = 132 are correct arithmetic. 66 randomised per group cover a loss of at most 16.7% for 55 evaluable; at 20% loss they leave 52.8 evaluable in expectation. For 20% loss, N / (1 - d) gives 69 per group (138 in total) for 55 evaluable; at a correlation of 0.5, 100 per group (200 in total) for the 80 evaluable the printed two-sided test needs and 79 (158) for the 63 the one-sided rule the code runs needs (96 and 76 by the product's x1.2), under a complete-case ANCOVA or multiple imputation under missing at random; which test is meant is not established (ST08). | That 66 per group (132 in total) deliver the evaluable N at the stated 20% loss, and that the evaluable N they inflate is adequate (ST01). At 20% loss, 66 randomised reach 80% power only from a correlation of 0.712 under the printed test (0.609 one-sided); at 0.70 they give 78.8% two-sided at 52.8 evaluable (78.6% averaged over binomial loss). | 'Allowing for 20%' can be read as adding 20% to the evaluable N, a common shorthand; and at a correlation of 0.70, the most favourable to 55, the shortfall is small. Tested: Tested and failed: Table 1 states 20% as 'Loss to follow-up at 6 months', and at that rate 66 cover 16.7%. Granting a correlation of 0.70, 66 randomised per group give 78.6% power averaged over binomial loss (78.5% under simple randomisation), while 69 give 80.4%. | settled |
| For sample sizes of 40 to 100 evaluable participants per group, in steps of 5, we simulated 200 trials under the planning values in Table 1, fitted the ANCOVA to each and counted the trials in which the treatment effect was statistically significant at the two-sided 5% level (Figure 1). [part: the decision rule] (Sample size, pp. 1-2; DEMO-TKA_SSE.qmd:65; ST04) | calculation | supporting | not established | The simulation counts a trial as significant when the upper-tail t p-value is below 0.05 (qmd:65): a one-sided 5% test, rejecting for t > 1.659 at 107 residual df where the printed test needs an absolute t above 1.982. Under the null it declares a favourable effect in exactly 5% of trials, against exactly 2.5% for the favourable tail of the printed test (normal generator; the simulation gives 5.05% and 2.57%). Changing that one line to the two-sided p-value moves the product's own pick at its seed from 55 to 70 on the same trials, and the exact N to 80 (crossing 79.3). | That the calculation counted significance at the two-sided 5% level: every printed N, power and plotted value comes from the one-sided rule. A run of the delivered code contradicts the sentence. | The two-sided test is what the trial will use; the code line is a slip and the text describes the intended rule. Tested: Not accepted: which test the trial will use is itself not established (ST08). The statement describes what the calculation did and fails under either reading: the one-line variant on the same trials shows the one-sided rule produced the printed numbers (work/pkg/variants/v1_two-sided.diff; work/logs/cd_v1_two-sided.log). | settled |
| For sample sizes of 40 to 100 evaluable participants per group, in steps of 5, we simulated 200 trials under the planning values in Table 1, fitted the ANCOVA to each and counted the trials in which the treatment effect was statistically significant at the two-sided 5% level (Figure 1). [part: under the planning values in Table 1] (Sample size, pp. 1-2; Table 1 (p. 1); DEMO-TKA_SSE.qmd:45; ST05) | assumption | supporting | not established | The simulation realises the Table 1 difference, SD, allocation and power target, and applies the 5% level one-sided (qmd:65) where Table 1 states two-sided. In addition it uses a pre-operative to 6-month correlation of 0.5 set in the source (qmd:45; realised 0.5002), printed nowhere and sourced nowhere. Over 0 to 0.8 this correlation moves the evaluable N under the printed test from 106 to 39 per group, more than any other input; at 0.5, 80. | That power was simulated under the planning values in Table 1, and any value for the correlation: none is printed, none has a source, and 55 needs at least 0.696 (two-sided) or 0.585 (one-sided). | The correlation of pre-operative and 6-month 6MWD may be documented elsewhere, for example in the registry report the product cites for the SD. Tested: Rests on material the product does not supply: no source is cited for the correlation, so the defence shields nothing. Unverifiable as delivered. | unverifiable |
| For sample sizes of 40 to 100 evaluable participants per group, in steps of 5, we simulated 200 trials under the planning values in Table 1, fitted the ANCOVA to each and counted the trials in which the treatment effect was statistically significant at the two-sided 5% level (Figure 1). [part: the grid, the replicates and the model fitted] (Sample size, pp. 1-2; DEMO-TKA_SSE.qmd:56, 59-63, 70-71; ST06) | calculation | supporting | holds | The code simulates 200 trials at each of 40, 45, ..., 100 evaluable per group from one seed (20260108) and fits in every trial the planned ANCOVA of the 6-month 6MWD on treatment and baseline (2n - 3 residual df, read from the fitted object). The render reproduces every value exactly. | Nothing in the description. 200 trials per point give a Monte Carlo SE of about 2.8 points near 80%, too few to decide where power crosses 80%; that bears on ST01, ST02 and ST07. | The description matches the code line by line. Tested: Challenged on whether the code fits the model the text names: read from the fitted object, the model is treatment + baseline with nobs 2n and 2n - 3 residual df, and an independent closed-form replica reproduces all 26 delivered decisions under both rules. Stands. | settled |
| Figure 1: Estimated power by number of evaluable participants per group (200 simulated trials per sample size). Dashed line: 80% power; dotted line: chosen sample size. (Figure 1 and caption, p. 2; DEMO-TKA_SSE.qmd:72-73, 131-141; ST07) | result | supporting | narrower | Figure 1 plots the running maximum of 13 single 200-trial estimates under the one-sided rule the code runs, at a correlation of 0.5 (the product's seed); read from the PDF's vector graphics, the plotted values equal the code's running maximum at all 13 points. At 8 of the 13 points that is the estimate; at 50, 60, 65, 80 and 85 per group the estimates are lower than plotted (65.5%, 77.0%, 79.0%, 85.5%, 89.0%). No Monte Carlo error is shown (SE 1.5 to 3.4 points). The dashed line (0.80) and the dotted line (55) are as the caption says. | That the plotted values are the estimated power at each sample size, and the reading that power is at least 80% from 55 per group on: the simulation shows 77.0% and 79.0% at 60 and 65, and the exact power under the same rule is below 80% at 55 and 60 (75.3%, 78.5%) and above it at 65 (81.4%). | Power increases with N, so a running maximum is a defensible smoother of noisy estimates, and it does not change the chosen N. Tested: Partly holds: the running maximum does not change the first grid point at 80% or the printed 81.5%. It fails as a smoother: it is biased upward and lowers a fitted crossing by 1.2 per group on average over seeds (in 98.5% of seeds), and the caption does not say it is applied. | settled |
| Table 1, row 'Significance level': 5%, two-sided (Table 1, row 'Significance level' (p. 1); DEMO-TKA_SSE.qmd:46, 114; ST08) | specification | supporting | not established | Table 1 and the decision rule (Sample size, pp. 1-2) state a two-sided 5% test. The code applies the same 5% level one-sided (alpha, qmd:46, in the decision rule at qmd:65), and every printed N, power and plotted value comes from that one-sided rule: 55, 81.5%, 66 and 132 as delivered, against 70, 80.5%, 84 and 168 with the two-sided line on the same trials. At the source's correlation of 0.5 neither version gives 55: 80 per group two-sided, 63 one-sided. | Which test the trial will use. The one-sided version made every printed number, so it is not an isolated slip: the two versions compete, and the element is not established until the statistician says which is meant. If one-sided 5% is meant, Table 1 and the decision rule are wrong and the favourable-direction type I error is 5%, twice the 2.5% of the printed test. Holds moved from holds: the printed numbers are the one-sided outputs (work/challenge/s2_N_anchor.log lines 4, 9-11 against 22, 27-29; re-run identical, work/logs/coord_rerun_challenge.log); status moved from unverified-here, because no document the review could obtain decides between two versions the product itself states. | Both printed mentions state two-sided 5%, and the code implements only the calculation's decision rule, nowhere the trial's analysis, so the planned test has one version. Tested: Tested and failed: the print says the simulation ran 'under the planning values in Table 1', and Table 1's level is that planning value; the code is the only other mention and it disagrees. The t-test chunk's two-sided default (qmd:82) does not use alpha and produces no printed number. | settled |
| Table 1, row 'Power': 80% (Table 1, row 'Power' (p. 1); DEMO-TKA_SSE.qmd:47, 115; ST09) | specification | supporting | holds | The design targets 80% power; the code's target is 0.80 (qmd:47) and Figure 1's dashed line is at 0.8000. Every N the review derives uses it. | none | Consistent in Table 1, the code and Figure 1. Tested: Not attacked: no check bears against it. | settled |
| Table 1, row 'Smallest difference of clinical interest': 35 m; source 'Agreed with the investigators (steering committee, 3 June 2026)' (Table 1, row 'Smallest difference of clinical interest' (p. 1); DEMO-TKA_SSE.qmd:43, 112; ST10) | assumption | supporting | holds | 35 m is the smallest difference of clinical interest that the print attributes to a steering committee decision of 3 June 2026, the right kind of source for a judgement of importance; the code adds it to every simulated intervention participant. N scales as 1/delta^2: at a correlation of 0.5 and the printed two-sided test, 30, 35 and 40 m need 108, 80 and 62 evaluable per group. | The decision itself, which is not in the job (unverified-here); whether app-guided home exercise can achieve 35 m over supervised physiotherapy (the product claims importance only); and which effect 35 m is, of assignment or under full adherence (ST14): if under full adherence, dilution of 5%, 10% or 20% (the review's scenarios) raises N to 88, 98 or 124 at a correlation of 0.5 (printed two-sided test). | A smallest difference of clinical interest is a judgement of importance, and a dated steering committee decision is the right kind of source for it. Tested: Untestable against the cited decision (not in the job); the source type fits the claim. The independent literature (published minimal important change of the 6MWT after TKA) could not be obtained in this environment. | unverified-here |
| Table 1, row 'SD of 6MWD at 6 months': 90 m; source 'Hospital TKA registry, 2019–2021 (internal report)' (Table 1, row 'SD of 6MWD at 6 months' (p. 1); DEMO-TKA_SSE.qmd:44, 113; ST11) | assumption | supporting | narrower | 90 m is the 6-month SD the print attributes to the hospital's TKA registry, 2019-2021, a source that predates the trial and describes care outside it; the calculation gives it to both arms. N scales as SD^2: at a correlation of 0.5 and the printed two-sided test, 80, 90 and 100 m need 63, 80 and 98 evaluable per group. | That 90 m applies to the trial's eligible participants, measured with the standardised protocol by blinded assessors, and to both arms: the registry cannot cover app-guided home exercise. An app-arm SD of 110 m (control 90 m) raises N from 80 to 105; 70 m lowers it to 59 (the review's scenarios; printed two-sided test, correlation 0.5). The registry report is not in the job (unverified-here). | The registry is the trial hospital's own; a common SD across arms is the usual planning convention; trial eligibility and standardised measurement tend to lower the SD, so 90 m may be conservative. Tested: Untestable here (registry not in the job). It would account for the control arm only, not for the app arm, so it keeps the row from not established but does not restore the full statement. The independent literature (6-month 6MWD SDs in comparable trials, by arm) could not be obtained in this environment. | unverified-here |
| Table 1, row 'Loss to follow-up at 6 months': 20%; source 'Hospital TKA registry, 2019–2021 (internal report)' (Table 1, row 'Loss to follow-up at 6 months' (p. 1); DEMO-TKA_SSE.qmd:48, 116, 147; ST12) | assumption | supporting | narrower | 20% is the 6-month loss the print attributes to the hospital's TKA registry, 2019-2021, the same source as the 6-month SD, so the registry had a 6-month 6MWD assessment. It moves the randomised N only: for 80 evaluable, 10%, 20% and 30% loss need 89, 100 and 115 randomised per group by N / (1 - d). | That 20% is the expected share of randomised trial participants without a 6-month 6MWD: it is not shown that loss in care at the hospital in 2019-2021 carries over to a consented, randomised cohort with blinded trial assessors, nor whether it counts deaths and those unable to walk (ST14). The registry report is not in the job (unverified-here). | Registries usually lose more patients than a trial with scheduled assessments, so 20% may be conservative. Tested: Untestable here (registry not in the job); the direction of the transport error is not established either way. Recorded; it keeps the row from not established. The independent literature (attrition at 6 months in comparable rehabilitation trials) could not be obtained in this environment. | unverified-here |
| The primary analysis is an analysis of covariance (ANCOVA) of 6MWD at 6 months with treatment group and baseline 6MWD as covariates. / The primary analysis is the ANCOVA described above. (Sample size, p. 1; Analysis, p. 2; DEMO-TKA_SSE.qmd:63; ST13) | specification | supporting | holds | The primary analysis is a linear ANCOVA of the 6-month 6MWD on treatment and the pre-operative 6MWD, a pre-randomisation covariate; the calculation fits exactly this model (read from the fitted object). Its size stays near 5% under skew, a ceiling and a concave baseline relation at equal arms (4.8% to 5.3%). | That outcomes are independent within arm: how the comparator is delivered is not printed. With the control arm shared by 4 physiotherapists at an ICC of 0.02 (the review's scenario), the planned ANCOVA's size is about 7% (7.1% and 7.6% in two simulations, 7.2% closed form) and N rises from 80 to at least 98 per group (printed two-sided test, correlation 0.5). With unequal arms (70 and 90 evaluable) and an app-arm SD of 110 m, the model-based test's size is 5.6% to 5.7%. | At a single centre, outpatient physiotherapy is usually delivered by many therapists each treating few participants, so the ICC is near 0 and the planned ANCOVA is valid. Tested: Untestable here (the protocol, which would say how the comparator is delivered, is not in the job); the documents do not contradict it. Recorded as a condition of the row. | unverified-here |
| The primary estimand is the difference in mean 6MWD at 6 months between app-guided home exercise and supervised physiotherapy in adults undergoing primary TKA who are eligible for the trial. (Primary endpoint and estimand, p. 1; ST14) | specification | supporting | narrower | The estimand states the population (eligible adults undergoing primary TKA), the treatment conditions (app-guided home exercise against supervised outpatient physiotherapy, 12 weeks each), the variable (6MWD at 6 months) and the summary (difference in means). Read with 'All randomised participants are analysed in the group to which they were allocated', it is consistent with a treatment-policy strategy for non-adherence and switching, and 'smallest difference of clinical interest' reads as the target for the estimand so defined. | The intercurrent events and their strategies: none is named. So it is not stated whether 35 m is the effect of assignment or of full adherence (if the latter, 5%, 10% or 20% dilution raises N from 80 to 88, 98 or 124), nor how death or inability to walk at 6 months enter, after which no 6MWD exists (scored 0 m in 0.5%, 1% or 2% of each arm: 93, 107 or 134; handled as missing within the 20%: unchanged). Scenario magnitudes the review's; printed two-sided test, correlation 0.5. | Analysing all randomised as allocated implies treatment policy for non-adherence and switching, and the remaining events can be specified in the protocol or SAP. Tested: Partly supported: the analysis-set sentence fixes the set, not a strategy, but it is consistent with treatment policy for adherence and switching. That narrows the attack to which effect 35 m is and to the truncating events, for which treatment policy gives no 6MWD. Not testable further here (protocol and SAP not in the job). | settled |
| All randomised participants are analysed in the group to which they were allocated. / The handling of missing outcome data and any sensitivity analyses will be specified in the statistical analysis plan. (Primary endpoint and estimand, p. 1; Analysis, p. 2; ST15) | specification | supporting | narrower | The analysis set is all randomised, as allocated; missing-data handling is deferred to the SAP, not yet written, which is legitimate at this stage. The calculation sizes evaluable participants with complete data (qmd:56-62) and inflates for loss, which gives an analysis of all randomised the complete-case information only if the lost are handled as missing at random given baseline and arm (complete cases, or multiple imputation under MAR: 79.4% against 79.8% for complete cases at 100 randomised in the same trials). Then 80 evaluable and 100 randomised per group at a correlation of 0.5 (printed two-sided test). | That the calculation sizes an analysis of all randomised under whatever handling the SAP chooses; the SSE does not state the assumption. Under J2R for the intervention arm, or delta adjustment of 17.5 or 35 m (the review's scenarios), N rises to 110/138, 98/123 or about 128/160 evaluable/randomised per group (124/155 by the approximation), and a trial sized under MAR keeps 61.5% to 71.7% power. | Deferring missing-data handling to the SAP is normal at the SSE stage, and a MAR-based primary analysis of all randomised has the complete-case information, so the allowance holds. Tested: Untestable here (the SAP is not written). It accounts for the evidence only if the SAP chooses MAR, which the product does not state; it keeps the row from not established, and the narrower scope stands. | settled |
| DEMO-TKA is a planned single-centre, randomised, controlled, parallel-group superiority trial in adults undergoing primary total knee arthroplasty (TKA). ... participants are randomised 1:1, in permuted blocks of variable size, to app-guided home exercise (intervention) or to supervised outpatient physiotherapy (control); Table 1, row 'Allocation ratio': 1:1 (Study design, p. 1; Table 1, row 'Allocation ratio' (p. 1); DEMO-TKA_SSE.qmd:59, 117; ST16) | specification | supporting | holds | A two-arm, individually randomised, parallel-group superiority design, 1:1 in permuted blocks of variable size, unstratified, at one centre. The calculation's exactly equal arms stand in for the blocks at no cost to N: arms up to 8 apart change power by at most 0.15 points (0.07 points at 100 randomised per group and a correlation of 0.5), and even simple randomisation costs 0.2 to 0.3 points. | none for the design as stated; block sizes and stratification are for the protocol (not in the job). | As the kernel. Tested: Challenged by arm-size imbalance and chance baseline imbalance (already in the exact power): neither moves N. | settled |
| Because adjustment for baseline increases precision, we estimated power by simulation. (Sample size, p. 1; ST17) | interpretation | supporting | holds | Adjusting for a baseline that correlates with the outcome lowers the residual variance by the factor 1 - rho^2 (less one df and a chance-imbalance term), so the ANCOVA needs fewer participants than a t-test: at a correlation of 0.5, 80 against 105 per group (23.8% fewer). The size of the gain is set by the correlation, which is not printed (ST05). | The size of the gain in this trial (ST05); the sentence claims only its direction. | The direction is a standard result, and it is all the sentence claims. Tested: Not reversed: at a correlation of 0 the exact ANCOVA needs 106 against the t-test's 105, so the gain needs a non-zero correlation, which the product assumes without printing it. | settled |
| For comparison, an unadjusted two-sample t-test would require 94 participants per group. (Sample size, p. 2; DEMO-TKA_SSE.qmd:82, 145; ST18) | calculation | peripheral | not established | At the printed values (35 m, 90 m, two-sided 5%, 80%) an unadjusted two-sample t-test needs 105 per group (104.77; the code computes it and never prints it, and three methods agree); 94 per group give 75.6% power. Like for like at a correlation of 0.5, the ANCOVA saves 105 to 80 (23.8%) two-sided, or 83 to 63 (24.1%) one-sided. | 94 per group, which the recomputation contradicts; and the saving the printed pair implies (94 to 55, 41.5%), which sets a two-sided t-test against the one-sided ANCOVA and implies a correlation of 0.644. | 94 may come from the planning values of an earlier draft. Tested: Rests on values the product does not print (94 matches an SD of 84.7 to 85.2 m or a difference of 37.0 to 37.2 m): shields nothing; the delivered code itself computes 105. | settled |
| Simulations were run in R version 4.3.3 (2024-02-29). The simulation code and the random seed are part of the source of this document. (Software, p. 2; DEMO-TKA_SSE.qmd:70, 157; ST19) | specification | peripheral | holds | The delivered source renders unmodified under R 4.3.3, the printed version, and reproduces every printed word and number and all 13 plotted values exactly with its seed 20260108; the t-test N of 94 is typed text that the code does not compute (it computes 105, never printed; ST18). It uses base R and stats only and reads no file. | none; the PDF metadata records no R version, so the printed version comes from the inline expression (qmd:157). | As the kernel. Tested: Challenged by a render in the review environment (Typst 0.13.0 against 0.15.1): only three hyphenations differ; the code's numbers re-run independently with the seed. | settled |

No rows were folded.

## Recomputation table

| Quantity | Printed (location) | Recomputed | Method and inputs | Agreement | Evidence |
|---|---|---|---|---|---|
| Evaluable N per group, two-sided 5% (the printed test) | 55 (Sample size, p. 2) | 80 at a correlation of 0.5; 55 only from 0.696 | Exact unconditional ANCOVA power. Inputs from Table 1 (35 m, 90 m, 80%, 1:1); correlation 0.5 from the source (qmd:45), not printed. Rebuilt independently. The product's own simulation with its decision line made two-sided, 10,000 trials per point: crossings 78.5 and 79.2, first grid point 80 | disagrees | work/logs/ss_exact_ancova.log section 2; work/challenge/s1_N_exact.log lines 12–15, 29; work/results/sim_crossing.csv; work/challenge/s5_N_sim.log line 22 |
| Evaluable N per group, one-sided 5% (the rule the code runs) | 55 (Sample size, p. 2) | 63 (grid point 65); 55 only from 0.585 | As above, one-sided. The product's own simulation as delivered, 10,000 trials per point: crossings 62.5 and 63.0, first grid point 65 | disagrees | work/logs/ss_exact_ancova.log section 2; work/challenge/s1_N_exact.log lines 26, 31; work/challenge/s5_N_sim.log lines 20–21 |
| Evaluable N per group by the product's own procedure | 55 (Sample size, p. 2) | 55 as delivered; 70 with the decision line made two-sided | The delivered code run unmodified with its seed 20260108, and with one line changed. Reuses the product's inputs, seed, 200 trials and selection rule, so it shows reproduction, not adequacy | agrees | work/logs/cd_delivered.log; work/logs/cd_v1_two-sided.log; work/challenge/s2_N_anchor.log lines 9, 27 |
| Power at 55 per group | 81.5% (Sample size, p. 2) | 75.3% one-sided and 64.2% two-sided at a correlation of 0.5; 80.4% two-sided at 0.7 | Exact; inputs from Table 1, correlation as stated. 10,000-trial runs of the product's function: 75.5% and 74.9% one-sided | disagrees | work/logs/ss_exact_ancova.log section 2; work/challenge/s1_N_exact.log lines 5, 20, 32; work/challenge/s5_N_sim.log line 11; analysis/code-and-data/results.csv SIM07 |
| 81.5% as a count of 200 trials | 81.5% (Sample size, p. 2) | 163 of 200; Monte Carlo SE 2.75 points, Wilson 95% interval 75.5% to 86.3% | The delivered code at its seed, which reuses the product's inputs and seed; binomial SE and Wilson interval | agrees | analysis/document/arithmetic-checks.csv A11; work/challenge/s2_N_anchor.log line 8; work/challenge/s4_N_print_checks.log lines 14–15 |
| Randomised N per group | 66 (Sample size, p. 2) | 69 for 55 evaluable; at a correlation of 0.5, 100 for 80 (two-sided) and 79 for 63 (one-sided) | ⌈N / (1 − 0.20)⌉, loss from Table 1; the printed ×1.2 covers 16.7% | disagrees | analysis/document/arithmetic-checks.csv A03, A06; work/logs/ss_exact_ancova.log section 4; work/challenge/s1_C_exact.log lines 9–10 |
| Total randomised | 132 (Sample size, p. 2) | 138 for 55 evaluable; at a correlation of 0.5, 200 (two-sided) and 158 (one-sided) | Twice the per-group N | disagrees | analysis/document/arithmetic-checks.csv A04; work/challenge/s1_C_exact.log line 10 |
| "55 × 1.2 = 66", "132 in total", as arithmetic | 66; 132 (Sample size, p. 2) | 66; 132 | The printed multiplication | agrees | analysis/document/arithmetic-checks.csv A01, A02 |
| Evaluable N left by 66 randomised at 20% loss | 55, the evaluable target (Sample size, p. 2) | 52.8 | 66 × (1 − 0.20) | disagrees | analysis/document/arithmetic-checks.csv A05; work/challenge/s1_C_exact.log line 9 |
| Unadjusted two-sample t-test, N per group | 94 (Sample size, p. 2) | 105 (104.77) | power.t.test, the normal approximation with z²/4, and the non-central t with both tails; inputs from Table 1. The delivered code also computes 105 | disagrees | analysis/document/arithmetic-checks.csv A07; work/logs/ss_exact_ancova.log section 6; work/challenge/s4_N_print_checks.log lines 4–7; work/challenge/s2_N_anchor.log line 12 |
| Power plotted at 60 and 65 per group | 81.5% at both (Figure 1, p. 2) | Simulated 77.0% and 79.0% (200 trials, the product's seed); exact one-sided 78.5% and 81.4% | The delivered code's estimates before the running maximum; exact one-sided power | disagrees | work/challenge/s2_N_anchor.log lines 6, 14; work/challenge/s4_N_print_checks.log lines 24–25 |

## Answers to the assignment questions

### Q1. Is the sample size adequate for the stated design?

No, not as delivered. The product does not establish that 55 evaluable and 66 randomised
participants per group (132 in total) are adequate. At the only correlation its materials
contain, they are too few under either reading of its test.

The stated design is an ANCOVA of the 6-month 6MWD on treatment and pre-operative 6MWD,
for a 35 m difference with an SD of 90 m, 80% power, 1:1 allocation and 20% loss. Its test
is stated two ways: Table 1 and the decision rule say two-sided 5%, and the calculation
runs one-sided 5% (DEMO-TKA_SSE.qmd:65). Which is meant is not established. The answer is
the same under either.

- At the correlation of 0.5 the code uses, printed and sourced nowhere, the ANCOVA needs
  80 evaluable per group two-sided (63 one-sided). For 20% loss by N / (1 − d) that is
  100 (79) randomised per group, 200 (158) in total. These are exact; the continuous
  crossing is 79.3 two-sided (work/challenge/s1_C_exact.log lines 5, 10, 52;
  work/logs/ss_exact_ancova.log sections 2 and 4).
- 55 evaluable suffice only from a correlation of 0.696 two-sided (0.585 one-sided). ×1.2
  covers 16.7% loss, so at 20% loss 66 randomised leave 52.8 evaluable; they suffice only
  from 0.712 (0.609) (work/challenge/s1_C_exact.log lines 7, 9, 15).
- The printed 55 is the first grid point whose single 200-trial estimate under the
  one-sided rule reached 80%. The power there is 75.3% under that rule and 64.2% under
  the printed test (work/challenge/s1_N_exact.log lines 5, 20).

Whether a sample size is adequate at the true correlation cannot be told from the
materials. The correlation moves N more than any other input (106 to 39 per group over 0
to 0.8; work/challenge/s1_N_exact.log lines 35–42), and the product gives no value or
source for it.

N also depends on conditions the product does not state. One at a time, at magnitudes the
review chose (work/challenge/s1_C_exact.log lines 26, 30, 33, 40, 46–48):
- the app arm's SD: 110 m needs 105, 70 m needs 59;
- whether 35 m is the effect of assignment: 10% dilution of a full-adherence effect needs
  98;
- how death or inability to walk enter: 1% of each arm scored 0 m needs 107; handled as
  missing, no change;
- the SAP's handling of the lost: J2R needs 110 evaluable, 138 randomised;
- clustering by physiotherapist: 4 physiotherapists at an ICC of 0.02 need at least 98.

These were not quantified jointly.

basis: ST01, ST02, ST03, ST04, ST05, ST08 (the N and its calculation); ST10, ST11, ST12, ST13, ST14, ST15 (the conditions); cross-cutting findings G1, G2, G3; findings F1–F9
status: answered

## Data and reproducibility

- **Data mode `none`.** The product reads no file: the intake scan finds 0 file reads,
  and every variable is simulated in the source (qmd:59–62). The data-contract audit does
  not apply, and no evidence ladder applies (review/code-and-data-REPORT.md, Data-contract
  audit).
- **What ran.** The delivered DEMO-TKA_SSE.qmd ran, unmodified, in a working copy. It was
  rendered by `quarto render` (Quarto 1.7.32, Typst 0.13.0, R 4.3.3, the printed R
  version) and also run as purled R code in one session (work/logs/cd_render.log;
  work/logs/cd_delivered.log). Further runs:
  - a one-line two-sided variant (work/pkg/variants/v1_two-sided.diff;
    work/logs/cd_v1_two-sided.log);
  - the product's `simulate_power()` at 2,000 and 10,000 trials, with only the replicate
    count and the seed changed (work/logs/cd_fixedN_sidedness.log;
    work/results/sim_nearcross.csv);
  - the product's chunks, run independently by the challenge (work/challenge/s2_N_anchor.log;
    work/challenge/s1_C_exact.log lines 2–3).
- **The render matches the delivered PDF.** Every word and number and all 13 plotted
  values agree; only three hyphenations differ, from the Typst version
  (work/logs/cd_compare_render.log; work/logs/cd_read_figure1.log). The PDF was made on
  28 October 2026, after the version date of 15 September 2026. Because the render
  reproduces it, no number comes from a stale render.
- **Code–text mismatches.**
  - Test sidedness: the code tests one-sided (qmd:65), the text two-sided (F1).
  - Correlation: set in the code (qmd:45), absent from the print, although the text says
    the simulation used the Table 1 values (F2).
  - Figure 1: it plots `cummax(power_raw)` (qmd:73), and the caption says "Estimated
    power" (F8).
  - t-test N: typed as 94 (qmd:145), while the code computes 105 (qmd:82) and never
    prints it (F10).
  - Equal arms and complete data: the code simulates both, where the design randomises in
    blocks and analyses all randomised. The blocks cost nothing (Statement ledger, the
    design row); the analysis set is the missing-data finding (F7).
- **Quarto and R mechanics.**
  - `echo`, `warning` and `message` are false for every chunk; re-run with
    `options(warn = 1)`, no warning was printed.
  - Every computing chunk is `include: false`. There is no `eval: false`, `error: true`,
    cache or freeze.
  - Base R and `stats` only: no package loads, no file reads, no paths.
  - One `set.seed(20260108)` with the default RNG. The grid points draw from one stream
    in order, so the printed 55 is a property of the seed (F5).
  - `power.t.test` uses its own default `sig.level`, which equals `alpha` only by
    coincidence (F10).
  - CRLF line endings have no effect.
  - Source: review/code-and-data-REPORT.md, Code against text.
- **What the checks covered.** Every chunk, all six inline expressions, every printed
  number and every plotted value. They do not cover the cited sources or the protocol
  (Limits of this review).

## Findings

### F1. The calculation tests one-sided at 5% where Table 1 and the decision rule state a two-sided 5% test; every printed number comes from the one-sided rule, so which test the trial will use is not established
bears on: ST08 (planned test), ST04 (decision rule), ST01 (evaluable N), ST02 (power at 55), ST03 (randomised N), ST05 (simulation inputs), ST07 (Figure 1), ST18 (t-test comparison)
where: unresolved
evidence: Table 1, row "Significance level" (p. 1); Sample size (pp. 1–2); DEMO-TKA_SSE.qmd:46, 65, 82; work/pkg/variants/v1_two-sided.diff; work/logs/cd_v1_two-sided.log; work/logs/ss_exact_ancova.log section 2; work/results/sim_typeI.csv; work/challenge/s2_N_anchor.log lines 4, 9–11, 22, 27–29; work/challenge/s1_N_exact.log lines 15, 26, 45–46, 56–58; review/code-and-data-REPORT.md, the sidedness finding (C1); review/challenge-REPORT-N.md, the ruling on the planned test

Table 1 (p. 1) states the significance level as "5%, two-sided". The Sample size section
(p. 2) counts trials significant "at the two-sided 5% level". The decision line at qmd:65,
`pt(t_arm, df = fit$df.residual, lower.tail = FALSE) < alpha`, is an upper-tail test at
5%. At 107 residual df it rejects for t > 1.659, where the printed test needs an absolute t
above 1.982. Under the product's normal generator, its favourable-direction type I error
is exactly 5%, twice the 2.5% of the printed test; the simulation gives 5.05% and 2.57%.

Every printed N, power and plotted value comes from this one-sided rule. With the decision
line changed to the two-sided p-value, on the same simulated trials, the product's own
procedure at its seed gives 70, 80.5%, 84 and 168 instead of 55, 81.5%, 66 and 132.
Decided exactly at the source's correlation of 0.5, N is 80 evaluable per group two-sided
and 63 one-sided.

Because the one-sided version made every printed number, it is not an isolated slip. The
two versions compete, and the planned test is not established until the author says which
is meant. The t-test comparison inherits the mix: it sets a two-sided t-test (qmd:82)
against the one-sided ANCOVA.

fix: First, which test will the trial use? If two-sided 5%, as Table 1 states: count a trial as significant when `2 * pt(abs(t_arm), df = fit$df.residual, lower.tail = FALSE) < alpha` (qmd:65), and re-derive N; that is 80 evaluable and 100 randomised per group at a correlation of 0.5 (the correlation finding, F2). If one-sided: state one-sided in Table 1 and in the decision rule, and justify the level; a one-sided 2.5% test keeps the favourable-direction error of the stated design.

### F2. The evaluable N rests on a baseline–outcome correlation that is neither printed nor sourced; 55 per group needs at least 0.696 under the printed test (0.585 one-sided), where the code uses 0.5
bears on: ST05 (simulation inputs), ST01 (evaluable N), ST02 (power at 55), ST03 (randomised N), ST17 (gain from baseline adjustment), ST18 (t-test comparison)
where: text and code
evidence: Table 1 (p. 1); Sample size (p. 1); DEMO-TKA_SSE.qmd:45; analysis/document/arithmetic-checks.csv A08–A10; analysis/code-and-data/assumption-ledger.csv A03; work/logs/doc_arithmetic.log; work/logs/ss_exact_ancova.log sections 2–3; work/results/ss_sensitivity.csv; work/challenge/s1_N_exact.log lines 29–42; work/challenge/s4_C_print.log line 25; review/document-REPORT.md, the correlation finding (D1); analysis/code-and-data/sample-size-diagnostics-REPORT.md, the exact second method (SS1)

The ANCOVA's power depends on the residual SD, 90 × √(1 − ρ²). So it depends on the
correlation ρ of pre-operative and 6-month 6MWD as much as on the difference and the SD.
Table 1 lists no correlation, and the print never mentions one. Yet the text says power
was simulated "under the planning values in Table 1" (p. 1). The source sets ρ = 0.5 in a
code comment with no source (qmd:45).

Exact power, inputs from Table 1, two-sided 5% (work/challenge/s1_N_exact.log lines 35–42):

| Correlation | 0 | 0.3 | 0.4 | 0.5 | 0.6 | 0.7 | 0.8 |
|---|---|---|---|---|---|---|---|
| Evaluable N per group | 106 | 96 | 89 | 80 | 68 | 55 | 39 |
| Randomised per group, N / (1 − 0.20) | 133 | 120 | 112 | 100 | 85 | 69 | 49 |
| Power at 55 per group | 52.1% | 55.9% | 59.3% | 64.2% | 71.0% | 80.4% | 91.8% |

- 55 is the N only from ρ 0.696 under the printed test, where it is the first grid point
  up to 0.730, or from ρ 0.585 under the coded one-sided test.
- The correlation moves N more than any other input.
- With no value printed and no source, it is unverifiable as delivered.
- The printed pair of 94 and 55 implies ρ 0.644 (F10).

fix: Add the correlation to Table 1 with its source; the registry that supplies the SD could give it for patients who meet the eligibility criteria. Compute N at the test the trial will use, from exact power or from a simulation that decides the crossing. Print N over a plausible range of the correlation, for example 0.4 to 0.7, next to the chosen value.

### F3. The estimand names no intercurrent events and no strategies, so it is not stated which effect the 35 m difference refers to, nor how death or inability to walk at 6 months enter
bears on: ST14 (estimand), ST10 (target difference), ST15 (analysis set and deferral to the SAP), ST01 (evaluable N), ST03 (randomised N)
where: text
evidence: Primary endpoint and estimand (p. 1); Analysis (p. 2); work/challenge/s4_C_print.log lines 13–16; analysis/code-and-data/assumption-ledger.csv A09, A10; work/logs/ss_exact_ancova.log section 3; work/logs/est_truncation.log; work/results/est_composite.csv; work/challenge/s1_C_exact.log lines 25–31; work/challenge/s2_C_sim.log lines 3–6; review/document-REPORT.md, the estimand finding (D5); analysis/code-and-data/estimand-diagnostics-REPORT.md, the truncating events (EST1); review/challenge-REPORT-C.md

The estimand states the population, the treatments, the variable and the summary (p. 1).
It names no intercurrent event. The print never mentions adherence, switching,
discontinuation, death or re-operation.

**Which effect 35 m is.** "All randomised participants are analysed in the group to which
they were allocated" fixes the analysis set, not a strategy. Read with "smallest
difference of clinical interest", it points to treatment policy for stopping and switching,
under which dilution does not apply; but the product does not say so. If 35 m is meant
under full adherence, dilution of 5%, 10% and 20% raises the evaluable N from 80 to 88, 98
and 124 per group (correlation 0.5, printed test).

**Death and inability to walk.** After death, or in a participant unable to walk at 6
months, no 6MWD exists. Treatment policy cannot supply one, and the deferral of "missing
outcome data" to the SAP does not name these events.
- Handled as missing (a hypothetical strategy, imputed under missing at random), they
  leave N unchanged.
- Scored as 0 m in the difference in means, at 0.5%, 1% and 2% of each arm, they raise the
  evaluable N to 93, 107 and 134 per group (117, 134 and 168 randomised). A trial sized at
  80 has 69.0% power with 1% scored 0 m (work/challenge/s2_C_sim.log line 5).

The proportions and dilution shares are the review's scenarios.

fix: List the intercurrent events, each with a strategy, as ICH E9(R1) describes; for this investigator-initiated trial that is good practice, not a requirement. The events: not starting or stopping the 12-week programme, additional or switched physiotherapy, re-operation, contralateral arthroplasty, inability to walk at 6 months, death. Say whether 35 m and 90 m apply under those strategies. Give death and inability to perform the 6MWD a strategy that needs no value that does not exist (a composite with its score and a summary that fits it, while alive, or hypothetical with the scenario stated), and size the trial for it. Missing outcome data stay with the SAP, as the product states (p. 2).

### F4. The SD and the loss come from a hospital registry of 2019–2021 that predates the trial; the product does not say how they carry over to the trial cohort, and gives the SD to the app arm with no source
bears on: ST11 (SD), ST12 (loss), ST13 (planned analysis), ST01 (evaluable N), ST03 (randomised N)
where: text and code
evidence: Table 1, rows "SD of 6MWD at 6 months" and "Loss to follow-up at 6 months" (p. 1); DEMO-TKA_SSE.qmd:44, 48, 61–62; analysis/code-and-data/assumption-ledger.csv A02, A04, A08; work/logs/ss_exact_ancova.log sections 3–4; work/logs/reg_departures.log; work/results/reg_departures.csv; work/challenge/s1_C_exact.log lines 19–24, 46–50; work/challenge/s2_C_sim.log lines 14–19; work/challenge/s4_C_print.log lines 19–23; analysis/code-and-data/regression-model-diagnostics-REPORT.md, the SD by arm (RM1); review/challenge-REPORT-C.md

Table 1 sources both the SD (90 m) and the loss (20%) to "Hospital TKA registry, 2019–2021
(internal report)". The registry gives both, so it had a 6-month 6MWD assessment. It
predates the trial and cannot describe app-guided home exercise. The product does not say
how the registry's patients compare with the trial's eligible participants, measured by
blinded assessors with a standardised protocol. Nor does it say whether the registry's loss
counts deaths and those unable to walk.

**The SD.** N scales as SD²: 80, 90 and 100 m need 63, 80 and 98 evaluable per group
(correlation 0.5, printed test). The generator gives both arms the same residual SD
(qmd:61–62). At equal arms the planned ANCOVA keeps its size: 5.0% at an app-arm SD of
110 m. Its power follows the mean of the two arms' residual variances, so an app-arm SD of
70 to 110 m (control 90 m) moves the evaluable N from 59 to 105 per group, 74 to 132
randomised. At a correlation of 0.7, 110 m moves 55 to 81. The direction is not known.
With unequal evaluable arms, 70 and 90, the model-based test's size is 5.6% to 5.7% when
the smaller arm is the more variable.

**The loss.** It moves the randomised N only: for 80 evaluable, 10%, 20% and 30% need 89,
100 and 115 per group.

The registry report is not in the job, so whether it supports either value for this
population is unverified here. The app-arm SDs are the review's scenarios.

fix: State how the registry's SD and loss carry over to the trial's eligible participants (consented, randomised, with a blinded 6-month assessment), what the loss counts (deaths, inability to walk), and whether 90 m applies to both arms and why. Otherwise plan with the mean of the two arms' residual variances at a plausible app-arm SD, and add the app-arm SD and the loss to the sensitivity of N.

### F5. The 55 and its 81.5% rest on one 200-trial estimate per grid point and a rule that takes the first to reach 80%; decided, the product's own code reaches 80% at 63 per group (grid point 65), and the rule picks a sample size with less than 80% true power in 39% of runs
bears on: ST01 (evaluable N), ST02 (power at 55), ST03 (randomised N), ST07 (Figure 1)
where: text and code
evidence: Sample size (pp. 1–2); Figure 1 caption (p. 2); DEMO-TKA_SSE.qmd:56, 70–75; analysis/document/arithmetic-checks.csv A11; work/results/sim_nearcross.csv; work/results/sim_crossing.csv; work/results/sim_mcse.csv; work/results/sim_selection_summary.csv; work/logs/sim_fit.log sections 4–5; work/challenge/s4_N_print_checks.log lines 13–18; work/challenge/s5_N_sim.log lines 9–40; review/document-REPORT.md, the Monte Carlo finding (D2); analysis/code-and-data/simulation-diagnostics-REPORT.md, the decided crossing and the selection rule (SIM1, SIM2)

**Precision.** At 200 trials per grid point, the printed 81.5% (163 of 200) has a Monte
Carlo SE of 2.75 points (Wilson 95% interval 75.5% to 86.3%). The product states no Monte
Carlo error.

**Selection.** The code picks the first grid point whose estimate reaches 80% (qmd:74),
which favours a high draw. Under the product's own one-sided rule at a correlation of 0.5,
the exact power at 55 is 75.3%. 163 or more of 200 at that power has probability 0.023
(z 2.03).

**The decided crossing.** Run with 10,000 trials per point, the product's function
reaches 80%:
- as delivered, at 62.5 and 63.0 in two runs (first grid point 65; exact 62.5);
- with the decision line made two-sided, at 78.5 and 79.2 (first grid point 80; exact
  79.3).

**How the rule behaves.** Over the exact distribution of the pick, the rule picks a grid
point below 80% true power:
- in 39.0% of runs as delivered, overstating the power at its pick by 2.0 points;
- in 28.9% under the printed test, overstating it by 2.2 points.

Across seeds 1 to 200 the delivered procedure picks 55 to 70 (55 or less in 7.5% of
seeds); with the two-sided line it picks 70 to 90. Correcting the test alone therefore
still leaves N to the draw, anywhere over four grid steps.

fix: Take N from exact power, or from the simulation at a replicate count that decides the crossing: about 6,400 trials per point near 80% give an SE of 0.5 points. Fit the curve to the simulated values in a window around 80%, or require the lower Monte Carlo confidence limit at the chosen N to reach 80%. Print the Monte Carlo SE beside every simulated power.

### F6. Outcomes in the supervised-physiotherapy arm may cluster by physiotherapist or therapy group; the product does not say how the comparator is delivered, and neither the calculation nor the planned ANCOVA allows for clustering
bears on: ST13 (planned analysis), ST01 (evaluable N), ST03 (randomised N)
where: text and code
evidence: Study design (p. 1); DEMO-TKA_SSE.qmd:62–63; analysis/code-and-data/assumption-ledger.csv A12; work/logs/rct_design.log sections 3a–3b; work/results/rct_clustering.csv; work/results/rct_clustering_sim.csv; work/challenge/s1_C_exact.log lines 39–45; work/challenge/s2_C_sim.log lines 7–13; work/challenge/s4_C_print.log line 18; analysis/code-and-data/rct-diagnostics-REPORT.md, clustering by physiotherapist (RCT1)

**The gap.** The control arm receives supervised outpatient physiotherapy over 12 weeks at
one centre (p. 1). The print names no number of physiotherapists, no session type and no
clustering. Every simulated residual is independent (qmd:62), and the planned ANCOVA has
no provider term (qmd:63). If outcomes share a physiotherapist effect, the variance of the
control-arm mean is multiplied by 1 + (m − 1) × ICC.

**Effect on N** (correlation 0.5, printed test; lower bounds, since a valid analysis has
fewer degrees of freedom than 2n − 3):
- control arm shared by 4 physiotherapists: 88, 98 and 151 evaluable per group at an ICC
  of 0.01, 0.02 and 0.05;
- shared by 8: 83, 88 and 103.

**Effect on the planned test.** Ignoring clustering, the planned ANCOVA rejects a true
null in about 7% of trials with 4 physiotherapists at an ICC of 0.02 (7.1% and 7.6% in two
simulations, 7.2% closed form), and in about 10% to 11% at 0.05.

The structures and ICCs are the review's scenarios. The effect is negligible only if many
physiotherapists each treat few participants.

fix: State how the supervised physiotherapy is delivered: the number of physiotherapists, individual or group sessions, and any therapist contact in the app arm. If outcomes may cluster, size the trial with a design effect at a sourced ICC and the realistic number of physiotherapists, and plan a primary analysis that accounts for it, for example a random physiotherapist effect in the control arm with small-sample degrees of freedom. Otherwise state why clustering is negligible.

### F7. The 20% allowance gives the analysis of all randomised the complete-case information, which holds only if the lost are handled as missing at random given baseline and arm; the product does not say so
bears on: ST15 (analysis set and deferral to the SAP), ST03 (randomised N), ST01 (evaluable N)
where: text
evidence: Primary endpoint and estimand (p. 1); Sample size and Analysis (p. 2); DEMO-TKA_SSE.qmd:56–62, 76; analysis/code-and-data/assumption-ledger.csv A11; work/logs/md_allowance.log; work/results/md_allowance.csv; work/results/md_mi_sim.csv; work/challenge/s1_C_exact.log lines 33–38; work/challenge/s3_C_mi.log lines 2–8; analysis/code-and-data/missing-data-diagnostics-REPORT.md, what the allowance assumes (MD1); review/challenge-REPORT-C.md

**What the allowance assumes.** The simulation draws a 6MWD for every evaluable
participant, and the allowance adds the lost afterwards (p. 2; qmd:56–62, 76). So the
planned power is that of a complete-case ANCOVA. An analysis of all randomised (p. 1) has
that information only under complete cases or multiple imputation under missing at random
given baseline and arm. At 100 randomised per group, multiple imputation under missing at
random gives 79.4% against 79.8% for complete cases in the same trials. Deferring the
handling to the SAP is legitimate, but the SSE does not state the assumption.

**Other primary analyses** the SAP could choose (the review's scenarios; correlation 0.5,
printed test, evaluable / randomised per group):
- J2R for the intervention arm: 110 / 138;
- delta adjustment of 17.5 m: 98 / 123;
- delta adjustment of 35 m: about 128 / 160 under multiple imputation, 124 / 155 by the
  approximation.

A trial sized under missing at random keeps 61.5% to 71.7% power under these analyses.

fix: State in the Sample size section the missing-data assumption the allowance makes (missing at random given baseline and arm, analysed by complete cases or by multiple imputation under that assumption), and require the SAP's primary analysis to match it. If the SAP will use a reference-based or delta-adjusted primary analysis, size the trial for that analysis.

### F8. Figure 1 plots a running maximum of the simulated power, not the estimates its caption names; at 60 and 65 per group the estimates are 77.0% and 79.0%, below the 81.5% plotted
bears on: ST07 (Figure 1), ST01 (evaluable N)
where: code
evidence: Figure 1 and caption (p. 2); DEMO-TKA_SSE.qmd:72–73, 137; work/results/cd_delivered_grid.csv; work/results/figure1_points.csv; work/logs/doc_figure1_checks.log; work/challenge/s2_N_anchor.log lines 6–7, 14–16; work/challenge/s3_N_figure1.log; work/challenge/s4_N_print_checks.log lines 20–29, 35–37; work/challenge/s5_N_sim.log line 38; review/code-and-data-REPORT.md, the Figure 1 finding (C3); review/document-REPORT.md (D2)

Figure 1, labelled "Estimated power", plots `power_curve <- cummax(power_raw)` (qmd:73,
137).
- **What is plotted.** Read from the PDF's vector graphics, the 13 plotted values equal
  the code's running maximum. They show 5 ties among 12 adjacent pairs; if each were its
  own 200-trial estimate, about 0.55 ties would be expected, and 5 or more has probability
  about 10⁻⁴.
- **What it hides.** At 50, 60, 65, 80 and 85 per group, the simulated estimates (65.5%,
  77.0%, 79.0%, 85.5%, 89.0%) are lower than plotted. The running maximum does not change
  the first grid point at 80% or the printed 81.5%. But it hides that the two points after
  the chosen one fell below 80%. Under the coded rule, the exact power is 75.3%, 78.5% and
  81.4% at 55, 60 and 65.
- **Fitted crossings.** A curve fitted to the plotted values crosses 80% at 58.3; one
  fitted to the simulated values crosses at 60.3. The running maximum lowers a fitted
  crossing by 1.2 per group on average over seeds. So the figure-based value of about 58
  is a lower bound; the decided crossing under the coded rule is 62.5.

fix: Plot `power_raw` with its Monte Carlo intervals, or say in the caption that a running maximum is shown. Choose N from a curve fitted to the simulated values at a replicate count that decides the crossing (F5).

### F9. The dropout allowance multiplies by 1.2 instead of dividing by 0.8: 66 randomised per group leave 52.8 evaluable at the stated 20% loss
bears on: ST03 (randomised N), ST12 (loss)
where: text and code
evidence: Sample size (p. 2); Table 1, row "Loss to follow-up at 6 months" (p. 1); DEMO-TKA_SSE.qmd:76; analysis/document/arithmetic-checks.csv A01–A06; work/logs/doc_arithmetic.log; work/logs/ss_exact_ancova.log section 4; work/results/md_binomial.csv; work/challenge/s1_C_exact.log lines 9–15; review/document-REPORT.md, the dropout finding (D3)

"55 × 1.2 = 66" and "132 in total" are right as arithmetic. But at 20% loss, 66
randomised leave 52.8 evaluable, and 66 cover a loss of at most 16.7%.

N / (1 − d) gives:
- 69 per group (138 in total) for 55 evaluable;
- 100 (200) for 80;
- 79 (158) for 63.

The product's ×1.2 on 80 gives 96 (192). N / (1 − d) holds the evaluable N in expectation
under binomial loss: 80.24% power at 100 randomised, against 80.34% at exactly 80
evaluable. Even at the correlation of 0.70 that the printed 55 needs, 66 randomised give
78.6% averaged over binomial loss; 66 reach 80% only from a correlation of 0.712 (0.609
one-sided).

fix: Randomise ⌈evaluable N / 0.8⌉ per group, and write the formula in the text: 69 per group (138 in total) for 55 evaluable; 100 (200) for the 80 the printed test needs at a correlation of 0.5.

### F10. The unadjusted t-test comparison prints 94 per group, typed into the text; the printed planning values give 105, which the code computes and never prints
bears on: ST18 (t-test comparison), ST17 (gain from baseline adjustment)
where: text
evidence: Sample size (p. 2); DEMO-TKA_SSE.qmd:82, 145; analysis/document/arithmetic-checks.csv A07; work/logs/doc_arithmetic.log; work/logs/cd_delivered.log; work/logs/ss_exact_ancova.log section 6; work/challenge/s4_N_print_checks.log lines 3–11; work/challenge/s2_N_anchor.log line 12; review/document-REPORT.md, the t-test finding (D4); review/code-and-data-REPORT.md (C2)

At 35 m, 90 m, two-sided 5% and 80%, a two-sample t-test needs 104.77 per group, so 105.
Three methods agree: `power.t.test`, the normal approximation with z²/4, and the
non-central t with both tails. The code computes 105 (qmd:82), and the sentence hard-codes
94 (qmd:145). 94 per group give 75.6% power. They match an SD of 84.7 to 85.2 m or a
difference of 37.0 to 37.2 m, neither of which is printed.

The evaluable N does not change, but the comparison overstates the saving from
adjustment:
- the printed pair implies a saving of 41.5% and a correlation of 0.644, and sets a
  two-sided t-test against the one-sided ANCOVA;
- like for like at a correlation of 0.5, the saving is 105 to 80 (23.8%) two-sided, or 83
  to 63 (24.1%) one-sided.

fix: Print `` `r n_ttest` `` (105 at the printed values) in place of the typed 94, pass `sig.level = alpha` to `power.t.test`, and compare it with the ANCOVA N under the same test.

## Limits of this review

- **Cited sources not provided.** The steering committee decision of 3 June 2026 and the
  hospital TKA registry report, 2019–2021, are not in the job; the assignment says they
  are not provided. Whether they support 35 m, 90 m and 20% for the trial's population is
  unverified here. Leaves `unverified-here`: the target difference (ST10), the SD (ST11)
  and the loss (ST12). Their holds is decided on the print's description of the source.
- **Protocol not provided.** It would say how the comparator is delivered (number of
  physiotherapists, sessions), the block sizes and stratification, and the test the trial
  will use. Leaves `unverified-here`: the planned analysis (ST13). The planned test (ST08)
  is not established on the product's own competing versions, whatever the protocol says.
- **SAP not yet written.** The estimand's intercurrent events and the handling of the
  lost are judged as a plan, on the print (the estimand and the analysis set, ST14 and
  ST15, both settled).
- **Independent literature not reachable.** Four propositions could not be checked
  against published work:
  - 6-month SDs of the 6MWD after primary TKA, by arm;
  - the minimal important change of the 6MWT about 6 months after TKA;
  - attrition at 6 months in comparable rehabilitation trials;
  - the published correlation of pre-operative and 6-month 6MWD.

  A general web search returns snippets only, and the publisher and repository hosts are
  outside this environment's allowed network (00_INTAKE.md, Requests for the operator;
  review/statements-REPORT.md, Findings). Leaves `unverified-here`: the target difference,
  the SD and the loss (ST10–ST12). The correlation the simulation uses (ST05) is
  unverifiable as delivered, whatever the literature says.
- **Data mode `none`.** No limit: the product reads no data, and no printed number
  depends on data.
- **Modules not applicable or run light.** Time-to-event, multiplicity, observational,
  prediction-model, Bayesian and small-n diagnostics do not apply; their reasons are in
  analysis/code-and-data/*-diagnostics-REPORT.md. Estimand, missing-data and
  regression-model diagnostics ran as light passes, the scope for an SSE. No row is left
  `unverified-here` by this.
- **Not run, and needed by no row.** These are stated as conditions of the supportable N,
  each of which alone already moves it:
  - the five conditions jointly;
  - a valid clustered analysis (a physiotherapist effect with small-sample degrees of
    freedom), so the clustered N are lower bounds;
  - departures from the generator at the printed 55;
  - the missing-not-at-random shift under complete cases;
  - missing pre-operative 6MWD.
- **Monte Carlo resolution.** 10,000 trials per point cannot separate 79 from 80
  evaluable under the printed test; about 57,000 would be needed. The exact method decides
  80 (analysis/code-and-data/simulation-diagnostics-REPORT.md).
- **Render environment.** Typst 0.13.0 here, against the 0.15.1 that made the delivered
  PDF. It affects layout only: three hyphenations (work/logs/cd_compare_render.log).

## Counts

**Statement ledger.** 7 not established, 5 narrower and 7 hold, against 6, 5 and 8 at the
statements stage (work/logs/verdict_ledger.log).

**Moved toward not established (1).**
- The planned test, "5%, two-sided" (Table 1, row "Significance level", p. 1; ST08), moved
  from holds to not established, and its status from unverified-here to settled.
  - It turns on the delivered code. The one-sided version of the 5% level made every
    printed number: 55, 81.5%, 66 and 132, against 70, 80.5%, 84 and 168 with the
    two-sided line (work/challenge/s2_N_anchor.log lines 4, 9–11, 22, 27–29). So the
    versions compete, and the element is not established until the statistician says
    which is meant.
  - The challenge ruled WRONG on this row. Its script re-runs to an identical log, and the
    cited pages say what it cites: Table 1 on p. 1, the decision rule on p. 2
    (work/challenge/rerun/RERUN-RECORD.md; work/logs/coord_rerun_challenge.log;
    work/challenge/rerun/page-1.png, page-2.png).
  - The status departs from the challenge's proposed unverified-here: no document the
    review could obtain would decide between two versions the product itself states.

**Moved toward holds (0).** None.

**Kept, with wording changed.** The STANDS WITH CHANGES rulings are adopted in these rows:
- the evaluable N (ST01): both tests on equal footing; the two-sided crossings are 78.5
  and 79.2 in two runs, against the exact 79.3;
- the decision rule (ST04): the exact sizes, 5% and 2.5%;
- the simulation's inputs (ST05): Table 1's level is applied one-sided;
- the randomised N (ST03): the one-sided N, and the 0.712 and 0.609 thresholds;
- the loss (ST12): the registry had a 6-month assessment;
- the answer to the question: both tests, the randomised-N threshold, and exact 80.

The rows on the conditions (ST10–ST15) label the test and mark the scenario magnitudes as
the review's. The headings and fixes the rulings proposed are adopted in the findings on
the test (F1), the correlation (F2), the estimand (F3), the SD by arm (F4), the selection
rule (F5), the handling of the lost (F7) and Figure 1 (F8).

**Challenge rulings by direction**, from the counts in part (g) of
review/challenge-REPORT-N.md and review/challenge-REPORT-C.md:

| Group | Direction | STANDS | STANDS WITH CHANGES | WRONG | ADD |
|---|---|---|---|---|---|
| Target N | against the author | 8 | 7 | 0 | 0 |
| Target N | for the author | 4 | 0 | 1 | 0 |
| Conditions, randomised N, question | against the author | 9 | 7 | 0 | 0 |
| Conditions, randomised N, question | for the author | 3 | 0 | 0 | 0 |
| Both groups | against the author | 17 | 14 | 0 | 0 |
| Both groups | for the author | 7 | 0 | 1 | 0 |

On the statement rows and the answer:
- STANDS 13: the power at 55 (ST02); the simulation's grid, replicates and model (ST06);
  Figure 1 (ST07); the power target (ST09); the target difference (ST10); the SD (ST11);
  the planned analysis (ST13); the estimand (ST14); the analysis set and the deferral to
  the SAP (ST15); the design (ST16); the gain from baseline adjustment (ST17); the t-test
  comparison (ST18); software, code and seed (ST19);
- STANDS WITH CHANGES 6: the evaluable N (ST01), the randomised N (ST03), the decision
  rule (ST04), the simulation's inputs (ST05), the loss (ST12) and the answer to the
  question;
- WRONG 1: the planned test (ST08).
