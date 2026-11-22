# Runs of the demo

One folder per run, named `<date>_<approach>` (for example `2026-11-05_agent`), holding
what the approach returned, unchanged:

- chat: the exported conversation or the copied answer
- chat with the document skill: the exported conversation and the files the skill
  returned (consistency table, check log)
- your own script (`tools/2-api`): the run's `.md` and `.json` from
  `review_results/prototype_runs/`, and the rendered `review.html`
- agent: the job's `CONSISTENCY_REVIEW.md`, `.html` and `.org`, `ISSUES.md`,
  `SYNTHESIS.md` and the annotated source (`work/annotated/*.REVIEW.qmd`)

Score the run in `SCORE.md` in its folder, against `../answer-key.md`: each planted
issue found, partly or missed, with the passage that decides it (a lead counts like a
finding), and whether the review sizes it; each further finding
valid or not, with the reason; time and cost, with their source. Then add one row per
run to `scoreboard.csv`:

| Column | Content |
|---|---|
| `approach` | `chat`, `chat_skill`, `api` or `agent` |
| `model`, `date`, `depth` | as run (`depth`: the agent's depth, or the chat skill's version) |
| `text_found`, `code_found`, `computation_found` | planted issues found, 0–2 each, a lead counting like a finding; note any "partly" in `notes` |
| `sized` | found issues whose consequence the review states in participants or power, 0–5 (the answer key's Scoring says what counts) |
| `other_valid`, `other_invalid` | further findings, judged by a statistician |
| `minutes`, `cost_usd` | wall-clock time, or model time for a run that waited for usage limits (elapsed time in `notes`); API cost, or `subscription` |
| `notes` | anything that affects the comparison |

Only `demo/sse/` goes to an approach; see `../../CLAUDE.md`.
