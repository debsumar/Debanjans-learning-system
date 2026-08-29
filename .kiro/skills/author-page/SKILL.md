---
name: author-page
description: Author accessible offline topic pages with shipped shell, CSS vocabulary, study markup, and verification rules.
---

# Author a topic page

Use this runbook when `$ARGUMENTS` asks for a new topic page or a rewrite.
Read `docs/THEME.md`, the closest shipped topic page, `assets/theme.css`, and
`assets/study.js` before writing. Ground every convention in shipped code.

## Depth-2 head contract

Use this exact head block for a page at `topics/<slug>/<page>.html`:

```html
<!doctype html>
<html lang="en" data-theme="dark">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="[One ASCII sentence describing page contents.]">
<title>[Topic page title]</title>
<link rel="icon" href="data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16'%3E%3Cpath fill='%23d97757' d='M2 4l6-2 6 2-6 2-6-2Zm0 3 6 2 6-2v3l-6 2-6-2V7Z'/%3E%3C/svg%3E">
<script src="../../assets/theme.js"></script>
<link rel="stylesheet" href="../../assets/theme.css">
<link rel="stylesheet" href="topic.css">
</head>
```

Keep charset first so decoding is known immediately. Keep viewport next so
mobile layout uses the device width. Put the title before runtime assets for
clear document metadata. Load `../../assets/theme.js` as a classic script,
with no `defer` or `async`, before stylesheets: it sets `data-theme` before
paint, preventing a theme flash. Load shared `theme.css` next so platform
components exist. Load sibling `topic.css` last so only topic token overrides
can follow shared tokens. Never use root-relative `/assets` paths: under
`file://`, they resolve at the filesystem root and 404.

## Page shell

Use `<a class="skip" href="#main">Skip to content</a>` as the first body
child. Include the sticky top bar, then the page content, then `<footer class="foot">`.
Use `<main id="main">`. Keep Home and topic links in `.top-links`. Keep the
theme toggle last in that link group, using this shipped markup verbatim:

```html
<button type="button" class="theme-toggle" id="theme-toggle" title="Switch between dark and light theme"><svg class="icon icon-moon" viewBox="0 0 24 24" width="1em" height="1em" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true" focusable="false"><path d="M20 14.5A8.5 8.5 0 0 1 9.5 4a8.5 8.5 0 1 0 10.5 10.5Z"/></svg><svg class="icon icon-sun" viewBox="0 0 24 24" width="1em" height="1em" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true" focusable="false"><path d="M12 4.2V2.5M12 21.5v-1.7M4.2 12H2.5M21.5 12h-1.7M6.5 6.5 5.3 5.3M18.7 18.7l-1.2-1.2M6.5 17.5l-1.2 1.2M18.7 5.3l-1.2 1.2M12 7.8a4.2 4.2 0 1 0 0 8.4 4.2 4.2 0 0 0 0-8.4Z"/></svg><span class="theme-label">Dark</span></button>
```

End the page with `<div id="study-summary"></div>` in the study content,
then make `<script src="../../assets/study.js"></script>` the last thing
before `</body>`. This script is optional enhancement, not content delivery.

## Component vocabulary

Pages compose from these real `assets/theme.css` components. Never invent CSS.
No inline `<style>`, ever.

- `.top`, `.top-inner`, `.site`, `.top-links`: sticky bar, inner layout, site name, links.
- `header.head`, `h1`, `.kicker`, `.pills`, `.pill`: page heading, title, supporting line, metadata row, metadata chip.
- `nav.toc`: in-page navigation chips.
- `section.card`: primary bordered content section.
- `.grid` and `.grid > .card`: responsive card layout and card treatment.
- `dl.defs`: definition term and explanation grid.
- `.tw` plus `table.t`: horizontal table wrapper and shared table styling.
- `.cal` with `.confuse`, `.clue`, `.hook`: callout base and warning, exam-clue, memory-hook variants.
- `details.more`: expandable answer or extra explanation.
- `.icon`, `.card-icon`: inline decorative icon and card-heading icon sizing.
- `.foot`: footer text and separator.
- `.skip`: keyboard skip link, hidden until focused.
- `.study-row`, `.study-summary`: optional study controls and summary mount.

