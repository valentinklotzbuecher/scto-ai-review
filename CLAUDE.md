# scto-ai-review: project notes

A talk (`slides/`) and a synthetic demonstration SSE with planted issues (`demo/`).
`README.md` explains both.

## The answer key stays out of reviews

- Only `demo/sse/` is reviewable. Never run a review of the demo (the `dkf-review`
  skill, the review prototype, a chat) from inside this repository, and never copy
  `demo/answer-key.*`, `slides/` or this file into a review job or a prompt.
- Review the demo from a clone of `stats_review`, with `new_job.py --product
  <this repo>/demo/sse/`.
- Never add hints to `demo/sse/`: no comments, file names or text that point at the
  planted issues.

## Numbers

- Every number about the demo, on the slides or in the answer key, comes from
  `Rscript demo/answer-key.R`; the figure comes from `Rscript slides/assets/make-figures.R`.
  Change the SSE, and re-run both and update the text.
- Scoreboard counts come only from recorded runs in `demo/runs/`, scored against
  `demo/answer-key.md`. Never fill them in from expectation.
- Facts about other tools and people are quoted from the sources listed in
  `README.md`; add the source when adding a fact.

## Rendering and checking

- `quarto render slides/index.qmd`, then look at every slide at 1280×720 with all
  fragments shown; nothing may run past the bottom edge. Commit the rendered
  `slides/index.html`.
- `quarto render demo/sse/DEMO-TKA_SSE.qmd` renders with Typst; the committed PDF is
  the one all approaches review.
- Slide text: short, plain, one idea per slide; speaker notes carry the rest.
