# CCA-F transcript audit: chunk-05

Scope: transcript L7365-L9205. Cross-page scan: all `topics/ccaf/*.html`; routed pages read in full. "Unsupported" means unsupported by this chunk, not necessarily false or unsupported by another chunk.

## Coverage tally

| Chunk lesson | Transcript lines | Routed chapter | Shipped page evidence | Verdict |
|---|---:|---|---|---|
| Reliable output examples | L7365-L7425 | C05 | `05-prompt-output-quality.html#examples`: positive, negative, scored examples; consistency/hallucination boundary. `c05-q01`, `c05-q02`, `c05-r01`, `c05-r02`. | COVERED |
| Goal and quality-criteria coordination | L7426-L7816 | C05 | `05-prompt-output-quality.html#criteria`: concrete criteria, logging is not enforcement, batch persistence. `07-evidence-context.html#findings`: source/excerpt records. | PARTIAL |
| Programmatic enforcement gates | L7817-L8061 | C04 | `04-reliable-orchestration.html#refinement` has a finalization/coverage gate; `#observability` rejects logged score as enforcement. No prerequisite-before-tool or pre/post interception. | PARTIAL |
| Structured human handoff | L8062-L8253 | C13 | `13-batch-and-escalation.html#support-state` preserves request, attempt, trigger, clarification history; `c13-q03`, `c13-r04` mention handoff context. No explicit assembled package before escalation or no-history-search purpose. | PARTIAL |
| SDK pre/post tool hooks | L8254-L8339 | C06 | No hook section, hook timing, match-all, or tool-specific matching in `06-tools-mcp-structured-output.html`; only general tool-choice controls. Exact SDK API surface is version-sensitive. | MISSING |
| Prompt chaining | L8340-L8493 | C02 | `02-decision-orchestration.html#fixed-vs-adaptive`: fixed sequence, output-to-next-input, document/content transformation, fixed-shape fit; `c02-q03`, `c02-r03`. | COVERED |
| Dynamic adaptive decomposition | L8494-L9176 | C02 | `02-decision-orchestration.html#fixed-vs-adaptive`: intermediate evidence changes next work, agent, depth, order; open-ended fit. No one-time unvisited-state gate, code-engine/model boundary, shared world state, or generated-system validation. | PARTIAL |
| Adaptive investigation | L9177-L9200 | C02 | `02-decision-orchestration.html#fixed-vs-adaptive`: unknowns, conclusion-changing evidence, verification claim, targeted work; `c02-q04`, `c02-r04`. | COVERED |
| Raw findings dilemma | L9201-L9205 | C07 | `07-evidence-context.html#findings`: raw text blob loses traceability/attribution. Source stops before remedy; page remedy content is assessed below. | COVERED |

## Missing content

(a) Transcript fact absent from every shipped page:

- L7426-L7816: Quality criteria need explicit source diversity, a per-finding quality breakdown, and feedback rather than one coordinator-only logged score. `05-prompt-output-quality.html#criteria` says logging is insufficient, but no page teaches diversity or per-finding feedback. Why: repeated weak/same-source evidence can pass a quantity/coverage count. Target: `05-prompt-output-quality.html#criteria`.
- L7426-L7816: A finding's cited source is research document, not researched item; it also needs supporting excerpt. `07-evidence-context.html#findings` retains provenance generally but does not teach this item-versus-source discriminator. Why: avoids treating an entity name as evidence provenance. Target: `07-evidence-context.html#findings`.
- L7817-L8061: Prompt instruction can be ignored; prerequisite state must structurally block invalid tool order, with pre-tool blocking and post-tool inspection placed at tool-call boundary. No shipped page teaches research-before-synthesis prerequisite or tool-order enforcement. Why: finalization coverage gate does not prevent an invalid earlier tool call. Target: new `04-reliable-orchestration.html#enforcement-gates`.
- L8062-L8253: Build structured handoff package before escalation, after automated attempt; recipient should not reconstruct context from conversation history. `13-batch-and-escalation.html#support-state` names retained state but not package assembly/timing/recipient benefit. Why: escalation receives actionable context, not raw history. Target: `13-batch-and-escalation.html#support-state`.
- L8494-L9176: Prompt statement "move to unknown room" is not a guarantee. Model invocation must be programmatically limited to unvisited state; generated room then becomes permanent and code engine owns later play. No shipped page covers this model/code boundary. Why: prevents model execution on every input and makes boundary testable. Target: new `02-decision-orchestration.html#adaptive-boundaries`.
- L8494-L9176: Generated multi-agent systems require observable, incremental validation against actual artifacts/behavior; demo lacked expected person/lore output and configuration handling. No shipped page connects adaptive decomposition to this validation discipline. Why: valid-looking agent folders/prompts do not prove stated behavior. Target: new `02-decision-orchestration.html#adaptive-boundaries`, cross-link `11-diagnostics-automation.html#run-evidence`.

