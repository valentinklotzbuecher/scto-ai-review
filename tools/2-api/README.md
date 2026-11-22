# 2 · An API review prototype

My review prototype: a Quarto document that sends a product to the model through the API
with the same review instructions every time, saves every run with its settings, tokens
and hashes, and renders the review. Billed per use with an API key, not
on a chat plan. A first pass before the human review, not a replacement for it.

| File | What it is |
|---|---|
| [`review.qmd`](review.qmd) | the review document: settings and display in R; the request through the Anthropic Python SDK, run from R with reticulate |
| [`prompt.md`](prompt.md) | the review instructions: a senior biostatistician's first pass, with checklists for a sample size estimation, an analysis report and data preparation, and the structure of the answer |
| [`to_be_reviewed/`](to_be_reviewed/README.md) | where the product goes: its `.qmd`, its PDF, or both |

## Set it up once

In R:

```r
install.packages(c("reticulate", "jsonlite", "knitr", "rmarkdown", "flextable"))
```

The document sets up its own Python with the Anthropic SDK, through reticulate's
`py_require()` (tested with reticulate 1.47.0); the first run downloads it. The API key
goes in `~/.Renviron`, never in the document:

```bash
cat >> ~/.Renviron <<'EOF'
ANTHROPIC_API_KEY=sk-ant-...
EOF
```

## Run a review

1. Put the product in `to_be_reviewed/`. For the demo, from the kit's root folder:

   ```bash
   cp demo/sse/DEMO-TKA_SSE.qmd demo/sse/DEMO-TKA_SSE.pdf tools/2-api/to_be_reviewed/
   ```

2. Open `review.qmd` in RStudio and set `cfg` in the chunk `runtime-params`: the file
   names (blank when the folder holds one of each), the `assignment` (the questions the
   review must answer), the model and its effort.
3. Run the chunks `runtime-params`, `setup-r` and `setup-py`, then
   `anthropic-review-manual`, the request. The review streams into the console and is
   saved.
4. Render `review.qmd`: the latest saved review of that product with that model.

Rendering never sends a request: the request chunk is `eval=FALSE`. Render before the
first run to see what would be sent; the appendix shows the whole prompt.

## What you get

Every run, never overwritten, in `review_results/prototype_runs/`:
`<product>_anthropic_<model>_<time>.md` and `.json`, with the review, the model that
answered, the stop reason, the settings, the tokens, and SHA-256 hashes of the prompt,
the `.qmd` and the PDF; the `.json` also keeps the model's summarised reasoning.

What the review looks like is set in `prompt.md`, and yours to change. The rendered
report adds the run's details, the prompt as sent and the cost at list prices.

## Settings

In `cfg`, the chunk `runtime-params`; the document's "Using the prototype" note has the
full table.

| Setting | Default | |
|---|---|---|
| `review_folder`, `pdf_file`, `qmd_file` | `to_be_reviewed`, blank, blank | what is reviewed |
| `assignment` | blank | questions the review answers one by one |
| `code_context_mode` | `full_text` | the whole `.qmd`; `code_only` sends its code chunks, `none` no source. A PDF is always attached |
| `anthropic_model` | `claude-opus-5-5` | or `claude-fable-5-2`; only the one chosen runs |
| `anthropic_effort` | `high` | `low` to `max`; `xhigh` or `max` only when the review warrants the tokens |
| `max_output_tokens` | 64,000 | thinking and review together; the request streams |
| `pricing_usd_per_1m` | 4 and 20; 8 and 40 | US$ per million input and output tokens, Claude Opus 5.5 and Claude Fable 5.2, list prices, November 2026; thinking is billed as output |
| `prompt_addendum`, `prompt_override` | blank | add to, or replace, the instructions in `prompt.md` |

Claude Fable 5.2 requires 30-day data retention; use it only where your arrangements
allow.

A run that does not finish is saved as not completed, with the reason, and no review:

- the model declined
- it hit the token limit
- it did not confirm that it read the whole source: the source ends with a token the
  review must return

No other model steps in for a declined request. The API can re-run a declined request on
another model (server-side fallbacks); the prototype leaves this off, so that only the
chosen model reviews.

## What it cannot do

- Run the code. It reads the `.qmd` and the PDF, nothing else: not R files the `.qmd`
  sources, not saved results.
- Check its own findings. One request per run: no second look in a fresh context.
- Answer the same twice. Two runs on one product can differ; run it twice to see how
  much.

## Test it on cases with known answers

Because it is a script, you can test it: run it on products whose issues you know, such
as the demos in [`../../demo/`](../../demo/README.md) and
[`../../demo-crt/`](../../demo-crt/README.md), and score each run against the answer key.
In R, [vitals](https://vitals.tidyverse.org), a port of Inspect (a Python framework for
evaluating language models) for [ellmer](https://ellmer.tidyverse.org) users, does this:
a dataset of cases, each with what a correct review must flag; the review prompt in an
ellmer chat as the solver; and a scorer that grades each review against its target. So
you compare prompts, models and effort settings on cases you know before you trust a
change.

## Data

What the document sends goes to the provider under its API terms. Send only documents
your institution allows, and never patient-level data.

Next: an agent that runs the code, still in development: [`../3-agent`](../3-agent/README.md).
