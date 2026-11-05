A template for starting new projects. The SIAM folder  contains LaTeX Macros distributed by [SIAM](https://www.siam.org), and downloaded from their [Macros](https://www.siam.org/publications/journals/about-siam-journals/information-for-authors). To comply with their permissions, they are included here as a whole. 

In the starter Manuscript folder, there is also a copy of the most recent SIAM macro style, wiith an article starter that I use for my projects. In concrete projects, I delete the SIAM folder, which is not necessary for the compilation, as all necessary files for my project are in the Manuscript folder.

## Document classes

`Manuscript/manuscript.tex` compiles with any of three classes; switching between them only needs a change to its `\documentclass` line:

```latex
% \documentclass[a4paper]{siamart251216}
% \documentclass[a4paper]{siamonline250211}
\documentclass[a4paper,baskervaldx]{daarticle}
```

`daarticle.cls` is my own class, built on the standard `article` class and independent of the SIAM classes. It has the same page layout as `siamonline`, and provides the same front-matter commands (`\headers`, `\email`, `\thanks`), environments (`abstract`, `keywords`, `MSCcodes`, theorem-like environments, `proof`) and theorem macros (`\newsiamthm`, `\newsiamremark`), so a document moves between the classes unchanged. Its look takes its cue from the publisher Adelphi: classic serif, small capitals, centred title and running heads, an ivory page, and colours sampled from the Biblioteca Adelphi covers.

Options of `daarticle`:

- `baskervaldx`: Baskervaldx text with matching newtx maths; `cmbright`: CM Bright (no small capitals, so headings are bold). With neither, the LaTeX default fonts are used.
- `print`: white page instead of ivory, for printing or submission.
- `a4paper` (default) or `letterpaper`; `hidelinks`.

`Manuscript/test-daarticle.tex` is a test document for the class: an excerpt of a paper with hypotheses, theorems, proofs, a figure, a table and an appendix.
