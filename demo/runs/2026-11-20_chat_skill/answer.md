I'll load your DKF document check and go through the SSE against both the source and the rendered PDF.

The `dkf-document-check` skill isn't installed in this session. I'll look for a local copy, then do the check directly.

Found a synced copy of the skill on disk; following it now. Next I'll recompute every printed number with the skill's `recompute.py`, using the PDF as the basis for findings.

I couldn't load `dkf-document-check` with the Skill tool in this session, so I followed the copy synced to disk (v0.1.1).

## 1. Status

**What I received:**
- **DEMO-TKA_SSE.pdf**: "Sample Size Estimation", DEMO-TKA, Version 1.0, 15 September 2026, by DKF Statistics, 2 pages. It doesn't print a status (draft or final) or a registry ID, and it's marked as a demonstration document.
- **DEMO-TKA_SSE.qmd**: the source. Its YAML date (2026-09-15) matches the PDF. Its fields are internal-dkf-id DEMO-01, product-type SSE, influence-on-protocol *high*, level-of-assumptions *medium* and final-product-risk *medium*.

**What's missing:** the protocol, the registry entry, the steering-committee record of 3 June 2026 and the hospital TKA registry internal report (2019–2021).

**Main result:** the printed 55 evaluable per group (81.5% power) can't be reproduced with the two-sided 5% test the document states.
- The source uses a correlation of 0.5, which isn't printed. With it, a two-sided test needs **79 evaluable per group**, and power at 55 is 64.5%.
- The printed curve matches a one-sided 5% test at all 13 grid points and a two-sided test at none (C04–C06).
- Dividing by (1 − 0.2) for loss to follow-up, the trial needs **99 randomised per group, 198 in total**, not 132.

## 2. Findings

### Documents and versions
None. The title page, version line and source YAML agree.

### Printed consistency and arithmetic

**D1. The printed sample size fits a one-sided test, not the two-sided 5% test the document states.**
- **Where:** p.2 §4 ("55 … 81.5%") and Figure 1, against Table 1 ("5%, two-sided") and §4 ("two-sided 5% level"). In the source, `DEMO-TKA_SSE.qmd:65`.
- **Evidence:** C03–C06.
- **What's wrong:** the source sets ρ = 0.5 (qmd:45). With the planning values in Table 1, a two-sided 5% ANCOVA then needs 79 evaluable per group. Power at 55 is 64.5% against the printed 81.5%, a gap of 5.0 Monte Carlo SE. The plotted curve is within 2 MCSE of a one-sided 5% test at 13/13 points and of a two-sided test at 0/13.
  - From the print alone, the curve could also come from a two-sided test with ρ ≈ 0.66.
  - The source supports the one-sided reading: qmd:65 rejects when `pt(t_arm, df, lower.tail = FALSE) < alpha`. That is one-sided at 5%, the same as two-sided at 10%.
