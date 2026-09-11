# CCAF chapter authoring contract

Source truth: `topics/az-900/01-cloud-computing.html`, `topics/az-900/05-compute-networking.html`, `topics/az-900/topic.css`, `assets/registry.js`, and `tools/verify.ps1`. Copy blocks. Replace only `[[LIKE THIS]]`. ASCII source only.

## 1. Head and body start

Use this exact depth-two head. CCAF favicon is cap-path URI with purple fill, not the AZ-900 favicon verbatim.

```html
<!doctype html>
<html lang="en" data-theme="dark">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="[[ONE UNIQUE ASCII SENTENCE DESCRIBING THIS CCAF CHAPTER]].">
<title>[[CHAPTER TITLE]] &middot; CCA-F Notes</title>
<link rel="icon" href="data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16'%3E%3Cpath fill='%23d97757' d='M2 4l6-2 6 2-6 2-6-2Zm0 3 6 2 6-2v3l-6 2-6-2V7Z'/%3E%3C/svg%3E">
<script src="../../assets/theme.js"></script>
<link rel="stylesheet" href="../../assets/theme.css">
<link rel="stylesheet" href="topic.css">
</head>
<body data-chapter="[[cNN]]" data-domain="[[DOMAIN NUMBER]]" data-weight="UNVERIFIED">
```

`description` is exactly one non-empty page-unique tag. `body` chapter id, domain, title, short title, sections, MCQ count, recall count, and objective ids come from `topicRegistries.ccaf.chapters` in `assets/registry.js`. Domain number is `d1` -> `1`, `d2` -> `2`, `d3` -> `3`, `d4` -> `4`, `d5` -> `5`.

## 2. Skip, top shell, breadcrumbs

First body child. Shipped chapter pages have no `.site` element. Do not invent one. `Learning System` is root breadcrumb text, not `.site` text. CCAF hub breadcrumb link text and topic label are `CCA-F`.

```html
<a class="skip" href="#main">Skip to content</a>
<div class="top">
  <div class="top-inner">
    <nav class="crumbs" aria-label="Breadcrumb"><ol><li><a href="../../index.html">Learning System</a></li><li><a href="index.html">CCA-F</a></li><li><span aria-current="page">[[REGISTRY shortTitle]]</span></li></ol></nav>
    <div class="top-links"><a href="[[PREV FILE OR index.html]]">&larr; Prev</a><a href="[[NEXT FILE OR index.html]]">Next &rarr;</a><button type="button" class="theme-toggle" id="theme-toggle" title="Switch between dark and light theme"><svg class="icon icon-moon" viewBox="0 0 24 24" width="1em" height="1em" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true" focusable="false"><path d="M20 14.5A8.5 8.5 0 0 1 9.5 4a8.5 8.5 0 1 0 10.5 10.5Z"/></svg><svg class="icon icon-sun" viewBox="0 0 24 24" width="1em" height="1em" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true" focusable="false"><path d="M12 4.2V2.5M12 21.5v-1.7M4.2 12H2.5M21.5 12h-1.7M6.5 6.5 5.3 5.3M18.7 18.7l-1.2-1.2M6.5 17.5l-1.2 1.2M18.7 5.3l-1.2 1.2M12 7.8a4.2 4.2 0 1 0 0 8.4 4.2 4.2 0 0 0 0-8.4Z"/></svg><span class="theme-label">Dark</span></button></div>
  </div>
</div>
```

Chapter breadcrumb rule: exactly one `nav.crumbs[aria-label="Breadcrumb"]`, exactly one `ol`, exactly three `li`; first two are one-link ancestors with exact hrefs `../../index.html` and `index.html`; third is unlinked `span[aria-current="page"]` whose text equals registry `shortTitle`. No typed separator (`/`, `>`, `&rsaquo;`, `&gt;`, or `&raquo;`); CSS supplies `.crumbs li + li::before`. Topic hub has two items; root has no breadcrumb.

## 3. Header, TOC, TL;DR

