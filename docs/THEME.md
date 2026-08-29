# Shared platform theme

Platform contract for standalone certification and topic note sets. Pages run from local `file://` URLs; no web server is required.

## Directory layout

```text
index.html                 root launcher
assets/theme.css            shared layout, component, and token CSS
assets/theme.js             shared theme boot and toggle
docs/THEME.md              this platform specification
docs/NEW-TOPIC.md           topic creation runbook
topics/<slug>/              one self-contained topic
  index.html                topic hub
  topic.css                 topic identity token overrides
  <chapter>.html            chapter pages
```

Do not add a second copy of shared CSS to any page. `assets/theme.css` is the only shared stylesheet.

## Required head blocks

Every document starts with `<!doctype html>` and uses `<html lang="en" data-theme="dark">`. Head children must appear in this exact order. The root launcher uses root-relative-to-document paths:

```html
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>[Page title]</title>
<script src="assets/theme.js"></script>
<link rel="stylesheet" href="assets/theme.css">
</head>
```

A topic page is at depth 2 under `topics/<slug>/`, so it uses these exact paths. Keep `topic.css` after shared CSS so identity overrides win:

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

Do not use `/assets/...` paths. Root-relative URLs begin at a server origin and fail for direct `file://` opening. Use the relative paths above.

## Theme behavior

Dark is the default. `assets/theme.js` synchronously reads localStorage key `dls-theme`, accepts only `light` or `dark`, and sets `data-theme` on `document.documentElement`. Storage failures degrade silently to dark. The script binds `#theme-toggle` after DOM readiness, flips the theme, persists the accepted value, and updates `.theme-label` to `Light` or `Dark`.

## Token contract

`assets/theme.css` defines both complete root token blocks: `:root` for dark and `:root[data-theme="light"]` for light. Keep token names unchanged.

| Token | Meaning |
| --- | --- |
| `--bg` | page background |
| `--surface` | primary card and bar surface |
| `--surface-2` | secondary surface and controls |
| `--border` | borders and separators |
| `--text` | primary text |
| `--muted` | secondary text |
| `--accent` | primary identity and link color |
| `--accent-soft` | softer identity color |
| `--accent-dim` | translucent identity background |
| `--good` | positive callout color |
| `--warn` | warning callout color |
| `--row` | alternating table-row background |
| `--code` | code background |
| `--radius` | shared corner radius |
| `--maxw` | shared content max width |
| `--font` | UI and heading font stack |
| `--font-serif` | reading-text font stack |
| `--mono` | code font stack |

Colour literals may appear only inside the two `:root` blocks in `assets/theme.css` or inside a topic CSS override. A topic `topic.css` may contain only `:root` and `:root[data-theme="light"]` token overrides, normally changing `--accent`, `--accent-soft`, and `--accent-dim`. It must contain no layout rules, component selectors, or media queries. New topics change those identity values to get their own look; shared structure stays in `assets/theme.css`.

## Shell class contract

Use existing shared shell classes. Do not invent parallel layout classes.

- `.top`, `.top-inner`, `.site`, `.top-links`: sticky top bar, site label, navigation, and toggle.
- `.wrap`: centered content wrapper.
- `header.head`: page title block containing `h1`, `p.kicker`, and `.pills`.
- `.pills`, `.pill`: compact metadata groups and labels.
- `nav.toc`: in-page table of contents links.
- `section.card`: content surface.
- `.grid`: responsive card grid.
- `.grid > .card`: grid item; its link wraps `h3` and `p`.
- `.foot`: footer line.
- `.theme-toggle`, `.theme-label`: shared theme control.
- `.icon`, `.card-icon`: inline decorative icon sizing and paint.

Keep the toggle as the last useful control in `.top-links`. Decorative SVGs use `aria-hidden="true"` and `focusable="false"`. Inline SVG paint must use `currentColor` or semantic `var(--token)` values; do not add literal color values to SVG markup.

## Text and asset rules

All source files must be ASCII-only. In HTML, encode non-ASCII punctuation and symbols with entities such as `&mdash;`, `&ndash;`, `&middot;`, `&larr;`, `&rarr;`, `&times;`, `&hellip;`, and named or numeric entities as needed. Do not paste Unicode punctuation into HTML.

No `@font-face`, remote stylesheet, remote script, remote image, or other remote asset. Font stacks in the shared CSS fall back to local system fonts. Keep links and assets usable when a page is opened directly from disk.

## Reusable icon SVG library

Use one decorative icon before each owned-file `h2`, or reuse an icon in a launcher card. Keep square `viewBox`, `em` sizing, `currentColor` stroke, `aria-hidden="true"`, and `focusable="false"`.

