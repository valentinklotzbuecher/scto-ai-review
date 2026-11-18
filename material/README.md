# Material for the talk

| File | What it is | Use |
|---|---|---|
| `brian-2026-llm-peer-review-medrxiv-v2.pdf` | Brian D, Pereira Hernández XI, Yin H, Koury J, Rust R. *Large language models detect methodological errors that human peer review misses in clinical trials.* medRxiv, version 2 posted 28 October 2026. doi:10.64898/2026.10.25.26366455 | CC BY 4.0: reuse with attribution. `slides/assets/brian2026-fig1b.png` is cropped from its Fig. 1b. Not peer reviewed. |
| `rust-2026-10-tweet.png` | Ruslan Rust (last author) on X announcing the preprint; the date is not visible in the screenshot | Source of the quote on the opening slide |
| `francis-2026-10-26-tweet.jpeg` | Joseph Francis on X, 26 October 2026, retiring Reviewer 2 | Source of "obsolete" on "Review services" and in the notes of "The bitter lesson"; in the demo deck, of the quotes in the notes of "What carries over" and on the backup slide "Others built review pipelines" |

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

## Where it is used in the talk

In the deck (`slides/index.qmd`):

- "Paste it into the chat": the 53–96% against 27%, every one of 15 models above the
  human reviewers.

In the demo deck (`slides/demo-deck.qmd`):

- Opening slide, "Should journals ban AI in peer review?": the 27% against 53–96%,
  the specificity caveat, Fig. 1b and Rust's quote.
- "A reader: chat, or one scripted call": the boundary sentence above, as the bridge
  from reading to checking.
- "Six planted issues, two at each level" and "What carries over": our demo follows the
  same design (inserted errors, one answer key), extended to code and computation.
- Backup, "How well one call reads": the 53–96% against 27% again.