```html
<div class="wrap">
  <header class="head">
    <h1>[[REGISTRY title]]</h1>
    <p class="kicker">[[ASCII CHAPTER PROMISE]].</p>
    <div class="pills"><span class="pill">Domain [[DOMAIN NUMBER]]</span><span class="pill">[[REGISTRY DOMAIN NAME]]</span><span class="pill">Weight unverified</span></div>
  </header>
  <nav class="toc"><a href="#tldr">In one minute</a><a href="#skills">Skills in scope</a><a href="#[[BODY SECTION ID]]">[[BODY SECTION LABEL]]</a><a href="#mcq">MCQs</a><a href="#recall">Quick recall</a></nav>
  <main id="main"><section class="card tldr" id="tldr"><h2>In one minute</h2><ul><li>[[RULE AND ITS BOUNDARY]].</li><li>[[RULE AND ITS BOUNDARY]].</li><li>[[RULE AND ITS BOUNDARY]].</li><li>[[RULE AND ITS BOUNDARY]].</li></ul></section>
```

`#tldr` is first `section` in `main`, exactly one `section.card.tldr#tldr`, 4-6 `li`, and `nav.toc` must link `#tldr`. Every TOC target exists. Add one TOC link for every real chapter section, including `#skills`, `#mcq`, and `#recall`.

## 4. Section archetypes

Registry labels are planning metadata, not DOM classes. Every body archetype uses `section.card`; use its chapter `sectionIds` order and `sectionArchetypes` mapping. Exact shipped structural examples follow.

### concept

Exact shipped prose element from `01-cloud-computing.html#what`:

```html
<p>Cloud computing = delivery of computing services over a network, on demand, with provider-operated infrastructure. Common rented capabilities include <a href="glossary.html#g-compute">compute</a>, <a href="glossary.html#g-storage">storage</a>, <a href="glossary.html#g-networking">networking</a>, and <a href="glossary.html#g-analytics">analytics</a>:</p>
```

### process

Exact shipped process from `05-compute-networking.html#endpoints`:

```html
<ol class="steps"><li><details class="more" open><summary>Request targets a private IP on the private endpoint network interface.</summary><p>A private endpoint is a network interface with a private IP in your VNet.</p></details></li><li><details class="more"><summary>Private Link carries the request privately to the Azure service.</summary><p>The private endpoint connects privately to an Azure service or your own service through Private Link.</p></details></li><li><details class="more"><summary>Public access remains a separate configuration decision.</summary><p>Creating a private endpoint does not itself restrict public access; disable public network access separately if required.</p></details></li></ol>
```

Use `.steps` only for real order. Every `li` has exactly one `details`; exactly one `details` has `open`; it is first.

### comparison

Exact shipped table from `05-compute-networking.html#endpoints`:

```html
<div class="tw"><table class="t"><thead><tr><th scope="col">Endpoint</th><th scope="col">Address and path</th><th scope="col">Use</th></tr></thead><tbody><tr><td>Public endpoint</td><td>Service reachable through a public IP/DNS name; access can still be restricted by authentication and firewall rules.</td><td>Public web/API access or clients outside a private network.</td></tr><tr><td>Private endpoint</td><td>Network interface with a private IP in your VNet that connects privately to an Azure service or your own service through Private Link.</td><td>Private network path; configure public network access separately if it must be disabled.</td></tr><tr><td>Service endpoint</td><td>VNet subnet identity and optimized route to supported Azure services such as <a href="glossary.html#g-storage">Azure Storage</a> or Azure SQL.</td><td>Secure service access without assigning a private endpoint NIC; service firewall settings still matter.</td></tr></tbody></table></div>
```

All header-row cells use `th scope="col"`; row headers use `th scope="row"`. Copy comparison markup from `topics/az-900/05-compute-networking.html`: `div.tw > table.t` with scoped headers.

### decision

Exact shipped decision lead from `01-cloud-computing.html#spending`:

```html
<p>Consumption-based model: pay for what you use, for how long, and for selected service tier or capacity. Provisioning is usually fast; cost follows usage and configuration.</p>
```

### worked-scenario

Exact shipped worked-scenario lead from `08-cost-management.html#tools`:

```html
<p><strong>Diagram:</strong> <a href="glossary.html#g-pricing-calculator">Estimate</a> first, deploy, analyse actual spend, use Advisor recommendations, then optimise; tags feed reporting and allocation.</p>
```

### callout

```html
<div class="cal myth"><span class="lbl">Common wrong turn</span><p><strong>&ldquo;Adding a private endpoint automatically disables public access.&rdquo;</strong> &mdash; It adds a private VNet path; identity, firewall, DNS, and public network settings still require separate configuration.</p></div>
<div class="cal confuse"><b class="lbl">Confuse</b>Peering connects VNets privately; VPN Gateway creates encrypted tunnels over public internet or related VPN paths; ExpressRoute provides private dedicated connectivity. Peering is not a replacement for every hybrid connection.</div>
```

