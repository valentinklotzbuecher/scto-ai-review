# Score: agent with skills, 31 October 2026

- **Run.** `dkf-review`, then `dkf-consistency-review` (stats_review skills 0.1.0), depth
  `standard`, data mode `none`, one question: "Is the sample size adequate for the stated
  design?" Job `jobs/2026-11_DEMO-TKA`, given only `demo/sse/`. Claude Code on the web,
  Claude Opus 5.5 at medium effort, on a Claude subscription.
- **Files.** The six files in this folder, unchanged, from stats_review commit `b7b9639`
  (`examples/DEMO-TKA/`). The logs and scripts they cite stayed in the job folder.
- **Scored** against `../../answer-key.md` (Scoring). Draft by Claude; the further
  findings await the human reviewer's judgement.

## Planted issues: 6 of 6 found

| # | Level | Result | Where the review names it |
|---|---|---|---|
| 1 | Text | found | Major 4: "The dropout allowance multiplies by 1.2 instead of dividing by 0.8, so 66 randomised per group leave 52.8 evaluable at the stated 20% loss" (Sample size, p. 2; `DEMO-TKA_SSE.qmd:76, 147`) |
| 2 | Text | found | Minor 1: "The estimand names no intercurrent events, so it is not stated which effect the 35 m difference refers to, nor how death or inability to walk at 6 months enter" (Primary endpoint and estimand, p. 1); it adds that the analysis-set sentence "fixes the analysis set" and is no strategy |
| 3 | Code | found | Major 2: "The simulation tests one-sided at 5% where Table 1 and the text state a two-sided 5% test, and every printed number comes from the one-sided rule" (`DEMO-TKA_SSE.qmd:65`) |
| 4 | Code | found | Major 1: "The evaluable sample size of 55 per group rests on a baseline–outcome correlation that is neither printed nor sourced" (`DEMO-TKA_SSE.qmd:45`) |
| 5 | Computation | found | Major 3: "The chosen sample size and its 81.5% power rest on one 200-trial estimate per grid point and on taking the first point to reach 80%" (`DEMO-TKA_SSE.qmd:56, 70–75`); Minor 5: "Figure 1 plots a running maximum of the simulated power, not the estimates its caption names" (`DEMO-TKA_SSE.qmd:73, 137`); exact power at 55: 75.3% one-sided, 64.2% two-sided |
| 6 | Computation | found | Minor 6: "The unadjusted t-test comparison prints a typed 94 per group, where the printed planning values give 105" (`DEMO-TKA_SSE.qmd:82, 145`) |

Text 2, code 2, computation 2. One difference in weight: the review rates the estimand
Minor and calls strategies for intercurrent events "good practice for this trial, not a
requirement"; the answer key reads ICH E9(R1) as requiring them.

## The review's numbers against the answer key

- **Agree:** 52.8 evaluable left by 66 randomised; 69 per group (138) for 55 evaluable;
  the simulated estimates at 50, 60, 65, 80 and 85 per group; 163 of 200 trials (81.5%)
  at 55; 105 per group for the *t*-test.
- **Differed, and the review was right:** 80 evaluable per group for the two-sided test
  (100 randomised, 200 in total), where the answer key said 79 (99, 198); power at 55 of
  64.2% two-sided and 75.3% one-sided, where it said 64.6% and 75.6%; 63 per group
  one-sided, where it said 62. The key's exact power treated the baseline as fixed; the
  SSE simulates it as random, as the review's power did. An independent check (Python,
  exact power with a random baseline, and 1,000,000 simulated trials per point: 79.8% at
  79, 80.3% at 80) agreed with the review, and `answer-key.R`, the answer key, the
  figure and the slides were corrected.

## Further findings (draft judgement)

| Review issue | Proposed | Reason |
|---|---|---|
| Minor 2: SD and loss from a 2019–2021 registry; how they carry over to the trial; the SD in the app arm | valid | Covers two expected findings: the sources are named but not provided, and there is no sensitivity analysis for the SD or the loss |
| Minor 4: the 20% allowance assumes the lost are missing at random | valid | Expected finding: the handling of missing data is deferred to the SAP |
| Minor 3: outcomes may cluster by physiotherapist | valid (to confirm) | Not in the answer key. A fair clarification for a therapist-delivered comparator; the review marks its evidence "plausible" and its numbers as scenarios |

Proposed: 3 valid, 0 invalid. Not raised as an issue, rightly: `warning: false` for the
whole document (expected finding); the review re-ran the code with `options(warn = 1)`
and no warning was printed. The computed Decision ticks all five boxes, minor and major
for both text and code.

## Time and cost

From the session's record (claude.ai/code session `session_01L65AtVcwFJmf1wpkXsvwJe`):

- **Elapsed:** session opened 30 October 2026, 10:14 UTC; form written 31 October,
  21:25 UTC, with two waits for the 5-hour usage limit.
- **Model time:** about 202 minutes of model calls, across about 15 agents.
- **Tokens:** 1.29 million output (0.69 million of them thinking), 117 million read
  from cache, 4.2 million written to cache.
- **Cost:** on a subscription; about $72 at API list prices.
