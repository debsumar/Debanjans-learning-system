---
name: verify-system
description: Verify registry integrity, static HTML contracts, study markup, SVG bounds, progressive enhancement, and classic-script discipline before commit.
---
# Verify before commit

Use this skill before any commit. `$ARGUMENTS` is an optional narrowing hint, such as a
topic slug or file. The repository verifier remains the required final check.

## Required command

Run from `C:\K4U\Debanjans-learning-system`:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\tools\verify.ps1
```

Require process exit code 0. Require final output `PASS` with `0 failures`.
A narrowed review does not replace this full command.

## Current `tools\verify.ps1` suite

Run this gate before every commit. It currently emits 33 result checks and must exit 0.
The one documented SVG geometry SKIP is not a FAIL, but still needs manual review. The
script reads `assets/registry.js`, `assets/study.js`, `assets/model.js`, asset CSS, root
HTML, and `topics/az-900/`.

Checks, in shipped order:

1. `registry metadata extraction`: topic and 11-chapter registry shape.
2. `registry JavaScript syntax`: Node syntax check.
3. `registry chapters exist`: every registry chapter file exists.
4. `disk chapters listed`: all 11 chapter HTML files are listed in registry.
5. `prev/next chain`: registry order, chapter links, and hub endpoints.
6. `launcher topic cards`: exact registry topic href order and targets.
7. `hub chapter cards`: exact registry chapter href order and targets.
8. `static HTML restrictions`: no `<style>` tag, retired key, root-relative assets, remote
   assets, or non-ASCII HTML.
9. `same-file anchors`: every `href="#x"` resolves to an id in that file.
10. `page accessibility and shared refs`: first-child skip link, `main#main`, and shared
    theme assets on every page.
11. `objective coverage`: registry objectives and HTML `data-objective` references cover
    both directions.
12. `skills-bullet ids`: every `#skills` bullet has a real, correctly owned objective id.
13. `recall and MCQ integrity`: unique id formats plus repo, chapter, review, and MCQ
    counts.
14. `confusion set integrity`: registry sets resolve to chapter callouts and hub targets.
15. `SVG geometry bounds and labels`: catalogue uses, numeric viewBoxes, primitive bounds,
    and centred-label anchors.
16. `study contract`: 11 chapters, hub, and review each have one mount and trailing classic
    `assets/study.js`; study syntax is local and classic.
17. `interactive model contract`: three registered models, rectangular static cells, and
    matrix-only outcomes.
18. `component catalogue`: `tldr`, `myth`, `steps`, `glossary-link`, `study-brief`, and
    `model` markup/invariant declarations.
19. `TL;DR contract`: one first-section TL;DR per chapter, 4-6 bullets, and TOC link.
20. `cross-file glossary anchors`: valid glossary slugs and live `glossary.html` targets.
21. `recall objective coverage`: all 114 chapter recall items carry known objectives;
    review `rev-*` items are explicitly exempt.
22. `steps contract`: every step item has one `details`; first and only open item.
23. `myth callouts`: chapter distribution, `span.lbl`, and maximum of three per chapter.
24. `study brief contract`: brief builder and copy controls; no module, network, or `var`.
25. `progressive enhancement`: answer items retain summaries and readable answers with JS off.
26. `model contract`: each `data-model` wrapper has one rectangular scoped matrix.
27. `model outcome vocabulary`: each model has 2-5 distinct non-empty outcomes.
28. `model script contract`: only model pages load one trailing classic `model.js`, after
    `study.js`.
29. `model progressive enhancement`: no matrix facts in `model.js`; model tables stay visible.
30. `model.js ES2026 classic discipline`: no real module syntax, `fetch(` call, or `var`.
31. `favicon and description contract`: every HTML page has an offline SVG data-URI favicon
    and one unique non-empty description.
32. `ES2026 classic asset scripts`: all four asset scripts have no `var` or module marker.

The verifier also reports one intentional `SVG unsupported geometry` SKIP when present:
path curves, transforms, markers, and text glyph extents are not statically checkable by
regex. This is not proof of visual correctness.

Current scope is hard-coded: `topics/az-900/`, 11 chapters, 57 objectives, 110 MCQs, 114
chapter recalls, 22 review recalls, 10 confusion sets, three interactive models, six
catalogued components, and four asset scripts. Adding a topic needs verifier support first.

## Honest limits

Verifier proves SHAPE: links, counts, ids, static contracts, selected SVG geometry, and
script discipline. It does not prove factual accuracy, MCQ answer-key correctness or
rationale quality, whether a diagram teaches anything, whether an interactive model teaches
anything, or rendered appearance. Human review against the official guide and in-browser
behaviour must cover those limits.

Module/network detector is tightened. After comments are removed, it bans real `import` or
`export` statements and `fetch(` calls. It deliberately allows those words in comments and
identifiers; the earlier broad regex caused false failures.

## Manual browser checks that remain

Open root, hub, review, glossary, and chapter pages directly from `file://`, then on hosted
copy. Check dark, light, and print rendering; keyboard focus order and visible focus; diagram
correctness; model predict-and-reveal flow; skip link, navigation, anchors, Prev/Next links,
and JavaScript-disabled readability. Study state persists on the hosted copy, but NOT across
`file://` pages: `localStorage` is per-file-URL, so standalone pages do not share state.

## Pre-commit checklist

1. Read verifier output. Fix every FAIL; do not treat SKIP as PASS.
2. Confirm changed files are ASCII-only and paths are relative.
3. Confirm registry/page objective coverage, IDs, counts, links, model markup, and study mounts.
4. Perform manual browser checks above, including print, JS-off reading, and model flow.
5. Review facts, answer keys, rationales, diagrams, models, and official-source alignment.
6. Re-run the exact PowerShell command. Commit only with exit code 0 and zero failures.
