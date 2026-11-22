# Material for the talk

| File | What it is | Use |
|---|---|---|
| `brian-2026-llm-peer-review-medrxiv-v2.pdf` | Brian D, Pereira Hernández XI, Yin H, Koury J, Rust R. *Large language models detect methodological errors that human peer review misses in clinical trials.* medRxiv, version 2 posted 28 October 2026. doi:10.64898/2026.10.25.26366455 | CC BY 4.0: reuse with attribution. `slides/assets/brian2026-fig1b.png` is cropped from its Fig. 1b. Not peer reviewed. |
| `rust-2026-10-tweet.png` | Ruslan Rust (last author) on X announcing the preprint; the date is not visible in the screenshot | Source of the quote on the discussion slide, "And in five years?" (on the opening slide of the demo deck) |
| `francis-2026-10-26-tweet.jpeg` | Joseph Francis on X, 26 October 2026, retiring Reviewer 2 | Source of "obsolete" on "Review services" and in the notes of "The bitter lesson"; in the demo deck, of the quotes in the notes of "What carries over" and on the backup slide "Others built review pipelines" |
| `francis-2026-10-26-skills-tweet.png` | Joseph Francis on X, 26 October 2026, releasing his review skills (/review, /audit-review, /review-digest): "When using them, you should remember that the results have been produced by robots and should be verified by humans." … "this is only how I begin my reviews. Quite a lot of human labour can go into them subsequently." | Source of the card on "Result-oriented review" |
| `rust-2026-10-28-tweet.png` | Ruslan Rust on X, 28 October 2026, with the date visible: "TLDR: From now on I won't do any peer review without AI. For clinical trials, I'd even call human-only review dangerous" | Source of the screenshot on "And in five years?"; supersedes the undated `rust-2026-10-tweet.png` |
| `douglass-2026-10-15-deep-review-tweet.png` | Rex Douglass on X, 15 October 2026, quoting News from Google (14 October): "Today @GoogleResearch is launching Deep Review — an agentic system designed to stress-test manuscripts, design docs, and complex proposals before submission or publication. After pilot partnerships analyzing over 15,000 research papers, we're making Deep Review globally" [available]. His comment: "For about three years I've thought about building this at least twice a day, and I keep not because it's token expensive, hard to monetize, and easy to enter. And then of course one of the big three does it and it's over." | Source of the card on "The bitter lesson" and of Deep Review on "Review services" |
| `douglass-2026-10-23-king-worthington-tweet.png` | Rex Douglass on X, 23 October 2026, quoting Gary King's post on King and Worthington, "AI Article Reviews Dominate Human Peer Reviews at Their Best: Evidence and Policy Choices" (GaryKing.org/peerless; the paper is noted below), with the abstract: "We show that AI-generated article reviews are now better, by every measure we could construct, than reviews written by well-compensated human experts and judged to be of unusually high quality by journal editors and authors." His comment: "It's been true for a year at least. More with some work." | Source of the card on the intro slide |

## Claude Agent SDK (documentation, read 18 November 2026)

code.claude.com/docs/en/agent-sdk/overview, quoted for the appendix slide "The Agent SDK":

- "The Agent SDK gives you the same tools, agent loop, and context management that
  power Claude Code, programmable in Python and TypeScript."
- Skills, commands and memory "load automatically from your project's `.claude/` and
  from `~/.claude/`, same as Claude Code."
- "Unless previously approved, Anthropic does not allow third party developers to offer
  claude.ai login or rate limits for their products, including agents built on the
  Claude Agent SDK. Use the API key authentication methods described in the Quickstart
  instead."
- "To drive the same agent loop from a language other than Python or TypeScript, run
  the CLI as a subprocess with the `-p` flag and `--output-format json`."

## Brian et al. 2026 in brief

