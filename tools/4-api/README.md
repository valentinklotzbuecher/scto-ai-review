# 4 · The checklist, as a script

Your checklist as a prompt, sent from a script through the API: the same prompt and the
same answer format for every product, the issues collected in one table, and every run
logged with its tokens and cost. Billed per use with an API key, not on a chat plan.

| File | What it is |
|---|---|
| [`prompt.md`](prompt.md) | the review prompt: methods, numbers, code against text, interpretation |
| [`schema.json`](schema.json) | the answer format: a decision, a summary, the issues (severity, area, location, problem, consequence, fix, verified) and the questions that need the code run |
| [`review.R`](review.R) | R, with [ellmer](https://ellmer.tidyverse.org) |
| [`review.py`](review.py) | Python, with the [Anthropic SDK](https://github.com/anthropics/anthropic-sdk-python) |

## Run it

R, with ellmer 0.5.2 or later:

```r
install.packages(c("ellmer", "jsonlite"))
```

```bash
Rscript tools/4-api/review.R --dry-run demo/sse/DEMO-TKA_SSE.pdf
```

```bash
ANTHROPIC_API_KEY=... Rscript tools/4-api/review.R demo/sse/DEMO-TKA_SSE.pdf
```

Python:

```bash
pip install anthropic
```

```bash
python tools/4-api/review.py --dry-run demo/sse/DEMO-TKA_SSE.pdf
```

```bash
ANTHROPIC_API_KEY=... python tools/4-api/review.py demo/sse/DEMO-TKA_SSE.pdf
```

`--dry-run` shows the request and sends nothing. Each PDF is sent with the Quarto source
of the same name beside it, if there is one; give several PDFs and each is its own
request. The demo SSE is synthetic: send nothing else from this kit, the answer key
least of all.

## What you get

In `review-results/`, in the folder you run from:

- `<name>.review.json`: the whole answer
- `issues.csv`: one row per issue, across products
- `runs.csv`: one row per run: time, product, model, effort, the prompt's MD5 (which
  prompt it was), input and output tokens, cost at list price, decision, number of issues

## Settings

At the top of each script:

- Model `claude-opus-5-5` at effort `max`, the "maximum effort" of the talk, with up to
  64,000 tokens for thinking and answer. The request streams, so a long review keeps its
  connection.
- Prices for the cost log: US$4 per million input tokens and US$20 per million output
  tokens (Claude Opus 5.5 list prices, November 2026). Thinking is billed as output.
- The Python script opts in to server-side fallbacks: if the model declines on a policy
  ground, the API re-runs the request on another model, and `runs.csv` names the model
  that answered. The R script leaves this out.

Another provider: in R, swap `chat_anthropic()` for that provider's function in ellmer,
such as `chat_openai()`, and check its model names and effort setting.

## What it cannot do

- Run the code. The answer lists what needs a code run (`needs_code_run`).
- Check its own findings. One request per product: no second look in a fresh context,
  no log of the checks behind an issue. `verified` is the model's claim that it did the
  arithmetic; check it.
- Answer the same twice. Two runs on one product can differ; run it twice to see how
  much.

## With tools in a loop: an agent

Give the model tools, such as "run this R code", and let the library run the loop: the
model asks for a tool, your code runs it, the result goes back, until the model stops
asking. In ellmer that is `tool()` and `chat$register_tool()`; in the Python SDK, the
tool runner. That is the agent of step 5, built by hand; Claude Code
([`../5-agent`](../5-agent/README.md)) is the ready-made one.

## Data

What the script sends goes to the provider under its API terms. Send only documents your
institution allows, and never patient-level data.
