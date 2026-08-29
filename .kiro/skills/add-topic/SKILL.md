---
name: add-topic
description: Add certification topics with registry-first objectives, static chapter pages, study markers, diagrams, questions, and verifier checks.
---
# Add a certification topic

Use this skill for `$ARGUMENTS`. Treat `$ARGUMENTS` as certification being added, for example `AWS Cloud Practitioner`.

## Non-negotiable ownership

- Create one self-contained folder: `topics/<slug>/`.
- Include `topic.css`, `index.html` hub, numbered chapter pages, `review.html`, and `glossary.html`.
- `assets/theme.css` and `assets/theme.js` are platform-owned. NEVER edit them for a new topic.
- Topic visual identity lives only in three accent token pairs in `topic.css`:
  `--accent`, `--accent-soft`, and `--accent-dim` in dark and light `:root` blocks.
- `topic.css` may have a leading comment and those token overrides only. No layout, component selectors, or media queries.
- One intentional manual platform exception: add the topic card to root `index.html`.
- Do not duplicate shared CSS. No build step, framework, or npm.

## Required page shell

Every topic document starts with `<!doctype html>` and `<html lang="en" data-theme="dark">`.
A depth-2 page under `topics/<slug>/` uses this exact head block:

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

`../../assets/theme.js` is a classic script and comes before both stylesheets. Use sibling `topic.css`.
End every study-enabled chapter, hub, and review page with:

```html
<script src="../../assets/study.js"></script>
```

Keep the script trailing, immediately before `</body>`. The hub and review have one
`<div id="study-summary"></div>` mount. Study content remains readable with JavaScript disabled.

First body child must be exactly:

```html
<a class="skip" href="#main">Skip to content</a>
```

Use `<main id="main">`. Use the shipped top bar contract: `.top`, `.top-inner`, `.site`,
`.top-links`, Home link to `../../index.html`, topic link to `index.html`, chapter Prev/Next
links, and the theme toggle last. Copy this toggle markup verbatim from `docs/NEW-TOPIC.md`:

```html
<button type="button" class="theme-toggle" id="theme-toggle" title="Switch between dark and light theme"><svg class="icon icon-moon" viewBox="0 0 24 24" width="1em" height="1em" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true" focusable="false"><path d="M20 14.5A8.5 8.5 0 0 1 9.5 4a8.5 8.5 0 1 0 10.5 10.5Z"/></svg><svg class="icon icon-sun" viewBox="0 0 24 24" width="1em" height="1em" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true" focusable="false"><path d="M12 4.2V2.5M12 21.5v-1.7M4.2 12H2.5M21.5 12h-1.7M6.5 6.5 5.3 5.3M18.7 18.7l-1.2-1.2M6.5 17.5l-1.2 1.2M18.7 5.3l-1.2 1.2M12 7.8a4.2 4.2 0 1 0 0 8.4 4.2 4.2 0 0 0-0 8.4Z"/></svg><span class="theme-label">Dark</span></button>
```

## Order of work

1. Ingest official exam guide. Fill certification manifest: vendor, exam code, display name,
   skills-measured date, official guide URL, domains, and weight ranges.
2. Build objective registry before writing prose. Use stable IDs in the form
   `<exam>-c<NN>-o<M>`; copy official wording exactly into objective `text`.
3. Build ordered chapter map: real filenames, titles, domains, weights, objective IDs,
   section IDs, section archetypes, and practice counts.
4. Then write chapter, hub, review, glossary, diagram, and question content.

Registry-first prevents drift: pages reference already-defined IDs, chapters, sections, and
counts. Verifier checks coverage in both directions, so prose cannot silently create or lose
objectives.

## Chapter contract

Every chapter follows this order:

`#skills` -> 4 to 6 body sections -> `#mcq` -> `#recall`

Each body section uses one closed section archetype from the registry:
`concept`, `process`, `comparison`, `decision`, `worked-scenario`, `callout`, `diagram`,
`mcq-set`, or `active-recall`. Registry `sectionIds` and `sectionArchetypes` must match real
HTML IDs. Chapter body carries `data-chapter`, `data-domain`, and `data-weight`.

Required machine-readable markers:

- Every objective bullet: `<li id="<exam>-cNN-oM">` inside `#skills`.
- Every answer panel: `data-mcq="cNN-qMM"` and one or more `data-objective` values.
- Every recall item: `data-recall="cNN-rMM"`.
- Every study page: one study-summary mount and trailing `../../assets/study.js`.

Use four answer strings per MCQ, required key/rationales, and counts declared in registry.
Keep prose in pages; registry stores contracts and metadata.

## Registry: all seven layers

Register topic and hub path in `assets/registry.js`. Fill all seven author-side layers:

1. certification manifest;
2. objective registry;
3. ordered chapter map;
4. closed section-archetype enum;
5. question schema and counts;
6. diagram catalogue, archetypes, uses, and geometry rules;
7. confusion sets plus study policy.

Use only source-supported confusion sets. Record callout chapter and resolved hub target
separately. Catalogue every diagram under a real archetype with nodes, labels, edges, groups,
and checkable geometry rules.

## Hard static constraints

- ASCII-only source. Encode punctuation with HTML entities such as `&mdash;`, `&ndash;`,
  `&middot;`, `&larr;`, and `&rarr;`.
- Relative paths only. Root-relative `/assets/...` breaks direct `file://` use.
- No remote assets, remote stylesheet, remote script, remote image, `@font-face`, inline
  `<style>`, module scripts, or `import`/fetch runtime dependencies.
- JavaScript uses ES2026 syntax in CLASSIC scripts only. `import` is CORS-blocked from
  `file://`; registry remains author-side data, not reader runtime code.
- Colour literals belong only in root token blocks or topic token override.
- Pages must remain readable with JavaScript disabled.

## Finish

Run from repository root:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\tools\verify.ps1
```

Require exit code 0 and zero failures. Fix every FAIL. Check direct `file://` opening,
anchors, Prev/Next chain, dark/light/print rendering, keyboard focus, diagrams, and answer
readability. Commit only after verification passes and human review covers facts, keys,
rationales, and visual teaching value.
