---
name: author-diagram
description: Author verified SVG diagrams from registered archetypes; geometry, routing, accessibility, theme, and viewBox checks
---
# Author diagram

Use this runbook for `$ARGUMENTS`.

## Why this skill exists

Six hand-authored diagrams shipped broken: arrows pointed 64 units into empty space, connectors crossed unrelated boxes, overlapping segments doubled arrowheads, and eight labels lacked `text-anchor="middle"` and overflowed boxes.

Make those bugs impossible before authoring prose around a diagram.

## Core rule

Never free-hand SVG coordinates. Pick one registered archetype. Follow its geometry contract.

Registry source: `assets/registry.js`, `diagramCatalogue`.

Registered archetypes and shipped usage counts:

- `flow-chain`: 6
- `comparison-columns`: 2
- `matrix`: 2
- `nested-containment`: 2
- `spectrum-axis`: 1
- `network-topology`: 1
- `hierarchy-tree`: 1

Catalogue total: 15 diagrams. Each archetype requires `nodes`, `labels`, `edges`, and `groups` as design data.

Choose archetype by relationship, not decoration:

- `flow-chain`: ordered movement or lifecycle.
- `comparison-columns`: side-by-side choices and discriminators.
- `matrix`: many-to-many or scope-to-tool mapping.
- `nested-containment`: parent, child, and boundary containment.
- `spectrum-axis`: ordered trade-off or continuum.
- `network-topology`: connected network components and paths.
- `hierarchy-tree`: levels flowing from parent to children.

## Geometry contract

Treat each box as `(x, y, width, height)`.

1. Faces are left `x`, right `x + width`, top `y`, bottom `y + height`.
2. A connector endpoint must land exactly on the intended box face.
3. Horizontal connector y must equal `y + height / 2` for BOTH joined boxes.
4. Vertical connector x must equal `x + width / 2` for BOTH joined boxes.
5. Arrowhead tip must coincide with connector endpoint. `marker-end` does not repair a wrong endpoint.
6. Centered label: use `text-anchor="middle"`; x must equal `x + width / 2`.
7. Label fit: at font-size F, assume about `0.5em` average advance; usable characters are about `boxWidth / (0.5 * F)`.
8. Nothing may fall outside the numeric `viewBox`.
9. Do not place a rect stroke exactly on a viewBox edge; half its stroke width gets clipped.

## Worked arithmetic: chapter 10 failure

Real ARM rect in `topics/az-900/10-management-deployment.html`:

```text
x=300, y=110, width=210, height=150
```

It spans y `110..260`. A connector ending at `(300,46)` misses its left face by `110 - 46 = 64` units. This is the shipped 64-unit empty-space failure.

Correct left-face entry uses the ARM box vertical centre:

```text
centerY = y + height / 2 = 110 + 150 / 2 = 185
endpoint = (x, centerY) = (300, 185)
```

Recompute from box geometry. Never copy a nearby coordinate.

## Routing checks

A connector must not cross an unrelated box or its label.

- List every unrelated rect and its bounds.
- Test whether each segment intersects any other rect bounds.
- Include label area in the same collision review; a line through text is a broken route.
- Prefer direct orthogonal segments with one clear semantic edge.
- If a bend is needed, check every segment, not only first and last points.

Do not duplicate segments. Overlapping paths each carrying `marker-end` create doubled arrowheads and darker strokes. One semantic edge gets one visible path and one arrowhead.

## Paint and theme

Every diagram `stroke` and `fill` must be `currentColor` or `var(--token)`. A colour literal in a diagram breaks the light theme. Only `:root` blocks may hold colour literals.

Use existing theme tokens. Do not invent per-diagram literal colours.

## Accessibility

Informative diagram: `role="img"` plus meaningful `aria-label` describing relationship and content.

Small 24x24 heading icons: keep `aria-hidden="true"`; never add a role to them. They are decoration, not content diagrams.

Keep explanatory text or a table equivalent beside dense visuals.

## Sizing and mobile honesty

Use shared inline convention exactly:

```html
style="width:100%;height:auto;max-width:760px"
```

Dense 760-920 unit diagrams with 12-16px text render around 5-6px on a 320px phone. That is unreadable. Add a nearby text or table equivalent; do not claim the diagram alone is accessible.

## Authoring sequence

1. Read `assets/registry.js` catalogue use and geometryRules.
2. Read target page examples in `topics/az-900/04-core-architecture.html`, `topics/az-900/05-compute-networking.html`, `topics/az-900/09-governance-compliance.html`, and `topics/az-900/10-management-deployment.html`.
3. Select one registered archetype and write box data first.
4. Compute faces and centers arithmetically.
5. Route every edge around unrelated boxes and labels.
6. Add one arrowhead per semantic edge.
7. Check labels, theme paint, ARIA, viewBox, and mobile equivalent.
8. Place diagram in its registry chapter and section use; keep its `aria-label` meaningful.

## Finish: verifier

Run from target repo:

```powershell
pwsh -File tools\verify.ps1
```

Require SVG geometry check `PASS`.

Verifier checks: registry metadata and diagram uses; all 15 catalogue SVGs; numeric viewBox; rect, circle, ellipse, line, and text bounds; rect stroke-edge violations; centered text missing `text-anchor="middle"`; static page and objective contracts.

Verifier honestly skips or cannot prove: path/polyline/polygon geometry, transforms, marker tip placement, connector-to-face arithmetic, route intersections, duplicate overlapping paths, text glyph width/label fit, and literal paint values. Manually check these before accepting `PASS`.