Every `.cal.myth` uses exact `span.lbl` text `Common wrong turn`; maximum three per chapter. Every registry `confusionSets` entry owned by this chapter requires matching `.cal.confuse` in its target section; text must mention every hyphen-separated confusion-set term.

### diagram

```html
<svg role="img" aria-label="Shared responsibility progression from on-premises to SaaS" viewBox="0 0 920 180"><rect x="20" y="54" width="205" height="72" rx="10" fill="var(--surface-2)" stroke="var(--border)"/><rect x="245" y="54" width="205" height="72" rx="10" fill="var(--accent-soft)" stroke="var(--border)"/><rect x="470" y="54" width="205" height="72" rx="10" fill="var(--accent)" stroke="var(--border)"/><rect x="695" y="54" width="205" height="72" rx="10" fill="var(--surface)" stroke="var(--border)"/><path d="M225 90h20m-7-7 7 7-7 7M450 90h20m-7-7 7 7-7 7M675 90h20m-7-7 7 7-7 7" fill="none" stroke="var(--accent)" stroke-width="3"/><text x="122.5" y="85" text-anchor="middle" fill="var(--text)" font-family="var(--font)" font-size="16">On-prem</text><text x="122.5" y="108" text-anchor="middle" fill="var(--muted)" font-family="var(--font)" font-size="13">customer owns most</text><text x="347.5" y="85" text-anchor="middle" fill="var(--bg)" font-family="var(--font)" font-size="16">IaaS</text><text x="347.5" y="108" text-anchor="middle" fill="var(--bg)" font-family="var(--font)" font-size="13">shared boundary</text><text x="572.5" y="85" text-anchor="middle" fill="var(--bg)" font-family="var(--font)" font-size="16">PaaS</text><text x="572.5" y="108" text-anchor="middle" fill="var(--bg)" font-family="var(--font)" font-size="13">provider owns more</text><text x="797.5" y="85" text-anchor="middle" fill="var(--text)" font-family="var(--font)" font-size="16">SaaS</text><text x="797.5" y="108" text-anchor="middle" fill="var(--muted)" font-family="var(--font)" font-size="13">provider owns most</text></svg>
```

Informative SVG: `role="img"`, meaningful `aria-label`, numeric `viewBox`, all registered label text exact. Choose only a CCAF registry `diagramCatalogue.archetypes` use for this chapter and section. Geometry: connectors end on box faces; horizontal connector y equals both box vertical centres; vertical connector x equals both box horizontal centres; arrow tip equals endpoint; centered box labels use `text-anchor="middle"` at box centre; labels fit; nothing outside viewBox; no rect stroke on a viewBox edge. Use only `currentColor` or `var(--token)` paint. Add nearby prose/table for dense mobile diagrams.

CCAF production markup has no inline style. Put responsive SVG sizing in shared CSS; do not copy the AZ-900 inline-style convention.

### mcq-set

```html
<section class="card" id="mcq"><h2>MCQs</h2><ol>
<li><strong>[[STEM]]</strong><ul><li>A. [[OPTION A]]</li><li>B. [[OPTION B]]</li><li>C. [[OPTION C]]</li><li>D. [[OPTION D]]</li></ul><details class="more" data-mcq="[[cNN-qMM]]" data-objective="[[ccaf-cNN-oN]]"><summary>Answer</summary><p><strong>Answer: [[KEY LETTER]] &mdash; [[KEY OPTION]].</strong></p><p>Reason: [[KEY RATIONALE]].</p><ul><li>[[FIRST WRONG LETTER]] &mdash; [[FIRST DISTRACTOR RATIONALE]].</li><li>[[SECOND WRONG LETTER]] &mdash; [[SECOND DISTRACTOR RATIONALE]].</li><li>[[THIRD WRONG LETTER]] &mdash; [[THIRD DISTRACTOR RATIONALE]].</li></ul></details></li>
</ol></section>
```

### active-recall

```html
<section class="card" id="recall"><h2>Quick recall</h2><p>Attempt each question before expanding it.</p><details class="more recall-item" data-recall="[[cNN-rMM]]" data-objective="[[ccaf-cNN-oN]]"><summary>[[QUESTION BEFORE ANSWER]]</summary><p>[[ANSWER IN HTML]].</p></details><div id="study-summary"></div></section>
```

## 5. Exact skills section

