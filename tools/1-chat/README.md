# 1 · Paste it into the chat

The simplest way, and the one the preprint tested: give the product to a chat with the
strongest model at its highest reasoning setting, and ask.

## How

1. Choose the strongest model your plan offers and its maximum effort (in ChatGPT a Pro
   model; in Claude, Opus or Fable at maximum effort).
2. Attach the rendered product (PDF) and its source (`.qmd`), and the documents it
   depends on (protocol, SAP) if you may share them.
3. Ask:

   > Please check if this is consistent.

   Or, for an answer in a fixed order (methods, numbers, code against text,
   interpretation), paste the review prompt from [`../2-api/prompt.md`](../2-api/prompt.md)
   first.

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

## Data

What you attach goes to the provider under your plan's terms. On personal plans (Pro,
Max), whether chats may be used for model training is a privacy setting; commercial
plans and the API are not covered by the consumer terms
([Anthropic's consumer terms](https://www.anthropic.com/news/updates-to-our-consumer-terms)).
Attach only documents your institution allows for that plan, never patient-level data.
