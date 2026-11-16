# AI-assisted review of statistical products: SCTO talk

A 20-minute talk for statisticians, *AI-assisted review of statistical products: from a
single prompt to an agent that checks the numbers*, and the synthetic demonstration
product it is built around.

The talk aims to get statisticians using these tools for better research. It opens with
new evidence that language models find errors human reviewers miss in trial reports,
then puts one product on screen for the rest of the talk: a synthetic SSE with six
planted issues. Each approach is shown on it: a reader (chat, or a single scripted API
call, the review prototype) and the agent skills we use now
([`stats_review`](https://github.com/valentinklotzbuecher/stats_review)), which can run
the code. A scoreboard records what each found, one finding is traced to its evidence,
and a slide gives concrete first steps. It closes with Sutton's bitter lesson: the tools
turn over in months, so invest in what carries over (test cases with known answers,
review standards, data rules, the statistician who signs), and every new model makes the
same checklist more powerful.

The main part is 14 slides and about 14½ minutes, which leaves the rest of the slot for
questions. How we got here (the timeline, what the prototype taught us, the review
pipelines and services others built: Reviewer 2, Refine) is in the backup slides, with
the Unjournal comparison, all recorded runs and the answer key in numbers.

## Contents

```
slides/index.qmd        the deck (Quarto reveal.js, lilac theme), with speaker notes
slides/index.html       the rendered deck, self-contained
slides/talk.scss        talk-specific styles on top of reveal_lilac.scss
slides/assets/          the demo figure, the script that draws it, the SSE page excerpt,
                        the review-form screenshot
demo/sse/               the synthetic SSE (.qmd and rendered PDF): the only reviewable part
demo/answer-key.md      the six planted issues, with their consequences
demo/answer-key.R       recomputes every number in the answer key and on the slides
demo/runs/              each approach's review of the demo, and the scoreboard
material/               sources: the trial-report preprint, tweet screenshots, notes
```

## Rendering

```bash
quarto render slides/index.qmd             # the deck; no R needed
Rscript slides/assets/make-figures.R       # redraws the demo figure (base R)
quarto render demo/sse/DEMO-TKA_SSE.qmd    # the SSE as PDF via Typst; needs R and knitr
Rscript demo/answer-key.R                  # about a minute
```

The rendered PDF in `demo/sse/` is the one every approach reviews. If you re-render it,
re-run every approach on the new PDF.

The committed figure was drawn with Liberation Sans as the default sans-serif font;
another default font changes its look, not its numbers.

## Running the demo

Give each approach only the two files in `demo/sse/`, never this repository: the answer
key and the slides name the planted issues.

1. **Chat.** Paste the PDF and the `.qmd` into a new chat and ask for a consistency
   review of the sample size estimation.
2. **One call.** Point the review prototype in `dkf-llm-explorations`
   (`02-review-prototype.qmd`) at `demo/sse/DEMO-TKA_SSE.qmd` and `.pdf`.
3. **Agent with skills.** In a clone of `stats_review`:

   ```bash
   python3 .claude/skills/dkf-review/scripts/new_job.py jobs/2026-11_DEMO-TKA \
     --product /path/to/scto-ai-review/demo/sse/
   ```

   Fill in `jobs/2026-11_DEMO-TKA/00_ASSIGNMENT.md` (product type `sse`, data mode
   `none`, depth `quick` or `standard`, one question such as "Is the sample size
   adequate for the stated design?"), then ask Claude Code to review it with
   `dkf-review` and write the consistency review.

Score each review against `demo/answer-key.md`, record it as `demo/runs/README.md`
describes, and transfer the counts to the scoreboard slide. The chat and one-call runs
are still to do; their rows on the scoreboard stay empty until they are scored. For the
chat run, record whether the chat ran code: a chat that does is no longer only a reader.

Three agent runs are recorded in `demo/runs/`, each with its score: 31 October 2026
(depth `standard`), 3 November (interim) and 5 November (depth `quick`). The scoreboard
slide shows the first and the last; the backup slide "All recorded runs of the demo"
shows all three. "One finding, traced" follows the 31 October run.

Images on the slides:

- "The product" shows page 2 of `demo/sse/DEMO-TKA_SSE.pdf`
  (`slides/assets/demo-sse-page2.png`: `pdftoppm -r 220 -f 2 -l 2 -png`, cropped from
  the top of the page to "132 in total"). Re-render the SSE, and redo the crop.
- "What the reviewer gets" shows the 5 November run's `CONSISTENCY_REVIEW.html`
  (`slides/assets/consistency-review.png`: Chromium at 900 px wide, light colour scheme,
  twice the pixel density, cropped from Decision to the first major issue).

## Sources for the slides

- Brian, Pereira Hernández, Yin, Koury, Rust, *Large language models detect
  methodological errors that human peer review misses in clinical trials*, medRxiv,
  28 October 2026, doi:10.64898/2026.10.25.26366455 (CC BY 4.0; in `material/`, with
  notes); Ruslan Rust on X ("For clinical trials, I'd even call human-only review
  dangerous")
- Rich Sutton, *The Bitter Lesson*, 13 March 2019,
  incompleteideas.net/IncIdeas/BitterLesson.html
- Reviewer 2: github.com/isitcredible/reviewer2 (README: 30+ chained calls, 15–45
  minutes, a few dollars); Joseph Francis on X, 26 October 2026 ("Reviewer 2—he
  dead", "Yes, I decided it was obsolete"; screenshot in `material/`)
- research_skills: github.com/isitcredible/research_skills (MIT, 0.9 first public
  release)
- Refine: refine.ink (referee-style reports; about $50 per paper in 2026)
- Unjournal comparison: llm-uj-research-eval.netlify.app (80% coverage of curated
  human consensus issues, range 50–100%, 52% overlap, 12 papers)
- Claude Science's built-in reviewer: claude.com/docs/claude-science/the-reviewer
- Costs and model versions: run logs in `stats_review/archive/2026_api_prototype/`
  and the decks in `dkf-llm-explorations`; for the demo's agent run, the session record
  summarised in `demo/runs/2026-10-31_agent/SCORE.md`
