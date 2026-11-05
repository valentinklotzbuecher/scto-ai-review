# Score: agent with skills, depth quick, 5 November 2026

- **Run.** `dkf-review`, then `dkf-consistency-review` (stats_review skills 0.2.0, the
  first version with the two-agent `quick` depth and length limits), depth `quick`,
  data mode `none`, one question: "Is the sample size adequate for the stated design?"
  Job `jobs/2026-11-5_DEMO-TKA2`, given only the two files in `demo/sse/` as
  attachments. Claude Code on the web, on a Claude subscription; the session record
  gives claude-opus-5-5 at effort `xhigh`.
- **Agents.** The coordinator; one review agent (document, code and data with the
  sample-size, simulation, estimand, RCT and missing-data modules worked through in the
  same agent, statements); one verdict agent that also compiled the form; one fresh
  verify agent. Status `COMPLETE`; the form is final.
- **Files.** The form (`.md`, `.html`, `.org`), `ISSUES.md`, `SYNTHESIS.md`, the
  annotated source and the verify record, unchanged from the job.
- **Scored** against `../../answer-key.md` (Scoring). Draft by Claude; the further
  findings await the human reviewer's judgement.

## Planted issues: 6 of 6 found

| # | Level | Result | Where the review names it |
|---|---|---|---|
| 1 | Text | found | Major 1: "The dropout allowance "55 × 1.2 = 66" (qmd:76, 147) leaves 52.8 expected evaluable per group (62.3% power)", with the fix "Inflate by N / (1 − d)" |
| 2 | Text | found | Major 3: "The estimand names no intercurrent events, and the calculation's evaluable set is not the stated analysis set" (Primary endpoint and estimand, p. 1; `DEMO-TKA_SSE.qmd:103–106`) |
| 3 | Code | found | Major 1: "The rejection rule `pt(t_arm, df = fit$df.residual, lower.tail = FALSE) < alpha` (DEMO-TKA_SSE.qmd:65) is a one-sided 5% test, while Table 1 and the Sample size section state "5%, two-sided"" |
| 4 | Code | found | Major 2: "The baseline–outcome correlation the sample size depends on most is neither stated nor sourced" (`DEMO-TKA_SSE.qmd:45`) |
| 5 | Computation | found | Major 1: "the printed 81.5% is 163 of 200 trials (Monte Carlo 95% interval 76.1% to 86.9%), and N is the first grid point to reach 80% (qmd:74)"; Minor 2: "Figure 1 plots a running maximum labelled "Estimated power"" (`DEMO-TKA_SSE.qmd:73, 137`) |
| 6 | Computation | found | Minor 3: "The unadjusted t-test comparator of 94 per group is typed into the text and does not follow from Table 1" (`DEMO-TKA_SSE.qmd:82, 145`) |

Text 2, code 2, computation 2. Unlike the two `standard` runs, this one rates the
estimand Major, the weight the answer key gives it. It folds three planted issues (the
one-sided test, the first crossing, the dropout allowance) into one Major issue, as
problems a colleague fixes in one go; each is named with its location and fix.

## The review's numbers against the answer key

- **Agree:** 80 evaluable per group under the stated two-sided test, 100 randomised
  and 200 in total; 64.2% power at 55 per group; 75.3% one-sided and 63 per group
  needed one-sided; 62.3% for the 52.8 expected evaluable as planned; 96, 80 and 55
  per group at correlations 0.3, 0.5 and 0.7; 105 per group (104.8) for the *t*-test,
  and 94 matching an SD of about 85 m; the plotted against simulated values at 60 and
  65 per group.

## Further findings (draft judgement)

| Review issue | Proposed | Reason |
|---|---|---|
| Minor 1: the 35 m target and the 20% loss are not argued for this trial | valid | Expected finding: the sources are named but not provided, and no sensitivity analysis; the review sizes both |
| Major 3, second half: the evaluable set and "all randomised" agree only if missing 6-month values are missing at random | valid | Expected finding: the handling of missing data is deferred to the statistical analysis plan |

Proposed: 2 valid, 0 invalid. One citation slip: Major 2 cites "SPIRIT item 14" for
the sample size, the SPIRIT 2013 number; SPIRIT 2025 numbers it 19 (corrected in the
skills' guideline reference, version 0.2.2). The computed Decision ticks all five boxes.

## Time, cost and size

From the session record ("Job creation and consistency review"), times in UTC:

- **Elapsed:** 06:25 to 06:59, **34 minutes** from the first message to the final,
  verified form, including installing R and knitr and one question to the user (the
  literature check, which the network blocked, was waived).
- **Model time:** 30 minutes of API time.
- **Tokens:** 200,240 output, 15.5 million read from cache, 0.5 million written.
- **Cost:** on a subscription; $9.72 at API list prices.
- **Size:** the form's general comments, issues and answers 1,136 words (limit about
  1,000, gate 1,250); the whole form 1,466 words; `SYNTHESIS.md` 3,434 words (limit
  about 3,000, gate 3,750). The `standard` runs wrote 2,600 to 2,900-word forms and
  9,200 to 12,700-word syntheses.
- **A defect found:** without the optional `mistune` package, the form's built-in
  Markdown converter broke two passages; the verify agent re-wrapped them (line breaks
  only). Fixed in the skills, version 0.2.1.
