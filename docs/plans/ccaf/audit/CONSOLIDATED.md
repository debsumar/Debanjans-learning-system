# CCA-F transcript audit: consolidated work order

## Verdict summary

84 transcript lessons tallied: 38 COVERED, 44 PARTIAL, 2 MISSING. Weakest: C09 (session/settings categories and stable state distinctions), C03 (coordinator ownership/context contradictions), C04 (recovery and enforcement), C07 (provenance/artifact contracts), and C11 (runtime evidence). C06, C08, and C13 core coverage is strong; remaining work is precision and boundaries. Lesson tally basis: L20-L18407. Chapter weaknesses are qualitative because some lessons route to multiple chapters.

## Blocking corrections

| File | Section or item | Wrong text | Corrected text | Transcript |
|---|---|---|---|---|
| `03-coordinator-design.html` | `#partitioning`, `c03-q07`, `c03-r08` | Planner owns selection and partitioning; coordinator delegates supplied partitions exactly once. | Coordinator owns decomposition, selection, routing, delegation, collection, and aggregation. Planner output may inform it, never become independent routing ownership. Reword existing question and recall; keep IDs/counts. | L3061-L3201 |
| `03-coordinator-design.html` | `#delegation` | Use sequential delegation only when later work needs an earlier result. | Sequential is required when dependency exists **or coordinator policy requires order**; parallel only when both independence and policy permit it. | L2922-L2956, L3232-L3286 |
| `03-coordinator-design.html` | `#handoff` | Subagents operate with isolated context; do not assume worker sees parent conversation. | Handoff must be explicit. Demonstrated spokes received full job/resume context; narrow context and scope enforcement are controls to validate, not default behavior. | L4652-L4664 |
| `03-coordinator-design.html` | `c03-q04` | Researcher returns verified facts. | Researcher returns gathered facts; transcript does not establish verification. Keep ID/count. | L7223-L7278 |
| `04-reliable-orchestration.html` | `#recovery` | Startup scan/reconciliation/resume presented as operating flow. | Recovery exists only when automatically invoked before every dispatch. Demonstrated coordinator was manually invoked; persist incrementally because reconciliation cannot restore unwritten work. | L14729-L15303, L16469-L16569 |
| `06-tools-mcp-structured-output.html` | `#mcp` | Read data directly through a mapped resource or schema. | Resource denotes read-data intent and may use callable server logic; it neither bypasses server logic nor enforces immutability. | L16850-L16856, L16908-L17040 |
| `12-agent-definitions-delegation.html` | `#agent-definition`, `c12-q01` | Name is reader-facing label; description alone drives routing. | Name and description are routing-sensitive. Inspect both, especially task-specific description wording. Keep item ID/count. | L5966-L6015 |

## Missing content worth adding

All additions fit registered existing section IDs and existing objectives. Do not create sections, objective IDs, MCQ IDs, or recall IDs.

