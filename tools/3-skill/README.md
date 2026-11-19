# 3 · A skill

A skill is a folder: a `SKILL.md` with instructions, reference files and small scripts.
The model reads each skill's name and description, and loads the rest when a task
matches. The checklist goes with the model, so you no longer paste a prompt.

## The skill: `dkf-document-check`

The first stage of the DKF consistency review on its own, for Claude chat (version
0.1.1, following the review skills 0.3.1 in
[stats_review](https://github.com/valentinklotzbuecher/stats_review/tree/skills-v0.3.1/chat-skills)).
It reads the product as an argument before any code, with four questions:

- Is it the document it says it is, and does it agree with the documents that govern it
  (protocol, SAP, registry entry)?
- Do its printed numbers agree with each other and with their own arithmetic? It
  recomputes them with scripts and logs each check.
- Does the design and analysis answer the question the product states? It names the
  design and the estimand, attribute by attribute.
- What must a review of the code check?

It returns findings, a consistency table, a check log and leads for the code review. It
does not run the product's code.

## Use it

1. Download `dkf-document-check.zip` from stats_review's
   [`chat-skills/`](https://github.com/valentinklotzbuecher/stats_review/tree/skills-v0.3.1/chat-skills).
2. In Claude, open Customize, then Skills, choose "+", create a skill and upload the
   ZIP. Code execution must be on. An uploaded skill is yours only.
3. In a new chat, attach the rendered product (PDF) and, if you like, its Quarto source
   and the governing documents, and ask:

   > Check this sample size estimation with dkf-document-check.

On the demo, attach only the two files in [`../../demo/sse/`](../../demo/sse/).

## What it is not

One stage of the review, not the review: it runs no product code, nobody challenges its
findings in a fresh context, and it writes no DKF form. For those, the agent
([`../5-agent`](../5-agent/README.md)).

## Data

What the chat reads goes to the provider under your plan's terms. Attach only documents
your institution allows, never patient-level data; the skill leaves an attached data
file unopened.

## Where it comes from

Condensed from the document stage of the `dkf-review` skill, which is adapted from Joe
Francis's [research_skills](https://github.com/isitcredible/research_skills) (The
Catalogue of Errors Ltd, MIT licence), written for research papers.