(b) None found: no page directly contradicts a transcript statement in L7365-L9205.

(c) Version-sensitive omission boundary: L8254-L8339 exact Agent SDK hook names, failure events, and matcher syntax remain absent. Do not add uncaveated API claims; if teaching conceptual hook timing/matching, label target SDK/version and verify it.

## Wrong or distorted content

No direct contradiction found.

- Page text: `04-reliable-orchestration.html#refinement` says "finalizes only through a gate." Transcript: a prerequisite gate means "don't let this [tool] run until it is done" and makes sequence skipping structurally impossible (L7817-L8061). Corrected wording: call this an evaluation/finalization gate; separately teach prerequisite enforcement gate for tool-call order. This is terminology conflation, not a false statement.
- Page text: `13-batch-and-escalation.html#support-state` says "bot handling ... human queue ... human active ... resolved." Transcript describes automated attempt, handoff build/staging, then escalation, but no queue-state lifecycle (L8062-L8253). Corrected wording: label queue lifecycle as a separate support-process model; state transcript-supported handoff sequence independently.

## Unsupported additions

(c) Page claims beyond this chunk; retain only with evidence from another assigned chunk or hedge as general practice:

- `13-batch-and-escalation.html#escalation` claims explicit human request, policy ambiguity, legal/fraud dispute, failed request, repeated failure, and multiple-match clarification triggers. Chunk source only demonstrates order lookup/refund/fraud-flag attempt then handoff/escalation (L8062-L8253). Keep if chunk-10 evidence supports; otherwise hedge as "example policy triggers," not this lesson's rule.
- `13-batch-and-escalation.html#support-state` claims queue/active/resolved state flow. No basis in L8062-L8253. Keep as sound general practice only if separately sourced; otherwise delete from this lesson's evidence framing.
- `07-evidence-context.html#findings` says structured records with source, location, excerpt, confidence solve blob loss. L9201-L9205 establishes attribution loss but ends before remedy. Keep only if chunk-06/source continuation supports it; otherwise hedge as later evidence-model guidance.
- `07-evidence-context.html#synthesis` adds conflict retention, deduplication, and attributed answer workflow. No basis in L9201-L9205. Keep if later chunk evidence supports; do not attribute to raw-findings lesson alone.
- `05-prompt-output-quality.html#criteria` adds false-positive/review-burden effects of specificity. Chunk gives criteria/rigidity and findings quality, not those particular effects (L7426-L7816). Keep as sound general practice, but do not present as transcript-derived claim for this lesson.

## Question fidelity

- Correct/direct: `c05-q01`, `c05-q02`, `c05-r01`, `c05-r02` accurately test positive/negative/scored examples and no truth guarantee (L7365-L7425). `c02-q03`, `c02-r03` accurately test fixed output-forward chain (L8340-L8493). `c02-q04`, `c02-r04` accurately test finding-to-verification-subtask adaptation (L9177-L9200).
- Unsupported relative to this chunk: `c13-q03`, `c13-r03`, `c13-r04` test explicit-human-request and policy-trigger rules, not structured package assembly before escalation (L8062-L8253). Keep only if chunk-10 supplies their basis; add one handoff-package question/recall instead.
- Unsupported relative to raw-findings partial lesson: `c07-q01`, `c07-r01`, `c07-r02`, `c07-r03` prescribe provenance fields/remedy beyond L9201-L9205. Their content may be supported elsewhere, but not by this incomplete lesson; cite later source or decouple from lesson 9.
- Missing assessment: no `data-mcq`/`data-recall` tests prerequisite enforcement versus prompt guidance (L7817-L8061), structured pre-escalation handoff (L8062-L8253), adaptive programmatic boundary/one-time generation (L8494-L9176), or hook timing/matching (L8254-L8339; version-caveated if added).

