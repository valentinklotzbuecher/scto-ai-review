# Consistency review: Sample Size Estimation, DEMO-TKA: app-guided home exercise versus supervised physiotherapy after total knee arthroplasty (DEMO-01, Version 1.0, 15 September 2026)

**Prepared:** 2026-10-31 · **Review depth:** standard · **Patient data:** not shared with the AI agent

> Pre-human review prepared by an AI agent with the DKF review skills (v0.1.0). It prepares the consistency review by a second statistician and does not replace it.

## Assignment

- Name of the statistical product: DEMO-TKA_SSE.pdf (rendered), with its Quarto source DEMO-TKA_SSE.qmd
- Important issues for reviewer:
  1. Is the sample size adequate for the stated design?
- Other documents this document depends on:
  - Study protocol: not provided
  - Hospital TKA registry, 2019–2021 (internal report), the source of the SD and the loss to follow-up: not provided
  - Steering committee decision of 3 June 2026, the source of the smallest difference of clinical interest: not provided
  - Statistical analysis plan: not yet written

## Review

### Decision

- [x] Statistical product needs minor changes in the text
- [x] Statistical product needs major changes in the text (second review necessary)
- [x] Statistical product needs minor changes in the R programming
- [x] Statistical product needs major changes in the R programming (second review necessary)
- [x] Clarifications required about code or methods (meeting or communication)

### General comments

The design holds as a plan and the planned ANCOVA is the model the calculation fits, but the document does not establish its sample size of 55 evaluable and 66 randomised participants per group (132 in total). The 55 rests on a correlation between pre-operative and 6-month 6MWD that is neither printed nor sourced (0.5 in the code), on a decision rule that tests one-sided where Table 1 states two-sided, and on a single 200-trial estimate per sample size. At a correlation of 0.5 the planned ANCOVA needs 80 evaluable and 100 randomised participants per group (200 in total) under the stated two-sided test, and 63 and 79 under the one-sided test the code runs; 55 suffices only from a correlation of 0.696 (0.585 one-sided). The dropout allowance multiplies by 1.2 instead of dividing by 0.8, and the sample size also assumes conditions the document does not state: which effect 35 m is, how death or inability to walk enter, how the lost are handled, whether outcomes cluster by physiotherapist, and whether 90 m holds in the app arm.

### Major issues

1. **The evaluable sample size of 55 per group rests on a baseline–outcome correlation that is neither printed nor sourced** (Table 1 "Planning values" (p. 1); Sample size (pp. 1–2); DEMO-TKA_SSE.qmd:45) [text and R code, needs clarification]

   The power of the ANCOVA depends on the residual SD, 90 × √(1 − ρ²), and so on the correlation ρ between pre-operative and 6-month 6MWD as much as on the difference and the SD. Table 1 lists no correlation and the text never mentions one, yet power is said to be simulated "under the planning values in Table 1"; the code sets ρ = 0.5 with no source (DEMO-TKA_SSE.qmd:45). At ρ = 0.5, with 35 m, 90 m and 80% power, the planned ANCOVA needs 80 evaluable participants per group under the two-sided 5% test that Table 1 states, and 63 under the one-sided test the code runs. At 55 per group the exact power is 64.2% and 75.3% respectively. 55 per group suffices only from a correlation of 0.696 two-sided, or 0.585 one-sided; over a correlation of 0 to 0.8 the required N runs from 106 to 39 per group, more than any other input moves it. The printed 81.5% (163 of 200 simulated trials) lies 2.03 standard errors above the exact power of the code's own rule. Fix: add the correlation to Table 1 with its source (the registry that supplies the SD could give it for patients who meet the eligibility criteria), compute N at the test the trial will use from exact power or from a simulation that decides the crossing, and print N over a plausible range of the correlation, for example 0.4 to 0.7.

