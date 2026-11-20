# A Third Pair of Eyes? AI-Assisted Review of Statistical Reports and Code

The kit for a 20-minute SCTO talk: the slides, a handout to read later, a starter for
each of four ways to get an AI review of a statistical product (a sample size
estimation, an analysis plan, a report: its methods, its numbers and its code), and a
synthetic test case with a known answer. My own exploration, not a DKF service or
recommendation.

## Start here

- **The handout**, [`slides/handout.html`](slides/handout.html): the talk in more detail,
  with every link. Download it and open it in a browser; it is self-contained.
- **The slides**, [`slides/index.html`](slides/index.html): nine slides and an
  appendix; press S for the speaker notes.
- **A starter for each way**, in [`tools/`](tools/):

| | Way | Starter |
|---|---|---|
| 1 | [Paste it into the chat](tools/1-chat/README.md) | the prompt, the settings, and `dkf-document-check`, a skill for Claude chat |
| 2 | [Review services](tools/2-services/README.md) | the list, paid, free and open source, with sources |
| 3 | [Your own script](tools/3-api/README.md) | `review.R` (ellmer) and `review.py` (Anthropic SDK), with the prompt and the answer format |
| 4 | [An agent in the repository](tools/4-agent/README.md) | Claude Code on the web with the DKF review skills as its instructions |

- **The demo**, [`demo/`](demo/README.md): a two-page synthetic SSE with six planted
  issues, its answer key and the recorded runs. Give a tool only `demo/sse/`; the rest
  of this kit names the issues.