## Terminology drift

| Transcript term | Page term | Assessment |
|---|---|---|
| good/bad/scored examples (L7365-L7425) | positive/negative/scored examples, `05...#examples` | Defensible normalization; preserve that bad example bounds undesired output. |
| goal and quality criteria (L7426-L7816) | criteria and scope, `05...#criteria` | Partial drift: page retains criteria but loses coordinator-specific goal, source diversity, and per-finding feedback. |
| prerequisite gate / enforcement gate (L7817-L8061) | finalization gate, `04...#refinement` | Not interchangeable. Evaluation gate decides completion; prerequisite gate blocks invalid tool progression. |
| handoff protocol/package (L8062-L8253) | support state/progressive handoff, `13...#support-state` | Partial drift. State can feed package, but package must be assembled for recipient before escalation. |
| pre-tool use/post-tool use hooks (L8254-L8339) | no page term | Missing; preserve SDK/version caveat. |
| prompt chaining/sequential pipeline (L8340-L8493) | prompt chaining/fixed chain, `02...#fixed-vs-adaptive` | Defensible. |
| dynamic adaptive decomposition (L8494-L9176) | dynamic adaptive decomposition/evidence-led decomposition, `02...#fixed-vs-adaptive` | Defensible core term; page omits programmatic boundary. |
| raw findings as single blob (L9201-L9205) | raw text blob, `07...#findings` | Defensible; page must not claim chunk supplies complete remedy. |

## Severity-ordered fix list

1. High - `topics/ccaf/04-reliable-orchestration.html`, new `#enforcement-gates`: distinguish prompt guidance from structural prerequisite gate; show pre-tool block, post-tool inspection, and research-before-synthesis ordering. Source: L7817-L8061.
2. High - `topics/ccaf/02-decision-orchestration.html`, new `#adaptive-boundaries`: add code-engine versus model-generator boundary, programmatic unvisited-state gate, permanent generated state, and observable incremental validation. Source: L8494-L9176.
3. High - `topics/ccaf/13-batch-and-escalation.html#support-state`: state sequence automated attempt -> assemble/stage structured package -> escalate; list recipient-context purpose without history search. Source: L8062-L8253.
4. Medium - `topics/ccaf/05-prompt-output-quality.html#criteria`: add source diversity, evidence/source requirements, per-finding quality breakdown/feedback, and source-document versus researched-item distinction; retain batch persistence. Source: L7426-L7816.
5. Medium - `topics/ccaf/07-evidence-context.html#findings`: add item-versus-cited-document discriminator, or link it to C05 criteria. Source: L7426-L7816.
6. Medium - `topics/ccaf/13-batch-and-escalation.html#escalation` and `#support-state`: cite chunk-10 evidence or hedge/remove trigger list and queue lifecycle from chunk-05 handoff framing. Source gap: L8062-L8253.
7. Medium - `topics/ccaf/07-evidence-context.html#findings` and `#synthesis`: cite continuation/chunk-06 evidence for structured remedy, conflict/deduplication workflow; L9201-L9205 only establishes attribution-loss problem.
8. Low - `topics/ccaf/06-tools-mcp-structured-output.html`, new version-caveated `#tool-hooks`: only after target SDK/version verification, teach conceptual pre/post timing and all-tool versus named-tool matching. Source: L8254-L8339.
9. Low - `topics/ccaf/04-reliable-orchestration.html#refinement`: rename/qualify finalization gate so it cannot be mistaken for prerequisite enforcement. Source: L7817-L8061.
10. Low - question sections: add applied items for fixes 1-3; retain `c05-q01`, `c05-q02`, `c02-q03`, `c02-q04`; re-source `c13-q03`/related recall and `c07-q01`/related recall to their actual transcript chunks. Source: L7365-L7425, L7817-L9205.
