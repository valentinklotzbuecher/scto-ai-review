# The second demo: a cluster trial whose sample size comes from saved results

A synthetic sample size estimation of three pages, DEMO-CRT (electronic decision support
for antibiotic prescribing in general practice, a cluster-randomised trial). Its sample
size comes from a simulation that the document does not run: it reads the results the
simulation saved. Four planted issues: one visible in the text, and three in the code and
its results whose consequences only running the code shows. The answer key names them; a
script recomputes every number in it.

| Path | What it is |
|---|---|
| [`sse/`](sse/) | the product: `DEMO-CRT_SSE.qmd` and its rendered PDF, the code it names (`R/`, `sim/`) and the results it reads (`results/power.rds`); the only part a review may see |
| `answer-key.md` | the four issues, their consequences and the scoring rules: **spoilers** |
| `answer-key.R` | recomputes every number in the key (R with lme4; about 20 minutes on four cores) |
| [`runs/`](runs/README.md) | each recorded review, unchanged, with its score, and `scoreboard.csv` |

## Try it yourself first

Review it as you would a colleague's SSE, code included, then open the key.

## Review it with a tool

Give the tool the whole of `sse/` and nothing else. The code needs R with lme4; the whole
simulation (`Rscript sim/run_power.R`, from `sse/`) took a quarter of an hour on one core
here, one grid point a minute or two.

- Chat, with or without the skill: attach every file in `sse/`
  ([`../tools/1-chat`](../tools/1-chat/README.md)). The skill does not run the product's
  code.
- The API review prototype: copy the PDF and its `.qmd` into the review document's
  `to_be_reviewed/`; it sends those two, not the code in `R/` and `sim/`
  ([`../tools/2-api`](../tools/2-api/README.md)).
- Agent: from a clone of third-pair-of-eyes, never from this kit
  ([`../tools/3-agent`](../tools/3-agent/README.md)), where R and lme4 are installed (on
  Debian or Ubuntu: `apt-get install -y r-base r-cran-lme4`):

  ```bash
  python3 .claude/skills/stats-review/scripts/new_job.py jobs/2026-11_DEMO-CRT \
    --product /path/to/scto-ai-review/demo-crt/sse/
  ```

  In `00_ASSIGNMENT.md`: product type `sse`, data mode `none`, depth `quick`, and one
  question, such as "Is the sample size adequate for the stated design?"

## Score it

Against `answer-key.md` (its Scoring section): each planted issue found, partly found or
missed, where a lead or a question for the code review counts like a finding; and for
the three in the code and its results, whether the review states the consequence in
practices, power or type I error. Score further findings as valid or not, and note
whether the approach ran the code. Record the run as [`runs/README.md`](runs/README.md)
describes.

## Recorded runs

None yet.

## Changing the demo

Read the key first: some files in `sse/` are part of the planted issues, and the key says
how each was made. Re-render with `quarto render demo-crt/sse/DEMO-CRT_SSE.qmd` (Typst;
needs R and knitr; the render reads the saved results and runs no simulation), re-run
`Rscript demo-crt/answer-key.R` and update the key. The committed PDF is the one every
tool reviews; re-render it, and every recorded run is out of date.
