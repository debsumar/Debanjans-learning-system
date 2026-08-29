---
name: add-topic
description: Add certification topics with registry-first objectives, static pages, study markers, diagrams, models, and verifier checks.
---
# Add a certification topic

Use this skill for `$ARGUMENTS`. Example: `AWS Cloud Practitioner`.

## Non-negotiable ownership

- Create one self-contained folder: `topics/<slug>/`.
- Include `topic.css`, `index.html`, numbered chapter pages, `review.html`, and `glossary.html`.
- `assets/theme.css` and `assets/theme.js` are platform-owned. Do not edit them for a topic.
- `topic.css` may contain only a leading comment and dark/light `:root` token overrides for `--accent`, `--accent-soft`, and `--accent-dim`.
- No duplicated shared CSS, build step, framework, npm, inline `<style>`, or remote asset.
- One intentional manual exception: add the topic card to root `index.html`.

## Asset scripts

- `assets/theme.js`: load in `<head>`, before stylesheets, as a classic script with no `defer`; synchronously set `data-theme` before paint and bind the toggle.
- `assets/study.js`: load trailing, immediately before `</body>` on study pages; optional classic progressive enhancement for recall/MCQ state, confidence, grading, and study briefs.
- `assets/model.js`: load trailing, after `assets/study.js`, only on pages containing a model; optional classic enhancement of a static matrix.
- `assets/registry.js`: load by NO page. Author-side data only; `assets/study.js` is its sole shipped runtime consumer.
- No module scripts, `import`, or fetch-based runtime dependencies: pages must work from `file://` with JavaScript disabled.

## Registry-first order - do this before prose

1. Read the official exam guide. Record vendor, exam code, display name, date, URL, domains, and weight ranges.
2. Add the topic and hub path to `assets/registry.js`.
3. Build the objective registry first. Copy official wording exactly; use stable IDs such as `<exam>-cNN-oM`.
4. Build the ordered chapter map: real filenames, titles, domains, weights, objective IDs, section IDs, archetypes, and MCQ/recall counts.
5. Declare the closed section-archetype enum, question schema, counts, diagrams, confusion sets, and study policy.
6. Only then write chapter, hub, review, glossary, diagram, and question HTML. Pages reference registry IDs; they do not invent them.
7. Registry is single most important sequencing rule. It prevents page prose from silently creating drift.

## Per-page head and shell

Every page starts with `<!doctype html>` and `<html lang="en" data-theme="dark">`. Every head has exactly one non-empty, page-specific description and one offline SVG favicon. Shipped order is charset, viewport, description, title, favicon, `theme.js`, then stylesheets:

```html
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="One ASCII sentence describing this page.">
<title>Topic page title &middot; Notes</title>
<link rel="icon" href="data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16'%3E%3Cpath fill='%23d97757' d='M2 4l6-2 6 2-6 2Zm0 3 6 2 6-2v3l-6 2-6-2V7Z'/%3E%3C/svg%3E">
<script src="../../assets/theme.js"></script>
<link rel="stylesheet" href="../../assets/theme.css">
<link rel="stylesheet" href="topic.css">
</head>
```

Use `assets/theme.js`, `assets/theme.css` at root depth; use `../../assets/...` under `topics/<slug>/`. Favicon is inline `data:image/svg+xml,`; no binary asset or remote request. Keep descriptions unique across all HTML files.

First body child, every page:

```html
<a class="skip" href="#main">Skip to content</a>
```

Use `<main id="main">`, shipped `.top`/`.top-inner`/`.site`/`.top-links` shell, relative links, and theme toggle last in `.top-links`. Chapter body carries `data-chapter`, `data-domain`, and `data-weight`.

## Chapter order and required markers

Use this order: `#skills`, body sections, `#mcq`, `#recall`. Each body section uses one registered archetype: `concept`, `process`, `comparison`, `decision`, `worked-scenario`, `callout`, `diagram`, `mcq-set`, or `active-recall`.

```html
<section class="card" id="skills"><h2>Official skills measured</h2><ul><li id="az900-cNN-o1">Official objective text</li></ul></section>
<details class="more" data-mcq="cNN-q01" data-objective="az900-cNN-o1"><summary>Answer</summary><p>Answer and rationales.</p></details>
<details class="more recall-item" data-recall="cNN-r01" data-objective="az900-cNN-o1"><summary>Recall prompt?</summary><p>Answer.</p></details>
```

Each MCQ has four answer strings, a key rationale, and one rationale per wrong option. Each recall/MCQ objective value must exist in registry. IDs are unique repository-wide. Every study page has exactly one `<div id="study-summary"></div>` mount and trailing `study.js`.

## Six authored learning components

### 1. TL;DR summary card

