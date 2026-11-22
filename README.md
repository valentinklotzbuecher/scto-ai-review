# A Third Pair of Eyes (and Hands)? AI-Assisted Review of Statistical Reports and Code

The kit for a 20-minute SCTO talk: the slides, a handout to read later, a starter for
each of three ways to get an AI review of a statistical product (a sample size
estimation, an analysis plan, a report: its methods, its numbers and its code), a list
of review services, and a synthetic test case with a known answer. My own exploration, not a DKF service or
recommendation.

## Start here

- **The handout**, [`slides/handout.html`](slides/handout.html): the talk in more detail,
  with every link. Download it and open it in a browser; it is self-contained.
- **The slides**, [`slides/index.html`](slides/index.html): ten slides and an
  appendix; press S for the speaker notes.
- **A starter for each way**, in [`tools/`](tools/):

| | Way | Starter |
|---|---|---|
| 1 | [Paste it into the chat](tools/1-chat/README.md) | the prompt, the settings, and `stats-document-check`, a skill for Claude chat |
| 2 | [An API review prototype](tools/2-api/README.md) | my review prototype, a Quarto document (`review.qmd`): settings in R, the request through the Anthropic Python SDK, every run kept, the review rendered with its prompt and cost |
| 3 | [Agentic review](tools/3-agent/README.md) | Claude Code on the web with the review skills as its instructions; still in development |

- **The services**, [`tools/services/`](tools/services/README.md): the list, paid, free
  and open source, with sources; templates for a script of your own.
- **The demo**, [`demo/`](demo/README.md): a two-page synthetic SSE with six planted
  issues, its answer key and the recorded runs. Give a tool only `demo/sse/`; the rest
  of this kit names the issues.
- **The second demo**, [`demo-crt/`](demo-crt/README.md): a cluster trial whose sample
  size comes from saved simulation results, with four planted issues, three of which
  only running its code sizes. Give a tool only `demo-crt/sse/`.

The review skills live in their own repository,
[third-pair-of-eyes](https://github.com/valentinklotzbuecher/third-pair-of-eyes); this kit links to
version 0.4.1 (tag `skills-v0.4.1`).

## The talk

It opens with a question, how well AI reviews research papers: Ruslan Rust's preprint,
in which every one of 15 language models found more of the errors inserted into trial
reports than human peer reviewers had, and King and Worthington's finding that AI
reviews beat paid expert reviews; then Rust's post (from now on no peer review without
AI; for clinical trials, human-only review dangerous). Its notes add that review must
also keep up with code that AI writes. It
turns to our internal consistency review (methods, numbers and code; errors in code are
not visible in the text), leaving open whether AI belongs before the second statistician
or alongside. Then three
approaches. A chat at maximum effort, and with a skill: the request as typed, and the
folder it calls (SKILL.md, references, scripts). An API review prototype: my
review prototype, a Quarto document that sends the product through the API (settings in R, the
request with the Python SDK through reticulate), keeps every run and renders the review,
shown as it is set up; because it is a script, it can be scored on test cases (in R,
vitals). Further development, with review services as templates: what they do, such as
Refine and the open-source Reviewer 2, which I was planning to fork; and, on the same
slide, Joe Francis retiring Reviewer 2 as obsolete, and the question how much more to
build when tools become obsolete this fast. Its notes name Sutton's bitter lesson and the
skills Francis released the same day. What I did based on that: a coding agent in the product's repository, such as Claude Code or Codex, with skills
adapted from his as its instructions and the Agent SDK to start it from a script, and,
in the agent's box, what it adds over the script: it runs the code, challenges its
findings and works on synthetic data; a first shot. One slide
shows how to try the chat skill, the review document and the agent on your own work. It
ends on one slide of items to discuss, followed by two slides of links. The talk takes about ten
minutes, which leaves the rest of the slot for the discussion.

## Contents

```
slides/index.qmd        the deck (Quarto reveal.js), with speaker notes; index.html rendered,
                        one self-contained file; index.pdf, a printed backup
slides/handout.qmd      the handout (Quarto HTML); handout.html rendered
slides/diagrams/        the diagrams as inline SVG, included by the deck and the handout
slides/website.scss     the deck's theme, after valentinklotzbuecher.github.io: ivory,
                        spruce-green ink, mauve; Zen Kaku Gothic New and IBM Plex Mono
slides/handout.scss     the same style for the handout
slides/assets/          the preprint's Fig. 1b, King and Worthington's Fig. 1, the
                        excerpt of the demo run's review, the QR code to the kit and
                        the logo; the posts are quoted as text
tools/                  one folder per way, each with a README; tools/2-api has the review
                        document
demo/sse/               the synthetic SSE (.qmd and rendered PDF): the only reviewable part
demo/answer-key.md      the six planted issues, their consequences, the scoring rules
demo/answer-key.R       recomputes every number in the answer key
demo/runs/              each recorded review of the demo, scored, and the scoreboard
demo-crt/               the second demo, laid out the same way: sse/ (with its R code
                        and saved results), answer key and script, runs/
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
quarto render demo-crt/sse/DEMO-CRT_SSE.qmd  # reads the saved results; runs no simulation
Rscript demo-crt/answer-key.R              # needs lme4; about 20 minutes on four cores
Rscript archive/assets/make-figures.R      # the earlier deck's power figure (base R)
```

`slides/index.html` is one self-contained file: fonts, figures, icons and scripts are
embedded and it fetches nothing, so it can be shared on its own and opens in a browser
offline. `slides/index.pdf` is the backup, each slide's last step on one page; to print
it again, open `slides/index.html?print-pdf` in Chrome and save it as PDF, with no
margins and background graphics on.