| Rank | Target file | Target section | Add | Transcript | Size |
|---|---|---|---|---|---|
| P0 | `03-coordinator-design.html` | `#hub-spoke`, `#delegation`, `#handoff` | Generic task manager versus coordinator; named worker roles, literal-evidence boundary, dynamic selection/skip-route examples, policy-ordered independent work, and representative-data plus human-judgement evaluation. | L2962-L3286, L3683-L4037 | New comparison table plus 3 bullets |
| P0 | `04-reliable-orchestration.html` | `#refinement` | Separate evaluation/finalization gate from structural prerequisite enforcement: pre-tool block, post-tool inspection, research-before-synthesis order. | L7817-L8061 | New subsection inside existing section |
| P0 | `04-reliable-orchestration.html` | `#recovery` | Automatic pre-dispatch recovery boundary, incremental writes, failure injection, scratchpad-plus-synthesis as one result path; no duplicate results state. | L14729-L15303, L16469-L16569 | New worked-scenario block |
| P0 | `07-evidence-context.html` | `#findings` | Plain-list versus structured-finding mismatch, silent empty artifact, error logging, compatible fallback conversion; URL/document/page/excerpt locator; cited document versus researched item; generated-research review checklist. | L5524-L5794, L7426-L7816, L9206-L9774 | New diagnosis table plus 4 bullets |
| P0 | `07-evidence-context.html` | `#durable-artifacts` | File-backed selected case facts/current-room filtering; explorer writes only findings/manifest, never source; append-only scratchpad; synthesizer/coordinator consume focused artifacts rather than raw source; manifest supports resume after interruption. | L15748-L16468 | New worked scenario |
| P0 | `11-diagnostics-automation.html` | `#status-debug`, `#run-evidence` | Check claimed sources against actual tool use; progress logs distinguish wait/stall; rate-limit versus max-usage/empty-artifact diagnosis; reduce exploration to one axis; reusable parser and relative ISO per-run log. | L920-L1213, L14729-L15303 | Two compact tables |
| P1 | `02-decision-orchestration.html` | `#fixed-vs-adaptive` | Code-owned execution versus model-generated state; programmatic unvisited-state gate; persist generated state; incrementally validate actual artifacts/behavior. | L8494-L9176 | New comparison row plus 3 bullets |
| P1 | `08-claude-code-workflows.html` | `#models` | Recording-time, version-caveated model matrix: normal same-model loop; default, Sonnet, Opus, Haiku, long-context Sonnet; Opus planning then Sonnet execution. | L1408-L1458 | Table |
| P1 | `09-sessions-settings.html` | `#session-lifecycle` | Managed fork identity/history/resume versus copied messages; web/local origin versus workspace context; rewind restore-history versus summarize-from-point choice. | L9779-L10105, L10258-L10414, L10808-L10882 | Table plus 2 bullets |
| P1 | `09-sessions-settings.html` | `#context`, `#settings-scopes` | Autocompact reserved headroom; clear removes conversation history but can retain non-conversation guidance/memory; higher scope wins; category map for auth, storage, environment, model, output preferences; response language differs from UI language. Omit volatile keys, paths, provider names, percentages. | L10491-L10509, L10631-L10659, L10883-L11046, L11891-L12210 | Two tables |
| P1 | `10-permission-safety.html` | `#rule-resolution`, `#sandbox`, `#bypass-risk`, `#modes` | Selector-scope matrix; default marker versus explicit policy; network approval distinct from permission/Bash sandbox; Bash fallback/non-Bash route; blocked-command -> bypass-permitted sandbox-disable -> escaped containment; alternate Glob/Grep path; space/path-scope examples. | L11047-L11890, L12211-L13093 | Two tables plus one causal callout |
| P1 | `12-agent-definitions-delegation.html` | `#sdk-parity`, `#delegation`, `#ownership` | Historical `task`/current `agent` caveat, lifecycle messages, parent-blocking qualification, direct-SDK versus internal-MCP port boundary, refactor destinations, and defer shorthand redesign pending SDK validation. | L5201-L5523, L6893-L7136, L7137-L7364 | Three compact callouts |
| P1 | `13-batch-and-escalation.html` | `#batch-choice`, `#support-state` | Batch cannot perform response-dependent interactive tool loop; automated attempt -> structured recipient-ready handoff package -> escalation, distinct from raw-history search. | L8062-L8253, L16675-L16683 | Two bullets plus sequence row |
| P2 | `01-agent-loops.html` | `#stop-reasons`, `#tool-turn` | Literal `tool_use` and `end_turn` returned-control terminology; inventory check -> result append -> order only if available; function-calling alias. | L1479-L1581, L2642-L2726, L1745-L1752 | 3 bullets |
| P2 | `02-decision-orchestration.html` | `#coverage` | Initial versus omitted EV dimensions: policy/subsidy, secondhand market, adoption barriers, lithium/cobalt supply, grid capacity, charging; use as decomposition coverage check. | L3351-L3466 | Table row set |
| P2 | `04-reliable-orchestration.html` | `#observability` | Timestamp, level, token count, request ID, spoke input/output, partition-question linkage, staged out-of-scope/context-pollution testing. | L4635-L4664, L4820-L4860 | Trace-field table |
| P2 | `05-prompt-output-quality.html` | `#examples`, `#criteria` | Measurement-extraction few-shot example; activity does not prove returned-result quality; scoped web access; source diversity and per-finding feedback. | L5795-L5920, L7426-L7816 | Worked example plus 3 bullets |
| P2 | `06-tools-mcp-structured-output.html` | `#tool-selection`, `#mcp` | Prescriptive tool descriptions guide selection apart from schemas; `function calling` alias; MCP resource less-back-and-forth rationale; C10 permission-policy cross-link. | L1745-L1841, L13094-L13176, L16827-L17040 | 4 bullets |
| P2 | `11-diagnostics-automation.html` | `#validate-change`, `#actions` | Direct SDK versus Agent SDK/internal-MCP port comparison, tool-factory ownership and target validation; configured issue/PR-comment/issue events; trigger -> action -> observed branch/PR check. | L6893-L7136, L17041-L17855 | Comparison table plus sequence |
| P2 | `13-batch-and-escalation.html` | `#batch` | Request-level `custom_id` correlation only; remove any completion-order implication. | L16668-L16756 | Sentence |
| P3 | `06-tools-mcp-structured-output.html` | `#tool-selection` | Conceptual pre-tool/post-tool timing and all-tool versus named-tool matching, explicitly target-SDK/version-caveated. Do not name API surface until verified. | L8254-L8339 | Callout |