2. **The simulation tests one-sided at 5% where Table 1 and the text state a two-sided 5% test, and every printed number comes from the one-sided rule** (Table 1, row "Significance level" (p. 1); Sample size (p. 2); DEMO-TKA_SSE.qmd:65) [text and R code, needs clarification]

   Table 1 gives the significance level as "5%, two-sided" and the Sample size section counts trials "statistically significant at the two-sided 5% level", but the decision line `pt(t_arm, df = fit$df.residual, lower.tail = FALSE) < alpha` (DEMO-TKA_SSE.qmd:65) is an upper-tail test at 5%. Its type I error in the favourable direction is 5%, twice the 2.5% of the stated test. Every printed sample size, power and plotted value comes from this rule: with only that line made two-sided, the same simulated trials give 70, 80.5%, 84 and 168 in place of 55, 81.5%, 66 and 132. Which test the trial will use therefore cannot be told from the document. Fix: state which test is intended. If two-sided 5%, as Table 1 says, count a trial as significant when `2 * pt(abs(t_arm), df = fit$df.residual, lower.tail = FALSE) < alpha` and re-derive N (80 evaluable and 100 randomised per group at a correlation of 0.5); if one-sided, say so in Table 1 and in the text and justify the level, noting that a one-sided 2.5% test keeps the favourable-direction error of the stated design.

3. **The chosen sample size and its 81.5% power rest on one 200-trial estimate per grid point and on taking the first point to reach 80%** (Sample size (pp. 1–2); Figure 1 caption (p. 2); DEMO-TKA_SSE.qmd:56, 70–75) [text and R code]

   With 200 simulated trials per sample size, the printed 81.5% has a Monte Carlo standard error of 2.75 points (95% interval 75.5% to 86.3%), and the document states no Monte Carlo error. Taking the first grid point whose estimate reaches 80% (DEMO-TKA_SSE.qmd:74) favours a high draw: under the code's own one-sided rule it picks a sample size with less than 80% true power in 39.0% of runs and overstates the power at its pick by 2.0 points (28.9% and 2.2 points under the two-sided test). Run with 10,000 trials per point, the delivered function reaches 80% at about 63 per group (first grid point 65), and with the two-sided decision line at about 79 (first grid point 80). Across seeds 1 to 200 the delivered procedure picks anywhere from 55 to 70, so the printed 55 is a property of the seed. Fix: take N from exact ANCOVA power, or simulate enough trials near the crossing to decide it (about 6,400 per point give a standard error of 0.5 points), fit the curve to the simulated values or require the lower Monte Carlo confidence limit at the chosen N to reach 80%, and print the Monte Carlo standard error beside every simulated power.

4. **The dropout allowance multiplies by 1.2 instead of dividing by 0.8, so 66 randomised per group leave 52.8 evaluable at the stated 20% loss** (Sample size (p. 2); Table 1, row "Loss to follow-up at 6 months" (p. 1); DEMO-TKA_SSE.qmd:76, 147) [text and R code]

   "55 × 1.2 = 66" is correct arithmetic, but at the 20% loss in Table 1, 66 randomised participants leave 52.8 evaluable in expectation; multiplying by 1.2 covers a loss of at most 16.7%. Dividing by 1 − 0.20 gives 69 per group (138 in total) for 55 evaluable, and 100 per group (200 in total) for the 80 evaluable that the two-sided test needs at a correlation of 0.5 (79 and 158 for the 63 of the one-sided test). Even at the correlation of 0.70 that the printed 55 needs, 66 randomised give 78.6% power averaged over binomial loss; 66 reach 80% only from a correlation of 0.712 (0.609 one-sided). Fix: randomise ⌈evaluable N / 0.8⌉ per group, that is `n_rand <- ceiling(n_evaluable / (1 - dropout))` (DEMO-TKA_SSE.qmd:76), and write the formula in the text.

### Minor issues

