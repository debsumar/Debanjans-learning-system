# CCA-F transcript audit: chunk 09

Scope: transcript `/tmp/ccaf-chunks/chunk8`, lines 14729-16569. Read in four 500-line slices. Routing checked in `docs/plans/ccaf/chunk-09.plan.md` and `docs/plans/ccaf/PLAN.md`; all `topics/ccaf/*.html` searched. No shipped file changed. Audit directory supplied `chunk-01` through `chunk-08`; this file adds chunk 09. No chunk-10 findings file existed at audit time. "Unsupported" means no basis in this chunk unless another cited chunk owns it. Deliberate omissions of exam format, scores, timings, and version-sensitive SDK/CLI specifics are excluded.

## Coverage tally

| Chunk lesson | Transcript lines | Routed chapter | Shipped page evidence | Verdict |
|---|---:|---|---|---|
| Independent multi-instance review | 15304-15488 | C05 | `05-prompt-output-quality.html#review`; `data-mcq="c05-q07"`; `data-recall="c05-r07"`: same-conversation history anchors self-review; fresh independent context reduces risk but proves nothing alone. | COVERED |
| Validation, retry, and remediation loops | 15489-15670 | C04, C05 | `05-prompt-output-quality.html#validation`; `c05-q05`, `c05-q06`, `c05-r05`, `c05-r06`; `04-reliable-orchestration.html#recovery`, `c04-q09`: precise error feedback, bounded correction, schema/semantic distinction, and absent-source stop. | COVERED |
| Large-context failure modes | 15671-15747 | C07 | `07-evidence-context.html#context-loss`; `c07-q04` through `c07-q06`; `c07-r05-r06`: preserve exact facts, section-process large sources, and filter tool output. | COVERED |
| Persisted facts and filtered tool output | 15748-15929 | C07 | `07-evidence-context.html#durable-artifacts`, `c07-q06`, `c07-r07`: generic persisted facts and reduced tool fields. No file-backed case-facts/current-room/world-state worked scenario or stated non-demonstration of document section processing. | PARTIAL |
| Context-safe codebase exploration architecture | 15930-16161 | C07 | `07-evidence-context.html#durable-artifacts`, `c07-q07`, `c07-r08`: findings versus manifest, explorer raw-material read, coordinator uses focused artifacts. No explicit coordinator raw-source prohibition or interruption causes. | PARTIAL |
| Explorer and synthesizer contracts | 16162-16468 | C07 | `07-evidence-context.html#durable-artifacts`, `c07-q08`, `c07-r07`: task question, entry points, call chain, key files, append-oriented scratchpad, and synthesis without reopening raw source. Missing write-scope/source-mutation ban, manifest-update contract, and append-not-rewrite rule. | PARTIAL |
| Orchestration evaluation and recovery gaps | 16469-16569 | C04 | `04-reliable-orchestration.html#recovery`; `c04-q07` through `c04-q09`; `c04-r07-r09`: happy-path boundary, interruption injection, reconciliation, preserved findings, and resume. No manual-invocation gap, always-run coordination instruction, or duplicate `results JSON` removal. | PARTIAL |
| Provenance, observability, and rate-limit diagnosis | 14729-15303 | C11 | `11-diagnostics-automation.html#status-debug`, `#run-evidence`, `c11-q02`, `c11-r02`: logs/artifacts versus completion wording. No claimed-source/tool-use check, progress-log purpose, rate-limit/concurrency response, or max-usage empty-artifact diagnosis. | PARTIAL |

## Missing content

