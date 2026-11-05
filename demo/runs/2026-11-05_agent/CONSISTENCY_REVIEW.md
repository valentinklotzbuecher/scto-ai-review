# Consistency review: DEMO-TKA sample size estimation (DEMO-01, Version 1.0, 15 September 2026)

**Prepared:** 2026-11-05 · **Review depth:** quick · **Patient data:** not shared with the AI agent

> Pre-human review prepared by an AI agent with the DKF review skills (v0.2.0). It prepares the consistency review by a second statistician and does not replace it.

## Assignment

- Name of the statistical product: DEMO-TKA_SSE.pdf (rendered), with its Quarto source DEMO-TKA_SSE.qmd
- Important issues for reviewer:
  1. Is the sample size adequate for the stated design?
- Other documents this document depends on:
  - Study protocol: not provided
  - Saved results the product loads: none
  - Cited sources for planning values: not provided (the product cites an internal hospital TKA registry report, 2019–2021, and a steering committee decision of 3 June 2026)

## Review

### Decision

- [x] Statistical product needs minor changes in the text
- [x] Statistical product needs major changes in the text (second review necessary)
- [x] Statistical product needs minor changes in the R programming
- [x] Statistical product needs major changes in the R programming (second review necessary)
- [x] Clarifications required about code or methods (meeting or communication)

### General comments

The planned 55 evaluable and 66 randomised participants per group (132 in total) do not
give the stated 80% power for the stated design. Under the stated values (two-sided
5%, 35 m, SD 90 m) and the code's baseline–outcome correlation of 0.5, the ANCOVA needs
80 evaluable participants per group. For 20% loss that is 100 randomised per group, 200
in total; 55 per group gives 64.2% power. A one-sided rejection rule, a sample
size chosen on 200 noisy simulated trials and a dropout allowance that multiplies
instead of dividing produce the gap. The correlation the calculation depends on most is
neither stated nor sourced, and the estimand names no intercurrent events.

### Major issues

1. **The sample size does not give 80% power at the stated two-sided 5%** (Table 1, p. 1; Sample size, p. 2; DEMO-TKA_SSE.qmd:65, 74, 76, 147) [text and R code]

   The rejection rule `pt(t_arm, df = fit$df.residual, lower.tail = FALSE) < alpha`
   (DEMO-TKA_SSE.qmd:65) is a one-sided 5% test, while Table 1 and the Sample size section
   state "5%, two-sided". At two-sided 5%, 35 m, SD 90 m and a correlation of 0.5, the
   ANCOVA needs 80 evaluable participants per group; 55 per group gives 64.2% power. Even
   under the one-sided rule, power at 55 is 75.3% and 63 per group are needed: the printed
   81.5% is 163 of 200 trials (Monte Carlo 95% interval 76.1% to 86.9%), and N is the
   first grid point to reach 80% (qmd:74). The dropout allowance "55 × 1.2 = 66"
   (qmd:76, 147) leaves 52.8 expected evaluable per group (62.3% power). Fix: use
   `2 * pt(abs(t_arm), df = fit$df.residual, lower.tail = FALSE) < alpha`, and choose N
   from a closed form or a fitted power curve with about 2,000 trials per point. Inflate by
   N / (1 − d) and print the result: 80 evaluable and 100 randomised per group, 200 in
   total, at a correlation of 0.5.

2. **The baseline–outcome correlation the sample size depends on most is neither stated nor sourced** (Table 1, p. 1; Sample size, p. 1–2; DEMO-TKA_SSE.qmd:45) [text and R code, needs clarification]

   The power of the ANCOVA depends on the correlation between baseline and 6-month 6MWD,
   but Table 1 lists none and the text says only that adjustment "increases precision";
   the code sets `rho <- 0.5` (DEMO-TKA_SSE.qmd:45) without a source. At two-sided 5%, the
   evaluable N per group is 96, 89, 80, 68 and 55 for correlations of 0.3, 0.4, 0.5, 0.6
   and 0.7: no other planning value moves N as much, and 55 per group is adequate only
   near 0.7. A reader cannot reproduce or judge the sample size from the print (SPIRIT
   item 14). Fix: add the correlation and its source (pre-operative against 6-month 6MWD
   in comparable TKA patients) to Table 1, and print N across its plausible range.