## Unsupported claims to hedge or remove

| File | Section | Text | Action | Transcript |
|---|---|---|---|---|
| `03-coordinator-design.html` | `#handoff` | Assigned tools/only needed tool capability presented as transcript rule. | Mark as general least-privilege guidance, not source claim. | L2862-L2956, L3061-L3201 |
| `04-reliable-orchestration.html` | `#recovery` | Persisted state alone implies recoverability. | Hedge: only state written before failure is recoverable; require automatic invocation separately. | L14729-L15303, L16469-L16569 |
| `09-sessions-settings.html` | `#version-checks` | Reversible test on non-sensitive data presented as transcript procedure. | Keep as author safety guidance, label it general practice. | L10112-L10257 |
| `10-permission-safety.html` | `#bypass-risk` | Mandatory credential revocation, named sensitive-system exclusions, and cleanup example presented as transcript behavior. | Keep only as clearly labelled author safety guidance. | L11379-L11890 |
| `11-diagnostics-automation.html` | `#actions` | Runner is isolated; human review is universally mandatory. | Hedge as repository governance/general platform practice, not transcript guarantee. | L17067-L17073, L17601-L17852 |
| `12-agent-definitions-delegation.html` | `#ownership` | Test seams and preserved-artifact checks are transcript-equivalent refactor requirements. | Hedge as general validation practice; source requires readable separated ownership, not this exact contract. | L5201-L5523 |
| `13-batch-and-escalation.html` | `#batch`, `c13-q02` rationale | Correlation works even when completion order differs. | Replace with request-level ID association; source gives no ordering assertion. | L16668-L16756 |

## Terminology corrections

| File | Current term | Transcript term | Change? | Transcript |
|---|---|---|---|---|
| `01-agent-loops.html` | tool-use state; terminal state | `tool_use`; `end_turn`; returned `stop_reason` JSON field | Yes; retain readable prose, print literal tokens. | L1479-L1529 |
| `02-decision-orchestration.html` | prompt chain for tool sequence/state machine | preconfigured decision tree/code-driven decision-making; tool sequence/state machine | Yes; do not use prompt chaining as replacement. | L2232-L2381 |
| `04-reliable-orchestration.html` | retry cap for refinement | iteration bound | Yes; reserve retry for failed-action/validation remediation. | L4404-L4435 |
| `06-tools-mcp-structured-output.html` | tool use only; read-only resource | tool use/function calling; resource read-data intent | Yes; add alias and avoid immutability implication. | L1745-L1752, L16908-L17040 |
| `07-evidence-context.html` | durable artifacts as one undifferentiated term | findings, manifest, scratchpad, synthesizer | Yes; retain distinct roles/permissions. | L15930-L16468 |
| `09-sessions-settings.html` | session fork; scope | fork-based session management; higher scope wins | Yes; add identity/resume and precedence discriminators. | L9779-L10105, L10883-L10933 |
| `12-agent-definitions-delegation.html` | Agent only | historical `task`; current `agent` | Yes, caveated; validate target SDK. | L7137-L7172, L7319-L7364 |
| `13-batch-and-escalation.html` | request-level correlation identifier | `custom_id` | Yes; retain literal once beside neutral term. | L16668-L16756 |

## Explicitly NOT actionable

| Item | Decision | Transcript |
|---|---|---|
| Reported exam format, scores, timings, and certification requirements | Do not add. Official guide remains unavailable/unverified; transcript claims are not curriculum facts. | L20-L220 |
| Exact install/auth commands, CLI labels, status/debug commands, paths, token/provider displays, SDK method names, hook matcher syntax, rejected `force` literal | Do not add as stable teaching. Preserve target-version validation only. | L564-L918, L8254-L8339, L10112-L10257, L13177-L14097 |
| Fixed model identifiers, fixed context percentage, retention number, setting keys/paths, provider names, UI details | Do not add. Teach stable conceptual boundary with recording-time/version caveat. | L10491-L11046, L1408-L1458 |
| Batch SLA/up-to-24-hours claim, workflow YAML, action/API-key setup, exact server syntax | Do not add. Product/configuration details age quickly. | L16642-L16645, L17359-L17545 |
| New page sections, objective IDs, MCQ IDs, recall IDs, or additional questions/recall | Do not add. Fold prose into registered sections. Reword existing identified items only; preserve chapter and global question counts. | L3061-L3201, L7817-L8061, L9779-L11046 |
| New question proposals for settings, selector scope, recovery, provenance, hooks, automation, or handoff | Reject unless a separate registry-contract change is approved first. This work order authorizes prose and existing-item corrections only. | L7817-L8253, L9779-L13093, L14729-L15303 |
| Uncaveated claim that source transcript proves all large-context controls, all recovery wiring, or resource immutability | Do not make. Source demonstrations have stated limits. | L15671-L15929, L16469-L16569, L16908-L17040 |