| Transcript fact absent from all shipped pages | Transcript lines | Why it matters | Exact target chapter and section |
|---|---:|---|---|
| File-backed selected case facts are loaded into every iterative prompt; a full world-state response is filtered to current-room facts before prompt construction. The demo does not test section-processing for a very large document. | 15748-15929 | Separates persistent prompt-relevant state from complete state and prevents claiming the demo proves all large-context controls. | `topics/ccaf/07-evidence-context.html#durable-artifacts` |
| Explorer contract: only findings paths and manifest are writable; source files must never be modified; scratchpads append new material and never rewrite prior sections. | 16162-16351 | Durable notes alone do not enforce investigation-only access or preserve earlier evidence during resume. | `topics/ccaf/07-evidence-context.html#durable-artifacts` |
| Coordinator context boundary: explorer reads noisy raw code; coordinator uses findings/manifest rather than raw source; manifest supports recovery after shutdown, error, or credit exhaustion. | 15930-16161 | Defines why role separation protects coordinator reasoning rather than merely distributing work. | `topics/ccaf/07-evidence-context.html#durable-artifacts` |
| Recovery must be automatically invoked before dispatch. Source found coordinator was manually run, prefers standing coordination instructions over an explicitly invoked skill, and removes competing `results JSON` in favor of scratchpad-plus-synthesis. | 16469-16569 | A manually runnable reconciler does not make recovery reliable; duplicate state paths obscure the source of truth. | `topics/ccaf/04-reliable-orchestration.html#recovery` |
| Claimed citations without preserved original sources indicate tools may not have run; add progress logging to distinguish wait from stall; reduce parallel exploration to one axis after a 50,000-input-token-per-second limit; treat completion wording plus empty files after max usage as incomplete. | 14729-15303 | Separates provenance failure, observability gap, throughput limit, usage ceiling, and durable-completion failure. | `topics/ccaf/11-diagnostics-automation.html#status-debug` and `#run-evidence` |

## Wrong or distorted content

| Page text | Transcript evidence | Corrected wording |
|---|---|---|
| `04-reliable-orchestration.html#recovery`: "At startup, the coordinator scans recorded state, reconciles stuck work, and resumes..." | The source first identifies happy-path-only implementation, then says recovery needs a wrapper/startup scan/failure test. Its later coordinator was run manually and not wired automatically; source recommends coordination instructions that run before every dispatch (16469-16569). | "Startup reconciliation is required only when wired into every dispatch path. The demonstrated coordinator was manually invoked; add an automatic pre-dispatch coordination boundary before claiming operational recovery." |
| `04-reliable-orchestration.html#recovery`: recovery prose treats persisted findings and reconciliation as sufficient flow. | Source reports prior failure before scratchpad write under rate limit, requires incremental writes, then later distinguishes a resumed row from an actual durable finding update (14729-15303; 16469-16569). | "Persist state and append findings incrementally; reconciliation can resume recorded work, but cannot recover work never persisted." |

## Unsupported additions

No page claim directly tied to this chunk requires deletion. Routed C05/C04/C07/C11 teaching is either transcript-supported here or covered by another audited chunk. Keep cross-chunk material source-qualified:

- `05-prompt-output-quality.html#review` field-level confidence, segmented accuracy, stratified sampling, and human routing are not supplied by this chunk's peer-review demonstration; they are supported by chunk-08 review material (14147-14580). Retain with that ownership, not as evidence from lines 15304-15488.
- `11-diagnostics-automation.html#actions` repository trigger, secret, branch/PR, and review-path guidance is outside this chunk's runtime diagnosis. Keep as sound general practice or source it to the owning automation lesson; do not use lines 14729-15303 as its basis.
- `07-evidence-context.html#synthesis` conflict retention and attributed answer workflow are not part of the case-facts/code-explorer demonstrations. Retain only under its provenance/synthesis source ownership, not as a consequence of persisted facts alone (15748-16468).

## Question fidelity