The review skills live in their own repository,
[stats_review](https://github.com/valentinklotzbuecher/stats_review); this kit links to
version 0.3.1 (tag `skills-v0.3.1`).

## The talk

It opens with a preprint in which every one of 15 language models found more of the
errors inserted into trial reports than human peer reviewers had, and with King and
Worthington's finding that AI reviews beat paid expert reviews. Then four ways to an AI
review, each drawn as a diagram: a chat at maximum effort, where a skill can bring your
checklist along; review services, someone else's pipeline, paid, free or open source;
your own pipeline, a script through the API in R (ellmer, with vitals to score it on
test cases with known answers) or Python (the SDKs); and an agent in the product's
repository, with the skills as its instructions and the Agent SDK to start it from a
script. One slide shows how to try the script and the agent from this kit. Then Sutton's
bitter lesson, as a warning not to over-engineer: Google's Deep Review, Reviewer 2
retired as obsolete, my own prototype too; what carries over is test cases, review
standards and data rules. It ends on one discussion slide that brings back the
preprint's last author (human-only review is dangerous; is AI-only review?), with
questions on signing off an AI-reviewed product, result-oriented review, the checks
never to hand over, writing for an AI reader, replication certificates and how juniors
will learn to review. The talk takes about ten and a half minutes, which leaves the rest
of the slot for the discussion; the Agent SDK is in the appendix.

## Contents

```
slides/index.qmd        the deck (Quarto reveal.js), with speaker notes; index.html rendered
slides/handout.qmd      the handout (Quarto HTML); handout.html rendered
slides/diagrams/        the diagrams as inline SVG, included by the deck and the handout
slides/website.scss     the deck's theme, after valentinklotzbuecher.github.io: ivory,
                        spruce-green ink, mauve; Zen Kaku Gothic New and IBM Plex Mono
slides/handout.scss     the same style for the handout
slides/assets/          the preprint's forest plot, and shot-*.png: the screenshot cards,
                        cut from the posts in material/ (see material/README.md)
tools/                  one folder per way, each with a README; tools/3-api has the scripts
demo/sse/               the synthetic SSE (.qmd and rendered PDF): the only reviewable part
demo/answer-key.md      the six planted issues, their consequences, the scoring rules
demo/answer-key.R       recomputes every number in the answer key
demo/runs/              each recorded review of the demo, scored, and the scoreboard
material/               sources: the preprint, post screenshots, quotes with pages
archive/                the earlier, longer deck built around the demo
```

## Rendering

```bash
quarto render slides/index.qmd             # the deck; no R needed
quarto render slides/handout.qmd           # the handout; no R needed
quarto render archive/demo-deck.qmd        # the earlier deck
quarto render demo/sse/DEMO-TKA_SSE.qmd    # the SSE as PDF via Typst; needs R and knitr
Rscript demo/answer-key.R                  # about a minute
Rscript archive/assets/make-figures.R      # the earlier deck's power figure (base R)
```

The rendered PDF in `demo/sse/` is the one every tool reviews. If you re-render it,
re-run every tool on the new PDF.

## Sources

- Brian, Pereira Hernández, Yin, Koury, Rust, *Large language models detect
  methodological errors that human peer review misses in clinical trials*, medRxiv,
  28 October 2026, doi:10.64898/2026.10.25.26366455 (CC BY 4.0; in `material/`, with
  notes); Ruslan Rust on X, 28 October 2026 ("From now on I won't do any peer review
  without AI. For clinical trials, I'd even call human-only review dangerous";
  screenshot in `material/`)
- King and Worthington, *AI Article Reviews Dominate Human Peer Reviews at Their Best:
  Evidence and Policy Choices*, working paper, version of 28 October 2026,
  gking.harvard.edu/files/peerless.pdf: the abstract (p. 1) and the details (pp. 4, 5,
  10), quoted in `material/README.md`; Rex Douglass's comment is from his post of
  23 October (screenshot in `material/`)
- Google's Deep Review: News from Google on X, 14 October 2026 (agentic; manuscripts,
  design docs, proposals; pilots on over 15,000 papers), quoted in Rex Douglass's post
  of 15 October (screenshot in `material/`, the source of the card on "The bitter
  lesson"); "free, 2 a week", its storage and training terms from Google Research's
  post of 14 October 2026,
  research.google/blog/analyzing-technical-documents-with-deep-review/, quoted in
  `material/README.md`
- Certify (Gary King, Yiqing Xu and Leo Yang, Harvard), replication certificates run by
  your own AI assistant: certify.iq.harvard.edu, quoted in `material/README.md`; in the
  discussion slide's notes, the handout and `tools/4-agent`
- Rich Sutton, *The Bitter Lesson*, 13 March 2019,
  incompleteideas.net/IncIdeas/BitterLesson.html
- Reviewer 2: github.com/isitcredible/reviewer2 (README: 30+ chained calls, 15–45
  minutes, a few dollars; aggressive prompting, then a verification cascade; Apache
  2.0); Joseph Francis on X, 26 October 2026 ("Reviewer 2—he dead", "Yes, I decided it
  was obsolete"; screenshot in `material/`), and the same day releasing his skills
  ("… the results have been produced by robots and should be verified by humans";
  screenshot in `material/`). The prompt quoted for its first stage is
  `src/reviewer2/prompts/01a_breaker.txt`
- research_skills: github.com/isitcredible/research_skills (MIT, 0.9 first public
  release)
- The other services (Refine paid, up to $50; Reviewer3 commercial; paperreview.ai from
  Stanford and openaireview.org from Chicago free; coarse.ink open source): the
  Reviewer 2 paper, *Yell at It*, `paper/yellatit.pdf` in
  github.com/isitcredible/reviewer2, pp. 6–7; quoted in `material/README.md`
- Claude Science's built-in reviewer, in the archived deck's notes:
  claude.com/docs/claude-science/the-reviewer
- vitals 0.4.1, CRAN (Simon Couch, Posit): "A port of 'Inspect', a widely adopted 'Python'
  framework for large language model evaluation. Specifically aimed at 'ellmer' users
  who want to measure the effectiveness of their large language model-based products";
  vitals.tidyverse.org; quoted in `material/README.md`
- Claude Agent SDK: code.claude.com/docs/en/agent-sdk/overview (Claude Code as a
  library; skills load from `.claude/`; API-key authentication for agents built on it;
  the CLI with `-p` from other languages); quoted in `material/README.md`
- Claude Code on the web: code.claude.com/docs/en/claude-code-on-the-web (runs in an
  isolated cloud VM, not on your machine; counts toward the plan's usage, no separate
  charge; the plans it is on); quoted in `material/README.md`
- The API starters' settings (model `claude-opus-5-5`, effort, structured output,
  server-side fallbacks, US$4 and US$20 per million input and output tokens): Anthropic's
  API documentation, November 2026; ellmer 0.5.2's `chat_anthropic()` and
  `type_from_schema()`
- The prompts are our own: "Please check if this is consistent." on the chat slide;
  `tools/3-api/prompt.md`; `chat-skills/dkf-document-check/SKILL.md` and the agent
  instruction in `stats_review`; the earlier prototype's prompt on the archived deck's
  backup slide
- "Since o1 pro" (December 2024) is the speaker's own experience, said as such
- Costs and times of the demo runs: `demo/runs/`, each with the session record
  summarised in its `SCORE.md`