**Design** (pp. 2–4, Fig. 1a). The largest inserted-error study of peer review
(Schroter et al., BMJ 2004; J R Soc Med 2008) gave 607 reviewers of a general medical
journal three trial reports with 9 major and 5 minor errors inserted. The preprint gave
the same three reports to 15 language models (four open-weight) without tools or web
access, then inserted the same 14 error types into 58 randomised trials published in
2026 and reviewed unmodified versions as controls. 1,796 reviews, scored against a
fixed answer key by two blinded LLM judges (Fable 5, Opus 5; Cohen's κ 0.93–0.97),
with two further judges from other developers as a check.

**Results.**

- Original reports (p. 4): human reviewers found 2.40 of 9 major errors (27%); the
  models 4.73 (Haiku 4.5) to 8.65 (Opus 5.5), that is 53–96%. All 180 model reviews
  scored above the human mean of 3.29 of 14.
- 2026 trials (p. 7): sensitivity 45.8% (Haiku 4.5) to 90.2% (GPT-6.1 Sol) and 92.9%
  (Opus 5.5); major-error scores 58–99% (abstract).
- Cross-checking errors (p. 9): humans found abstract–results discrepancies 25%,
  inconsistent participant counts 32%, text–table discrepancies 7%, reversed
  comparisons 10%; on the 2026 trials the four leading models found all four in every
  review.
- Controls (p. 10): overall specificity 82.4%; models that found more inserted errors
  also flagged more error types on unmodified reports (Spearman ρ = −0.76). Most
  flags: conclusions not supported by the results, missing reasons for non-enrolment.
  The authors note a flag on a control "is not necessarily incorrect".
- Time and cost (p. 12): human reviewers report 5 to 8.5 hours per review; models 1.4
  to 16.3 minutes and an estimated $0.005 to $2.24 per review.

**The boundary of manuscript-only review** (p. 13, verbatim):

> This design also marks the boundary of what manuscript-only review can achieve,
> whether by humans or by models. Every error tested here is visible in the text,
> whereas errors in data handling or analysis code, undisclosed deviations from the
> registered protocol and fabricated data are not. In this study, the models could not
> execute code or access anything beyond the manuscript, yet the leading models
> detected nearly all errors that were detectable in principle. Greater progress may
> therefore come from giving reviewers, human or AI, access to the underlying
> evidence, including de-identified data, analysis code, protocols and registry
> entries, which models can cross-check at a scale that volunteer reviewers cannot.

**Limitations** (pp. 14–15): human comparison from historical reviews; modified
manuscripts and scores not validated by human assessors; the 55 further trials were
prepared and checked by language-model agents; judges may share biases; prior exposure
to trial findings cannot be excluded.

**Competing interests** (p. 17): four authors are affiliated with ResearchHub
Foundation, whose platform is implementing AI-assisted review. The experiment itself
was run in Claude Code (p. 16).

## Claude Code on the web (documentation, read 18 November 2026)

code.claude.com/docs/en/claude-code-on-the-web, quoted for "An agent in the repository":

- "A cloud session is a Claude Code session that runs on cloud infrastructure instead of
  on your machine."
- "It counts toward your plan's usage limits alongside the rest of your Claude and
  Claude Code usage, and there's no separate charge for the cloud VM."
- "Cloud sessions are available on Pro, Max, Ultra, and Team plans, and for Enterprise
  users with premium seats or Chat + Claude Code seats."
- Security and isolation: "each session runs in an isolated, Anthropic-managed VM";
  network access "is limited by default and can be disabled"; git credentials "stay
  outside the sandbox". The caveat behind the slide's footnote: "When running with
  network access disabled, Claude Code can still communicate with the Anthropic API,
  which may allow data to exit the VM."

## Review services (the Reviewer 2 paper)

Joseph Francis, *Yell at It: Prompt Engineering for Automated Peer Review*,
`paper/yellatit.pdf` in github.com/isitcredible/reviewer2, pp. 6–7, quoted for "Review
services":

> refine.ink, the oldest of the five, was founded by Benjamin Golub, a professor of
> economics at Northwestern, and Yann Calvó López […]; it is commonly seen as the gold
> standard and is expensive, costing up to $50 per review. reviewer3.com, founded by
> Natalie Khalil, is another commercial alternative. paperreview.ai, the Stanford
> Agentic Reviewer by Yixing Jiang and Andrew Ng, is a free system, as is
> openaireview.org, from the Chicago Human+AI Lab under Chenhao Tan. The most recent
> alternative is coarse.ink, by David Van Dijcke […]; it appears to have effectively
> been reverse-engineered from refine.ink and is also open source.

Reviewer 2 itself is Apache 2.0 (its `LICENSE`). The prompt in the notes of "Review
services" is the start of its first stage, `src/reviewer2/prompts/01a_breaker.txt`: "You are **The Breaker**. You
take a sledgehammer to academic texts, breaking them into pieces."

## King and Worthington, Deep Review and Certify (read 19 November 2026)

Read with `curl` through the session's proxy (the WebFetch tool cannot resolve these
hosts, but they are allowed):

