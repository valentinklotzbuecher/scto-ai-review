# 3 · Review services as templates

Others built whole review pipelines: you upload the PDF, a fixed chain of model calls
with prompts the vendor wrote runs behind it, and you get a report. All are built for
research papers, not for sample size estimations or analysis plans, and all but the
open-source ones mean uploading to a third party.

| Service | Access | By |
|---|---|---|
| [refine.ink](https://refine.ink) | paid, up to $50 a review | Benjamin Golub and Yann Calvó López |
| [reviewer3.com](https://reviewer3.com) | paid | Natalie Khalil |
| [paperreview.ai](https://paperreview.ai) | free | Yixing Jiang and Andrew Ng, Stanford |
| [openaireview.org](https://openaireview.org) | free | Chicago Human+AI Lab, Chenhao Tan |
| [Reviewer 2](https://github.com/isitcredible/reviewer2) | open source (Apache 2.0); run it with your own Gemini API key | Joe Francis |
| [coarse.ink](https://coarse.ink) | open source | David Van Dijcke |
| [Deep Review](https://research.google/blog/analyzing-technical-documents-with-deep-review/) | free, two reviews a week; more with your own Gemini API key | Google Research |

More appear every month. Prices and terms as of November 2026; check them before you
upload anything unpublished.

- **Reviewer 2** chains more than 30 model calls; a run takes 15–45 minutes and costs a
  few dollars in Gemini API usage (its README). Its first stage, The Breaker, is told to
  "take a sledgehammer to academic texts", and later stages remove the hallucinations
  that aggression produces.
  On 26 October 2026 its author retired the hosted version, which he had decided was
  obsolete, and released the skills he now begins his reviews with:
  [research_skills](https://github.com/isitcredible/research_skills) (MIT), on which
  the skills in [`../1-chat`](../1-chat/README.md) and [`../4-agent`](../4-agent/README.md)
  build.
- **Deep Review**: Google says uploaded documents are never used to train, fine-tune or
  improve its models, and are stored for one year.

## As templates

The pipelines behind the services are scripts that call a model through its API, and
the open-source ones show their steps and prompts: templates for a script of your own,
such as the review document in [`../2-api`](../2-api/README.md).

Sources: Joseph Francis, *Yell at It: Prompt Engineering for Automated Peer Review*,
`paper/yellatit.pdf` in the Reviewer 2 repository, pp. 6–7 (refine.ink, reviewer3.com,
paperreview.ai, openaireview.org, coarse.ink); Reviewer 2's README, licence and prompts;
Joseph Francis on X, 26 October 2026 (the retirement and the skills); Google Research,
*Analyzing technical documents with Deep Review*, 14 October 2026. Quoted, with the
screenshots, in [`../../material/`](../../material/README.md).
