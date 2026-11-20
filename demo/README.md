# The demo: a test case with a known answer

A synthetic sample size estimation of two pages, DEMO-TKA (app-guided home exercise
versus supervised physiotherapy after total knee arthroplasty), with six planted issues:
two visible in the text, two only in the source code, and two that need a calculation
or a re-run to establish. The answer key names them; a script recomputes every number
in it.

| Path | What it is |
|---|---|
| [`sse/`](sse/) | the product: `DEMO-TKA_SSE.qmd` and its rendered PDF, the only part a review may see |
| `answer-key.md` | the six issues, their consequences and the scoring rules: **spoilers** |
| `answer-key.R` | recomputes every number in the key (base R, seeded, about a minute) |
| [`runs/`](runs/README.md) | each recorded review, unchanged, with its score, and `scoreboard.csv` |

## Try it yourself first

Review the two pages as you would a colleague's SSE, then open the key.

## Review it with a tool

Give the tool only the two files in `sse/`. A chat or an agent opened on this kit can
read the answer key, and then finds the issues without doing the review.

- Chat, with or without the skill: attach the two files
  ([`../tools/1-chat`](../tools/1-chat/README.md)).
- API script: `review.R` or `review.py` send only the files named on the command line
  ([`../tools/3-api`](../tools/3-api/README.md)).
- Agent: from a clone of stats_review, never from this kit
  ([`../tools/4-agent`](../tools/4-agent/README.md)):

  ```bash
  python3 .claude/skills/dkf-review/scripts/new_job.py jobs/2026-11_DEMO-TKA \
    --product /path/to/scto-ai-review/demo/sse/
  ```

  In `00_ASSIGNMENT.md`: product type `sse`, data mode `none`, depth `quick`, and one
  question, such as "Is the sample size adequate for the stated design?"

## Score it

Against `answer-key.md` (its Scoring section): each planted issue found, partly found or
missed, where a lead or a question for the code review counts like a finding; and for
each one found, whether the review states its consequence in participants or power
(five of the six have one). Score further findings as valid or not. Record the run as
[`runs/README.md`](runs/README.md) describes.

## Recorded runs

| Date | Approach | Planted issues found | Consequence stated | Time | Cost |
|---|---|---|---|---|---|
| 31 Oct 2026 | agent, depth `standard` | 6 of 6 | 5 of 5 | 202 min of model time | subscription; about $72 at API list prices |
| 3 Nov 2026 | agent, `standard` with modules skipped, interim | 6 of 6 | 5 of 5 | 98 min of active time | subscription; $26.84 at API list prices |
| 5 Nov 2026 | agent, depth `quick` | 6 of 6 | 5 of 5 | 34 min, start to final form | subscription; $9.72 at API list prices |
| 20 Nov 2026 | chat with the skill `dkf-document-check` 0.1.1 | 6 of 6 | 5 of 5 | not recorded | subscription |

The first run also caught an error in the first version of the key. The chat with the
skill ran only its own scripts, never the product's code. Runs of the chat on its own
and of the API script are still to do.

Not a blind test: the skills and the demo were written in the same week, and the skills
already describe two of the planted issue types.

## Contribute a test case

What carries over from one model to the next is a set of test cases with known answers.
One written by someone else is a blind test for every tool and every new model. To
contribute: write a synthetic product as you would write a real one (Quarto, rendered
PDF), plant issues at the three levels (text, code, computation), write a key whose
numbers a script recomputes, and keep every hint out of the product: no comments, file
names or text that point at an issue.

## Changing the demo

Change the SSE, and re-render it (`quarto render demo/sse/DEMO-TKA_SSE.qmd`, Typst, needs
R and knitr), re-run `Rscript demo/answer-key.R` and update the key. The committed PDF is
the one every tool reviews; re-render it, and every recorded run is out of date.
