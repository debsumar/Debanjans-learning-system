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

Study markup is stable, semantic HTML. A chapter body carries `data-chapter`, `data-domain`, and `data-weight`. Recall answers use `<details class="recall-item" data-recall="cNN-rMM">`; multiple-choice answers use `data-mcq="cNN-qMM"`. IDs are unique across the repository. Objective-linked answers carry one or more `data-objective` values from the registry. The `#skills` list uses one `id="az900-cNN-oM"` on every objective `<li>`.

Every study-enabled chapter, the review page, and the topic hub provide exactly one `<div id="study-summary"></div>` mount and exactly one trailing `<script src="../../assets/study.js"></script>` reference. `study.js` is OPTIONAL progressive enhancement: attempt, confidence, self-grade, and Leitner controls are conveniences; all prompts and answer content remain readable with JavaScript disabled.

All JavaScript uses ES2026 syntax in classic scripts: never modules. `import` is CORS-blocked from `file://`, so do not use `<script type="module">`, module imports, or a fetch-based runtime contract. `localStorage` is scoped per file URL. Study state does not follow the reader between pages opened from disk, but works normally on the hosted GitHub Pages copy.

## Registry and verification

`assets/registry.js` directly assigns one `globalThis.LEARNING_SYSTEM` object in a classic script. It stores the certification manifest, objective registry, ordered chapter map, section archetypes, question contract, diagram catalogue, confusion sets, and study policy. It is author-side single source of truth, not a runtime dependency.

`tools/verify.ps1` extracts registry metadata text and validates registry JavaScript syntax with Node when available. It checks registry/disk chapter parity, navigation chain, exact launcher and hub href order, objective coverage, question IDs/counts, skills-bullet IDs, confusion targets, SVG geometry, study contract, JavaScript-disabled readability, classic-script syntax, static HTML restrictions, same-file anchors, skip/main contracts, and shared asset references. It prints PASS/FAIL/SKIP counts and exits non-zero on any failure.