3. **The estimand names no intercurrent events, and the calculation's evaluable set is not the stated analysis set** (Primary endpoint and estimand, p. 1; Analysis, p. 2; DEMO-TKA_SSE.qmd:103–106) [text]

   The estimand states population, treatments, variable and summary measure but no
   intercurrent events or strategies. Stopping or switching treatment, revision or
   contralateral knee surgery, inability to walk and death are plausible within 6 months;
   death truncates 6MWD, which a treatment-policy strategy cannot cover. "All
   randomised participants are analysed in the group to which they were allocated" is an
   analysis-set statement, while the sample size counts evaluable participants and
   defers missing data to the statistical analysis plan. The two agree only if missing
   6-month 6MWD is missing at random given baseline and arm, which the product does not
   state. The source is marked as a protocol section, where ICH E9(R1) places the
   estimand. Fix: name the intercurrent events with a strategy for each, say whether the
   35 m target is a treatment-policy effect, and state the missing-data assumption the
   sample size makes.

### Minor issues

1. **The 35 m target and the 20% loss to follow-up are not argued for this trial** (Table 1, p. 1; DEMO-TKA_SSE.qmd:112, 116) [text, needs clarification]

   Table 1 gives 35 m as the "Smallest difference of clinical interest" but does not say
   whether it is the minimal important difference for 6MWD after TKA or the effect
   app-guided exercise is expected to achieve over supervised physiotherapy, and argues
   neither. The 20% loss comes from the hospital's routine-care TKA registry and is
   applied to trial follow-up without saying how it was adapted. Evaluable N per group
   runs from 108 to 62 as the difference runs from 30 to 40 m, and randomised N for 80
   evaluable from 89 to 115 as loss runs from 10% to 30%. Fix: say whether 35 m is the
   minimal important difference or the expected effect, and cite the evidence for it.
   Say how registry loss was adapted to trial follow-up.

2. **Figure 1 plots a running maximum labelled "Estimated power"** (Figure 1, p. 2; DEMO-TKA_SSE.qmd:73, 137) [R code]

   The plotted curve is `cummax(power_raw)` (DEMO-TKA_SSE.qmd:73), not the simulated
   power: 5 of the 13 points lie above the simulated value at their N (60 per group:
   81.5% plotted against 77.0%; 65 per group: 81.5% against 79.0%). The plot therefore does
   not show the Monte Carlo noise, including a 13.5-point rise between 50 and 55 per group. Fix: plot the raw
   estimates with Monte Carlo intervals, or a fitted curve, and label the figure
   accordingly.

3. **The unadjusted t-test comparator of 94 per group is typed into the text and does not follow from Table 1** (Sample size, p. 2; DEMO-TKA_SSE.qmd:82, 145) [text]

   Under Table 1's values (35 m, SD 90 m, two-sided 5%, 80% power) an unadjusted
   two-sample t-test needs 105 participants per group (104.8); the code computes this as
   `n_ttest` (DEMO-TKA_SSE.qmd:82) but never prints it, and the text types 94 (qmd:145).
   94 follows only from other inputs, such as an SD of 85.2 m. The comparator understates
   by 11 per group the gain the text attributes to baseline adjustment. Fix: print
   `n_ttest` inline (105 under Table 1), or state the inputs that give 94.

### Answers to the issues listed in the assignment

1. *Is the sample size adequate for the stated design?*

   No. At the product's own planning values (35 m, SD 90 m, two-sided 5%, 80% power, 20%
   loss) and the correlation of 0.5 its code uses, the ANCOVA design needs 80 evaluable
   participants per group, 100 randomised per group and 200 in total; the printed 55
   evaluable per group gives 64.2% power, and the 52.8 expected from 66 randomised 62.3%.
   The gap comes from a one-sided rejection rule, a choice of N on 200 noisy simulated
   trials and a multiplicative dropout allowance (Major issue 1). Adequacy also depends on
   the baseline–outcome correlation, which the product does not state: 55 per group
   suffices only near 0.7, while 0.3 needs 96 (Major issue 2).

### What this review could not check

- The steering committee decision and the hospital TKA registry report were not provided, and independent literature on the 6MWD target and SD after TKA could not be obtained, so whether 35 m, 90 m and 20% match their sources was not checked.
- The protocol was not provided, so the design, randomisation and endpoint were checked as this document prints them, not against the protocol.
- Quarto was not available, so the code was run in R 4.3.3 without it and printed values, not the typeset layout, were compared with the code's output.
- Normality of 6MWD, which the simulation assumes, was not checked.
- Multiplicity, regression-model, observational, prediction-model and Bayesian diagnostics were not run at this review depth, and no independent challenge of the findings ran.

---

<!-- dkf-consistency-review build: ledger=ISSUES.md sha256=a5b1f0bc5cf3571bffa74418a0ebd03b699b49a1eed22ce8dd0768d98cbbe24c final=yes generated=2026-11-05T06:57:56 -->