| IDs | Finding | Transcript lines | Disposition |
|---|---|---:|---|
| `c05-q05`, `c05-q06`, `c05-r05`, `c05-r06` | Schema/syntax versus semantic/business validation; precise returned error; capped remediation; absent source information terminal path. | 15489-15670 | Keys and rationales supported. |
| `c05-q07`, `c05-r07`, `rev-d10` | Fresh independent reviewer versus same-conversation self-review; reduced anchoring, not correctness proof. | 15304-15488 | Keys and rationales supported. |
| `c07-q04` through `c07-q06`, `c07-r05-r06` | Precision-fact reinjection, section processing, and tool-field filtering. | 15671-15747 | Keys and rationales supported. |
| `c07-q07` through `c07-q09`, `c07-r07-r09` | Manifest/recovery state, append-only scratchpad role, findings versus manifest, and coordinator use of focused artifacts. | 15930-16468 | Keys and rationales supported, but add source-mutation/write-scope and case-facts scenarios. |
| `c04-q07` through `c04-q09`, `c04-r07-r09`, `rev-d08` | Reconcile interrupted task, deliberate interruption test, and retry-versus-recovery distinction. | 15489-15670; 16469-16569 | Keys supported. Qualify any wording that implies recovery is already automatically wired. |
| `c11-q02`, `c11-r02`, `rev-d21` | Completion wording is not durable completion; inspect persisted artifact. | 14729-15303 | Key supported, but add max-usage/empty-artifact scenario and distinguish it from ordinary missing-file failure. |
| C11 question set | No item tests absent original sources despite claimed research, progress logs for opaque wait, rate-limit response, one-axis scope reduction, or max-usage empty artifacts. | 14729-15303 | Add or replace C11 items after count-contract approval. |

## Terminology drift

| Transcript term | Page term | Assessment |
|---|---|---|
| independent agent/model/new or empty context | independent reviewer/fresh context | Defensible normalization. Retain source discriminator: context independence, not necessarily a different model (15304-15488). |
| validation-retry-feedback loop; specific validation errors | bounded remediation; precise failure | Defensible. Retain explicit error feedback and distinguish validation retry from task recovery (15489-15670; 16469-16569). |
| progressive summarization; lost-in-the-middle | precision loss; lost-in-the-middle risk | Defensible. Retain named vulnerable facts: dates, percentages, and numbers (15671-15747). |
| case facts; world state; current room | persisted facts; tool-output filtering | Too broad as complete coverage. Page term is defensible only if it adds selected file-backed facts and current-context filtering (15748-15929). |
| findings, manifest, scratchpad, synthesizer | durable artifacts | Useful umbrella, but must preserve distinct roles and explorer/synthesizer permissions (15930-16468). |
| happy path; reconciliation; manually run coordinator; `results JSON` | recovery; reconciliation | Partial drift. Current term loses automatic-invocation and duplicate-control-path concerns (16469-16569). |
| provenance failure; web-search progress; token rate limit; max usage | durable evidence; status/debug evidence | Too generic as complete coverage. Add source/tool-execution evidence, runtime progress, rate-limit versus usage-ceiling distinction (14729-15303). |

## Severity-ordered fix list

Consolidated and de-duplicated work order. Inputs: audit findings `chunk-01` through `chunk-08` plus this chunk. Sources are grouped by one target section; later source lines supplement rather than duplicate earlier items.