## Fix batches

All batches are file-disjoint and can run in parallel. Preserve existing section IDs, objective IDs, page shell, diagram contracts, and stated MCQ/recall counts. No batch creates questions or recall items; only B03 and B12 reword identified existing items.

| Batch | File and existing sections | Work | Registry-fixed counts preserved | Transcript |
|---|---|---|---|---|
| B01 | `01-agent-loops.html`: `#stop-reasons`, `#tool-turn` | Literal controls, function-calling alias, inventory-before-order example. | C01: 8 MCQ, 8 recall; no ID changes. | L1479-L1581, L1745-L1752, L2642-L2726 |
| B02 | `02-decision-orchestration.html`: `#fixed-vs-adaptive`, `#coverage` | Adaptive code/model boundary; EV gap coverage; canonical decision terminology. | C02: 7 MCQ, 7 recall; no ID changes. | L2232-L2381, L3351-L3466, L8494-L9176 |
| B03 | `03-coordinator-design.html`: `#hub-spoke`, `#delegation`, `#partitioning`, `#handoff`, existing `c03-q04`, `c03-q07`, `c03-r08` | Correct ownership, ordering, context, and gathered-facts wording; add coordinator/dynamic-selection material. | C03: 10 MCQ, 10 recall; reword only listed IDs. | L2842-L4037, L4550-L4664, L7223-L7278 |
| B04 | `04-reliable-orchestration.html`: `#refinement`, `#observability`, `#recovery` | Enforcement versus evaluation, trace/test fields, automatic recovery/incremental persistence; rename retry cap. | C04: 9 MCQ, 9 recall; no ID changes. | L4393-L4860, L7817-L8061, L14729-L15303, L16469-L16569 |
| B05 | `05-prompt-output-quality.html`: `#examples`, `#criteria` | Measurement extraction, scoped web access/activity-quality boundary, diversity/per-finding feedback. | C05: 9 MCQ, 9 recall; no ID changes. | L5795-L5920, L7426-L7816 |
| B06 | `06-tools-mcp-structured-output.html`: `#tool-selection`, `#mcp` | Description-versus-schema, function-calling, caveated hooks, resource semantics/rationale, C10 policy link. | C06: 10 MCQ, 10 recall; no ID changes. | L1745-L1841, L8254-L8339, L13094-L13176, L16775-L17040 |
| B07 | `07-evidence-context.html`: `#findings`, `#durable-artifacts` | Finding mismatch/provenance/review and durable-artifact role/write contracts. | C07: 9 MCQ, 9 recall; no ID changes. | L5524-L5794, L7426-L7816, L9206-L9774, L15748-L16468 |
| B08 | `08-claude-code-workflows.html`: `#models` | Version-caveated recording-time model decision matrix. | C08: 7 MCQ, 7 recall; no ID changes. | L1408-L1458 |
| B09 | `09-sessions-settings.html`: `#session-lifecycle`, `#context`, `#settings-scopes` | Fork/origin/rewind, compact/clear, precedence/categories/language distinctions. | C09: 12 MCQ, 12 recall; no ID changes. | L9779-L11046, L11891-L12210 |
| B10 | `10-permission-safety.html`: `#rule-resolution`, `#sandbox`, `#modes`, `#bypass-risk` | Selector/default-policy, gates/fallback, matcher examples, causal bypass warning; hedge general advice. | C10: 7 MCQ, 7 recall; no ID changes. | L11047-L13093 |
| B11 | `11-diagnostics-automation.html`: `#status-debug`, `#run-evidence`, `#actions`, `#validate-change` | Runtime/provenance evidence, logs/limits, port validation, automation trigger-to-artifact boundary; hedge runner/review claims. | C11: 6 MCQ, 6 recall; no ID changes. | L920-L1213, L6893-L7136, L14729-L15303, L17041-L17855 |
| B12 | `12-agent-definitions-delegation.html`: `#agent-definition`, `#sdk-parity`, `#delegation`, `#ownership`, existing `c12-q01` | Correct routing surfaces; version/lifecycle/parent-blocking/port/refactor material; hedge test-seam doctrine. | C12: 6 MCQ, 6 recall; reword only `c12-q01`. | L5201-L5523, L5921-L6165, L6893-L7136, L7137-L7364 |
| B13 | `13-batch-and-escalation.html`: `#batch`, `#batch-choice`, `#support-state`, existing `c13-q02` rationale | Noninteractive batch mechanism, correlation correction, structured handoff sequence. | C13: 4 MCQ, 4 recall; reword rationale only. | L8062-L8253, L16631-L16774 |