## Required page shape

Section archetypes are a closed enum: `concept`, `process`, `comparison`,
`decision`, `worked-scenario`, `callout`, `diagram`, `mcq-set`, and
`active-recall`. Choose only these labels when planning sections.

Required skeleton: `#skills` -> 4-6 body sections -> `#mcq` -> `#recall`.
Use a TOC only for real anchors. Put official objective bullets in `#skills`.
Use `section.card` for each major section. Put questions in `#mcq` and
recall prompts in `#recall`; keep every answer in the HTML.

## Accessibility and static rules

- Put `scope="col"` on every header-row `<th>`; use `scope="row"` for row headers.
- Give every informative diagram `role="img"` and a useful `aria-label`.
- Give every decorative icon `aria-hidden="true"` and `focusable="false"`.
- Give every filter a visible labelled input and a `role="status"` live region.
- Keep heading order correct; never skip heading levels.
- Use ASCII source only. Encode punctuation as `&mdash;`, `&middot;`, `&ndash;`, `&larr;`, and `&rarr;`.
- Use relative paths only. Use no remote assets, `@font-face`, or root-relative URLs.
- Use ES2026 syntax only in classic scripts. Never use modules: `import` is
  CORS-blocked from `file://`. Keep colour literals only inside `:root` blocks.
- Presentation belongs in `assets/`; do not duplicate shared CSS in pages.

## Progressive enhancement and finish

Progressive enhancement is mandatory. Page must be fully readable with
JavaScript disabled. Never hide answer content behind a class added only by
`study.js`; `<details>` answers and prompts must remain available in HTML.

Run `tools\verify.ps1` after writing. Require 0 failures. Check ASCII, exact
relative asset paths, unique IDs, shell order, table scopes, diagram labels,
study mounts, trailing study script, and readable answers before handoff.


## Interactive outcome model

Use optional model enhancement only when a static outcome matrix teaches a decision or comparison. Keep one visible `<table class="t model-matrix">` inside `<div class="model" data-model="...">`; first header cell names options, remaining headers name scenarios, row headers name options, and body cells contain outcomes. Static table is sole source of truth. Declare only model ID, owning chapter/section, and row/column dimensions in `assets/registry.js`; never duplicate outcome values there or in `assets/model.js`. Load `../../assets/model.js` after `study.js` when page uses model markup. `tools\verify.ps1` checks rectangular dimensions, non-empty cells, registry-to-page mapping, and runtime derivation. Matrix must remain visible and useful with JavaScript disabled.


Use these exact shipped patterns. Read `docs/THEME.md`, `assets/theme.css`, and `assets/study.js` before authoring.

### TL;DR

Put one TL;DR card first inside `<main>`. Add its TOC pill. Use 4-6 bullets. Each bullet must state a rule and its boundary, not a topic label:

```html
<nav class="toc"><a href="#tldr">In one minute</a></nav>
<main id="main"><section class="card tldr" id="tldr"><h2>In one minute</h2><ul>
<li>Choose a VM when guest OS control is required; choose a managed host when that boundary is not required.</li>
<li>Use a subscription for billing and access boundaries; use a resource group for lifecycle grouping.</li>
<li>Use a private endpoint for a private VNet path; configure public network access separately.</li>
<li>Use a region pair for selected cross-region continuity features; pairing alone does not guarantee failover.</li>
</ul></section>
```

### Myth callout

Use no more than 2-3 per chapter. Quote false belief, then correct it. Label must be `Common wrong turn`. `.cal.confuse` states a rule; `.cal.myth` closes a wrong inference:

```html
<div class="cal myth"><span class="lbl">Common wrong turn</span><p><strong>&ldquo;Adding a private endpoint automatically disables public access.&rdquo;</strong> &mdash; It adds a private VNet path; public network access remains a separate setting.</p></div>
```

### Causal steps

