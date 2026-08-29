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

## What `tools\verify.ps1` checks

The script reads `assets/registry.js`, `assets/study.js`, root HTML, and `topics/az-900/`.
It checks:

- registry file presence, metadata extraction, and registry JavaScript syntax with Node;
- registry/disk chapter parity: every listed chapter exists and every disk chapter is listed;
- chapter Prev/Next chains in registry order, with hub endpoints;
- root launcher cards, real hub targets, exact topic href order;
- topic hub cards, real chapter targets, exact chapter href order;
- static HTML restrictions: ASCII bytes, no `<style>`, retired `az900-theme` key,
  root-relative `/assets/` paths, or remote script/stylesheet;
- same-file anchors: every `href="#x"` has matching `id="x"`;
- skip link as first body child, `main#main`, and shared theme asset references;
- objective coverage both directions: registry objectives are referenced by HTML and
  HTML `data-objective` values exist in registry;
- `#skills` section and skills-bullet IDs, including count and chapter ownership;
- recall and MCQ ID integrity, duplicate IDs, ID formats, and chapter/review counts;
- confusion-set integrity: registry chapters, callout classes, hub targets, and terms;
- SVG geometry bounds and centred labels: numeric viewBox, rect/circle/ellipse/line/text
  bounds, and `text-anchor="middle"` where applicable;
- diagram catalogue count and matched labelled SVG count;
- study contract: one trailing `assets/study.js` reference and one
  `id="study-summary"` mount on each study page;
- progressive enhancement: answer items have `<summary>` and are not statically hidden;
- ES2026 discipline: asset scripts have no `var` and no module markers.

Current script scope matters. `tools/verify.ps1` hard-codes `topics/az-900/`, 11 chapters,
57 AZ-900 objectives, 110 MCQs, 114 chapter recalls, 22 review recalls, and 10 confusion
sets. Adding another topic requires verifier support before this script can prove that topic.
Do not call a new topic verified based on AZ-900-only checks.

## What verifier cannot prove

Verifier proves shape, links, counts, static contracts, and selected SVG geometry. It cannot
prove:

- factual accuracy of any claim;
- correctness of any MCQ answer key or rationale;
- whether a diagram teaches the intended idea;
- rendered appearance.

Human review against the official exam guide must cover these.

Honest geometry SKIP: path curves, transforms, markers, and text glyph extents are not
statically checkable by regex. A SKIP is not proof of visual correctness.

## Manual browser checks that remain

Open root, hub, review, glossary, and chapter pages directly from `file://`, then on hosted
copy. Check:

- dark, light, and print rendering;
- keyboard focus order and visible focus;
- diagram correctness, labels, arrows, and teaching meaning;
- skip link, navigation, anchors, Prev/Next links, and no-JavaScript readability;
- study state persists on hosted copy, but NOT across `file://` pages: `localStorage` is
  scoped per file URL, so standalone pages do not share study state.

## Pre-commit checklist

1. Read verifier output. Fix every FAIL; do not treat SKIP as PASS.
2. Confirm changed files are ASCII-only and paths are relative.
3. Confirm registry/page objective coverage, IDs, counts, links, and study mounts.
4. Perform manual browser checks above, including print and JavaScript-disabled reading.
5. Review facts, answer keys, rationales, diagrams, and official-source alignment.
6. Re-run the exact PowerShell command. Commit only with exit code 0 and zero failures.