Use every registry chapter `objectiveIds`, in registry order, one bullet per id. Text equals matching `topicRegistries.ccaf.objectives[].text`. While `skillsMeasuredAsOf` is `UNVERIFIED`, never call these official skills or official objective bullets. Use TOC and heading text `Skills in scope`, and state: `This provisional mapping remains subject to the official guide when it is published.`

```html
<section class="card" id="skills"><h2><svg class="icon icon-list" viewBox="0 0 24 24" width="1em" height="1em" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" vector-effect="non-scaling-stroke" aria-hidden="true" focusable="false"><path d="M8 6h11M8 12h11M8 18h11M4 6h.01M4 12h.01M4 18h.01"/></svg>Skills in scope</h2><p>This provisional mapping remains subject to the official guide when it is published.</p><ul><li id="[[ccaf-cNN-o1]]">[[OBJECTIVE TEXT VERBATIM FROM REGISTRY]]</li><li id="[[ccaf-cNN-o2]]">[[OBJECTIVE TEXT VERBATIM FROM REGISTRY]]</li></ul></section>
```

## CONFUSION CALLOUT CONTRACT

For every registry confusion set, its `hubLinkTarget` section must contain a `.cal.confuse` callout. The entire target section must also contain every hyphen-separated token of the set id as a word; `tool-use-result`, for example, requires `tool`, `use`, and `result`. Do not rely on a callout elsewhere in the chapter. The verifier checks this section-scoped contract.

| Set id | Target chapter and section |
|---|---|
| `tool-use-result` | c01 `01-agent-loops.html#tool-turn` |
| `end-turn-text` | c01 `01-agent-loops.html#loop-exit` |
| `code-model-decision` | c02 `02-decision-orchestration.html#decision-owner` |
| `chain-adaptive` | c02 `02-decision-orchestration.html#fixed-vs-adaptive` |
| `coordinator-spoke` | c03 `03-coordinator-design.html#hub-spoke` |
| `parallel-sequential` | c03 `03-coordinator-design.html#delegation` |
| `partition-selection` | c03 `03-coordinator-design.html#partitioning` |
| `retry-recovery` | c04 `04-reliable-orchestration.html#recovery` |
| `schema-semantic` | c05 `05-prompt-output-quality.html#validation` |
| `self-independent-review` | c05 `05-prompt-output-quality.html#review` |
| `resource-tool` | c06 `06-tools-mcp-structured-output.html#mcp` |
| `any-named-tool` | c06 `06-tools-mcp-structured-output.html#tool-choice` |
| `provenance-confidence` | c07 `07-evidence-context.html#findings` |
| `findings-manifest` | c07 `07-evidence-context.html#durable-artifacts` |
| `claude-code-sdk` | c08 `08-claude-code-workflows.html#setup-boundaries` |
| `fork-resume-rewind` | c09 `09-sessions-settings.html#session-lifecycle` |
| `compact-clear` | c09 `09-sessions-settings.html#context` |
| `project-local` | c09 `09-sessions-settings.html#settings-scopes` |
| `permission-sandbox` | c10 `10-permission-safety.html#sandbox` |
| `ask-bypass` | c10 `10-permission-safety.html#modes` |
| `complete-durable` | c11 `11-diagnostics-automation.html#run-evidence` |
| `agent-description-procedure` | c12 `12-agent-definitions-delegation.html#agent-definition` |
| `batch-custom-id` | c13 `13-batch-and-escalation.html#batch` |
| `request-frustration` | c13 `13-batch-and-escalation.html#escalation` |

## 6. MCQ contract

Per item: exactly four options; `data-mcq="cNN-qMM"`; non-empty space-separated real `data-objective` ids; one key rationale; exactly one rationale for each of three distractors. IDs are topic-unique and format `^c\d{2}-q\d{2}$`. Use only objectives genuinely tested.

```html
<li><strong>Which compute type gives the customer guest operating-system control?</strong><ul><li>A. Function</li><li>B. Container</li><li>C. Virtual machine</li><li>D. App Service web app</li></ul><details class="more" data-mcq="c05-q01" data-objective="az900-c05-o1"><summary>Answer</summary><p><strong>Answer: C &mdash; Virtual machine.</strong></p><p>Reason: A VM exposes guest OS, installed software, and patching responsibilities.</p><ul><li>A &mdash; Functions abstract the host and run code units.</li><li>B &mdash; Containers package apps and share a host kernel.</li><li>D &mdash; App Service manages the web hosting platform.</li></ul></details></li>
```