- King and Worthington, *AI Article Reviews Dominate Human Peer Reviews at Their Best:
  Evidence and Policy Choices*, working paper, version of 28 October 2026,
  gking.harvard.edu/files/peerless.pdf. Abstract (p. 1): "We show that AI-generated
  article reviews are now better, by every measure we could construct, than reviews
  written by well-compensated human experts and judged to be of unusually high quality
  by journal editors and authors." The corpus (p. 4): "124 scholarly paper submissions
  and 134 human reviews" from rapidPeer, IQSS's paid review service. The AI reviews (p.
  4): "a single AI review with Claude Opus 4.8 (Anthropic, 2026) at its maximum
  reasoning setting", given the manuscript and the verbatim rapidPeer reviewer
  guidelines. The judges: GPT-5.5, blinded (p. 5), and three former journal editors,
  who "preferred the AI review in 26 of 30 judgments (87%)" (p. 10).
- Google Research, *Analyzing technical documents with Deep Review*, 14 October 2026,
  research.google/blog/analyzing-technical-documents-with-deep-review/: "Every user
  receives two complimentary document reviews per week. Users with high-volume workflows
  can connect their Gemini API key for higher usage limits"; documents "are never used
  to train, fine-tune, or improve Google models" and are stored for one year. Deep
  Review grew out of the Paper Assistant Tool, piloted with STOC 2026, ICML 2026,
  NeurIPS 2026 and ICLR 2027. This is the "free, 2 a week" tag on "Review services".
- Certify, "Software for Replication Certification", certify.iq.harvard.edu, a beta:
  "A replication certificate adds to a replication dataset evidence that rerunning the
  code produces the results to be published." You open "an AI assistant that can run
  commands on your computer, such as Claude Code or Codex"; it reruns the replication
  package on your computer, and the certificate is sealed in a Dataverse archive.
  Details: Gary King, Yiqing Xu and Leo Y. Yang, 2026, "Replication Certification at
  Publication: Checkable by Anyone, Anywhere, in Seconds, Forever." In the notes of "An
  agent in the repository" and in the links.

## vitals (CRAN package database, read 20 November 2026)

vitals 0.4.1, published on CRAN on 10 November 2026; author Simon Couch, with Max
Kuhn, Hadley Wickham and Mine Cetinkaya-Rundel as contributors; Posit Software, PBC;
vitals.tidyverse.org, github.com/tidyverse/vitals. Title: "Large Language Model
Evaluation". Description:

> A port of 'Inspect', a widely adopted 'Python' framework for large language model
> evaluation. Specifically aimed at 'ellmer' users who want to measure the effectiveness
> of their large language model-based products, the package supports prompt
> engineering, tool usage, multi-turn dialog, and model graded evaluations.

Used on "Your own script" (the scores box and the notes), in the handout and in
`tools/2-api`: scripted calls can be scored on test cases with known answers.

## Just Ask the Model, our Unjournal working paper (read 19 November 2026)

