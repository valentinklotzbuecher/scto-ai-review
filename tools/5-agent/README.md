# 5 · An agent in the repository

An agent works in a copy of the product's repository. It reads the files, runs the R
code, recomputes the numbers, re-runs the simulations, has its findings challenged by
agents that did not write them, and writes a draft of the consistency-review form with a
log behind every number. Here: Claude Code on the web with the DKF review skills from
[stats_review](https://github.com/valentinklotzbuecher/stats_review/tree/skills-v0.3.1)
(version 0.3.1).

## Why this way

- **It runs the code**, which no reader can.
- **It never touches your computer.** "Each session runs in an isolated,
  Anthropic-managed VM"; network access "is limited by default"; git credentials "stay
  outside the sandbox". What it reads still goes to the provider.
- **It runs on your Claude plan, not on API credits.** "It counts toward your plan's
  usage limits … and there's no separate charge for the cloud VM." Cloud sessions are
  available on Pro, Max, Ultra and Team plans, and for Enterprise users with premium
  seats or Chat + Claude Code seats.
- **It leaves a record**: the job folder, with the form, the issues, and the scripts and
  logs behind them, committed with the product.

Quotes: [Claude Code on the web](https://code.claude.com/docs/en/claude-code-on-the-web),
read 18 November 2026.

## Set up once

1. Connect GitHub at claude.ai/connect-github. The Claude GitHub App must be installed on
   the product's repository.
2. Create a cloud environment and paste stats_review's
   [`tools/web_setup.sh`](https://github.com/valentinklotzbuecher/stats_review/blob/skills-v0.3.1/tools/web_setup.sh)
   as its setup script. It installs R with knitr and rmarkdown, Quarto, Poppler and
   mistune; add the product's R packages there.
3. Allow package managers and github.com under network access.
4. Set no `ANTHROPIC_API_KEY` among the environment's variables: with it, Claude Code
   bills the API instead of your plan.

## Each review

1. Start a session in that environment with the product's repository and stats_review.
2. Create the job beside the product, or ask Claude to:

   ```bash
   python3 ../stats_review/.claude/skills/dkf-review/scripts/new_job.py review/2026-11-19_quick \
     --product SSE001.qmd SSE001.pdf
   ```

3. Fill in `00_ASSIGNMENT.md`: product type, your questions, the documents it depends
   on, what is cleared, the data mode, the depth (`quick` for a short SSE).
4. Type one sentence; the skills hold the rest:

   > Review the product in review/2026-11-19_quick with dkf-review, then write the
   > consistency review.

   It checks the clearance, states depth, data mode and size, asks you to check your
   usage, and waits for your go-ahead.
5. Merge the session's branch in the product's repository. The human reviewer starts
   from the job's `REVIEWER.md`.

The full guide is stats_review's README.

## Data

| Data mode | The agent reads |
|---|---|
| `none` (default) | documents and code |
| `synthetic` | and dummy data, built from the code or from a codebook made locally |
| `shared` | and patient-level data, only with a recorded clearance |

Before the agent opens anything, a script checks the clearance and stops the run if a
data file sits where the data mode does not allow it.

## On the demo

Three recorded runs each found all six planted issues and stated the consequence of all
five that have one, in participants or power. The `quick` run took 34 minutes from
start to finished form, on a subscription ($9.72 at API list prices). The skills and the demo were written in the same week, and the skills already
describe two of the planted issue types, so this shows the checklist at work, not a
blind test. See [`../../demo/`](../../demo/README.md).

## Driving it from code: the Agent SDK

- Claude Code as a library, in Python and TypeScript: "the same tools, agent loop, and
  context management that power Claude Code"; skills load from the project's
  `.claude/`.
- Worth it for evals over many test cases, batch runs and guardrails in code. Not needed
  for one review, and it does not fine-tune the model.
- Authenticates with an API key and bills per token, unlike Claude Code on a plan.
- From R or any other language: run the command line, `claude -p "…" --output-format json`.

Quotes: [Agent SDK overview](https://code.claude.com/docs/en/agent-sdk/overview), read
18 November 2026.

## Others going this way

[Certify](https://certify.iq.harvard.edu/) (Gary King, Yiqing Xu and Leo Yang, Harvard;
a beta): your own AI assistant, such as Claude Code or Codex, reruns a replication
package on your computer, and the certificate adds "evidence that rerunning the code
produces the results to be published."
