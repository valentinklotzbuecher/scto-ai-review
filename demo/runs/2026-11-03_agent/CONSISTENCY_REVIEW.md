# Consistency review: Sample Size Estimation, DEMO-TKA: app-guided home exercise versus supervised physiotherapy after total knee arthroplasty (DEMO-01, Version 1.0, 15 September 2026)

**Prepared:** 2026-11-03 · **Review depth:** standard · **Patient data:** not shared with the AI agent

> Pre-human review prepared by an AI agent with the DKF review skills (v0.1.0). It prepares the consistency review by a second statistician and does not replace it.

> **Preview, not final:** ledger status is INTERIM, not COMPLETE.

## Assignment

- Name of the statistical product: DEMO-TKA_SSE.pdf (rendered), source DEMO-TKA_SSE.qmd
- Important issues for reviewer:
  1. Is the sample size adequate for the stated design?
- Other documents this document depends on:
  - Study protocol: not provided
  - Saved results the product loads: none (the simulation runs inside the source)
  - Cited sources of the planning values: the hospital TKA registry internal report 2019–2021 and the steering committee decision of 3 June 2026 (internal; not provided)

## Review

### Decision

- [x] Statistical product needs minor changes in the text
- [x] Statistical product needs major changes in the text (second review necessary)
- [ ] Statistical product needs minor changes in the R programming
- [x] Statistical product needs major changes in the R programming (second review necessary)
- [x] Clarifications required about code or methods (meeting or communication)

### General comments

The product does not establish its sample size. The printed 55 evaluable participants per group and its power of 81.5% come from a simulation that counts a one-sided 5% test, while the product states a two-sided 5% test; under the stated test the power at 55 per group is about 64%, and at the product's own inputs the design needs 80 evaluable per group, which is 100 randomised per group and 200 in total for 20% loss, against the planned 66 and 132. Two further departures run in the same direction: the power rests on a baseline-to-6-month correlation of 0.5 that Table 1 does not list and no source supports, and N is the first grid point whose single 200-trial estimate reached 80%; the dropout allowance also under-inflates for the stated 20% loss. The planned analysis, a two-sided 5% ANCOVA adjusted for the pre-operative 6MWD with 80% power, is the model the code simulates, and the delivered source and seed reproduce every number the code computes. Whether 80 evaluable per group is itself adequate turns on the correlation, the SD and the effect, whose cited sources were not provided.

### Major issues

1. **The simulation counts a one-sided 5% test, while the product states a two-sided 5% test** (Sample size, pp. 1–2; Table 1, row "Significance level", p. 1; Figure 1, p. 2; DEMO-TKA_SSE.qmd:65) [R code]

   The Sample size section says the simulation "counted the trials in which the treatment effect was statistically significant at the two-sided 5% level", and Table 1 gives "5%, two-sided", but the code rejects when `pt(t_arm, df = fit$df.residual, lower.tail = FALSE) < alpha` with alpha 0.05 (DEMO-TKA_SSE.qmd:65, :46). This is a one-sided upper-tail test at 5%, whose critical value is that of a two-sided 10% test; every other mention, including the code's own t-test comparison (DEMO-TKA_SSE.qmd:82), is two-sided. On the same 200 simulated trials at 55 per group, the stated test rejects in 133 (66.5%; 95% interval 59.5% to 73.0%) rather than 163 (81.5%), and at 4,000 trials per grid point its power at 55 is 63.6%. With Table 1's effect of 35 m and SD of 90 m and the code's correlation of 0.5, the stated test needs 80 evaluable participants per group, analytically and by the product's own code at 4,000 trials per grid point (81.6% at 80, 77.6% at 75). The error is anti-conservative: the evaluable N of 55, its power of 81.5% and the randomised N of 66 per group (132 in total) do not hold for the test the product states. Make the rejection rule at line 65 two-sided (`2 * pt(abs(t_arm), df = fit$df.residual, lower.tail = FALSE) < alpha`, or compare `coef(summary(fit))['arm', 'Pr(>|t|)']` with alpha), run at 4,000 trials per grid point, and correct the evaluable N (80 per group at the current inputs), its power, the randomised N (100 per group, 200 in total by N / (1 − 0.20)) and Figure 1.

2. **The power rests on a baseline-to-6-month correlation of 0.5 that the product neither prints nor sources** (Table 1, p. 1; Sample size, pp. 1–2; DEMO-TKA_SSE.qmd:45) [text and R code, needs clarification]

   The primary analysis is an ANCOVA adjusted for the pre-operative 6MWD, so its power depends on the correlation ρ between the pre-operative and the 6-month 6MWD: adjustment reduces the variance of the effect estimate by the factor 1 − ρ². Table 1 lists no correlation, yet the Sample size section says the trials were simulated "under the planning values in Table 1"; the code sets `rho <- 0.5` with a comment and no source (DEMO-TKA_SSE.qmd:45). With Table 1's effect and SD, the stated two-sided test needs 106, 89, 80, 68 and 55 evaluable participants per group at a correlation of 0, 0.4, 0.5, 0.6 and 0.7, so the printed 55 suffices under the stated test only at a correlation of about 0.70 or more (0.696). For equal relative changes, N is about three times as sensitive to the SD and to the effect as to the correlation. The correlation matters because it is the only planning value with neither a stated value nor a source, so the product puts no bound on how far it may move. Add the correlation to Table 1 with its source (for example the registry's paired pre-operative and 6-month 6MWD), recompute under the two-sided test, and show N over a plausible range of the correlation together with the SD and the effect (at the current effect and SD: 89, 80, 68 and 55 evaluable per group at ρ 0.4, 0.5, 0.6 and 0.7).