Klotzbücher, Reinstein, Pacchiardi and Zhang, *Just Ask the Model: One-Shot LLM Research
Evaluation and Structured Expert Review*, llm-uj-research-eval.netlify.app (also on
GitHub Pages), the version deployed on 10 November 2026 (`gh-pages` of
llm-uj-research-eval, deploy commit 0944f53). The headline on its first page, "Can the
model find the issues experts find?":

> On 30 papers, a one-shot Claude Opus 5.5 report raised 61% of an individual
> evaluator's issues by a GPT judge and 35% by a stricter Claude judge; a second
> evaluator raised 36% and 22% of the same issues. Both are far above a placebo that
> pairs one paper's evaluations with the model's report on another paper (2% and 1%).
> So the model overlaps with an individual evaluator more than a second evaluator does,
> under both judges, though the two judges disagree on the level and no human has
> checked the matches yet. An earlier analysis of 12 papers against a short curated
> consensus list reported 80% coverage, but that judge was GPT-5.2 Pro grading its own
> critiques; a blinded re-judging gives 44%–60% at the main level, and about 80% only
> when any criticism of the same result counts.

Its introduction calls the design "the simplest possible setup—a single prompt to a
frontier model, with no bespoke pipeline". The talk cited the earlier 80% until
19 November 2026 and has not cited the working paper since; the quote stays here
because the archived deck still carries the superseded figure.

## Where it is used in the talk

In the deck (`slides/index.qmd`):

- The intro slide, "Models find more errors than reviewers did": Rust's words, then the
  27% against 53–96% and Fig. 1b. The caveats (preprint, 2004 human reviewers, LLM
  judges, flags on unmodified reports) are in its notes.
- "Three kinds of review" (notes): King and Worthington; Brian et al.'s methodological
  errors and the boundary sentence above, on errors in analysis code; Certify.
- The discussion slide, "To discuss": the preprint's last author, as the bookend, in its
  notes.
- The posts are shown as screenshots, cut from the files above into
  `slides/assets/shot-*.png`; where a card leaves text out, a dashed rule marks the gap:
  - intro slide: `shot-rust.png`, the text of `rust-2026-10-28-tweet.png` without its
    figure (the figure is the next click, from the preprint itself); then, on the last
    click, `shot-king-worthington.png`, the whole of
    `douglass-2026-10-23-king-worthington-tweet.png`;
  - "The bitter lesson", a backup slide in the appendix for the discussion item "Build
    our own tools, or wait for the next model?", two cards for one click each:
    `shot-deep-review.png`, the whole of `douglass-2026-10-15-deep-review-tweet.png`
    ("Review services" also lists Deep Review); then `shot-reviewer2-retired.png`, from
    `francis-2026-10-26-tweet.jpeg`: the post retiring Reviewer 2, then a reply's
    question and his answer ("Yes, I decided it was obsolete").
- The discussion slide's notes quote Francis's "verified by humans" sentence (from
  `francis-2026-10-26-skills-tweet.png`) as text, describe Certify, and summarise the
  bitter lesson with Douglass's comment.

In the handout (`slides/handout.qmd`) and the tool READMEs (`tools/`), as text, not
screenshots:

- Brian et al.: the design, the results on the original and the 2026 trials, the
  caveats and the boundary sentence above; Rust's quote.
- King and Worthington: the corpus, the AI reviews and the editors' judgments (pp. 4,
  5, 10).
- Francis's "verified by humans" sentence and the retirement of Reviewer 2; Douglass's
  comment of 15 October; the services from the Reviewer 2 paper; Deep Review's terms;
  Certify.
- The quotes on Claude Code on the web (`tools/4-agent`) and on the Agent SDK.

In the earlier demo deck (`archive/demo-deck.qmd`):

- Opening slide, "Should journals ban AI in peer review?": the 27% against 53–96%,
  the specificity caveat, Fig. 1b and Rust's quote.
- "A reader: chat, or one scripted call": the boundary sentence above, as the bridge
  from reading to checking.
- "Six planted issues, two at each level" and "What carries over": our demo follows the
  same design (inserted errors, one answer key), extended to code and computation.
- Backup, "How well one call reads": the 53–96% against 27% again.