```html
<svg class="icon icon-cloud" viewBox="0 0 24 24" width="1em" height="1em" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" vector-effect="non-scaling-stroke" aria-hidden="true" focusable="false"><path d="M7.5 18.5h9a4 4 0 0 0 .7-7.94A6 6 0 0 0 5.6 9.9 3.5 3.5 0 0 0 7.5 18.5Z"/></svg>
<svg class="icon icon-list" viewBox="0 0 24 24" width="1em" height="1em" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" vector-effect="non-scaling-stroke" aria-hidden="true" focusable="false"><path d="M8 6h11M8 12h11M8 18h11M4 6h.01M4 12h.01M4 18h.01"/></svg>
<svg class="icon icon-layers" viewBox="0 0 24 24" width="1em" height="1em" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" vector-effect="non-scaling-stroke" aria-hidden="true" focusable="false"><path d="m4 8 8-4 8 4-8 4-8-4Zm0 4 8 4 8-4M4 16l8 4 8-4"/></svg>
<svg class="icon icon-shield" viewBox="0 0 24 24" width="1em" height="1em" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" vector-effect="non-scaling-stroke" aria-hidden="true" focusable="false"><path d="M12 3 19 6v5c0 4.5-2.8 7.8-7 10-4.2-2.2-7-5.5-7-10V6l7-3Z"/><path d="m9 12 2 2 4-4"/></svg>
<svg class="icon icon-database" viewBox="0 0 24 24" width="1em" height="1em" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" vector-effect="non-scaling-stroke" aria-hidden="true" focusable="false"><ellipse cx="12" cy="5" rx="7" ry="3"/><path d="M5 5v7c0 1.7 3.1 3 7 3s7-1.3 7-3V5M5 12v7c0 1.7 3.1 3 7 3s7-1.3 7-3v-7"/></svg>
<svg class="icon icon-network" viewBox="0 0 24 24" width="1em" height="1em" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" vector-effect="non-scaling-stroke" aria-hidden="true" focusable="false"><circle cx="12" cy="5" r="2"/><circle cx="5" cy="18" r="2"/><circle cx="19" cy="18" r="2"/><path d="m11 7-5 9m7-9 5 9M7 18h10"/></svg>
<svg class="icon icon-coin" viewBox="0 0 24 24" width="1em" height="1em" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" vector-effect="non-scaling-stroke" aria-hidden="true" focusable="false"><circle cx="12" cy="12" r="8"/><path d="M14.5 9.5c-.5-.7-1.3-1-2.5-1-1.4 0-2.5.7-2.5 1.8 0 2.7 5 1.1 5 3.8 0 1.1-1 1.9-2.5 1.9-1.2 0-2.1-.4-2.7-1.1M12 7v10"/></svg>
<svg class="icon icon-scales" viewBox="0 0 24 24" width="1em" height="1em" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" vector-effect="non-scaling-stroke" aria-hidden="true" focusable="false"><path d="M12 4v16M6 20h12M4 7h16M6 7l-3 6a3 3 0 0 0 6 0L6 7Zm12 0-3 6a3 3 0 0 0 6 0l-3-6Z"/></svg>
<svg class="icon icon-terminal" viewBox="0 0 24 24" width="1em" height="1em" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" vector-effect="non-scaling-stroke" aria-hidden="true" focusable="false"><rect x="3" y="4" width="18" height="16" rx="2"/><path d="m7 9 3 3-3 3m5 0h5"/></svg>
<svg class="icon icon-chart" viewBox="0 0 24 24" width="1em" height="1em" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" vector-effect="non-scaling-stroke" aria-hidden="true" focusable="false"><path d="M4 19V5M4 19h16M7 16l3-4 3 2 5-7"/></svg>
<svg class="icon icon-question" viewBox="0 0 24 24" width="1em" height="1em" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" vector-effect="non-scaling-stroke" aria-hidden="true" focusable="false"><circle cx="12" cy="12" r="9"/><path d="M9.7 9a2.4 2.4 0 1 1 3.9 1.9c-1 .8-1.6 1.2-1.6 2.6M12 17h.01"/></svg>
<svg class="icon icon-brain" viewBox="0 0 24 24" width="1em" height="1em" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" vector-effect="non-scaling-stroke" aria-hidden="true" focusable="false"><path d="M9 4a3 3 0 0 0-3 3 3 3 0 0 0-2 5 3 3 0 0 0 2 5 3 3 0 0 0 3 3m6-16a3 3 0 0 1 3 3 3 3 0 0 1 2 5 3 3 0 0 1-2 5 3 3 0 0 1-3 3M9 4v16m6-16v16M9 8h2m2 0h2M9 14h2m2 0h2"/></svg>
<svg class="icon icon-leaf" viewBox="0 0 24 24" width="1em" height="1em" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" vector-effect="non-scaling-stroke" aria-hidden="true" focusable="false"><path d="M19 4C9 4 5 8 5 14c0 3 2 5 5 5 6 0 10-5 9-15Z"/><path d="M5 19c2-4 5-7 10-9"/></svg>
```