3. **The chosen N is the first grid point whose single 200-trial estimate reached 80%, and Figure 1 hides the estimates below 80%** (Sample size, pp. 1–2; Figure 1 and caption, p. 2; DEMO-TKA_SSE.qmd:56, :73–74, :137) [text and R code]

   The printed 81.5% is 163 of 200 simulated trials, with a Monte Carlo SE of 2.75 points and a 95% interval of 75.4% to 86.6%, and N is taken as the first grid point whose single estimate reaches 80% (DEMO-TKA_SSE.qmd:56, :73–74). Such a rule selects upward deviations: the raw estimates at 60 and 65 per group are 77.0% and 79.0%. At 4,000 trials per grid point the coded one-sided test has 74.2% power at 55 and first reaches 80% at 65 per group, so even on its own coded terms 55 is optimistic by 7 to 8 per group. Figure 1 is captioned "Estimated power by number of evaluable participants per group (200 simulated trials per sample size)", but it plots the running maximum `cummax(power_raw)` (DEMO-TKA_SSE.qmd:73, :137): at 50, 60, 65, 80 and 85 per group the plotted values (68.0%, 81.5%, 81.5%, 89.5%, 89.5%) are not the estimates (65.5%, 77.0%, 79.0%, 85.5%, 89.0%). The running maximum leaves 55 and 81.5% unchanged but hides that the target is reached at 55 and missed at 60 and 65, the pattern that marks 81.5% as an upward deviation; the plotted power is also that of the one-sided test. Run at least 1,600 trials per grid point (Monte Carlo SE at most 1 point at 80%; 4,000 gives 0.63 points), choose N from a curve fitted to the raw rejection counts and cross-checked with the analytic ANCOVA formula, report the Monte Carlo interval at the chosen N, and plot `power_raw` at each grid point with its Monte Carlo interval under the two-sided test, captioned as what is plotted.

4. **The randomised sample size under-inflates for the stated 20% loss to follow-up** (Sample size, p. 2; Table 1, row "Loss to follow-up at 6 months", p. 1; DEMO-TKA_SSE.qmd:76, :147) [text and R code]

   The product states: "Allowing for 20% loss to follow-up, we will randomise 55 × 1.2 = 66 participants per group, 132 in total" (p. 2). The arithmetic is right, but the formula is not: at 20% loss, 66 randomised yield 52.8 evaluable per group, below 55, so the allowance covers loss only up to 16.7%, and N / (1 − 0.20) gives 69 per group and 138 in total for 55 evaluable. The code uses the same formula (`ceiling(n_evaluable * (1 + dropout))`, DEMO-TKA_SSE.qmd:76) and the text types "× 1.2" (DEMO-TKA_SSE.qmd:147), so the shortfall carries into any corrected N: for 80 evaluable, the product's formula gives 96 per group where N / (1 − 0.20) gives 100. The error is anti-conservative, and the product does not say how participants without a 6-month value enter the analysis of all randomised participants, which is what the allowance should rest on. Randomise ceiling(N_evaluable / (1 − 0.20)) per group in the code (DEMO-TKA_SSE.qmd:76) and the text (DEMO-TKA_SSE.qmd:147): 55 → 69 per group (138 in total); 80 → 100 per group (200 in total).

### Minor issues

1. **The estimand names no intercurrent events, and the analysis of all randomised participants is not what the calculation sizes** (Primary endpoint and estimand, p. 1; Sample size, p. 2; Analysis, p. 2; DEMO-TKA_SSE.qmd:59–63) [text, needs clarification]

   The primary estimand states its population, treatment conditions, variable and population-level summary, but names no intercurrent events and no strategy for them (Primary endpoint and estimand, p. 1). Events that plausibly occur here include not starting or stopping the app, supervised physiotherapy received in the intervention arm, revision surgery or a complication that makes the walk test impossible, and death. The product states that "All randomised participants are analysed in the group to which they were allocated", yet the primary analysis is "the ANCOVA described above", sized on "evaluable participants" and simulated on complete data (DEMO-TKA_SSE.qmd:59–63); an ANCOVA of the 6-month value includes only participants who have one, and the handling of missing outcomes is deferred to the statistical analysis plan. The product therefore does not say whether the 35 m is the effect among participants who complete the 6-month walk test or a treatment-policy effect, nor what the 20% allowance assumes about participants without a 6-month value. This bears on the sample size: N scales with 1/δ², so an effect 10% smaller under the chosen strategy raises N by 23% (from 80 to 98 evaluable per group at the current inputs). Name the intercurrent events and the strategy for each, state that 35 m is the effect under that strategy, state how participants without a 6-month value enter the analysis of all randomised participants (for example, missing at random given baseline and arm, by a method the statistical analysis plan will name), and size the 20% allowance on that basis.

