# Verify pass: consistency review (dkf-consistency-review step 7)

- Date: 2026-11-05; fresh context; no operator contact.
- Read: CONSISTENCY_REVIEW.html (as text), CONSISTENCY_REVIEW.md, ISSUES.md, SYNTHESIS.md, 00_ASSIGNMENT.md; spot-checks in review/extracts/DEMO-TKA_SSE.txt, 01_product/DEMO-TKA_SSE.qmd, work/logs/ss_ancova_recompute.log.
- Ledger revision verified: sha256:ad67d0a1af99 (as delivered) → sha256:a5b1f0bc5cf3 (after the line-break fix below).
- Result: **PASS after a form-mechanics fix.** No finding, number, quote or severity changed; no ERRATA.md item opened.

## Checks

| Check | Result |
|---|---|
| Decision boxes follow from the issues | Pass. Major text: issues 1–3; major R code: issues 1, 2; minor text: issues 4, 6; minor R code: issue 5; clarification: issues 2, 4. All five boxes ticked, each with at least one issue behind it. |
| Severity and change/clarification | Pass. Defaults hold: issue 1 carries primary rows not established (ST01–ST03); issue 2 a supporting row not established (ST07); issue 3 a primary row narrower (ST09); issues 4–6 supporting rows narrower (ST05/ST06, ST04, ST08). No departures. `change:` follows the mapped findings' `where:` (F1, F3 code + F4 text and code → text and code; F2 text and code; F5 text; F6 unresolved → text, clarification yes; F7 code; F8 text). |
| Every issue has a location and a concrete fix | Pass. All six render a printed location with qmd lines and end with "Fix: …" naming the change. |
| General comments carry the bottom line | Pass. They lead with the synthesis's lead finding (55/66 per group, 132, do not give 80% power for the stated design; 80 evaluable, 100 randomised, 200 at a correlation of 0.5; 64.2%), name the same three causes, then the unstated correlation and the estimand. Not softer than "the sample size itself is not established". Five sentences. |
| Assignment question answered as asked | Pass. Q1 answers "No." with the synthesis's numbers and dependence on the correlation; status `answered` in the ledger and the synthesis. The renderer does not print the status line (by design of the script; the answer's opening word conveys it). |
| No process subject; no internal IDs, stage names or paths in rendered prose | Pass. Scan of the rendered text for row/finding IDs, artifact names, job paths and stage words found none (only "ICH E9(R1)" and the form's own "issues" headings). Sentences about the review's reach sit only under "What this review could not check", as the form intends. |
| Not checked matches the synthesis's limits | Pass. Sources not provided, protocol not provided, render environment, normality, modules not run at this depth and no independent challenge; all stated as limits of the review, not faults of the product. |

## Spot-checks against the product

- qmd lines cited in the issues hold: 45 `rho <- 0.5`; 65 one-sided `pt(..., lower.tail = FALSE) < alpha`; 73 `cummax(power_raw)`; 74 first grid point ≥ target; 76 `ceiling(n_evaluable * (1 + dropout))`; 82 `n_ttest`; 103–106 estimand; 112, 116 Table 1 rows for 35 m and 20%; 137 plot of `power_curve`; 145 typed "94"; 147 typed "× 1.2".
- Quotes found verbatim in the printed extract: "5%, two-sided" (Table 1), "55 × 1.2 = 66 participants per group, 132 in total", "increases precision", "Smallest difference of clinical interest", "would require 94 participants per group".
- Numbers: `power.t.test(delta = 35, sd = 90, power = 0.8)` gives n = 104.77 (issue 6: 105, 104.8). The log records two-sided power 0.642 at 55 and 0.803 at 80 per group (issues 1, Q1: 64.2%, 80). A quick independent closed form with the 1 − ρ² factor gives 79 two-sided and 63 one-sided, matching the synthesis's "80 (79 by the 1 − ρ² design factor)" and "63". The normal-approximation 95% interval for 163/200 is 76.1% to 86.9%.

## Defects found and fixed (form mechanics only)

1. **Issue 1 lost a line reference and split its body.** In the ledger a wrapped line began "147) leaves 52.8 …". The renderer's built-in Markdown converter read it as an ordered list starting at 147. The HTML therefore printed "(qmd:76," followed by a numbered list item, dropped "147)", and moved the code fix into a separate paragraph. Fix: re-wrapped so "(qmd:76, 147)" sits on one line.
2. **"What this review could not check" bullets were broken mid-sentence.** Each bullet's continuation line became a separate paragraph inside the list item (for example "were not" / "provided, …"). Fix: each bullet on a single line.

The words were checked identical before and after (whitespace-normalised comparison). Gates re-run on sha256:a5b1f0bc5cf3:
- `check_facts.py`: exit 0; 129 values and 6 quotes resolved, no elided quotes, the same as before. The judgment pass carries over and a new gate line is recorded in ISSUES.facts.md.
- `check_issue_coverage.py`: PASS (19 declared findings, 6 issues, 1 question; no departures), recorded in ISSUES.coverage.md.
- `check_style.py`: sweep clean, with the register layer INCOMPLETE without `PASSAGE_SCANNER` as before. The manual pass carries over, recorded in ISSUES.keeps.md.
- `render_review.py ISSUES.md --org --finalize`: FINAL. The Decision boxes are unchanged and the HTML now renders both passages correctly.

work/annotated/DEMO-TKA_SSE.REVIEW.qmd was not regenerated, because the issue wording it carries is unchanged.

## Note for the skill maintainers (general, no product content)

`mistune` is not installed here, so `render_review.py` used its built-in converter (`simple_md`). That converter has two weaknesses:
- It treats any wrapped line inside an issue body that begins with digits followed by ")" or "." as a nested ordered list.
- It renders a bullet's continuation lines as a separate `<p>`.

Either a converter fix or a ledger-format rule (no body line may start with "<digits>)" or "<digits>."; "Not checked" bullets on one line) would prevent a recurrence.

gate: verify pass — 2026-11-05 — sha256:a5b1f0bc5cf3
