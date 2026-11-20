# Runs of the second demo

One folder per run, named `<date>_<approach>` (for example `2026-11-25_agent`), holding
what the approach returned, unchanged, as for the first demo
([`../../demo/runs/README.md`](../../demo/runs/README.md)).

Score the run in `SCORE.md` in its folder, against `../answer-key.md`: each planted
issue found, partly or missed, with the passage that decides it (a lead counts like a
finding), and whether the review sizes it; each further finding valid or not, with the
reason; time and cost, with their source; and whether the approach ran the product's
code. Then add one row per run to `scoreboard.csv`, with the columns of the first demo's
scoreboard and these ranges:

| Column | Range here |
|---|---|
| `text_found` | 0–1 |
| `code_found` | 0–1 |
| `computation_found` | 0–2 |
| `sized` | 0–3 (the answer key's Scoring says what counts) |

Only `demo-crt/sse/` goes to an approach; see `../../CLAUDE.md`.
