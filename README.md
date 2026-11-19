# AI-assisted review of statistical products: SCTO talk

A 20-minute talk for statisticians, *AI review of statistical products*: a personal
exploration, not a DKF service, of five ways to get an AI review.

The deck (`slides/index.qmd`) has eleven slides and a short appendix, with little text
on the slides and the rest in the speaker notes. It opens with the preprint result that
models find more inserted errors in trial reports than human reviewers did, and King
and Worthington's finding that AI reviews beat paid expert reviews, then walks
through five ways to get an AI review, each drawn as a diagram: a chat at maximum
effort; the same through the API, from a script in R (ellmer) or Python (the SDKs),
which with tools in a loop becomes an agent (the review prototype, the Unjournal
project); review services, paid, free and open source; a skill; and an agent with
skills in the product's repository
([`stats_review`](https://github.com/valentinklotzbuecher/stats_review)). One table
compares them. It closes with Sutton's bitter lesson (don't build tools that go
obsolete; keep checklists, test cases and data rules), result-oriented review (what the
human reviewer checks: that the AI tested enough, that each step does what it says, the
approach and the interpretation), and a discussion that brings back the preprint's last
author: human-only review is dangerous; is AI-only review? The content takes about 12
minutes, which leaves the rest of the slot for the discussion.

The earlier, longer deck (`slides/demo-deck.qmd`) is built around a synthetic SSE with
six planted issues (`demo/`) and a scoreboard of recorded runs; it is kept for the demo.

## Contents

```
slides/index.qmd        the deck (Quarto reveal.js), with speaker notes and inline SVG diagrams
slides/index.html       the rendered deck, self-contained (fonts embedded)
slides/website.scss     the deck's theme, after valentinklotzbuecher.github.io: ivory,
                        spruce-green ink, mauve; Zen Kaku Gothic New and IBM Plex Mono
slides/demo-deck.qmd    the earlier deck built around the demo SSE (.html rendered)
slides/talk.scss        the demo deck's styles, on top of reveal_lilac.scss
slides/assets/          the demo figure, the script that draws it, the SSE page excerpt,
                        the review-form screenshot
demo/sse/               the synthetic SSE (.qmd and rendered PDF): the only reviewable part
demo/answer-key.md      the six planted issues, with their consequences
demo/answer-key.R       recomputes every number in the answer key and on the slides
demo/runs/              each approach's review of the demo, and the scoreboard
material/               sources: the trial-report preprint, tweet screenshots, notes
```

## Rendering

```bash
quarto render slides/index.qmd             # the deck; no R needed
quarto render slides/demo-deck.qmd         # the earlier demo deck
Rscript slides/assets/make-figures.R       # redraws the demo figure (base R)
quarto render demo/sse/DEMO-TKA_SSE.qmd    # the SSE as PDF via Typst; needs R and knitr
Rscript demo/answer-key.R                  # about a minute
```

The rendered PDF in `demo/sse/` is the one every approach reviews. If you re-render it,
re-run every approach on the new PDF.

The committed figure was drawn with Liberation Sans as the default sans-serif font;
another default font changes its look, not its numbers.

## Running the demo

Give each approach only the two files in `demo/sse/`, never this repository: the answer
key and the slides name the planted issues.

1. **Chat.** Paste the PDF and the `.qmd` into a new chat and ask for a consistency
   review of the sample size estimation.
2. **Chat with the document skill.** Upload `chat-skills/dkf-document-check.zip` from
   `stats_review` as a skill (Customize, Skills; code execution on), then in a new chat
   attach the PDF and the `.qmd` and ask for a document check of the sample size
   estimation with `dkf-document-check`. It is the agent's first stage without the code
   runs, so it separates knowing what to check from running the code.
3. **Agent with skills.** In a clone of `stats_review`:

   ```bash
   python3 .claude/skills/dkf-review/scripts/new_job.py jobs/2026-11_DEMO-TKA \
     --product /path/to/scto-ai-review/demo/sse/
   ```

   Fill in `jobs/2026-11_DEMO-TKA/00_ASSIGNMENT.md` (product type `sse`, data mode
   `none`, depth `quick` or `standard`, one question such as "Is the sample size
   adequate for the stated design?"), then ask Claude Code to review it with
   `dkf-review` and write the consistency review.

Score each review against `demo/answer-key.md`, record it as `demo/runs/README.md`
describes, and transfer the counts to the scoreboard slide. A lead counts like a
finding, and each run also records how many issues it sizes (`demo/answer-key.md`,
Scoring). The chat and chat-with-skill runs are still to do; their rows on the
scoreboard stay empty until they are scored. The one-call prototype is no longer run
on the demo. For the chat runs, record whether the chat ran code: a chat that does is no
longer only a reader (the document skill runs its own arithmetic scripts, never the
product's code).

Three agent runs are recorded in `demo/runs/`, each with its score: 31 October 2026
(depth `standard`), 3 November (interim) and 5 November (depth `quick`). In the demo
deck, the scoreboard slide shows the first and the last; the backup slide "All recorded
runs of the demo" shows all three. "One finding, traced" follows the 31 October run.

Images on the demo deck's slides:

- "The product" shows page 2 of `demo/sse/DEMO-TKA_SSE.pdf`
  (`slides/assets/demo-sse-page2.png`: `pdftoppm -r 220 -f 2 -l 2 -png`, cropped from
  the top of the page to "132 in total"). Re-render the SSE, and redo the crop.
- "What the reviewer gets" shows the 5 November run's `CONSISTENCY_REVIEW.html`
  (`slides/assets/consistency-review.png`: Chromium at 900 px wide, light colour scheme,
  twice the pixel density, cropped from Decision to the first major issue).

## Sources for the slides

- Brian, Pereira Hernández, Yin, Koury, Rust, *Large language models detect
  methodological errors that human peer review misses in clinical trials*, medRxiv,
  28 October 2026, doi:10.64898/2026.10.25.26366455 (CC BY 4.0; in `material/`, with
  notes); Ruslan Rust on X, 28 October 2026 ("From now on I won't do any peer review
  without AI. For clinical trials, I'd even call human-only review dangerous";
  screenshot in `material/`)
- King and Worthington, *AI Article Reviews Dominate Human Peer Reviews at Their Best:
  Evidence and Policy Choices*, working paper, Harvard IQSS, October 2026,
  gking.harvard.edu/peerless; the abstract sentence on the intro slide is from Rex
  Douglass's post of 23 October quoting it (screenshot in `material/`)
- Google's Deep Review: News from Google on X, 14 October 2026 (agentic; manuscripts,
  design docs, proposals; pilots on over 15,000 papers), quoted in Rex Douglass's post
  of 15 October (screenshot in `material/`, the source of the quote on "The bitter
  lesson"); "free, 2 a week" from the coverage noted in `material/README.md`
- Certify (Harvard IQSS), replication certification run by your own agent:
  certify.iq.harvard.edu, in the agent slide's notes; noted in `material/README.md`
- Rich Sutton, *The Bitter Lesson*, 13 March 2019,
  incompleteideas.net/IncIdeas/BitterLesson.html
- Reviewer 2: github.com/isitcredible/reviewer2 (README: 30+ chained calls, 15–45
  minutes, a few dollars); Joseph Francis on X, 26 October 2026 ("Reviewer 2—he
  dead", "Yes, I decided it was obsolete"; screenshot in `material/`), and the same
  day releasing his skills ("… the results have been produced by robots and should be
  verified by humans"; screenshot in `material/`)
- research_skills: github.com/isitcredible/research_skills (MIT, 0.9 first public
  release)
- Refine: refine.ink (referee-style reports; about $50 per paper in 2026)
- Unjournal comparison: llm-uj-research-eval.netlify.app (80% coverage of curated
  human consensus issues, range 50–100%, 52% overlap, 12 papers)
- Claude Science's built-in reviewer: claude.com/docs/claude-science/the-reviewer
- Claude Agent SDK: code.claude.com/docs/en/agent-sdk/overview (Claude Code as a
  library; skills load from `.claude/`; API-key authentication for agents built on it);
  quoted in `material/README.md`
- Claude Code on the web: code.claude.com/docs/en/claude-code-on-the-web (runs in an
  isolated cloud VM, not on your machine; counts toward the plan's usage, no separate
  charge); quoted in `material/README.md`
- Reviewer 2's licence (Apache 2.0) and cost ("a few dollars in Gemini API usage"):
  its README and LICENSE at github.com/isitcredible/reviewer2. The prompt quoted in the
  notes of "Review services" is the start of its first stage,
  `src/reviewer2/prompts/01a_breaker.txt`
- The other services on "Review services" (Refine paid, up to $50; Reviewer3 commercial;
  paperreview.ai from Stanford and openaireview.org from Chicago free; coarse.ink open
  source): the Reviewer 2 paper, *Yell at It*, `paper/yellatit.pdf` in
  github.com/isitcredible/reviewer2, pp. 6–7; quoted in `material/README.md`
- The chat prompt on "Paste it into the chat" and the prompts described in the notes are
  our own: the review prototype's system prompt (full text on the demo deck's backup
  slide), `chat-skills/dkf-document-check/SKILL.md` in `stats_review`, and the agent
  instruction from the `stats_review` README
- "Since o1 pro" (December 2024) on the chat slide is the speaker's own experience, said
  as such in the notes
- Costs and model versions: run logs in `stats_review/archive/2026_api_prototype/`
  and the decks in `dkf-llm-explorations`; for the demo's agent run, the session record
  summarised in `demo/runs/2026-10-31_agent/SCORE.md`