Add only where genuine ordered causality exists. Chapters 01, 02, and 03 correctly have none. Forcing one is worse than omitting it. Use `<ol class="steps">` containing `<details class="more">`; first item open, all later items closed. Text must preserve sequence meaning with JavaScript off:

```html
<ol class="steps"><li><details class="more" open><summary>1. Request targets a private IP.</summary><p>The private endpoint exposes a private IP in the VNet.</p></details></li><li><details class="more"><summary>2. Private Link carries the request.</summary><p>The private path reaches the Azure service.</p></details></li><li><details class="more"><summary>3. Public access is configured separately.</summary><p>Disable public network access separately when required.</p></details></li></ol>
```

### First-use glossary link

Link first substantive prose use only. Never link inside a heading, table header, `summary`, MCQ stem or option, or TL;DR. Use canonical cross-file href and slug rule: `g-` + term lowercased, runs of non-alphanumerics collapsed to single hyphens, edge hyphens removed:

```html
<p>A <a href="glossary.html#g-private-endpoint">private endpoint</a> maps an Azure service to a private IP in a VNet.</p>
```

### Recall objective

Every recall item must carry `data-objective` with one or more real registry ids. Space-separate multiple ids. This tag enables objective-level weakness reporting:

```html
<details class="more recall-item" data-recall="c05-r10" data-objective="az900-c05-o6"><summary>What does a private endpoint provide?</summary><p>A private IP on a VNet network interface through Private Link.</p></details>
```

### Portable study brief

Keep exactly one `<div id="study-summary"></div>` on every study-enabled page, before the trailing `study.js` script. `study.js` is optional progressive enhancement. It serialises study state to Markdown in a visible read-only textarea, ranking weak objectives by miss rate and marking high-confidence misses for LLM-targeted practice. Visible textarea is primary because clipboard access is unreliable under `file://`. `localStorage` is per file URL: disk-opened pages do not share state, hosted pages do. Never make content depend on the brief or on JavaScript.


## Interactive learning model contract

Use a model only when a page has a useful outcome prediction. Read `assets/model.js` and `assets/theme.css` first. Add this exact shape, replacing labels and values while preserving the structure:

```html
<div class="model" data-model="example-id" data-model-rows="Option" data-model-cols="Scenario">
  <div class="tw"><table class="t model-matrix">
    <thead><tr><th scope="col">Option</th><th scope="col">Scenario A</th><th scope="col">Scenario B</th></tr></thead>
    <tbody>
      <tr><th scope="row">Choice A</th><td>Outcome one</td><td>Outcome two</td></tr>
      <tr><th scope="row">Choice B</th><td>Outcome two</td><td>Outcome one</td></tr>
    </tbody>
  </table></div>
</div>
```

Contract: matrix is source of truth. Column headers are scenarios; row headers are options; cells are outcomes. Keep matrix rectangular, cells non-empty, at least 2 option rows, and 2-5 distinct outcomes. `model.js` derives controls and verdict from matrix and hardcodes no domain facts. This prevents a hardcoded widget from silently disagreeing with notes. Harness asks learner to predict before reveal to use generation effect: generating an answer strengthens retrieval more than passive reading. Static table stays visible and useful with JavaScript disabled; never hide `.model-matrix` or any model table with CSS.

On model pages, load exactly one trailing classic script after study.js:

```html
<script src="../../assets/study.js"></script>
<script src="../../assets/model.js"></script>
```

## Offline head metadata contract

Add exactly one inline SVG data-URI favicon per page. Its `href` starts with `data:image/svg+xml,` and never uses a remote URL. Encode SVG markup for attribute-safe ASCII:

```html
<link rel="icon" href="data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16'%3E%3Crect width='16' height='16' rx='3' fill='%23d97757'/%3E%3Cpath d='M4 4h8v8H4z' fill='%23141413'/%3E%3C/svg%3E">
```

Add exactly one non-empty, unique description for every page. Describe page-specific learning content; do not reuse one generic sentence:

```html
<meta name="description" content="AZ-900 notes on Azure storage services, tiers, redundancy, and transfer tools.">
```