- **Effect:** the trial is too small (anti-conservative).
  - Evaluable participants go from 55 to 79 per group (+24).
  - Randomised go from 66 to 99 per group, and from 132 to 198 in total (with D4's formula).
  - With a two-sided test, the printed design has 64.5% power at 55 evaluable. It has 62.7% at the 52.8 per group expected to remain from 66 randomised (C19).
- **Fix:** reject on `2 * pt(abs(t_arm), fit$df.residual, lower.tail = FALSE) < alpha` and rerun. If a one-sided test is intended, say so in Table 1 and §4 and use 2.5% one-sided. That also gives 79.

**D2. The correlation that drives the ANCOVA gain isn't printed.**
- **Where:** §4 p.1 says the trials were simulated "under the planning values in Table 1", but Table 1 has no correlation. qmd:45 sets `rho <- 0.5` with no source.
- **Evidence:** C20.
- **What's wrong:** a reader can't reproduce N from the print. Evaluable N per group for a two-sided test, by correlation:

  | ρ | 0 | 0.3 | 0.4 | 0.5 | 0.6 |
  |---|---|---|---|---|---|
  | Evaluable N per group | 105 | 96 | 89 | 79 | 68 |

  SPIRIT 2025 asks for every assumption behind the sample size.
- **Effect:** for ρ between 0.3 and 0.6, N runs from 96 to 68 evaluable per group.
- **Fix:** add the correlation between pre-operative and 6-month 6MWD to Table 1 with its source. If the 2019–2021 registry has pre-operative 6MWD, estimate it there. Print N for a range of values.

**D3. Monte Carlo precision doesn't resolve the chosen N.**
- **Where:** §4 p.2 and the Figure 1 caption ("200 simulated trials").
- **Evidence:** C08–C10.
- **What's wrong:** with 200 replicates, the MCSE at 81.5% is 2.7 percentage points. The margin over 80% is 1.5 points, or 0.55 MCSE. Even under the model the curve fits (one-sided, ρ = 0.5), the true requirement is 63. The rule "first grid point with estimate ≥ 80%" picks 55 in only 8.4% of repeated runs.
- **Effect:** about 8 too few evaluable per group even on the document's own model (55 vs 63). This is separate from D1.
- **Fix:** use at least 2,000 replicates (MCSE 0.9 points) or 10,000 (0.4 points), and print the MCSE. Check the result against the formula of Borm et al. (2007): t-test N × (1 − ρ²) = 79.

**D4. The dropout inflation multiplies instead of divides.**
- **Where:** p.2 §4, "55 × 1.2 = 66 … 132 in total".
- **Evidence:** C12–C15.
- **What's wrong:** if 20% of 66 randomised are lost, 52.8 remain, which is below 55. Dividing instead, N/(1 − d) = 68.75, so 69 per group and 138 in total.
- **Effect:** 3 too few per group (6 in total) at the printed N. Once D1 is fixed, 79/0.8 gives 99 per group (198 in total), not 95 (190).
- **Fix:** randomise ⌈N/(1 − 0.2)⌉ per group and print the formula.

**D5. The t-test comparison of 94 per group is wrong.**
- **Where:** p.2 §4. The 94 is typed at qmd:145; `n_ttest` is computed at qmd:82 but never used.
- **Evidence:** C01–C02.
- **What's wrong:** the inputs in Table 1 give 105 per group for a two-sided t-test and 83 for a one-sided one. Neither gives 94.
- **Effect:** no effect on N, but it overstates the gain from ANCOVA: the document shows 94 → 55 (−41%), whereas the correct figures are 105 → 79 (−25%).
- **Fix:** print `` `r n_ttest` ``, computed with the same sidedness as the ANCOVA.

**D6. Figure 1 plots a running maximum but is captioned "Estimated power".**
- **Where:** p.2, Figure 1 and caption. The source uses `cummax(power_raw)` at qmd:73.
- **Evidence:** C11, C16–C17.
- **What's wrong:** the curve never decreases and has 5 exact ties between neighbouring points (45 = 50; 55 = 60 = 65; 75 = 80 = 85).
  - Independent estimates would give that many ties with probability 0.0001, and a never-decreasing curve with probability 0.011.
  - A running maximum gives that many ties with probability 0.34.
- **Effect:** N doesn't change, because the first point at or above 80% is the same for the raw and the running-maximum curve. But the figure overstates power at the tied points and hides the Monte Carlo noise.
- **Fix:** plot the raw estimates with Monte Carlo intervals and caption them accordingly.

### Design and method

**D7. The estimand has no intercurrent events or strategies.**
- **Where:** p.1 §2.
- **What's wrong:** treatment, population, variable and summary measure are stated, but intercurrent events are not. Relevant ones here include:
  - stopping the app, or adding physiotherapy outside the trial in the app arm;
  - missed sessions in the control arm;
  - revision surgery or a knee replacement on the other side before 6 months;
  - death, or being unable to do the 6MWD.

  "All randomised participants are analysed in the group to which they were allocated" describes the analysis set, not a strategy.
- **Effect:** the 35 m target and the 20% allowance don't refer to a defined estimand. Under a treatment-policy strategy, extra physiotherapy in the app arm shrinks the difference between arms.
- **Fix:** give each intercurrent event a strategy, and state that the 35 m refers to that estimand.

**D8. The stated analysis set differs from the analysis the sample size assumes.**
- **Where:** §2 p.1 against §4 and §5.
- **What's wrong:** §2 says all randomised participants are analysed. But §4 sizes the trial on evaluable participants with 20% lost. An ANCOVA of observed 6-month 6MWD analyses complete cases only, and §5 leaves missing data to the SAP.
- **Effect:** it isn't defined how the 20% of randomised participants without an outcome enter the primary analysis.
- **Fix:** state the primary analysis. Either use all randomised with multiple imputation under MAR, or use complete cases and state that assumption. Also say what the dropout inflation assumes.

**D9. The direction of the target effect isn't stated.**
- **Where:** §1 ("superiority") and Table 1 ("35 m").
- **What's wrong:** the print doesn't say which arm is expected to walk further. App-guided home exercise against supervised physiotherapy is often tested for non-inferiority.
- **Effect:** if the investigators' question is whether the app is not worse, the design answers a different question.
- **Fix:** state the hypothesis, for example "the app increases 6MWD at 6 months by ≥ 35 m", and confirm superiority with the investigators.

## 3. Tables

**check_log.csv** has all 10 columns. Condensed:

| id | location | quantity | printed | recomputed | result |
|---|---|---|---|---|---|
| C01 | p.2 §4 | t-test N per group, two-sided | 94 | 105 | mismatch |
| C02 | p.2 §4 | t-test N per group, one-sided | 94 | 83 | mismatch |
| C03 | p.2 §4 | ANCOVA evaluable N, two-sided, ρ 0.5 | 55 | 79 | mismatch |
| C04 | p.2 §4 | power at 55, two-sided | 81.5% | 64.5% | mismatch (band 6.8 points) |
| C05 | p.2 §4 | power at 55, one-sided | 81.5% | 75.6% | within band (6.1 points) |
| C06 | Fig 1 | 13 plotted values | 0.635–0.950 | two-sided 0/13, one-sided 13/13 within 2 MCSE | mismatch / within band |
| C07 | p.2 §4 | ρ implied by 55 if two-sided | — | 0.69 | derived |
| C08 | p.2 §4 | 81.5% possible with 200 replicates | 81.5% | 163/200 | match |
| C09 | p.2 §4 | MCSE at 81.5% | — | 2.7 points (margin 0.55 MCSE) | derived |
| C10 | p.2 §4 | chosen N, one-sided model | 55 | true 63; 55 chosen in 8.4% of runs | derived |
| C11 | Fig 1 | ties between neighbouring points | 5 | P = 0.0001 if independent; 0.34 if running max | derived |
| C12 | p.2 §4 | 55 × 1.2 | 66 | 66.0 | match |
| C13 | p.2 §4 | 55 / (1 − 0.2) | 66 | 69 | mismatch |
| C14 | p.2 §4 | evaluable left from 66 | 55 needed | 52.8 | mismatch |
| C15 | p.2 §4 | total randomised | 132 | 132 | match |
| C16 | Fig 1 | dotted line position | 55 | 55.0 | match |
| C17 | Fig 1 | dashed line position | 0.80 | 0.800 | match |
| C18 | p.2 §4 | corrected design | 55 / 66 / 132 | 79 / 99 / 198 | mismatch |
| C19 | p.2 §4 | printed design's two-sided power | 80% | 62.7% | mismatch |
| C20 | Table 1 | evaluable N by ρ (0 to 0.6) | 55 | 105 / 96 / 89 / 79 / 68 | derived |

**consistency_table.csv** has 29 elements:
- *differs*: sidedness (print against source and figure) and the analysis set (§2 against §4–5).
- *missing-in-product*: intercurrent events, the correlation and the direction of the effect.
- Every protocol, SAP and registry cell is *not in chat*.

**sensitivity_statements.csv** has 5 claims: 3 CONTRADICTED (the 55/80% claim, the t-test's 94, the 66 randomised), 1 QUALIFIED (the precision gain) and 1 CONTRADICTED given ρ = 0.5 (the two-sided test). The search terms were *robust, sensitive, driven, conservative, at least, remains, adequate, increases precision, would require, allowing for*.

## 4. Leads for the code review
- **qmd:65:** the rejection rule is one-sided (D1). Rerun it two-sided; the first grid point at or above 80% should land around 75–85.
- **qmd:56 and qmd:71–74:** `n_sim = 200` and a step-5 grid, which rounds N up to a multiple of 5 (80, not 79). Report the MCSE (D3).
- **qmd:73:** `cummax` (D6).
- **qmd:82 against qmd:145:** `n_ttest` is computed but 94 is typed (D5). The "1.2" at qmd:147 and the values in Table 1 (qmd:112–117) are also typed separately from the settings at qmd:43–48, so changing a planning value won't update every printed number.
- **qmd:45:** ρ = 0.5 has no source (D2).
- **qmd:60–62:** the simulation sets the baseline SD equal to the 6-month SD and simulates no missing outcomes. Check that this matches the intended analysis (D8).
- **Reproduction:** does the code give 55 and 81.5% under R 4.3.3 with seed 20260108? I didn't run the product's code, by the skill's rule.

## 5. Not covered
- The protocol. Influence-on-protocol is *high*, so the second reviewer's protocol comparison is core.
- The registry entry, the SAP, the steering-committee record of 3 June 2026 and the registry internal report (2019–2021) behind the 90 m SD and the 20% loss.
- Whether the product's code reproduces the printed numbers, and where ρ comes from.
