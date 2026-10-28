# Runs of the demo

One folder per run, named `<date>_<approach>` (for example `2026-11-05_agent`), holding
what the approach returned, unchanged:

- chat: the exported conversation or the copied answer
- one call: the prototype's `.md` and `.json`
- agent: the job's `CONSISTENCY_REVIEW.md` and `.html` and `SYNTHESIS.md`

Then add one row per run to `scoreboard.csv`, scored against `../answer-key.md`:

| Column | Content |
|---|---|
| `approach` | `chat`, `one_call` or `agent` |
| `model`, `date`, `depth` | as run (`depth` for the agent only) |
| `text_found`, `code_found`, `computation_found` | planted issues found, 0–2 each; note any "partly" in `notes` |
| `other_valid`, `other_invalid` | further findings, judged by a statistician |
| `minutes`, `cost_usd` | wall-clock time; API cost, or `subscription` |
| `notes` | anything that affects the comparison |

Only `demo/sse/` goes to an approach; see `../../CLAUDE.md`.
