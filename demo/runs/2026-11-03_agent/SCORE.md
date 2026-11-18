# Score: agent with skills, 3 November 2026

- **Run.** `dkf-review`, then `dkf-consistency-review` (stats_review skills 0.1.0), depth
  `standard`, data mode `none`, one question: "Is the sample size adequate for the stated
  design?" Job `jobs/2026-11_DEMO-TKA`, given only the two files in `demo/sse/` as
  attachments. Claude Code on the web, on a Claude subscription. The model in the
  session record is claude-opus-5-5 for every message; the effort setting is not
  recorded.
- **Modules skipped.** The run stopped at the weekly usage limit while dispatching the
  first clinical module. On resuming, the user chose to skip the modules and finish, so
  the ledger status is `INTERIM` and the form says "Preview, not final".
- **Files.** `CONSISTENCY_REVIEW.md`, `.html` and `SYNTHESIS.md`, unchanged from the job.
  `ISSUES.md`, the `.org` form and the annotated source were not copied.
- **Scored** against `../../answer-key.md` (Scoring). Draft by Claude; the further
  finding awaits the human reviewer's judgement.

## Planted issues: 6 of 6 found

| # | Level | Result | Where the review names it |
|---|---|---|---|
| 1 | Text | found | Major 4: "The randomised sample size under-inflates for the stated 20% loss to follow-up" (Sample size, p. 2; `DEMO-TKA_SSE.qmd:76, :147`): 66 randomised leave 52.8 evaluable; 55 / (1 − 0.20) gives 69 per group, 138 in total |
| 2 | Text | found | Minor 1: "The estimand names no intercurrent events, and the analysis of all randomised participants is not what the calculation sizes" (Primary endpoint and estimand, p. 1) |
| 3 | Code | found | Major 1: "The simulation counts a one-sided 5% test, while the product states a two-sided 5% test" (`DEMO-TKA_SSE.qmd:65`) |
| 4 | Code | found | Major 2: "The power rests on a baseline-to-6-month correlation of 0.5 that the product neither prints nor sources" (`DEMO-TKA_SSE.qmd:45`) |
| 5 | Computation | found | Major 3: "The chosen N is the first grid point whose single 200-trial estimate reached 80%, and Figure 1 hides the estimates below 80%" (`DEMO-TKA_SSE.qmd:56, :73–74, :137`): names both the running maximum and the first-crossing selection |
| 6 | Computation | found | Minor 2: "The unadjusted t-test comparison prints 94 participants per group; Table 1 and the delivered code give 105" (`DEMO-TKA_SSE.qmd:82, :145`) |

Text 2, code 2, computation 2. As in the run of 31 October, the review rates the
estimand Minor; it rates the dropout allowance Major.

## The review's numbers against the answer key

- **Agree:** 80 evaluable per group under the stated two-sided test (fitted crossing
  79.3), 100 randomised per group and 200 in total; the correlation of 0.696 at which 55
  per group suffice; 106, 80 and 55 per group at correlations 0, 0.5 and 0.7; 69 per
  group and 138 in total for 55 evaluable; 52.8 evaluable from 66 randomised; 105 per
  group for the *t*-test, and 94 matching an SD of about 85 m; the raw estimates at 50,
  60, 65, 80 and 85 per group.
- **Within Monte Carlo error:** two-sided power at 55 of 63.6% at 4,000 trials per grid
  point (key, exact: 64.2%); one-sided power at 55 of 74.2% (key, exact: 75.3%); the
  one-sided test first reaching 80% at 65 per group on the grid of 5 (key: 63 needed).

## Sizing: 5 of 5

Scored on 18 November 2026 under the sizing rule then added to the answer key
(Scoring), from the review's own numbers: issue 1, 52.8 evaluable from 66 randomised
and 69 per group for 55 evaluable; 3, 80 evaluable per group under the stated
two-sided test, and 63.6% power at 55 by simulation; 4, 106, 80 and 55 per group at
correlations 0, 0.5 and 0.7, and 0.696 for 55; 5, 74.2% power at 55 under the
one-sided test, by simulation; 6, 105 per group for the *t*-test.

## Further findings (draft judgement)

| Review issue | Proposed | Reason |
|---|---|---|
| Minor 1, second half: the analysis of all randomised participants is not what the calculation sizes, and the product does not say how participants without a 6-month value enter it | valid | Expected finding: the handling of missing data is deferred to the statistical analysis plan |

Proposed: 1 valid, 0 invalid. The sources of the planning values are listed under
"What this review could not check", not raised as an issue (an expected finding). The
computed Decision ticks minor and major changes to the text, major changes to the code,
and clarification.

## Time and cost

From the session record ("Job 2026-11_DEMO-TKA creation and review"), times in UTC:

- **Elapsed:** 30 October 09:46 to 3 November 13:29, 4 days 3 hours 44 minutes.
- **Active:** about 98 minutes, 25 on 30 October and 73 on 3 November; 80 minutes of
  API time. Stage agents: document 10.8 min, code and data 11.0, statements 13.2,
  challenge 19.4, verdict 11.2, compile about 7 (split by the 5-hour limit), verify 1.9.
- **Waiting:** the weekly limit, already at 97% when the run started, stopped it 25
  minutes in (idle 97½ hours, until the user resumed on 3 November); the 5-hour limit
  stopped it once more (idle 31 minutes).
- **Defect cost:** the verdict check failed three times on a defect in the check itself
  (it compared the verdict's statement counts with the earlier statements ledger).
- **Tokens:** 531,001 output (294,942 of them thinking), 39.2 million read from cache,
  1.5 million written to cache.
- **Cost:** on a subscription; $26.84 at API list prices.