1. **The estimand names no intercurrent events, so it is not stated which effect the 35 m difference refers to, nor how death or inability to walk at 6 months enter** (Primary endpoint and estimand (p. 1); Analysis (p. 2)) [text, needs clarification]

   The estimand states the population, the treatments, the variable and the population-level summary, but names no intercurrent event and no strategy; adherence, switching, re-operation, death and inability to walk are not mentioned. "All randomised participants are analysed in the group to which they were allocated" fixes the analysis set and points to a treatment-policy strategy for stopping or switching, but the document does not say so, nor whether 35 m is the effect of assignment or of full adherence; if the latter, a 10% dilution raises the evaluable N from 80 to 98 per group at a correlation of 0.5. After death, or in a participant unable to walk at 6 months, no 6MWD exists: a treatment-policy strategy cannot supply one, and the deferral of missing outcome data to the statistical analysis plan does not name these events. Handled as missing they leave N unchanged; scored as 0 m in 1% of each arm they raise it to 107 per group. Fix: list the intercurrent events with a strategy for each, as ICH E9(R1) describes (good practice for this trial, not a requirement), say whether 35 m and 90 m apply under those strategies, give death and inability to perform the walk test a strategy that needs no value that does not exist, and size the trial for it.

2. **The SD and the loss come from a hospital registry of 2019–2021; the document does not say how they carry over to the trial, and gives the SD to the app arm without a source** (Table 1, rows "SD of 6MWD at 6 months" and "Loss to follow-up at 6 months" (p. 1); DEMO-TKA_SSE.qmd:44, 48, 61–62) [text and R code, needs clarification]

   Table 1 sources both the SD of 90 m and the loss of 20% to "Hospital TKA registry, 2019–2021 (internal report)", which predates the trial and cannot describe app-guided home exercise. The document does not say how the registry's patients compare with the trial's eligible participants, measured with a standardised protocol by blinded assessors, nor whether the registry's loss counts deaths and participants unable to walk. N scales with the square of the SD: 80, 90 and 100 m need 63, 80 and 98 evaluable participants per group (correlation 0.5, two-sided test). The code gives both arms the same SD (DEMO-TKA_SSE.qmd:61–62); an app-arm SD between 70 and 110 m, with 90 m in the control arm, moves the evaluable N from 59 to 105 per group. Fix: state how the registry's SD and loss carry over to the trial population, what the loss counts, and whether 90 m applies to both arms and why; otherwise plan with the mean of the two arms' residual variances at a plausible app-arm SD, and show N over a range of the app-arm SD and of the loss.

3. **How the supervised physiotherapy is delivered is not stated, and neither the calculation nor the planned ANCOVA allows for outcomes clustering by physiotherapist** (Study design (p. 1); DEMO-TKA_SSE.qmd:62–63) [text and R code, needs clarification]

   The control arm receives "supervised outpatient physiotherapy" over 12 weeks at one centre, but the document names no number of physiotherapists and no session type. Every simulated residual is independent (DEMO-TKA_SSE.qmd:62), and the planned ANCOVA has no provider term (DEMO-TKA_SSE.qmd:63). If the control arm were shared by 4 physiotherapists with an intra-cluster correlation of 0.02, the evaluable N at a baseline–outcome correlation of 0.5 would rise from 80 to at least 98 per group, and the planned ANCOVA would reject a true null hypothesis in about 7% of trials. Fix: state how the physiotherapy is delivered (number of physiotherapists, individual or group sessions, any therapist contact in the app arm). If outcomes may cluster, size the trial with a design effect at a sourced intra-cluster correlation and the realistic number of physiotherapists, and plan an analysis with a physiotherapist effect and small-sample degrees of freedom; otherwise state why clustering is negligible.

4. **The 20% allowance holds for an analysis of all randomised participants only if the lost are handled as missing at random, which the document does not state** (Primary endpoint and estimand (p. 1); Sample size and Analysis (p. 2); DEMO-TKA_SSE.qmd:56–62, 76) [text]

   The simulation draws a 6-month 6MWD for every evaluable participant and the allowance adds the lost afterwards, so the planned power is that of a complete-case ANCOVA. An analysis of "All randomised participants" has that information only under complete cases or multiple imputation under missing at random given baseline and arm. If the statistical analysis plan chooses a reference-based primary analysis instead, such as jump to reference for the intervention arm, the trial needs 110 evaluable and 138 randomised participants per group at a correlation of 0.5. A trial sized under missing at random keeps 61.5% to 71.7% power under such reference-based or delta-adjusted analyses. Fix: state in the Sample size section that the allowance assumes the lost are missing at random given baseline and arm, analysed by complete cases or by multiple imputation under that assumption. Require the primary analysis in the statistical analysis plan to match it, or size the trial for the analysis that plan will use.

