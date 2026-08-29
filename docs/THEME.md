# Shared platform theme

Platform contract for standalone certification and topic note sets. Pages run directly from local `file://` URLs; no web server is required.

## Directory layout

```text
index.html                 root launcher
assets/theme.css            shared layout, components, and tokens
assets/theme.js             shared theme boot and toggle
assets/registry.js          author-side metadata source; never required by readers
tools/verify.ps1            author-side drift checker; never required by readers
docs/THEME.md               this platform specification
docs/NEW-TOPIC.md           topic creation runbook
topics/<slug>/              one self-contained topic
  index.html                topic hub
  topic.css                 topic identity token overrides
  <chapter>.html            chapter pages
```

Do not add a second copy of shared CSS to any page. `assets/theme.css` is the only shared stylesheet. `assets/registry.js` is authoritative metadata for tooling and future generation; static pages do not load it at runtime. Run `tools/verify.ps1` after metadata or page changes.

## Required head blocks

Every document starts with `<!doctype html>` and uses `<html lang="en" data-theme="dark">`. Head children appear in this order. Root launcher paths are:

```html
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>[Page title]</title>
<script src="assets/theme.js"></script>
<link rel="stylesheet" href="assets/theme.css">
</head>
```

A topic page is at depth 2 under `topics/<slug>/`:

```html
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>[Topic page title]</title>
<script src="../../assets/theme.js"></script>
<link rel="stylesheet" href="../../assets/theme.css">
<link rel="stylesheet" href="topic.css">
</head>
```

No `/assets/...` paths. Root-relative URLs fail when pages open directly from `file://`.

## Accessibility and shell contract

Every page puts this exact link as first `<body>` child:

```html
<a class="skip" href="#main">Skip to content</a>
```

`<main id="main">` is required. Shared `:focus-visible` uses a 2px accent outline, 2px offset, and 3px radius. Informative inline diagrams use `role="img"` and a useful `aria-label`; decorative SVGs use `aria-hidden="true"` and `focusable="false"`. Header-row table cells use `scope="col"`; row headers use `scope="row"`.

Use existing shell classes: `.top`, `.top-inner`, `.site`, `.top-links`, `.wrap`, `header.head`, `.pills`, `.pill`, `nav.toc`, `section.card`, `.grid`, `.grid > .card`, `.foot`, `.theme-toggle`, `.theme-label`, `.icon`, and `.card-icon`. Keep toggle last in `.top-links`. Grid cards are flex columns with `padding: 16px`; their direct link is flexible, and direct child `.pills` uses `margin-top: auto; padding-top: 10px` for bottom alignment. Links in prose retain underlines; colour is not sole link indication. Controls meet shipped 24px minimum tap-target sizing.

## Theme behavior

Dark is default. `assets/theme.js` synchronously reads localStorage key `dls-theme`, accepts only `light` or `dark`, sets `data-theme` before paint, and syncs the toggle label and `aria-pressed`. Storage errors fall back silently. LocalStorage is scoped by file URL in browsers, so theme choice will often NOT persist from one standalone page URL to another.

Verified `file://` constraints: local JSON `fetch()` is CORS-blocked in Chrome, Edge, and Firefox; `<script type="module">` also fails for this offline use. Do not depend on either. Classic scripts work. Readers must be able to read notes with JavaScript disabled.

`--sticky: 92px` is shared token. All `[id]` targets use `scroll-margin-top: var(--sticky)`; `h2` follows same offset convention. Reduced motion overrides smooth scrolling:

```css
:focus-visible { outline: 2px solid var(--accent); outline-offset: 2px; border-radius: 3px; }
[id] { scroll-margin-top: var(--sticky); }
@media (prefers-reduced-motion: reduce) { html { scroll-behavior: auto; } }
```

Print is paper-first: print tokens use white backgrounds, dark readable text, print-safe borders, hidden navigation/toggle/skip UI, transparent cards, no dark theme, and visible underlined links. Tables lose the screen minimum width and overflow wrapper.

## Token contract

`assets/theme.css` defines complete dark and light root token blocks. Keep token names unchanged.