Exactly one per chapter. It is first `<section>` inside `main`; TOC has a pill to `#tldr`. Use 4-6 bullets. Every bullet states a rule plus boundary, condition, exception, or scope.

```html
<nav class="toc"><a href="#tldr">In one minute</a></nav>
<main id="main"><section class="card tldr" id="tldr"><h2>In one minute</h2><ul>
<li>Choose X when condition applies; boundary limits that choice.</li>
<li>Use Y for this scope; it does not imply Z outside that scope.</li>
<li>Prefer A under constraint; choose B when constraint changes.</li>
<li>Rule plus exception, not topic label.</li>
</ul></section>
```

### 2. Misconception closure

Use `.cal.myth` for a false inference and correction. Label exactly `Common wrong turn`. Use 2-3 only when warranted, never more than 3 per chapter. `.cal.confuse` is distinct: it states a rule or discriminator.

```html
<div class="cal myth"><span class="lbl">Common wrong turn</span><p><strong>&ldquo;False belief.&rdquo;</strong> &mdash; Correct boundary or consequence.</p></div>
<div class="cal confuse"><b class="lbl">Confuse</b>State the actual rule or discriminator.</div>
```

### 3. Causal steps

Use `.steps` only where genuine causality or ordered path exists. Native ordered `details`; every `li` has exactly one `details`; first only item is `open`. Chapters 01, 02, and 03 correctly have no `.steps`; omission beats invented process.

```html
<ol class="steps"><li><details class="more" open><summary>1. Input causes next state.</summary><p>Why this transition occurs.</p></details></li><li><details class="more"><summary>2. Next state produces result.</summary><p>Result and boundary.</p></details></li></ol>
```

### 4. First-use glossary links

Link first substantive prose use only. Never link headings, table headers, `summary`, MCQ stem/option, or TL;DR. Target `glossary.html#g-slug`; slug is `g-` plus lowercase term, with each run of non-alphanumeric characters collapsed to one hyphen and edge hyphens removed.

```html
<p>A <a href="glossary.html#g-private-endpoint">private endpoint</a> maps a service to a private VNet IP.</p>
```

### 5. Recall objective tags

Every chapter recall item carries one or more registry objective IDs in `data-objective`; space-separate multiple IDs. `study.js` uses them for objective weakness reporting.

```html
<details class="more recall-item" data-recall="c05-r10" data-objective="az900-c05-o6"><summary>What does this provide?</summary><p>Answer.</p></details>
```

### 6. Interactive model

Optional. Static outcome matrix is single source of truth; `assets/model.js` derives options, scenarios, predictions, and verdicts from it. Registry declares identity and dimensions, never outcome values. Keep table visible; never hide it. Use 2-5 distinct non-empty outcome values.

```html
<div class="model" data-model="example-id" data-model-rows="Option" data-model-cols="Scenario">
<div class="tw"><table class="t model-matrix"><thead><tr><th scope="col">Option</th><th scope="col">Scenario A</th><th scope="col">Scenario B</th></tr></thead><tbody>
<tr><th scope="row">Choice A</th><td>Outcome one</td><td>Outcome two</td></tr>
<tr><th scope="row">Choice B</th><td>Outcome two</td><td>Outcome one</td></tr>
</tbody></table></div></div>
```

Model page ending:

```html
<script src="../../assets/study.js"></script>
<script src="../../assets/model.js"></script>
</body>
```

Registry also catalogs `study-brief`: this is optional script-derived output, not a replacement for authored static answers. `study.js` renders visible copy controls and textarea; failed clipboard access must not hide it.

## Topic extra pages

`glossary.html` has two sections: a terms `dl`, then a separate `Discriminators` `dl` for `X vs Y` contrasts. Give every `dt` canonical `id="g-..."`. Include a labelled filter, such as `<label for="filter">Filter glossary terms</label>`, plus a live `role="status"` region.

`review.html` includes an interleaved discrimination drill, cross-chapter scenarios, and a weight-aware plan. Keep review recall IDs `rev-dNN` or `rev-sNN`; review items are not chapter objective coverage.

## Verification gate

Run from repository root:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\tools\verify.ps1
```

`tools\verify.ps1` has 33 normal Add-Check gates. Require exit code 0 and zero failures before committing. Gate enforces objective coverage both directions, cross-file glossary anchors, recall/MCQ integrity, steps and model contracts, favicon and unique descriptions, and progressive enhancement, plus registry/disk parity, navigation, diagrams, static restrictions, and classic scripts. Conditional SKIP lines are informational; never ignore FAIL.

## Finish

Check all cited paths, IDs, classes, counts, anchors, and chapter links against shipped files. Open pages directly via `file://`; verify dark/light/print rendering, keyboard focus, visible matrices, and answer readability with JavaScript disabled. Human-review facts, answer keys, rationales, glossary first-use choice, and component teaching quality. Commit only after verifier passes.