1. P0 - `topics/ccaf/03-coordinator-design.html#partitioning`, `#delegation`, `#handoff`: restore coordinator ownership of decomposition, selection, routing, delegation, and aggregation; remove separate planner as routing owner; qualify sequential work as dependency- or policy-ordered; state handoff is explicit and current demo may supply broad context. Add adaptive selection, representative-data/human-judgement evaluation, and scope-pollution tests. Sources: 2842-3466, 3683-4037, 4550-4860.
2. P0 - `topics/ccaf/04-reliable-orchestration.html#recovery`: retain reconciliation but add automatic pre-dispatch invocation, incremental finding writes, failure injection, and scratchpad-plus-synthesis as one result path; remove/avoid duplicate `results JSON`. State manual coordinator invocation was an observed gap, not a completed control. Sources: 14729-15303, 16469-16569.
3. P0 - `topics/ccaf/04-reliable-orchestration.html`, new `#enforcement-gates`: distinguish evaluation/finalization gate from prerequisite enforcement. Show prompt guidance versus structural pre-tool block, post-tool inspection, and research-before-synthesis order. Source: 7817-8061.
4. P0 - `topics/ccaf/07-evidence-context.html#durable-artifacts`: add case-facts/world-state worked scenario; explorer writes only findings/manifest, never source; scratchpad append-not-rewrite; synthesizer reads scratchpads rather than raw source; coordinator consumes artifacts rather than noisy raw code. Sources: 15748-16468.
5. P0 - `topics/ccaf/07-evidence-context.html#findings`: add structured-record mismatch diagnosis (plain list versus structured finding), error logging/fallback conversion, concrete URL/document/page/excerpt provenance, generated-research review checklist, and researched-item versus cited-document discriminator. Sources: 5524-5794, 7426-7816, 9206-9774.
6. P0 - `topics/ccaf/11-diagnostics-automation.html#status-debug` and `#run-evidence`: add provenance check for claimed sources versus actual tool execution; progress logs for opaque runs; rate-limit versus max-usage distinction; one-axis/concurrency reduction; completion-plus-empty-artifact classification. Retain reusable parser, project-relative per-run ISO log, and artifact inspection. Sources: 501-1213, 14729-15303.
7. P1 - `topics/ccaf/05-prompt-output-quality.html#validation` and `#review`: retain current correct independent-review/remediation material; add source diversity, per-finding quality feedback, source-document distinction, and measurement-extraction/progress-versus-result-quality scenario. Sources: 7365-8339, 15304-15670.
8. P1 - `topics/ccaf/02-decision-orchestration.html`, new `#adaptive-boundaries`: add code-engine versus model-generator boundary, programmatic unvisited-state gate, durable generated state, and incremental artifact/behavior validation. Sources: 8494-9176.
9. P1 - `topics/ccaf/06-tools-mcp-structured-output.html#tool-selection`, `#schemas`, new version-caveated `#tool-hooks`: add prescriptive tool-description selection rule, function-calling alias, hook timing/matching concepts only after SDK verification, and C10 policy cross-link for default permission markers. Sources: 1745-1841, 8254-8339, 13094-13176.
10. P1 - `topics/ccaf/08-claude-code-workflows.html#models`: add recording-time model-choice matrix: normal same-model loop, default, Sonnet, Opus, Haiku, long-context Sonnet, and Opus-plan/Sonnet-execution; preserve version caveat. Sources: 1408-1458.
11. P1 - `topics/ccaf/09-sessions-settings.html#session-lifecycle`, `#context`, `#settings-scopes`, new `#settings-categories`: add fork identity/resume versus copied messages, web/local origin versus workspace, autocompact reserve, clear-retained non-conversation state, rewind restore-versus-summarize choice, higher-scope precedence, settings categories, and response-language versus UI distinction. Sources: 9779-11046, 11891-12210.
12. P1 - `topics/ccaf/10-permission-safety.html#rule-resolution`, `#sandbox`, `#bypass-risk`, `#modes`: add selector-scope matrix, default-marker versus explicit policy distinction, network approval as separate observed gate, Bash fallback and non-Bash route, blocked-command-to-sandbox-disable causal path, and matcher examples. Sources: 11047-11890, 12211-13093.
13. P1 - `topics/ccaf/12-agent-definitions-delegation.html#agent-definition`, `#sdk-parity`, `#delegation`, `#ownership`: make agent name and description routing-sensitive; add `task`/`agent` history, lifecycle messages, parent-blocking qualification, direct-SDK/internal-MCP port boundary, and concrete ownership/refactor checklist. Sources: 5921-7364.
14. P1 - `topics/ccaf/13-batch-and-escalation.html#support-state` and `#escalation`: add automated attempt -> structured handoff package -> escalation sequence; distinguish recipient-ready package from raw-history search; source or hedge trigger list and queue lifecycle. Sources: 8062-8253.
15. P2 - `topics/ccaf/01-agent-loops.html#tool-turn`, `#loop-exit`; `06-tools-mcp-structured-output.html#mcp`, `#tool-choice`: preserve literal `tool_use`, `end_turn`, and function-calling language; conditionalize protocol IDs/iteration guards and MCP/named-tool claims on their actual source or target protocol. Sources: 1479-1841, 1842-2841.
16. P2 - Question sections for C04/C05/C07/C09/C10/C11/C12/C13: retain source-faithful keys listed in prior audits; replace unsupported or distorted ownership/diagnostic claims; add applied questions for automatic recovery, provenance/tool use, rate-limit versus usage ceiling, enforcement gates, adaptive boundary, settings precedence, selector scope, and handoff package only after count-contract review. Sources: 3061-3201, 7817-8253, 9779-13093, 14729-16569.