| Token | Meaning |
| --- | --- |
| `--bg` | page background |
| `--surface` | primary card and bar surface |
| `--surface-2` | secondary surface and controls |
| `--border` | borders and separators |
| `--text` | primary text |
| `--muted` | secondary text |
| `--accent` | identity and link color |
| `--accent-soft` | softer identity color |
| `--accent-dim` | identity tint |
| `--good` | positive callout color |
| `--warn` | warning callout color |
| `--good-dim` | positive callout tint |
| `--warn-dim` | warning callout tint |
| `--hook-dim` | memory-hook callout tint |
| `--row` | alternating table-row background |
| `--code` | code background |
| `--radius` | shared corner radius |
| `--maxw` | shared content max width |
| `--sticky` | sticky bar and target offset, `92px` |
| `--font` | UI and heading font stack |
| `--font-serif` | reading-text font stack |
| `--mono` | code font stack |

Callouts use `.cal` plus `.confuse`, `.clue`, or `.hook`; each variant changes border, label, and tint so meaning is not colour-only. Reading prose inside cards is capped at `72ch`.

Colour literals belong in root token blocks or a topic token override. A topic `topic.css` may contain a leading comment, `:root`, and `:root[data-theme="light"]` token overrides. It must not contain layout rules, component selectors, or media queries.

## Relative assets and static rules

No `@font-face`, remote stylesheet, remote script, remote image, or other remote asset. Font stacks fall back locally. Source files stay ASCII-only; HTML encodes punctuation with entities such as `&mdash;`, `&ndash;`, `&middot;`, `&larr;`, and `&rarr;`. No inline `<style>` blocks. `assets/registry.js` may be loaded only as a future classic script feature, never required for page reading.

## Study markup contract

Study markup is stable, semantic HTML. A chapter body carries `data-chapter`, `data-domain`, and `data-weight`. Recall answers use `<details class="recall-item" data-recall="cNN-rMM" data-objective="az900-cNN-oM">`; multiple-choice answers use `data-mcq="cNN-qMM"` and `data-objective="..."`. IDs are unique across the repository. Objective-linked answers carry one or more `data-objective` values from the registry. The `#skills` list uses one `id="az900-cNN-oM"` on every objective `<li>`.

Every study-enabled chapter, the review page, and the topic hub provide exactly one `<div id="study-summary"></div>` mount and exactly one trailing `<script src="../../assets/study.js"></script>` reference. `study.js` is OPTIONAL progressive enhancement: attempt, confidence, self-grade, and Leitner controls are conveniences; all prompts and answer content remain readable with JavaScript disabled.

All JavaScript uses ES2026 syntax in classic scripts: never modules. `import` is CORS-blocked from `file://`, so do not use `<script type="module">`, module imports, or a fetch-based runtime contract. `localStorage` is scoped per file URL. Study state does not follow the reader between pages opened from disk, but works normally on the hosted GitHub Pages copy.

## Registry and verification

`assets/registry.js` directly assigns one `globalThis.LEARNING_SYSTEM` object in a classic script. It stores the certification manifest, objective registry, ordered chapter map, section archetypes, question contract, diagram catalogue, confusion sets, and study policy. It is author-side single source of truth, not a runtime dependency.

`tools/verify.ps1` extracts registry metadata text and validates registry JavaScript syntax with Node when available. It checks registry/disk chapter parity, navigation chain, exact launcher and hub href order, objective coverage, question IDs/counts, skills-bullet IDs, confusion targets, SVG geometry, study contract, JavaScript-disabled readability, classic-script syntax, static HTML restrictions, same-file anchors, skip/main contracts, and shared asset references. It prints PASS/FAIL/SKIP counts and exits non-zero on any failure.


## Learning affordance contracts

These components are presentation contracts. Keep their content in static HTML so the page remains useful with JavaScript disabled.

### TL;DR card

Every chapter starts its `<main>` with one TL;DR card, and its TOC includes a pill linking to `#tldr`:

```html
<nav class="toc"><a href="#tldr">In one minute</a></nav>
<main id="main"><section class="card tldr" id="tldr"><h2>In one minute</h2><ul>
<li>Choose a VM when guest OS control is required; choose a managed host when that boundary is not required.</li>
<li>Use a subscription for billing and access boundaries; use a resource group for lifecycle grouping.</li>
<li>Use a private endpoint for a private VNet path; configure public network access separately.</li>
<li>Use a region pair for selected cross-region continuity features; pairing alone does not guarantee failover.</li>
</ul></section>
```

Use 4-6 bullets. Each bullet states a rule and its boundary: what to choose or conclude, plus the condition, limit, exception, or scope that prevents overgeneralization. A topic label alone is not a TL;DR rule.

### Misconception closure

Use `.cal.myth` for a short misconception-closure callout. Label it `Common wrong turn`, quote the false belief, then correct it:

```html
<div class="cal myth"><span class="lbl">Common wrong turn</span><p><strong>&ldquo;Adding a private endpoint automatically disables public access.&rdquo;</strong> &mdash; It adds a private VNet path; public network access remains a separate setting.</p></div>
```

`.cal.confuse` states the rule or discriminator. `.cal.myth` closes a wrong inference by naming the belief and correcting it. Use no more than 2-3 myth callouts per chapter.

### Causal steps

Use `.steps` only for a genuine ordered causal path. It is an ordered list of expandable details; first item is open, remaining items are closed:

```html
<ol class="steps"><li><details class="more" open><summary>1. Request targets a private IP.</summary><p>The private endpoint exposes a private IP in the VNet.</p></details></li><li><details class="more"><summary>2. Private Link carries the request.</summary><p>The private path reaches the Azure service.</p></details></li><li><details class="more"><summary>3. Public access is configured separately.</summary><p>Disable public network access separately when required.</p></details></li></ol>
```

Step text must still read as an ordered sequence with JavaScript off. Chapters 01, 02, and 03 correctly have no causal sequence. Do not force `.steps` into a chapter when no genuine ordered path exists; omission is better than a false process.

### First-use glossary links

Link the first substantive prose use of a glossary term to its canonical definition:

```html
<p>A <a href="glossary.html#g-private-endpoint">private endpoint</a> maps an Azure service to a private IP in a VNet.</p>
```

Do not place these links in headings, table headers, `summary`, MCQ stems or options, or TL;DR content. Use only the first substantive prose occurrence; later uses need no link. Glossary ids use `g-` plus the term lowercased, with each run of non-alphanumeric characters collapsed to one hyphen and edge hyphens removed. Example: `Private endpoint` becomes `g-private-endpoint`.

### Objective-linked recall

Recall items carry one or more objective ids, just like MCQ answer panels:

```html
<details class="more recall-item" data-recall="c05-r10" data-objective="az900-c05-o6"><summary>What does a private endpoint provide?</summary><p>A private IP on a VNet network interface through Private Link.</p></details>
```

`data-objective` enables objective-level weakness reporting. Use registry objective ids, separated by spaces when an item tests more than one objective.

### Portable study brief

Each study-enabled page has exactly one `<div id="study-summary"></div>` mount. `study.js` optionally enhances it with controls and a read-only visible textarea. The script serialises current study state as copyable Markdown: weak objectives rank by miss rate, and high-confidence misses receive a `[HIGH-CONFIDENCE MISS]` marker. The brief is intended to be pasted to an LLM to request targeted practice.

This is optional progressive enhancement, not content delivery. The visible textarea is the primary copy path because clipboard access is unreliable under `file://`; a failed clipboard attempt must not remove or hide the text. `localStorage` is per file URL: state does not accumulate across pages opened from disk, but does accumulate across pages on the hosted copy. Pages and answers remain readable with JavaScript disabled.

### CSS contract

Use shipped selectors without inline styles or new component names. `.tldr` extends `section.card` with an accent left border and compact list spacing. `.cal.myth` extends `.cal` with the myth border and tint tokens; its text label remains visible, so colour is not its only meaning. `.steps` removes the default list treatment, supplies numbered markers and a connector, and wraps each item in `details.more`. `.study-summary` styles the optional metrics, high-confidence miss list, copy controls, reset controls, and read-only textarea; print rules hide study controls without hiding answers.
