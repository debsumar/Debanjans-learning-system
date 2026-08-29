# Content Blueprint

`assets/registry.js` is author-side DATA. Chapter pages remain static HTML and readable with JavaScript disabled. `assets/study.js` is the sole optional consumer.

## Seven layers

1. **Certification manifest**: vendor, exam code, display name, skills-measured date, official guide URL, domains, and exam weights.
2. **Objective registry**: 57 exact skills bullets. Each has stable HTML `id`, verbatim `text`, domain, chapter, and confusion-set links.
3. **Chapter map**: ordered chapter files, titles, domain weights, objective IDs, static section IDs, section archetypes, and practice counts.
4. **Section archetypes**: closed enum: `concept`, `process`, `comparison`, `decision`, `worked-scenario`, `callout`, `diagram`, `mcq-set`, `active-recall`.
5. **Question schema**: contract for existing items: item ID, objectives, Bloom level, stem, four options, key, key rationale, and one rationale per wrong option. No questions are re-authored here.
6. **Diagram catalogue**: seven visual archetypes covering 15 diagrams, required data fields, chapter uses, and SVG geometry invariants.
7. **Confusion sets and study policy**: ten canonical discriminators with real callout targets, plus Leitner intervals, confidence values, and weight-aware review guidance.

## Data boundary

Content is DATA. Presentation is TEMPLATE. HTML, CSS, and SVG markup belong to page/template owners. Registry entries describe content and contracts; they do not render pages.

An LLM may generate or reshape registry data only after checking source pages. It must never generate HTML, CSS, SVG coordinates, or objective IDs. Objective IDs come from the machine-readable skills markers and are referenced, never invented, elsewhere.

## Verification boundary

Verifier can prove shape: classic-script syntax, one global assignment, ASCII bytes, required keys, closed enum values, unique objective IDs, objective coverage, chapter order, section order, practice counts, confusion links, catalogue counts, and declared SVG geometry invariants.

Verifier cannot prove factual truth, current Microsoft policy, official-source correctness, answer-key correctness, rationale quality, or diagram pedagogy. Human review against the official guide remains required.

## Adding AWS Cloud Practitioner

1. Read the AWS official exam guide. Record vendor, code, display name, version/date, URL, domains, and weight ranges.
2. Create AWS chapter pages with static HTML markers: chapter/domain/weight body data, objective IDs, MCQ metadata, and recall metadata.
3. Assign stable IDs from an AWS namespace only after reading every official objective. Copy wording verbatim into the objective registry.
4. Add ordered AWS chapter-map entries using real files and real section IDs. Classify each body section with the closed archetype enum.
5. Declare AWS question counts and schema contract. Keep question prose in pages, not registry.
6. Catalogue every AWS diagram under an existing archetype. Supply nodes, labels, edges, groups, and checkable geometry rules.
7. Add only source-supported confusion sets. Record actual callout chapter separately from each hub link target.
8. Add AWS Leitner, confidence, and weight-proportional review policy. Record any coverage skew honestly.
9. Run syntax, ASCII, uniqueness, objective-coverage, section-order, count, confusion, and SVG checks.
10. Review facts, wording, answer keys, rationales, and visual teaching value manually. Passing shape checks is not factual approval.


## Learning components and data boundaries

The five learning components belong in the presentation layer, with machine-checkable metadata kept beside them:

- TL;DR card: static HTML summary and TOC link; registry declares the chapter-level presence contract.
- `.cal.myth`: static misconception closure; registry declares the allowed component contract and tooling checks count and label shape.
- `.steps`: static ordered causal sequence; registry declares presence only where a real ordered path is intended. Chapters 01, 02, and 03 omit it.
- First-use glossary links: static cross-file links to glossary ids; registry glossary metadata and verifier checks keep anchors resolvable.
- Recall `data-objective`: static item metadata; registry objective ids are data, and tooling checks every reference against them.

HTML owns wording, order, and markup. CSS owns `.tldr`, `.cal.myth`, and `.steps` presentation. `study.js` owns optional interaction and serialisation. `assets/registry.js` declares the component and objective contracts so `tools/verify.ps1` can check them; it does not render pages and readers do not load it as a runtime dependency.

The portable study brief is derived data, not authored chapter content. `study.js` reads `data-objective` and local study records, ranks objective results by miss rate, marks high-confidence misses, and writes Markdown to the visible textarea. Clipboard copying is only a convenience; the textarea remains the reliable `file://` path. Per-file-URL `localStorage` means disk-opened pages keep separate state, while the hosted copy shares state across its pages.

## Interactive outcome models

Interactive prediction models are optional progressive enhancement. The static HTML `table.model-matrix` is the single source of truth for scenario headers, option row labels, and every outcome cell; JavaScript may only derive controls and prediction feedback from that table. `assets/registry.js` declares model identity, owning chapter and section, and rectangular dimensions, but never duplicates outcome values. `assets/model.js` reads `table.model-matrix`, and each model remains readable with JavaScript disabled. `tools/verify.ps1` checks registry-to-page identity, one matrix per model, dimensions, non-empty headers/cells, and runtime derivation from matrix cells.

A model contract does not replace visible answers. Keep the matrix in native table markup, keep controls optional, and do not add domain outcomes to JavaScript or registry metadata.


These checks prove shape and linkage, not teaching quality. Human review still decides whether a TL;DR boundary is accurate, a myth closes a real inference, a steps list represents causality, a glossary link is first-use and substantive, or an objective tag reflects what recall tests.
