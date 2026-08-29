# Add a topic

Use this runbook to add one self-contained topic without duplicating platform CSS.

1. Create `topics/<slug>/`.
2. Create `topics/<slug>/topic.css` with only dark and light accent token overrides. Do not add layout or component rules.
3. Create `topics/<slug>/index.html` as the topic hub.
4. Create chapter pages using the documented depth-2 head block and `.top-links` navigation below.
5. Add one card to the root `index.html`. Copy the existing card, update title, description, link, and pills.
6. Keep every page ASCII-only. Use HTML entities for non-ASCII punctuation.

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

Do not add inline `<style>`, inline theme JavaScript, `@font-face`, remote assets, or root-relative `/assets/...` paths.

## Depth-2 top-links block

Use relative links from a chapter page or hub at `topics/<slug>/` depth:

```html
<div class="top"><div class="top-inner"><div class="site">Debanjan&rsquo;s Learning System</div><div class="top-links"><a href="../../index.html">Home</a><a href="index.html">Topic hub</a><a href="[previous-file]">&larr; Prev</a><a href="[next-file]">Next &rarr;</a><button type="button" class="theme-toggle" id="theme-toggle" title="Switch between dark and light theme"><svg class="icon icon-moon" viewBox="0 0 24 24" width="1em" height="1em" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true" focusable="false"><path d="M20 14.5A8.5 8.5 0 0 1 9.5 4a8.5 8.5 0 1 0 10.5 10.5Z"/></svg><svg class="icon icon-sun" viewBox="0 0 24 24" width="1em" height="1em" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true" focusable="false"><path d="M12 4.2V2.5M12 21.5v-1.7M4.2 12H2.5M21.5 12h-1.7M6.5 6.5 5.3 5.3M18.7 18.7l-1.2-1.2M6.5 17.5l-1.2 1.2M18.7 5.3l-1.2 1.2M12 7.8a4.2 4.2 0 1 0 0 8.4 4.2 4.2 0 0 0 0-8.4Z"/></svg><span class="theme-label">Dark</span></button></div></div></div>
```

For the first chapter, link `Prev` to `index.html` or omit it according to the topic navigation design. For the final chapter, omit `Next` or link it to the hub. Keep all chapter links valid.

## Verification checklist

Before handoff, open pages directly from disk and verify:

- Dark theme loads; light theme loads; toggle label and persistence work.
- Every page has a working `Home` link to `../../index.html`.
- Every chapter has a working `Topic hub` link to `index.html`.
- Prev/next chain has no broken links and correct first/last behavior.
- Every TOC link reaches an existing section anchor.
- All pages use `../../assets/theme.js`, `../../assets/theme.css`, and `topic.css`.
- No page duplicates shared CSS.
- ASCII scan passes for every new file; HTML punctuation uses entities.
- No `@font-face`, remote asset, or `/assets/...` path appears.