2. **The unadjusted t-test comparison prints 94 participants per group; Table 1 and the delivered code give 105** (Sample size, p. 2; DEMO-TKA_SSE.qmd:82, :145) [text]

   The Sample size section states: "For comparison, an unadjusted two-sample t-test would require 94 participants per group" (p. 2). With Table 1's values (35 m, SD 90 m, two-sided 5%, 80% power), `power.t.test` gives 104.77, rounded up to 105 per group, and the hidden chunk computes the same 105 as `n_ttest` (DEMO-TKA_SSE.qmd:82), but the sentence types 94 (DEMO-TKA_SSE.qmd:145). At 94 per group the t-test has 75.6% power; 94 would follow from an SD of 85.2 m or an effect of 37.0 m, neither of which the product states. The ANCOVA sample size is unaffected, but the comparison understates the gain the ANCOVA has to deliver. Print the computed `n_ttest` inline in place of the typed number: 105 per group with Table 1's values.

### Answers to the issues listed in the assignment

1. *Is the sample size adequate for the stated design?*

   No. The product does not establish that 55 evaluable participants per group (66 randomised, 132 in total) are adequate for the design it states, and at its own inputs that sample size is too small.

   - The test behind the printed numbers: the 55 and the 81.5% come from a one-sided 5% rejection rule in the code (DEMO-TKA_SSE.qmd:65), while the design states a two-sided 5% test. Under the stated test the power at 55 per group is 66.5% on the product's own 200 simulated trials (133 of 200; 95% interval 59.5% to 73.0%) and 63.6% at 4,000 trials per grid point.
   - What the stated test needs: with Table 1's effect of 35 m and SD of 90 m and the code's unprinted, unsourced correlation of 0.5, the stated test needs 80 evaluable per group, analytically and by the product's own code at 4,000 trials per grid point (81.6% at 80, 77.6% at 75). By N / (1 − 0.20) that is 100 randomised per group and 200 in total, against the planned 66 and 132.
   - Monte Carlo precision and the choice of N: at 200 trials per grid point the estimate at 55 has a 95% interval of 75.4% to 86.6%, and the rule takes the first grid point whose single estimate reaches 80%, so it picks upward deviations. At 4,000 trials per grid point even the coded one-sided test first reaches 80% at 65 per group.
   - The dropout allowance: 55 × 1.2 under-inflates for 20% loss; 66 randomised yield 52.8 evaluable, and 55 evaluable need 69 per group, 138 in total.

   Whether 80 evaluable per group (100 randomised) is itself adequate depends on planning values the product does not support:

   - the correlation, which the product neither states nor sources: the stated test needs 80 per group at 0.5, and 55 is enough only at about 0.70 or more;
   - the SD and the effect: 63 to 98 per group for an SD of 80 to 100 m, and 98 per group at an effect of 31.5 m and 124 at 28 m;
   - the estimand strategy, which the product does not tie to the 35 m.

   The cited sources of the effect, the SD and the loss rate were not provided. Whether these values and a correlation value are supported for this population, and with them the N the design needs, therefore stays open.

### What this review could not check

- The planning values (the effect of 35 m, the SD of 90 m, the loss of 20% and the correlation of 0.5) were not graded against the published literature, so the sample size the design needs at supported planning values is open.
- The cited sources of the planning values (the hospital TKA registry internal report 2019–2021 and the steering committee decision of 3 June 2026) were not provided, so whether they contain the 35 m, the 90 m and the 20% was not checked.
- The study protocol was not provided and the statistical analysis plan is not yet written, so the planned test, the planned analysis and the 1:1 allocation were not checked against them.
- The robustness of the power to a skewed or bounded 6MWD, unequal arm variances or a heterogeneous effect was not assessed.
- The simulation was run at the delivered seed and grid only; other seeds or RNG streams and a grid finer than 5 per group were not examined, so the N at the product's inputs is known to the grid step of 5 (fitted crossing 79.3, 95% interval 78.5 to 80.2).
- The estimand, the handling of missing outcomes and the randomisation were read from the printed text only; no dedicated estimand, missing-data or randomisation assessment was made.
- Quarto was not available, so the PDF was not re-rendered; Figure 1 was compared with the code's output numerically, from the PDF's vector graphics.

---

<!-- dkf-consistency-review build: ledger=ISSUES.md sha256=e6cbf3245183eba74d7ca24dfdcc22df12f7059c67f975d5f0b53548bd25e19a final=no generated=2026-11-03T13:26:26 -->
