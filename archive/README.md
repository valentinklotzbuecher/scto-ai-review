# Archive: the earlier demo deck

The first, longer version of the talk, built around the demo SSE (`../demo/`): the
product, its six planted issues, a scoreboard of recorded runs, one finding traced, and
what the human reviewer gets. Kept for the demo; the talk is now `../slides/index.qmd`.

```
demo-deck.qmd, .html   the deck (Quarto reveal.js), rendered self-contained
reveal_lilac.scss      its base theme; talk.scss on top
assets/                its own figures: the SSE's page 2, the power figure and the
                       script that draws it, the review-form screenshot
```

```bash
quarto render archive/demo-deck.qmd
```

```bash
Rscript archive/assets/make-figures.R
```

The deck names the planted issues: like `../slides/`, it never goes into a review.

Its figures are as of early November 2026. The Unjournal figure on its backup slide (one
call per paper found 80% of the expert issues) was superseded on 10 November 2026: the
working paper now reports that figure as self-judged and gives the 30-paper comparison
quoted in `../material/README.md`.

Images on its slides:

- "The product" shows page 2 of `../demo/sse/DEMO-TKA_SSE.pdf`
  (`assets/demo-sse-page2.png`: `pdftoppm -r 220 -f 2 -l 2 -png`, cropped from the top
  of the page to "132 in total"). Re-render the SSE, and redo the crop.
- "What the reviewer gets" shows the 5 November run's `CONSISTENCY_REVIEW.html`
  (`assets/consistency-review.png`: Chromium at 900 px wide, light colour scheme, twice
  the pixel density, cropped from Decision to the first major issue).
- The power figure is drawn by `assets/make-figures.R` (base R) from the SSE's own
  simulation; the committed figure used Liberation Sans as the default sans-serif font.
