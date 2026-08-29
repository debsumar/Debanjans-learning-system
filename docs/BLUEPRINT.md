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
