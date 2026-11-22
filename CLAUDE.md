# scto-ai-review: project notes

The kit for an SCTO talk: the deck and a handout (`slides/`), a starter for each of three
approaches and a list of review services (`tools/`), two synthetic demonstration SSEs with planted issues (`demo/`, and
`demo-crt/`, a cluster trial whose sample size comes from saved simulation results), the
sources (`material/`) and the earlier demo deck (`archive/`). `README.md` is the start
page.

## The answer key stays out of reviews

- Only `demo/sse/` and `demo-crt/sse/` are reviewable. Never let an agent or a chat
  review a demo from inside this repository (the `dkf-review` skill, a chat, Claude
  Code), and never copy `demo/answer-key.*`, `demo-crt/answer-key.*`, `slides/`,
  `archive/` or this file into a review job or a prompt. The review document in
  `tools/2-api/` sends only the `.qmd` and PDF it finds in its `to_be_reviewed/` (or
  names in `cfg`), so either demo's two files may be copied there.
- Review a demo with the agent from a clone of `stats_review`, with `new_job.py
  --product <this repo>/demo/sse/` (or `demo-crt/sse/`).
- Never add hints to `demo/sse/` or `demo-crt/sse/`: no comments, file names or text
  that point at the planted issues.
- `demo-crt/sse/results/power.rds` is part of a planted issue: never regenerate it with
  `sim/run_power.R`. `demo-crt/answer-key.md` says how it was made.

## Numbers and facts

- Every number about a demo, on the slides, in the handout or in its answer key, comes
  from its script: `Rscript demo/answer-key.R` or `Rscript demo-crt/answer-key.R`
  (about 20 minutes on four cores); the archived deck's figure comes from
  `Rscript archive/assets/make-figures.R`. Change an SSE, and re-run its script (and
  for DEMO-TKA the figure's) and update the text.
- Scoreboard counts come only from recorded runs in `demo/runs/` and
  `demo-crt/runs/`, scored against the demo's answer key. Never fill them in from
  expectation.
- Facts about other tools and people are quoted from the sources listed in
  `README.md`; add the source when adding a fact, and keep source files in `material/`
  with a note of where each fact is (page or post).
- A fact stated in several places (deck, notes, handout, tool READMEs) changes in all
  of them.

## The kit

- The deck and the handout include the same diagrams from `slides/diagrams/`; change
  one there, and re-render both.
- The kit links to the review skills at a fixed version, tag `skills-v0.3.1` in
  `stats_review`. For a newer version, update the links in `tools/1-chat`,
  `tools/3-agent`, the handout and the deck's Links slides.
- `tools/2-api/review.qmd` is the speaker's review prototype, ported from
  `02-review-prototype.qmd` in dkf-llm-explorations with current models. Both read the
  review instructions from their `prompt.md`; keep the two files identical. Keep its
  request chunk `eval=FALSE`, so rendering sends nothing, and check a change by rendering
  it with a demo in `to_be_reviewed/`. Of that folder only its README is committed;
  never a product, a rendered review or `review_results/`.
- No API keys, no patient data and no real product in this repository.

## Rendering and checking

- `quarto render slides/index.qmd`, then look at every slide at 1280×720 with all
  fragments shown; nothing may run past the bottom edge. Commit the rendered
  `slides/index.html`.
- `quarto render slides/handout.qmd`, then check it at desktop and phone width: the
  page never scrolls sideways. Commit the rendered `slides/handout.html`.
- `quarto render demo/sse/DEMO-TKA_SSE.qmd` and `quarto render
  demo-crt/sse/DEMO-CRT_SSE.qmd` render with Typst; the committed PDFs are the ones all
  tools review.
- Slide text: short, plain, one idea per slide; speaker notes carry the rest.