5. **Figure 1 plots a running maximum of the simulated power, not the estimates its caption names** (Figure 1 and caption (p. 2); DEMO-TKA_SSE.qmd:73, 137) [R code]

   The caption reads "Estimated power", but the figure plots `power_curve <- cummax(power_raw)` (DEMO-TKA_SSE.qmd:73, 137). At 50, 60, 65, 80 and 85 per group the simulated estimates (65.5%, 77.0%, 79.0%, 85.5% and 89.0%) are lower than plotted, so the figure shows 81.5% at 55, 60 and 65 per group and does not show that the two points after the chosen one fell below 80%. A curve fitted to the plotted values crosses 80% at 58.3, against 60.3 for the simulated values. Fix: plot `power_raw` with its Monte Carlo intervals, or say in the caption that a running maximum is shown, and choose N as described in the issue on the single 200-trial estimates.

6. **The unadjusted t-test comparison prints a typed 94 per group, where the printed planning values give 105** (Sample size (p. 2); DEMO-TKA_SSE.qmd:82, 145) [text]

   At 35 m, 90 m, two-sided 5% and 80% power, a two-sample t-test needs 104.77 participants per group, so 105; the code computes this value as `n_ttest` (DEMO-TKA_SSE.qmd:82), but the sentence hard-codes "94 participants per group" (DEMO-TKA_SSE.qmd:145). 94 per group give 75.6% power. The printed pair implies a 41.5% saving from adjusting for baseline and sets a two-sided t-test against the one-sided ANCOVA; like for like at a correlation of 0.5, the saving is 105 to 80 (23.8%). Fix: print `` `r n_ttest` `` in place of the typed 94, pass `sig.level = alpha` to `power.t.test`, and compare it with the ANCOVA N under the same test.

### Answers to the issues listed in the assignment

1. *Is the sample size adequate for the stated design?*

   No, not as delivered. The document does not establish that 55 evaluable and 66 randomised participants per group (132 in total) are adequate, and at the only correlation its materials contain they are too few under either reading of its test. At the correlation of 0.5 that the code uses, printed and sourced nowhere, the planned ANCOVA needs 80 evaluable participants per group under the two-sided 5% test that Table 1 states and 63 under the one-sided test the code runs. With 20% loss handled by N / (1 − 0.20), that is 100 (79) randomised per group, 200 (158) in total. 55 evaluable suffice only from a correlation of 0.696 two-sided (0.585 one-sided), and 66 randomised only from 0.712 (0.609). Whether some sample size is adequate at the true correlation cannot be told from the document, which gives no value or source for it. Each of the following, on its own, also raises the required N: an SD above 90 m in the app arm, a 35 m effect meant under full adherence, death or inability to walk scored as a worst value, handling of the lost other than as missing at random, and outcomes clustering by physiotherapist. Their joint effect is not established.

### What this review could not check

- The steering committee decision of 3 June 2026 and the hospital TKA registry report, 2019–2021, were not provided, so whether they support 35 m, 90 m and 20% for the trial's population was not checked.
- The study protocol was not provided, so how the comparator is delivered, the block sizes and stratification, and the test the trial will use were not compared with it.
- The statistical analysis plan is not yet written; the intercurrent events and the handling of the lost were judged as a plan, on this document alone.
- Published work on the 6-month SD of the 6MWD after primary TKA, its minimal important change, attrition at 6 months in comparable rehabilitation trials and the correlation of pre-operative and 6-month 6MWD could not be obtained in this environment.
- The five unstated conditions were examined one at a time, not jointly; the sample sizes under clustering are lower bounds, because a valid clustered analysis has fewer degrees of freedom.
- A simulation at 10,000 trials per point cannot separate 79 from 80 evaluable participants per group under the two-sided test; the exact calculation gives 80.

---

<!-- dkf-consistency-review build: ledger=ISSUES.md sha256=d7d7c165d082521973fb0afbc8b00cb1ad38e58e5d265aad51fafb75acabd5e6 final=yes generated=2026-10-31T21:25:11 -->
