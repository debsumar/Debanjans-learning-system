# Add a topic

Use this runbook to add one self-contained topic without duplicating platform CSS. Adding topic costs one folder plus one intentional manual launcher edit; platform CSS and JavaScript stay unchanged.

1. Create `topics/<slug>/`.
2. Create `topics/<slug>/topic.css` with only dark/light accent token overrides. A leading comment is allowed; no layout or component rules.
3. Create `topics/<slug>/index.html` as topic hub.
4. Create chapter pages using depth-2 head block and top-bar navigation below.
5. Add one card to root `index.html`. This is the intentional manual platform exception: launcher must expose topic, while shared platform files stay untouched.
6. Add `review.html` for interleaved practice and `glossary.html` for searchable canonical definitions when the topic supports them. Keep the depth-2 shell, relative assets, and static readability.
7. Build the seven registry layers from [`docs/BLUEPRINT.md`](BLUEPRINT.md): certification manifest, objective registry, chapter map, section archetypes, question schema/count contract, diagram catalogue/geometry rules, and confusion sets. Keep study policy as the cross-cutting review policy. Record real page counts, filenames, titles, domains, weights, accents, hub path, description, and pill labels.
8. Check every page is ASCII-only. Use HTML entities for punctuation.
9. Run `tools/verify.ps1`; fix every FAIL before handoff. The verifier checks objective coverage, question IDs/counts, skills IDs, confusion targets, SVG geometry, study contract, progressive enhancement, and classic-script discipline.
10. Open root, hub, review, glossary, and chapter files directly from disk. Check dark/light rendering, labels, focus, anchors, navigation, and JavaScript-disabled readability.

Read [`docs/BLUEPRINT.md`](BLUEPRINT.md) for data-layer sequence, DATA/TEMPLATE boundary, and extension guidance before changing registry metadata.

## Ownership boundary

Platform-owned shell: shared `.top` structure, `.top-inner`, `.top-links`, Home destination, theme toggle markup/behavior, skip link, `main#main`, shared asset references, and component classes. Root platform site text is `Debanjan&rsquo;s Learning System`.

Topic-owned shell text: topic title, description, pills, hub link label, chapter title, and chapter Prev/Next targets. Shipped AZ-900 chapter pages use `AZ-900 Notes` as `.site` text and `AZ-900` as hub link text. Do not copy the old `Debanjan&rsquo;s Learning System` / `Topic hub` wording into a topic chapter block.

`assets/registry.js` is author-owned metadata, not page runtime code. `tools/verify.ps1` is author tooling, not reader code. Readers need neither file to read notes.

## Topic-page head block

Copy exactly for pages inside `topics/<slug>/`:

```html
<!doctype html>
<html lang="en" data-theme="dark">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>[Topic page title]</title>
<script src="../../assets/theme.js"></script>
<link rel="stylesheet" href="../../assets/theme.css">
<link rel="stylesheet" href="topic.css">
</head>
```

No inline `<style>`, inline theme JavaScript, `@font-face`, remote assets, or root-relative `/assets/...` paths.

## Depth-2 top-links block

Use relative links from chapter page or hub at `topics/<slug>/` depth. Replace topic-specific and chapter-specific placeholders; keep platform shell and toggle markup:

```html
<div class="top"><div class="top-inner"><div class="site">AZ-900 Notes</div><div class="top-links"><a href="../../index.html">Home</a><a href="index.html">AZ-900</a><a href="[previous-file]">&larr; Prev</a><a href="[next-file]">Next &rarr;</a><button type="button" class="theme-toggle" id="theme-toggle" title="Switch between dark and light theme"><svg class="icon icon-moon" viewBox="0 0 24 24" width="1em" height="1em" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true" focusable="false"><path d="M20 14.5A8.5 8.5 0 0 1 9.5 4a8.5 8.5 0 1 0 10.5 10.5Z"/></svg><svg class="icon icon-sun" viewBox="0 0 24 24" width="1em" height="1em" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true" focusable="false"><path d="M12 4.2V2.5M12 21.5v-1.7M4.2 12H2.5M21.5 12h-1.7M6.5 6.5 5.3 5.3M18.7 18.7l-1.2-1.2M6.5 17.5l-1.2 1.2M18.7 5.3l-1.2 1.2M12 7.8a4.2 4.2 0 1 0 0 8.4 4.2 4.2 0 0 0-0 8.4Z"/></svg><span class="theme-label">Dark</span></button></div></div></div>
```

The exact shipped AZ-900 toggle SVG may be copied from an existing page. First chapter Prev points to `index.html`; final chapter Next points to `index.html`. Intermediate links follow registry order.

## Verification checklist

Before handoff:

- Dark theme loads; light theme loads; toggle label and `aria-pressed` update.
- Expect localStorage persistence to be unreliable across standalone `file://` page URLs; current-page theme still works.
- Every page has skip link first in body and `<main id="main">`.
- Every chapter has Home to `../../index.html` and hub link to `index.html`.
- Prev/Next chain has no broken links and correct hub endpoints.
- Every TOC link reaches an existing section anchor.
- Pages use `../../assets/theme.js`, `../../assets/theme.css`, and `topic.css`.
- No page duplicates shared CSS or adds `<style>`.
- Informative diagrams have `role="img"` and `aria-label`; table header cells use `scope="col"`.
- ASCII scan passes; punctuation uses entities; no `@font-face`, remote asset, or `/assets/...` path.
- `assets/registry.js` lists every chapter in order with real metadata.
- `tools/verify.ps1` returns PASS and zero failures.