For CCAF replace only source values: `c05-q01` -> `cNN-qMM`, `az900-c05-o1` -> real `ccaf-cNN-oN`, and question content. Every distractor rationale must state the condition under which that option would be correct, then distinguish it from this stem. Do not place glossary links in MCQ stem, options, or answer summary.

## 7. Recall contract

One independently expandable recall item per declared recall count. Every item has both fields; id format `^c\d{2}-r\d{2}$`.

```html
<details class="more recall-item" data-recall="c05-r10" data-objective="az900-c05-o6"><summary>What does a private endpoint provide?</summary><p>A private IP on a VNet NIC connecting privately through Private Link to an Azure service or your own service; public access needs separate configuration.</p></details>
```

For CCAF replace only ids and content. `data-objective` accepts one or more real IDs separated by spaces.

## 8. Study mount and scripts

Place exactly one mount inside `#recall`, after all recall `details`, before `</section>`. Non-model page ends exactly:

```html
<div id="study-summary"></div></section>
  </main>
</div>
<script src="../../assets/study.js"></script>
</body>
</html>
```

Model page ends exactly; `model.js` only on a page with registered `data-model`:

```html
<div id="study-summary"></div></section>
  </main>
</div>
<script src="../../assets/study.js"></script>
<script src="../../assets/model.js"></script>
</body>
</html>
```

A model is one `div.model[data-model]` with exactly one visible `table.t.model-matrix`; one `thead` row using `th scope="col"`; one `tbody`; at least two rows, each with one `th scope="row"`; rectangular non-empty cells; 2-5 distinct outcome values. Matrix dimensions and id equal CCAF `interactiveModel.models` and `componentCatalogue.model.shipped` records. Model pages are c03 `ccaf-delegation-mode` (3 rows, 3 columns), c06 `ccaf-tool-choice` (4 rows, 4 columns), and c09 `ccaf-session-action` (5 rows, 5 columns). Each loads trailing classic `model.js` after `study.js`.

## 9. Prev/next

Registry chapter order is `topicRegistries.ccaf.chapters` order. Every page uses exact link text shown in top shell.

- First `c01` / `01-agent-loops.html`: Prev `index.html`; Next `02-decision-orchestration.html`.
- Middle chapter: Prev previous registry `file`; Next next registry `file`.
- Last `c13` / `13-batch-and-escalation.html`: Prev `12-agent-definitions-delegation.html`; Next `index.html`.

## C12 coordinator-spoke boundary

C12 may reference coordinator ownership, but it must not duplicate c03's `coordinator-spoke` callout. The registered `coordinator-spoke` target is only c03 `#hub-spoke`; c12 uses its own registered callout target.

## 10. Verifier checklist

### Registry and navigation

- Add exactly one CCAF chapter record before page work: `id`, `file`, `title`, `shortTitle`, `domain`, `weight`, `objectiveIds`, `sectionIds`, `sectionArchetypes`, `mcqCount`, `recallCount`. Gate: disk chapter list exactly equals registry chapter file list; chain and hub card href order equal registry order.
- Use chapter `shortTitle` as breadcrumb leaf; `title` as `h1`; `sectionIds` as actual section ids; `sectionArchetypes` only from closed enum.
- Create all objective bullets declared by `objectiveIds`; no bullet from another chapter. Gate: every `#skills li[id]` is a real objective assigned to this chapter.
- Reference every CCAF objective somewhere in its page with `#skills` id and/or `data-objective`; never use absent objective IDs. Gate: registry-to-page and page-to-registry objective coverage.
- Apply the CONFUSION CALLOUT CONTRACT below. For every registry confusion set, put `.cal.confuse` in its target section, include every hyphen-separated id token as a word in that section, and keep exactly one valid hub target link.
- For registered diagram use, exact `chapter`, `section`, and `label` come from `diagramCatalogue.archetypes.*.uses`; all declared uses must resolve to one matching SVG.
- For registered model, id/page/section/rows/columns come from both `interactiveModel.models` and `componentCatalogue.model.shipped`; never add an unregistered model or load `model.js` outside a model page.

### Counts supplied by registry

