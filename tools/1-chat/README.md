# 1 · Paste it into the chat

The simplest way, and the one the preprint tested: give the product to a chat with the
strongest model at its highest reasoning setting, and ask. Add a skill, and the chat
brings your checklist along.

## How

1. Choose the strongest model your plan offers and its maximum effort (in ChatGPT a Pro
   model; in Claude, Opus or Fable at maximum effort).
2. Attach the rendered product (PDF) and its source (`.qmd`), and the documents it
   depends on (protocol, SAP) if you may share them.
3. Ask:

   > Please check if this is consistent.

   Or, for an answer in a fixed structure, paste the review prompt from
   [`../2-api/prompt.md`](../2-api/prompt.md) first.

Try it on the demo: attach the two files in [`../../demo/sse/`](../../demo/sse/) and
nothing else from this kit; the answer key is in it.

## What you get, and what not

- An answer that is often good. In King and Worthington's study, one model at its
  maximum reasoning setting, given the paper and the reviewer guidelines, wrote one
  review per paper; three former journal editors preferred it to the paid expert review
  in 26 of 30 judgments.
- No record of what was checked, and a different answer next time.
- No code runs. A chat with a code tool can run small scripts, not your R project with
  its packages and data.

## With a skill: your checklist in the chat

A skill is a folder: a `SKILL.md` with instructions, reference files and small scripts.
The model reads each skill's name and description and loads the rest when a task
matches, so the checklist comes along and you no longer paste a prompt. The same skills
are the agent's instructions in [`../4-agent`](../4-agent/README.md).

`dkf-document-check` is the first stage of the DKF consistency review on its own, for
Claude chat (version 0.1.1, following the review skills 0.3.1 in
[stats_review](https://github.com/valentinklotzbuecher/stats_review/tree/skills-v0.3.1/chat-skills)).
It reads the product as an argument before any code, with four questions:

- Is it the document it says it is, and does it agree with the documents that govern it
  (protocol, SAP, registry entry)?
- Do its printed numbers agree with each other and with their own arithmetic? It
  recomputes them with scripts and logs each check.
- Does the design and analysis answer the question the product states? It names the
  design and the estimand, attribute by attribute.
- What must a review of the code check?

What is in the folder, and when the model reads it:

```
dkf-document-check/
  SKILL.md                            always: name and description; when a task
                                      matches: the rules, three checks, the output
  references/estimands.md             when needed
  references/clinical-guidelines.md   when needed
  references/product-profiles.md      when needed
  scripts/recompute.py                when needed: recomputes the printed numbers
```

It returns findings, a consistency table, a check log and leads for the code review. It
does not run the product's code, and nobody challenges its findings in a fresh context;
for those, the agent.

1. Download `dkf-document-check.zip` from stats_review's
   [`chat-skills/`](https://github.com/valentinklotzbuecher/stats_review/tree/skills-v0.3.1/chat-skills).
2. In Claude, open Customize, then Skills, choose "+", create a skill and upload the
   ZIP. Code execution must be on. An uploaded skill is yours only.
3. In a new chat, attach the rendered product (PDF) and, if you like, its Quarto source
   and the governing documents, and ask:

   > Please review this using /dkf-document-check.

The skill is condensed from the document stage of the `dkf-review` skill, which is
adapted from Joe Francis's [research_skills](https://github.com/isitcredible/research_skills)
(The Catalogue of Errors Ltd, MIT licence), written for research papers.

## Data

What you attach goes to the provider under your plan's terms. On personal plans (Pro,
Max), whether chats may be used for model training is a privacy setting; commercial
plans and the API are not covered by the consumer terms
([Anthropic's consumer terms](https://www.anthropic.com/news/updates-to-our-consumer-terms)).
Attach only documents your institution allows for that plan, never patient-level data;
the skill leaves an attached data file unopened.
