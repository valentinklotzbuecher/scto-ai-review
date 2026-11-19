# scto-ai-review: project notes

The kit for an SCTO talk: the deck and a handout (`slides/`), a starter for each of five
tools (`tools/`), a synthetic demonstration SSE with planted issues (`demo/`), the
sources (`material/`) and the earlier demo deck (`archive/`). `README.md` is the start
page.

## The answer key stays out of reviews

- Only `demo/sse/` is reviewable. Never let an agent or a chat review the demo from
  inside this repository (the `dkf-review` skill, a chat, Claude Code), and never copy
  `demo/answer-key.*`, `slides/`, `archive/` or this file into a review job or a prompt.
  The API starters in `tools/2-api/` send only the files named on their command line,
  so they may run on `demo/sse/` from here.
- Review the demo with the agent from a clone of `stats_review`, with `new_job.py
  --product <this repo>/demo/sse/`.
- Never add hints to `demo/sse/`: no comments, file names or text that point at the
  planted issues.

## Numbers and facts

- Every number about the demo, on the slides, in the handout or in the answer key,
  comes from `Rscript demo/answer-key.R`; the archived deck's figure comes from
  `Rscript archive/assets/make-figures.R`. Change the SSE, and re-run both and update
  the text.
- Scoreboard counts come only from recorded runs in `demo/runs/`, scored against
  `demo/answer-key.md`. Never fill them in from expectation.
- Facts about other tools and people are quoted from the sources listed in
  `README.md`; add the source when adding a fact, and keep source files in `material/`
  with a note of where each fact is (page or post).
- A fact stated in several places (deck, notes, handout, tool READMEs) changes in all
  of them.

## The kit

- The deck and the handout include the same diagrams from `slides/diagrams/`; change
  one there, and re-render both.
- The kit links to the review skills at a fixed version, tag `skills-v0.3.1` in
  `stats_review`. For a newer version, update the links in `tools/4-skill`,
  `tools/5-agent`, the handout and the deck's Links slide.
- The two API starters send the same prompt, answer format, model and effort, and write
  the same files; keep them in step, and check both with `--dry-run`, which sends
  nothing.
- No API keys, no patient data and no real product in this repository.

## Rendering and checking

- `quarto render slides/index.qmd`, then look at every slide at 1280×720 with all
  fragments shown; nothing may run past the bottom edge. Commit the rendered
  `slides/index.html`.
- `quarto render slides/handout.qmd`, then check it at desktop and phone width: the
  page never scrolls sideways. Commit the rendered `slides/handout.html`.
- `quarto render demo/sse/DEMO-TKA_SSE.qmd` renders with Typst; the committed PDF is
  the one all tools review.
- Slide text: short, plain, one idea per slide; speaker notes carry the rest.