The rendered PDFs in `demo/sse/` and `demo-crt/sse/` are the ones every tool reviews.
If you re-render one, re-run every tool on the new PDF.

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
  10; the editors compared 10 of the pairs, p. 5, without reading the manuscripts,
  p. 19), quoted in `material/README.md`; Rex Douglass's comment is from his post of
  23 October (screenshot in `material/`)
- Google's Deep Review: News from Google on X, 14 October 2026 (agentic; manuscripts,
  design docs, proposals; pilots on over 15,000 papers), quoted in Rex Douglass's post
  of 15 October (screenshot in `material/`; quoted in the notes of "The bitter
  lesson"); "free, 2 a week", its storage and training terms from Google Research's
  post of 14 October 2026,
  research.google/blog/analyzing-technical-documents-with-deep-review/, quoted in
  `material/README.md`
- King and Worthington's Figure 1 on the intro slide: cropped from page 6 of the version
  of 28 October 2026 (the speaker's copy; noted in `material/README.md`); the paper
  states no licence, and the figure is shown with its source, as part of the talk
- Liu, Guo, Hartline and Hullman, *Learning Checklists to Reduce Lottery Effects in
  Scientific Peer Review*, arXiv:2610.28666, 14 October 2026 (CC BY 4.0, in `material/`),
  and Ghosh, Saim and Jiang, *AI Reviews Are Biased Towards the Appendix*,
  arXiv:2611.17811, 13 November 2026: in the notes of "To discuss" and in the handout;
  quoted with pages in `material/README.md`
- Aniket Panjwani on X, on Refine's costs and on evals (date not visible; transcribed in
  `material/README.md`): in the notes of "Further development: review services as templates"
- Certify (Gary King, Yiqing Xu and Leo Yang, Harvard), replication certificates run by
  your own AI assistant: certify.iq.harvard.edu, quoted in `material/README.md`; in the
  discussion slide's notes, the handout and `tools/3-agent`
- The review bottleneck, in the notes of the intro slide: Faros Research, *The AI
  Productivity Paradox Report 2025*, 23 July 2025,
  faros.ai/blog/ai-productivity-paradox-report-2025 (telemetry from over 10,000
  developers in 1,255 teams; within each company, the change from the two quarters with
  the lowest AI adoption to the two with the highest); quoted in `material/README.md`
- Rich Sutton, *The Bitter Lesson*, 13 March 2019,
  incompleteideas.net/IncIdeas/BitterLesson.html
- Reviewer 2: github.com/isitcredible/reviewer2 (README: 30+ chained calls, 15–45
  minutes, a few dollars; aggressive prompting, then a verification cascade; Apache
  2.0); Joseph Francis on X, 26 October 2026 ("Reviewer 2—he dead", "Yes, I decided it
  was obsolete"; screenshot in `material/`), and the same day releasing his skills
  ("Point your agent at a folder …", "… the results have been produced by robots and
  should be verified by humans"; screenshot in `material/`, quoted on "The bitter
  lesson"). The prompt quoted for its first stage is
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
- The review document's settings (models `claude-opus-5-5` and `claude-fable-5-2`,
  effort, adaptive thinking with summaries, streaming; US$4 and US$20, and US$8 and
  US$40, per million input and output tokens; Claude Fable 5.2's 30-day data retention;
  server-side fallbacks, left off): Anthropic's API documentation, November 2026;
  reticulate's `py_require()`. The document itself is the speaker's prototype, ported
  with current models and its prompt in `tools/2-api/prompt.md`
- The prompts are our own: "Please check if this is consistent." on the chat slide;
  `tools/2-api/prompt.md`; `chat-skills/stats-document-check/SKILL.md` and the agent
  instruction in `third-pair-of-eyes`; the earlier prototype's prompt on the archived deck's
  backup slide
- ChatGPT's Pro series (GPT-6 Pro, on the Pro plans): OpenAI's help centre,
  help.openai.com/en/articles/20001354, November 2026; Claude Opus 5.5 and Fable 5.2:
  Anthropic's model overview, November 2026
- "Since o1 pro" (December 2024) is the speaker's own experience, said as such
- Further reading on the Links slides and in the handout: from the speaker's exploration
  notes (the Sources of `03-extensions.qmd` in dkf-llm-explorations) and the Unjournal
  project's bibliography (`references.bib` on the `working-paper` branch of
  llm-uj-research-eval), and Brodeur et al. in PNAS 2026 (doi:10.1073/pnas.2524747123,
  title and issue from Crossref); every link was checked to answer on 22 November 2026 (the
  journal pages through their DOI, the GitHub repositories through GitHub's search)
- Icons for the three approaches (overview, crumbs, "Try it yourself"): Bootstrap Icons
  1.11.3, chat-dots, file-earmark-code and robot (MIT licence, The Bootstrap Authors),
  as inline paths in `slides/diagrams/_overview.qmd` and `slides/website.scss`
- The logo on the title slide, `slides/assets/third-pair-of-eyes.svg`: drawn for this
  kit, in code; its wordmark is outlines of IBM Plex Mono Medium (SIL Open Font
  License). The same file is the logo of the skills' repository
- The QR code to the kit, `slides/assets/qr-kit.svg`: made with segno 1.6.6 for
  https://github.com/valentinklotzbuecher/scto-ai-review (error correction M), its
  two-module border cropped from the viewBox so that the code's edge lines up with the
  text (the slide's paper is its quiet zone), and decoded back from the rendered slides
  before use
- Costs and times of the demo runs: `demo/runs/`, each with the session record
  summarised in its `SCORE.md`