| Chapter | File | `chapters[].mcqCount` / `recallCount` | `questionSchema.counts.perChapter` |
|---|---|---:|---:|
| c01 | 01-agent-loops.html | 8 / 8 | 8 / 8 |
| c02 | 02-decision-orchestration.html | 7 / 7 | 7 / 7 |
| c03 | 03-coordinator-design.html | 10 / 10 | 10 / 10 |
| c04 | 04-reliable-orchestration.html | 9 / 9 | 9 / 9 |
| c05 | 05-prompt-output-quality.html | 9 / 9 | 9 / 9 |
| c06 | 06-tools-mcp-structured-output.html | 10 / 10 | 10 / 10 |
| c07 | 07-evidence-context.html | 9 / 9 | 9 / 9 |
| c08 | 08-claude-code-workflows.html | 7 / 7 | 7 / 7 |
| c09 | 09-sessions-settings.html | 12 / 12 | 12 / 12 |
| c10 | 10-permission-safety.html | 7 / 7 | 7 / 7 |
| c11 | 11-diagnostics-automation.html | 6 / 6 | 6 / 6 |
| c12 | 12-agent-definitions-delegation.html | 6 / 6 | 6 / 6 |
| c13 | 13-batch-and-escalation.html | 4 / 4 | 4 / 4 |

- Count `data-mcq` exactly `chapters[].mcqCount`; count `data-recall` exactly `chapters[].recallCount`. Matching total contract: `questionSchema.counts.mcqTotal = 104`, `recallTotal = 104`; review count is `reviewRecallTotal = 37`.
- MCQ IDs are topic-unique `cNN-qMM`; recall IDs are topic-unique `cNN-rMM`; no duplicate `data-mcq` or `data-recall` across CCAF pages, hub, review, or glossary.

### Static page rules

- First `body` child is exact skip link; one `main#main`; shared `theme.js` and `theme.css` references exist.
- Every same-file `href="#id"` resolves to exactly an existing id. Keep all ids unique.
- Exactly one offline SVG-data-URI favicon and exactly one non-empty unique description.
- Exactly one study mount and one trailing classic `study.js`; study answers have `summary` and remain readable with JavaScript disabled.
- Every recall `details` has non-empty real `data-objective`; total chapter recall objective-tag count equals `questionSchema.counts.recallTotal` across chapters.
- Exactly one first `#tldr`; 4-6 bullets; TOC has `#tldr`.
- Each `.steps` list satisfies first-only `open`; each `.cal.myth` exact label and maximum three.
- Every MCQ distractor rationale says when that option would be correct before distinguishing it from this stem.
- Every `glossary.html#g-...` target resolves to CCAF glossary `dt[id]`; slug is `g-` plus lowercase ASCII words joined by hyphens.
- Every informative SVG has numeric viewBox, registry `aria-label`, bounded rect/circle/ellipse/line/text geometry, no rect at viewBox edge, and `text-anchor="middle"` for centered box text.
- Every table header uses `scope="col"`; row-header cells use `scope="row"`.

## 11. Hard bans

- Non-ASCII bytes. Use entities: `&mdash;`, `&middot;`, `&ndash;`, `&larr;`, `&rarr;`, `&ldquo;`, `&rdquo;`.
- Inline `<style>` or presentation copied into a page; shared CSS only. Do not add inline presentation attributes under CCAF hard ban.
- Remote scripts, stylesheets, fonts, images, or other assets.
- Root-relative `/assets/...` paths; use `../../assets/...` for CCAF chapter pages.
- ES modules (`import`, `export`, `type="module"`) or `fetch()`; classic local scripts only.
- Duplicate ids, duplicate study IDs, missing same-file anchor targets.
- Colour literals outside `:root` token blocks; chapter pages define no colour literals. CCAF `topic.css` has exactly two `:root` blocks and only `--accent`, `--accent-soft`, `--accent-dim` declarations.
- Glossary links in headings, `summary`, MCQ stem/options, table headers, or TL;DR. Link first substantive prose use only.

## Shipped-versus-skill discrepancies

1. Shipped AZ-900 chapter shell has `.top`, `.top-inner`, `.crumbs`, and `.top-links`, but no `.site`; `author-page` vocabulary says `.site` and says to keep Home/topic links in `.top-links`. Follow shipped chapters: no `.site`, breadcrumb ancestors, Prev/Next, then theme toggle.
2. CCAF favicon policy supersedes the earlier verbatim-AZ-900 instruction: use the cap-path SVG data URI with `fill='%23d97757'`, not AZ-900 `fill='%23d97757'`.
3. Shipped informative SVG guidance may show inline presentation attributes, but CCAF hard-bans them. Use shared CSS for CCAF SVG sizing; do not copy that source convention into production markup.
