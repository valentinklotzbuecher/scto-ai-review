# Score: chat with the document skill, 20 November 2026

- **Run.** The chat skill `dkf-document-check` 0.1.1 (stats_review `chat-skills/`,
  following the review skills 0.3.1), run by the user in a Claude app session with the
  two files in `demo/sse/` attached and a request for the document check (the prompt in
  `tools/1-chat`). The skill was not yet installed in that session: the model found the
  copy synced to disk and followed it ("I couldn't load `dkf-document-check` with the
  Skill tool in this session, so I followed the copy synced to disk (v0.1.1)"). So the
  session could read files on disk: an app session with tools, not a bare chat window.
  It ran its own scripts (`recompute.py`, its own simulations, a read of the plotted
  values from the PDF's vector graphics), never the product's code ("I didn't run the
  product's code, by the skill's rule"). Model, effort and time not recorded.
- **Files.** `answer.md`, the answer as the user pasted it into this kit's Claude Code
  session; `check_log.csv`, `consistency_table.csv` and `sensitivity_statements.csv`,
  the files it saved, as uploaded (byte-identical).
- **The answer key out of reach?** The answer shows no sign of it: its sample sizes
  follow its own stated method (a fixed-baseline approximation: 79 per group, where the
  key has 80), it does not give the key's explanation of the typed 94 (an SD of 85 m),
  and it raises a point the key does not (D9).
- **Scored** against `../../answer-key.md` (Scoring). Draft by Claude; the further
  findings await the human reviewer's judgement.

## Planted issues: 6 of 6 found

| # | Level | Result | Where the answer names it |
|---|---|---|---|
| 1 | Text | found | D4: "The dropout inflation multiplies instead of divides." (p.2 §4, "55 × 1.2 = 66 … 132 in total") |
| 2 | Text | found | D7: "The estimand has no intercurrent events or strategies." (p.1 §2); the analysis-set sentence "describes the analysis set, not a strategy" |
| 3 | Code | found | D1: "The printed sample size fits a one-sided test, not the two-sided 5% test the document states."; "qmd:65 rejects when `pt(t_arm, df, lower.tail = FALSE) < alpha`. That is one-sided at 5%" |
| 4 | Code | found | D2: "The correlation that drives the ANCOVA gain isn't printed."; "qmd:45 sets `rho <- 0.5` with no source" |
| 5 | Computation | found | D6: "Figure 1 plots a running maximum but is captioned "Estimated power"." (`cummax(power_raw)` at qmd:73); D3: "Monte Carlo precision doesn't resolve the chosen N." (the first grid point at 80%, 200 replicates) |
| 6 | Computation | found | D5: "The t-test comparison of 94 per group is wrong."; "The 94 is typed at qmd:145; `n_ttest` is computed at qmd:82 but never used", and Table 1 gives 105 |

Text 2, code 2, computation 2. The skill writes findings, not the DKF form, so nothing
is rated Major or Minor. Two findings lean on the source, as the skill allows ("to see
where a printed number comes from"): D1 notes that the print alone fits either a
one-sided test or a two-sided one with a correlation of about 0.66, and settles it with
qmd:65; D2 cites qmd:45. D6 establishes the running maximum from the print first: five
ties among the 13 plotted values have probability 0.0001 for independent estimates, and
`cummax` in the source confirms it.

## The answer's numbers against the answer key

- **Agree:** 52.8 evaluable from 66 randomised per group; 69 per group (138 in total)
  for 55 evaluable; 105 per group for the *t*-test (83 one-sided); 63 per group under
  the code's one-sided test; 163 of 200 trials for the printed 81.5%, with a Monte Carlo
  SE of 2.7 points; 0.69 as the correlation 55 per group needs (key 0.696); 96 per group
  at a correlation of 0.3.
- **Differ by one per group or under half a point:** 79 evaluable per group under the
  two-sided test (key 80), so 99 randomised and 198 in total (key 100 and 200); 105 at a
  correlation of 0 (key 106); 64.5% power at 55 two-sided (key 64.2%), 75.6% one-sided
  (key 75.3%), 62.7% as planned (key 62.3%). Its exact power treats the baseline as
  fixed, as the first version of the key did; with a random baseline, as the SSE
  simulates it, the numbers are the key's. All within the sizing tolerance. It notes
  that the product's step-5 grid "would give 80".
- **Not given:** that 94 matches an SD of 85 m.

## Sizing: 5 of 5

From the answer's own numbers: issue 1, 52.8 evaluable per group from 66 randomised and
69 per group for 55 evaluable; 3, 64.5% power at 55 and 79 evaluable per group under the
stated two-sided test; 4, 105, 96 and 79 per group at correlations 0, 0.3 and 0.5, and
0.69 as the correlation 55 needs; 5, 75.6% power at 55 under the code's one-sided test,
63 per group, and a Monte Carlo SE of 2.7 points; 6, 105 per group for the *t*-test.

## Further findings (draft judgement)

| Finding | Proposed | Reason |
|---|---|---|
| D8: the stated analysis set (all randomised) differs from the evaluable set the sample size assumes; missing data are deferred to the SAP | valid | Expected finding: the handling of missing data is deferred to the statistical analysis plan |
| D9: the direction of the target effect is not stated; superiority or non-inferiority | valid (to confirm) | Not in the answer key. The SSE says "superiority" but not which arm is expected to walk further, and under the code's one-sided rule the direction decides the test; whether the question is non-inferiority is for the investigators |

Proposed: 2 valid, 0 invalid. Not raised as findings: the sources of the planning values
(under "Not covered"), and `warning: false`. The leads for the code review add a point
the key does not list: the "1.2" and the values in Table 1 are typed separately from the
settings at qmd:43–48, so a changed planning value would not update every printed
number.

## Time and cost

Not recorded. Run by the user on a Claude plan, so no API cost; model, effort and time
to be added from the user.
