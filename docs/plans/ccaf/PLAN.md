# Claude Certified Architect - Foundations master plan

**Goal:** plan a registry-first, offline-static CCAF topic from ten transcript chunk plans. This is planning only. No implementation asset, registry, launcher, or topic folder exists or is changed here.

## Certification manifest

| Field | Draft value | Status |
|---|---|---|
| Vendor | Anthropic | Transcript-supported course framing. |
| Exam code | `CCA-F` | **UNVERIFIED - needs official exam guide.** Transcript uses it while saying no official code technically exists. |
| Display name | Claude Certified Architect - Foundations | **UNVERIFIED - needs official exam guide.** User-supplied and transcript-framed name. |
| Slug | `ccaf` | Planned repository identifier. |
| Hub path | `topics/ccaf/index.html` | Planned static path. |
| Description | Offline notes for Claude agent architecture, tool/MCP design, Claude Code, output quality, context, and reliability. | Draft repository description; official scope **UNVERIFIED**. |
| Pill labels | `Anthropic`, `CCA-F`, `Offline notes`, `Guide mapping pending` | Product/certification labels **UNVERIFIED - needs official exam guide.** |
| Skills-measured date | `UNVERIFIED - needs official exam guide` | Not established in transcript. |
| Official guide URL | `UNVERIFIED - needs official exam guide` | Do not invent URL. |
| Reported format | 60 MCQs; 120 minutes; 720 passing score; up to 17 misses; verbose questions | **UNVERIFIED - needs official exam guide.** Transcript-only, recording-time report. |

Transcript says development experience and labs matter. Treat as course guidance, not eligibility, exam policy, or official blueprint fact.

## Domain and weight map

| ID | Provisional transcript-derived domain | Weight | Status |
|---|---|---|---|
| d1 | Agentic architecture and orchestration | `UNVERIFIED` | Named in orientation; official wording/weight absent. |
| d2 | Tool design and MCP integration | `UNVERIFIED` | Named in orientation; official wording/weight absent. |
| d3 | Claude Code configuration and workflows | `UNVERIFIED` | Named in orientation; official wording/weight absent. |
| d4 | Prompt engineering and structured output | `UNVERIFIED` | Proposed split of ambiguous orientation wording. |
| d5 | Context management and reliability | `UNVERIFIED` | Proposed split of ambiguous orientation wording. |

No numeric weights are reliable in chunk plans. Do not claim weight-proportional scoring. Current practice allocation follows source-content mass and must be reweighted only after official guide evidence.

## Chapter map

**Count justification:** 13 chapters follow 84 source lessons and their distinct decisions: loop control; decision ownership; coordinator design; reliability/recovery; prompt/output quality; tool/MCP contracts; evidence/context; Claude Code workflows; sessions/settings; permissions; diagnostics/automation; definitions/delegation; batch/escalation. Merging these creates pages too broad for stable objectives and confusion callouts. More splits would fragment repeated concepts.

| NN | Filename | Title | shortTitle | Domain | Weight | Source chunk plans | Objective ID range | MCQ | Recall |
|---:|---|---|---|---|---|---|---|---:|---:|
| 01 | `01-agent-loops.html` | Agent loops and tool-result control | Agent loops | d1 | UNVERIFIED | 01, 02 | `ccaf-c01-o1` - `o6` | 8 | 8 |
| 02 | `02-decision-orchestration.html` | Decision ownership and orchestration | Decision orchestration | d1 | UNVERIFIED | 02, 03, 05 | `ccaf-c02-o1` - `o4` | 7 | 7 |
| 03 | `03-coordinator-design.html` | Coordinator and multi-agent design | Coordinator design | d1 | UNVERIFIED | 02, 03, 04, 05 | `ccaf-c03-o1` - `o4` | 10 | 10 |
| 04 | `04-reliable-orchestration.html` | Reliable orchestration and recovery | Reliable orchestration | d1 | UNVERIFIED | 03, 05, 09 | `ccaf-c04-o1` - `o4` | 9 | 9 |
| 05 | `05-prompt-output-quality.html` | Prompt, output, and review quality | Prompt and output quality | d4 | UNVERIFIED | 04, 05, 08, 09 | `ccaf-c05-o1` - `o4` | 9 | 9 |
| 06 | `06-tools-mcp-structured-output.html` | Tools, MCP, and structured output | Tools and MCP | d2 | UNVERIFIED | 01, 04, 08, 10 | `ccaf-c06-o1` - `o4` | 10 | 10 |
| 07 | `07-evidence-context.html` | Evidence, synthesis, and context control | Evidence and context | d5 | UNVERIFIED | 04, 05, 06, 08, 09 | `ccaf-c07-o1` - `o4` | 9 | 9 |
| 08 | `08-claude-code-workflows.html` | Claude Code workflows and model use | Claude Code workflows | d3 | UNVERIFIED | 01, 10 | `ccaf-c08-o1` - `o4` | 7 | 7 |
| 09 | `09-sessions-settings.html` | Sessions, context, and settings | Sessions and settings | d3 | UNVERIFIED | 06, 07 | `ccaf-c09-o1` - `o4` | 12 | 12 |
| 10 | `10-permission-safety.html` | Permissions, sandboxing, and safe execution | Permission safety | d3 | UNVERIFIED | 07, 08 | `ccaf-c10-o1` - `o4` | 7 | 7 |
| 11 | `11-diagnostics-automation.html` | Diagnostics and repository automation | Diagnostics and automation | d3 | UNVERIFIED | 01, 04, 08, 09, 10 | `ccaf-c11-o1` - `o4` | 6 | 6 |
| 12 | `12-agent-definitions-delegation.html` | Agent definitions and delegation | Agent delegation | d1 | UNVERIFIED | 03, 04 | `ccaf-c12-o1` - `o4` | 6 | 6 |
| 13 | `13-batch-and-escalation.html` | Batch operations and human escalation | Batch and escalation | d2 | UNVERIFIED | 05, 10 | `ccaf-c13-o1` - `o3` | 4 | 4 |

The source unions above equal the per-lesson index and objective sources. Total selected contract: 104 MCQs and 104 recall items.

## Objective registry

Every row is **official-wording-pending**. IDs are draft planning IDs; wording must be replaced from official guide before registry implementation.

| ID | Chapter | Draft objective | Source chunks |
|---|---:|---|---|
| `ccaf-c01-o1` | 01 | Trace a tool-use turn from stop reason through dispatch, correlated result, and terminal response. | 01, 02 |
| `ccaf-c01-o2` | 01 | Select structured completion control using stop reason and bounded iteration rather than text parsing. | 01, 02 |
| `ccaf-c01-o3` | 01 | Distinguish tool request, tool result, displayed output, and conversation state. | 01, 02 |
| `ccaf-c01-o4` | 01 | Use tool metadata, input schema, and evidence-first debugging before judging tool behavior. | 01 |
| `ccaf-c01-o5` | 01 | Treat transcript-reported exam format and score constraints as unverified until official guide confirmation. | 01 |
| `ccaf-c01-o6` | 01 | Apply the transcript lab-first study loop: inspect example, implement, then validate behavior. | 01 |
| `ccaf-c02-o1` | 02 | Distinguish code-owned decision trees from model-driven decision ownership. | 02 |
| `ccaf-c02-o2` | 02 | Design constrained classification output for code-driven routing. | 02 |
| `ccaf-c02-o3` | 02 | Select prompt chaining for fixed work shape and adaptive decomposition for evidence-led work. | 05 |
| `ccaf-c02-o4` | 02 | Select decomposition and coverage-review safeguards for broad work. | 02, 03 |
| `ccaf-c03-o1` | 03 | Define coordinator responsibilities and hub-and-spoke communication boundaries. | 02, 04 |
| `ccaf-c03-o2` | 03 | Choose single, sequential, or parallel delegation from dependency and independence. | 02, 04 |
| `ccaf-c03-o3` | 03 | Design non-overlapping partitions with one routing owner and explicit scope boundaries. | 03 |
| `ccaf-c03-o4` | 03 | Apply explicit context handoff and isolated sub-agent/tool boundaries. | 04, 05 |
| `ccaf-c04-o1` | 04 | Implement coverage evaluation, gap-only refinement, bounded attempts, and finalization gates. | 03, 09 |
| `ccaf-c04-o2` | 04 | Preserve structured sub-agent success, empty-result, partial-result, and failure context. | 03 |
| `ccaf-c04-o3` | 04 | Design auditability with scoped calls, inputs/outputs, errors, latency, IDs, and coverage evidence. | 03, 09 |
| `ccaf-c04-o4` | 04 | Reconcile interrupted task state and resume durable work beyond a happy-path smoke test. | 09 |
| `ccaf-c05-o1` | 05 | Use positive, negative, and scored examples to constrain output without claiming truth guarantees. | 05 |
| `ccaf-c05-o2` | 05 | Write specific, bounded instructions that reduce false positives and review burden. | 05, 08 |
| `ccaf-c05-o3` | 05 | Separate schema/syntax validation from semantic, business-rule, and human quality validation. | 08, 09 |
| `ccaf-c05-o4` | 05 | Design independent review and confidence-calibrated human review using segmented evidence. | 08, 09 |
| `ccaf-c06-o1` | 06 | Choose least-scope tool capability for read, search, edit, shell, or delegated work. | 01, 08 |
| `ccaf-c06-o2` | 06 | Interpret JSON Schema types, enums, nested structures, and required fields for tool arguments. | 08 |
| `ccaf-c06-o3` | 06 | Select `auto`, `any`, named tool, or `none` while controlling named-tool loop risk. | 08 |
| `ccaf-c06-o4` | 06 | Distinguish MCP discovery, resources, and tools without overstating resource immutability. | 10 |
| `ccaf-c07-o1` | 07 | Preserve claim provenance with structured finding, source, location, excerpt, and confidence fields. | 04, 05, 06, 08 |
| `ccaf-c07-o2` | 07 | Preserve claim-source mappings and expose credible conflicts during synthesis. | 05, 08 |
| `ccaf-c07-o3` | 07 | Mitigate precision loss, lost-in-the-middle risk, and oversized tool output. | 09 |
| `ccaf-c07-o4` | 07 | Use persisted facts, findings, scratchpads, and manifests without treating them as interchangeable. | 06, 09 |
| `ccaf-c08-o1` | 08 | Describe Claude Code as a context-action-verification coding harness. | 01 |
| `ccaf-c08-o2` | 08 | Choose transcript-described model options for task complexity, speed, long context, and plan/execution split. | 01 |
| `ccaf-c08-o3` | 08 | Separate setup/authentication smoke tests from application/API behavior claims. | 01 |
| `ccaf-c08-o4` | 08 | Use skills, procedures, and coordinator guidance at their intended boundary. | 10 |
| `ccaf-c09-o1` | 09 | Distinguish new, resumed, forked, rewound, compacted, and cleared session states. | 06 |
| `ccaf-c09-o2` | 09 | Inspect active-session context and decide whether continuity, compaction, or clearing fits. | 06 |
| `ccaf-c09-o3` | 09 | Select managed, user, project, or local settings by scope, Git treatment, and precedence. | 06, 07 |
| `ccaf-c09-o4` | 09 | Verify SDK/session commands, retention, and version-specific capabilities empirically. | 06 |
| `ccaf-c10-o1` | 10 | Resolve allow, ask, and deny rules and check alternate tool paths. | 07 |
| `ccaf-c10-o2` | 10 | Distinguish permission authorization from Bash sandbox execution boundary. | 07, 08 |
| `ccaf-c10-o3` | 10 | Select permission mode and path/command matcher scope for stated work. | 07 |
| `ccaf-c10-o4` | 10 | Assess bypass risk, least privilege, and disposable-environment controls. | 07, 08 |
| `ccaf-c11-o1` | 11 | Use status and debug evidence to diagnose provider, authentication, tool state, and reproducible faults. | 08 |
| `ccaf-c11-o2` | 11 | Treat logs, formatted output, and persisted artifacts as evidence distinct from UI or completion wording. | 01, 08, 09 |
| `ccaf-c11-o3` | 11 | Evaluate workflow triggers, permissions, secrets, branches, PRs, and latency before automation trust. | 10 |
| `ccaf-c11-o4` | 11 | Validate generated, refactored, or ported implementation against behavior, artifacts, and target SDK. | 01, 03, 04 |
| `ccaf-c12-o1` | 12 | Define agent identity, description, prompt, model, turns, and allow/disallow tool controls. | 04 |
| `ccaf-c12-o2` | 12 | Validate SDK field and terminology claims against target language and version. | 04 |
| `ccaf-c12-o3` | 12 | Plan parallel-safe delegation without inferring scheduling or internal-loop visibility. | 04 |
| `ccaf-c12-o4` | 12 | Refactor coordinator responsibilities into testable, human-readable ownership boundaries. | 03, 04 |
| `ccaf-c13-o1` | 13 | Select asynchronous batch processing when cost matters more than immediacy and correlate work by IDs. | 10 |
| `ccaf-c13-o2` | 13 | Apply escalation, clarification, and progressive state transitions to support-agent scenarios. | 05, 10 |
| `ccaf-c13-o3` | 13 | Distinguish explicit human request, ambiguity, multiple matches, frustration, and policy-triggered escalation. | 10 |

## Section archetypes per chapter

Closed enum only: `concept`, `process`, `comparison`, `decision`, `worked-scenario`, `callout`, `diagram`, `mcq-set`, `active-recall`.

| Chapter | Planned body sections |
|---:|---|
| 01 | `orientation` callout; `stop-reasons` concept; `tool-turn` process; `loop-exit` decision; `weather-trace` worked-scenario; `mcq` mcq-set; `recall` active-recall |
| 02 | `decision-owner` comparison; `routing` decision; `fixed-vs-adaptive` comparison; `coverage` process; `mcq` mcq-set; `recall` active-recall |
| 03 | `hub-spoke` diagram; `delegation` decision; `partitioning` comparison; `handoff` process; `mcq` mcq-set; `recall` active-recall |
| 04 | `refinement` process; `reports` comparison; `observability` diagram; `recovery` worked-scenario; `mcq` mcq-set; `recall` active-recall |
| 05 | `examples` comparison; `criteria` decision; `validation` process; `review` worked-scenario; `mcq` mcq-set; `recall` active-recall |
| 06 | `tool-selection` comparison; `schemas` concept; `tool-choice` decision; `mcp` comparison; `mcq` mcq-set; `recall` active-recall |
| 07 | `findings` concept; `synthesis` process; `context-loss` callout; `durable-artifacts` comparison; `mcq` mcq-set; `recall` active-recall |
| 08 | `agentic-loop` process; `models` decision; `setup-boundaries` callout; `harness` comparison; `mcq` mcq-set; `recall` active-recall |
| 09 | `session-lifecycle` diagram; `context` decision; `settings-scopes` comparison; `version-checks` callout; `mcq` mcq-set; `recall` active-recall |
| 10 | `rule-resolution` decision; `sandbox` comparison; `modes` comparison; `bypass-risk` worked-scenario; `mcq` mcq-set; `recall` active-recall |
| 11 | `status-debug` process; `run-evidence` comparison; `actions` worked-scenario; `validate-change` decision; `mcq` mcq-set; `recall` active-recall |
| 12 | `agent-definition` concept; `sdk-parity` callout; `delegation` diagram; `ownership` comparison; `mcq` mcq-set; `recall` active-recall |
| 13 | `batch` process; `batch-choice` decision; `escalation` decision; `support-state` diagram; `mcq` mcq-set; `recall` active-recall |

Future chapter shell also has `#tldr` first and `#skills`; neither is a body-archetype registration.

## Question and count contract

- IDs: chapter `cNN`; MCQ `cNN-qMM`; recall `cNN-rMM`.
- Final planned counts are chapter-map counts: 104 MCQs and 104 one-per-MCQ recall items.
- Chunk plans propose 282 MCQ candidates and 314 recall candidates. They are a candidate backlog, not committed content.
- Selection pass: first select one applied MCQ and one recall per objective; second select registered confusion discriminators; third select highest-evidence process/decision items; fourth preserve chapter content mass; reject duplicate, transcript-version-sensitive, or demo-only candidates unless official guide supports them. Unselected candidates remain unnumbered backlog, never hidden questions.
- Allocation is deliberately non-flat: C09 has 12 from its dense ten-lesson sessions/settings pool; C13 has 4 because its six lessons are narrower and overlap C05/C06. Official weights can replace counts only after source confirmation.
- Each MCQ has exactly four options, one key, key rationale, and one rationale per distractor. Distractors are plausible near-neighbors and state when they would fit.
- Draft Bloom values: `remember`, `understand`, `apply`, `analyze`; prefer scenario discrimination. Every MCQ and recall references a real registry objective. `#skills` owns every chapter objective.

## Diagram catalogue

Static SVG is enough for structure, lifecycle, comparison, and routing. Use registered diagram archetypes, currentColor/token paint, ARIA labels, text equivalents, computed geometry, and existing verifier contracts.

| Chapter | Diagram ID | Archetype | Shows | Why static SVG is enough |
|---:|---|---|---|---|
| 01 | `ccaf-tool-turn` | flow-chain | Tool request, dispatch, correlated result, append, terminal response | Ordered lifecycle. |
| 02 | `ccaf-decision-owner` | comparison-columns | Code-owned route versus model-owned next action | Fixed discriminator. |
| 03 | `ccaf-hub-spoke` | network-topology | Coordinator, isolated spokes, context/result paths | Communication structure. |
| 04 | `ccaf-refinement-gate` | flow-chain | Initial work, coverage check, gap retry, terminal gate | Bounded causal flow. |
| 05 | `ccaf-quality-loop` | flow-chain | Requirement, examples/criteria, validation, independent review | Quality-control sequence. |
| 06 | `ccaf-mcp-roles` | comparison-columns | Discovery, resource read intent, tool action intent | Stable role distinction plus caveat. |
| 07 | `ccaf-evidence-path` | flow-chain | Source, finding, synthesis, attributed/conflict-aware answer | Provenance lifecycle. |
| 08 | `ccaf-code-loop` | flow-chain | Gather context, action, verification, feedback | Workflow phases. |
| 09 | `ccaf-session-branches` | hierarchy-tree | Baseline, resume, fork, compact/clear/rewind decisions | Session relationship map. |
| 10 | `ccaf-control-layers` | nested-containment | Permission rule, tool, Bash sandbox, disposable host | Boundary layering. |
| 11 | `ccaf-actions-run` | flow-chain | Trigger, runner, action, branch/PR inspection | Workflow lifecycle. |
| 12 | `ccaf-agent-definition` | nested-containment | Identity, description, prompt, tools, controls, model | Definition composition. |
| 13 | `ccaf-escalation-state` | flow-chain | Bot -> triggered -> queued -> active -> resolved | State progression. |

## Confusion sets and hub targets

| ID | X vs Y | Discriminator | Target |
|---|---|---|---|
| `tool-use-result` | `tool_use` vs `tool_result` | Request/exposed call versus correlated execution output. | `01-agent-loops.html#tool-turn` |
| `end-turn-text` | `end_turn` vs displayed text | Structured completion versus potentially misleading content. | `01-agent-loops.html#loop-exit` |
| `code-model-decision` | Code-driven vs model-driven | Who owns next decision. | `02-decision-orchestration.html#decision-owner` |
| `chain-adaptive` | Prompt chain vs adaptive decomposition | Fixed order versus evidence-selected work. | `02-decision-orchestration.html#fixed-vs-adaptive` |
| `coordinator-spoke` | Coordinator vs sub-agent | Orchestrates/routs/aggregates versus bounded execution. | `03-coordinator-design.html#hub-spoke` |
| `parallel-sequential` | Parallel vs sequential | Independence versus prior-result dependency. | `03-coordinator-design.html#delegation` |
| `partition-selection` | Partitioning vs selection | Divides selected work versus decides whether work is needed. | `03-coordinator-design.html#partitioning` |
| `retry-recovery` | Validation retry vs task recovery | Corrects artifact versus resumes interrupted durable task. | `04-reliable-orchestration.html#recovery` |
| `schema-semantic` | Schema validity vs semantic quality | Format contract versus factual/business correctness. | `05-prompt-output-quality.html#validation` |
| `self-independent-review` | Self-review vs independent review | Retained generator history versus fresh context. | `05-prompt-output-quality.html#review` |
| `resource-tool` | MCP resource vs MCP tool | Read-data intent versus action intent; no immutability claim. | `06-tools-mcp-structured-output.html#mcp` |
| `any-named-tool` | `any` vs named tool | Any listed tool versus one required named tool. | `06-tools-mcp-structured-output.html#tool-choice` |
| `provenance-confidence` | Provenance vs confidence | Claim origin/location versus certainty signal. | `07-evidence-context.html#findings` |
| `findings-manifest` | Findings vs manifest | Evidence knowledge versus task/recovery state. | `07-evidence-context.html#durable-artifacts` |
| `claude-code-sdk` | Claude Code workflow vs Agent SDK application | CLI coding harness versus program integration boundary. | `08-claude-code-workflows.html#setup-boundaries` |
| `fork-resume-rewind` | Fork vs resume vs rewind | New branch, continuation, or changed history point. | `09-sessions-settings.html#session-lifecycle` |
| `compact-clear` | Compact vs clear | Summarized continuity versus conversation-history removal. | `09-sessions-settings.html#context` |
| `project-local` | Project vs local settings | Shared repository convention versus untracked local preference. | `09-sessions-settings.html#settings-scopes` |
| `permission-sandbox` | Permission rule vs sandbox | Authorization versus Bash execution environment. | `10-permission-safety.html#sandbox` |
| `ask-bypass` | Do-not-ask vs bypass | Auto-deny unless approved versus skip prompts. | `10-permission-safety.html#modes` |
| `complete-durable` | Completion text vs durable completion | Reported success versus verified artifact. | `11-diagnostics-automation.html#run-evidence` |
| `agent-description-procedure` | Agent description vs skill procedure | Routing/invocation label versus executable procedure. | `12-agent-definitions-delegation.html#agent-definition` |
| `batch-custom-id` | Batch ID vs `custom_id` | Batch retrieval identity versus request/result correlation. | `13-batch-and-escalation.html#batch` |
| `request-frustration` | Explicit human request vs frustration | Immediate escalation versus attempt supported solution first. | `13-batch-and-escalation.html#escalation` |

## Glossary plan

**Scope:** chunk plans contain 485 distinct raw proposed `g-` slugs. The table is a curated canonical glossary set for first implementation, not an exhaustive claim. It has 40 canonical terms. The remaining 445 raw candidates are deferred to a pre-authoring inventory pass: normalize aliases, discard demo-only/package/version strings, retain only terms used in published prose, then create one canonical `dt` per retained term. No future page may link a deferred slug before its canonical `dt` exists.

**Collision normalization:** `g-allowed-tool` -> `g-allowed-tools`; `g-agent-loop` -> `g-agentic-loop`; all listed repeated raw slugs below resolve to exactly one definition: `g-agent-sdk`, `g-claude-md`, `g-coordinator`, `g-finding`, `g-model-selection`, `g-observability`, `g-tool-use`, `g-tool-result`, `g-stop-reason`, `g-structured-output`, `g-mcp-server`, `g-context-window`, `g-provenance`, `g-sandbox`, and `g-agent-definition`. `task`/`agent` is version-caveated alias text, not duplicate definitions.

| Canonical slug | Canonical term | Source lesson evidence |
|---|---|---|
| `g-agentic-loop` | Agentic loop | chunk-01 L5; chunk-02 L2 |
| `g-agent-sdk` | Agent SDK | chunk-01 L3; chunk-04 L6 |
| `g-claude-code` | Claude Code | chunk-01 L5; chunk-06 L4 |
| `g-claude-md` | CLAUDE.md | chunk-01 L12; chunk-06 L7 |
| `g-stop-reason` | Stop reason | chunk-01 L3; chunk-02 L1 |
| `g-tool-use` | Tool use | chunk-01 L3; chunk-02 L1 |
| `g-tool-result` | Tool result | chunk-01 L3; chunk-02 L1 |
| `g-tool-use-id` | Tool use ID | chunk-02 L1 |
| `g-tool-choice` | Tool choice | chunk-01 L9; chunk-08 L6 |
| `g-tool-input-schema` | Tool input schema | chunk-01 L9; chunk-08 L7 |
| `g-code-driven-decision-making` | Code-driven decision-making | chunk-02 L2 |
| `g-model-driven-decision-making` | Model-driven decision-making | chunk-02 L2 |
| `g-coordinator` | Coordinator | chunk-02 L4; chunk-04 L4 |
| `g-research-partitioning` | Research partitioning | chunk-03 L3 |
| `g-refinement-loop` | Refinement loop | chunk-03 L4 |
| `g-observability` | Observability | chunk-01 L4; chunk-03 L5 |
| `g-structured-report` | Structured report | chunk-03 L6 |
| `g-structured-output` | Structured output | chunk-02 L3; chunk-08 L8 |
| `g-few-shot-prompting` | Few-shot prompting | chunk-04 L2; chunk-05 L1 |
| `g-prompt-chaining` | Prompt chaining | chunk-05 L6 |
| `g-dynamic-adaptive-decomposition` | Dynamic adaptive decomposition | chunk-05 L7 |
| `g-handoff-protocol` | Handoff protocol | chunk-05 L4 |
| `g-mcp-server` | MCP server | chunk-01 L10; chunk-10 L3 |
| `g-mcp-resource` | MCP resource | chunk-10 L4 |
| `g-agent-definition` | Agent definition | chunk-04 L3 |
| `g-allowed-tools` | Allowed tools | chunk-01 L11; chunk-04 L3 |
| `g-model-selection` | Model selection | chunk-01 L7; chunk-06 L10 |
| `g-session-fork` | Session fork | chunk-06 L2 and L5 |
| `g-context-window` | Context window | chunk-01 L7; chunk-06 L6 |
| `g-context-compaction` | Context compaction | chunk-06 L7 |
| `g-settings-precedence` | Settings precedence | chunk-06 L9 |
| `g-permission-rule` | Permission rule | chunk-07 L1 and L6 |
| `g-sandbox` | Sandbox | chunk-07 L2; chunk-08 L1 |
| `g-debug-log` | Debug log | chunk-08 L4 |
| `g-provenance` | Provenance | chunk-06 L1; chunk-09 L8 |
| `g-finding` | Finding | chunk-04 L1; chunk-05 L2 |
| `g-findings-artifact` | Findings artifact | chunk-09 L5 |
| `g-task-manifest` | Task manifest | chunk-09 L5 |
| `g-batch-processing` | Batch processing | chunk-10 L2 |
| `g-progressive-escalation` | Progressive escalation | chunk-10 L6 |

Discriminator `dl-` entries: one for every confusion-set ID above, prefixed `dl-`; each definition repeats only its discriminator and links to owning anchor. Slug rule: `g-` plus lowercased canonical term with non-alphanumeric runs collapsed to one hyphen.

## Interactive model candidates

Use model enhancement only where source supports a 2-5 value outcome matrix. Static table remains visible and is source of truth.

| Model ID | Chapter | Rows | Columns | Outcomes | Why |
|---|---:|---|---|---|---|
| `ccaf-delegation-mode` | 03 | Single, Sequential, Parallel | Factual; dependent stages; independent axes | `single`, `sequential`, `parallel` | Dependency-to-delegation matrix. |
| `ccaf-tool-choice` | 06 | `auto`, `any`, named tool, `none` | Optional; one required; exact tool; prohibited | `may use`, `must choose one`, `must use named`, `cannot use` | Distinct stated constraints. |
| `ccaf-session-action` | 09 | Resume, Fork, Compact, Clear, Rewind | Continue; branch; reduce/retain; fresh; earlier point | `continue`, `branch`, `summarize`, `remove history`, `restore/condense` | Five decisive session outcomes. |
| `ccaf-permission-mode` | 10 | Default, Accept edits, Plan, Do-not-ask, Bypass | New tool; file edit; unapproved action | `prompt`, `auto-edit`, `analyze boundary`, `auto-deny`, `skip prompts` | Transcript decision values; version caveat visible. |
| `ccaf-support-route` | 13 | Resolve, Clarify, Escalate | Supported; multiple matches; human/legal/fraud/ambiguity | `resolve`, `clarify`, `escalate` | Real three-outcome routing matrix. |

No model for quality score, rate limit, or resource immutability; source lacks stable decisive values.

## review.html plan

- Static `review.html`; depth-2 shell; one study mount; trailing classic `study.js`; no registry runtime dependency.
- `rev-d01` through `rev-d24`: one interleaved recall item per confusion set, linked to owning anchor.
- `rev-s01` through `rev-s13`: cross-chapter scenarios for loop exit, delegation, quality gate, tool choice, provenance, session action, permission/bypass, debug evidence, automation, definitions, batch, and escalation.
- Study policy: Leitner 1/3/7/14/30 days; confidence low/medium/high; until weights confirm, rank due, missed, low-confidence, then high-confidence misses. Show weight ranking as **UNVERIFIED - do not rank by claimed exam weight**. After official map, rank confirmed weight, miss rate, high-confidence misses.
- Include source/version caveat: transcript API, SDK, CLI, settings, session, and action observations need official/version validation before timeless presentation.

## topic.css accent proposal

CCA-F shares the Claude terracotta accent already used by az-900, by explicit owner decision: the palette is the platform's Claude identity rather than a per-topic differentiator. The verifier requires only that `topic.css` declares the three accent tokens with no colour outside the root blocks; it does not require topics to differ. Shipped `topic.css` contains only these token declarations in its two root blocks:

```css
:root {
  --accent: #d97757;
  --accent-soft: #d4a27f;
  --accent-dim: rgba(217, 119, 87, .10);
}
:root[data-theme="light"] {
  --accent: #b3552d;
  --accent-soft: #8a4522;
  --accent-dim: rgba(179, 85, 45, .08);
}
```

No layout, component, or other color rule belongs in `topic.css`. Validate contrast against shared theme during implementation.

## Registry-first build order

1. Obtain official Anthropic guide; resolve code, title, URL/date, domains, weights, and objective wording.
2. Replace every `UNVERIFIED` field and every official-wording-pending objective; preserve approved IDs only after human review.
3. Add topic/hub, manifest, 53 objectives, chapter map, archetypes, question contract, diagrams, confusion sets, glossary/model declarations, and study policy to `assets/registry.js`.
4. Create `topics/ccaf/topic.css` containing only approved root accent tokens.
5. Create hub, glossary, review, and 13 static chapters with shipped shell, ASCII, relative paths, and JS-disabled readable content.
6. Add objective-linked skills, questions, recall, rationales, glossary links, callouts, breadcrumbs, navigation, diagrams, then launcher card.
7. Inspect direct `file://` pages: navigation, dark/light/print, focus, static answers, diagrams, and matrices.
8. Run `powershell -NoProfile -ExecutionPolicy Bypass -File .\tools\verify.ps1`; fix every failure; require exit 0 and zero failures.

Rollback: restore only files created in failing step; shared platform assets are not planned changes.

## Verifier risk list

The verifier has 33 normal Add-Check gates. Highest CCAF exposure and avoidance:

| Gate area | Risk | Avoidance |
|---|---|---|
| Registry/disk parity | 13 chapters plus 3 extra pages | Registry map first; reconcile names after page batch. |
| Objective uniqueness/coverage | 53 draft IDs and repeated concepts | Freeze table; each objective gets skills, MCQ, recall. |
| Chapter order/navigation | Long 13-page Prev/Next chain | Check table order and hub endpoints before prose. |
| Closed archetypes | Rich source tempts new labels | Use only enum in this plan. |
| Question IDs/counts | 104 paired items | Count `cNN-qMM`/`cNN-rMM`; tag both item types. |
| Four-option/rationale shape | Many applied near-neighbors | Schema first; human review every distractor condition. |
| Confusion links | 24 anchors | Register anchors before hub/review links. |
| Glossary anchors | 485 raw source slugs and aliases | Curated scope, canonical map, deferred inventory, first-use only. |
| Study contract | Every study page needs mount/script | Copy shell exactly; classic local script only. |
| Model contract | Matrix/registry drift | Visible rectangular tables; register dimensions only. |
| Diagram/SVG geometry | 13 diagrams | Existing archetypes, computed faces, ARIA, manual routing. |
| Skip/main/breadcrumb | Repeated shell drift | Copy depth-2 shell; registered shortTitle leaf. |
| Paths/remote assets | Transcript has APIs/GitHub/web | Static examples only; no fetch, modules, remote/root paths. |
| CSS/color ownership | Topic identity and diagrams | Root token blocks only; token/currentColor diagrams. |
| ASCII | Product names, arrows, quotes | ASCII scan; entities in future HTML. |
| Description/favicon | 16 future HTML pages | Metadata checklist before verifier. |
| Progressive enhancement | Study/model temptation | Native details and visible tables; scripts optional. |
| Classic scripts | SDK examples tempt imports | Do not ship imported source code; classic local enhancement only. |

Remaining lower-risk gates still require full `tools/verify.ps1` run; passing shape never validates current product facts, keys, rationales, or teaching quality.

## Per-subchapter plan file index

| Plan file | Lesson | Future chapter |
|---|---|---|
| chunk-01.plan.md | 1 Orientation | C01 (`ccaf-c01-o5`) |
| chunk-01.plan.md | 2 Lab-first method | C01 (`ccaf-c01-o6`) |
| chunk-01.plan.md | 3 Stop-reason lab | C01 |
| chunk-01.plan.md | 4 Parser/logging | C11 |
| chunk-01.plan.md | 5 Claude Code fundamentals | C08 |
| chunk-01.plan.md | 6 Tools in Claude Code | C06 |
| chunk-01.plan.md | 7 Model selection | C08 |
| chunk-01.plan.md | 8 Stop reasons/chaining | C01 |
| chunk-01.plan.md | 9 Tool-use walkthrough | C01 |
| chunk-01.plan.md | 10 Minimal architecture/docs validation | C06 |
| chunk-01.plan.md | 11 Install/auth/hello world | C08 |
| chunk-01.plan.md | 12 Shared parser/log refinement | C11 |
| chunk-02.plan.md | 1 Tool-use response handling | C01 |
| chunk-02.plan.md | 2 Preconfigured vs model decisions | C02 |
| chunk-02.plan.md | 3 Routing/safe termination | C01 |
| chunk-02.plan.md | 4 Hub-and-spoke | C03 |
| chunk-02.plan.md | 5 Job-screening coordinator | C03 |
| chunk-02.plan.md | 6 Narrow decomposition | C02 |
| chunk-03.plan.md | 1 Fixed checks/adaptive coverage | C03 |
| chunk-03.plan.md | 2 Dynamic selection | C03 |
| chunk-03.plan.md | 3 Research partitioning | C03 |
| chunk-03.plan.md | 4 Refinement loop | C04 |
| chunk-03.plan.md | 5 Observability/control | C04 |
| chunk-03.plan.md | 6 Sub-agent failure handling | C04 |
| chunk-03.plan.md | 7 Maintainability refactor | C12 |
| chunk-04.plan.md | 1 Structured findings/observability | C07 |
| chunk-04.plan.md | 2 Few-shot/scoped research | C05 |
| chunk-04.plan.md | 3 Agent definition | C12 |
| chunk-04.plan.md | 4 Parallel calls/permission review | C12 |
| chunk-04.plan.md | 5 Coordinator ownership refactor | C12 |
| chunk-04.plan.md | 6 Direct SDK to Agent SDK port | C11 |
| chunk-04.plan.md | 7 Agent tool architecture | C12 |
| chunk-04.plan.md | 8 Task-tool/name migration | C12 |
| chunk-05.plan.md | 1 Reliable output examples | C05 |
| chunk-05.plan.md | 2 Goal/quality criteria coordination | C05 |
| chunk-05.plan.md | 3 Programmatic enforcement gates | C04 |
| chunk-05.plan.md | 4 Structured human handoff | C13 |
| chunk-05.plan.md | 5 SDK pre/post hooks | C06 |
| chunk-05.plan.md | 6 Prompt chaining | C02 |
| chunk-05.plan.md | 7 Dynamic adaptive decomposition | C02 |
| chunk-05.plan.md | 8 Adaptive investigation | C02 |
| chunk-05.plan.md | 9 Raw findings dilemma | C07 |
| chunk-06.plan.md | 1 Findings provenance | C07 |
| chunk-06.plan.md | 2 Fork session management | C09 |
| chunk-06.plan.md | 3 Resume/fork verification | C09 |
| chunk-06.plan.md | 4 Claude Code sessions/resume | C09 |
| chunk-06.plan.md | 5 Claude Code session fork | C09 |
| chunk-06.plan.md | 6 Context inspection | C09 |
| chunk-06.plan.md | 7 Compact/clear | C09 |
| chunk-06.plan.md | 8 Rename/rewind | C09 |
| chunk-06.plan.md | 9 Settings scopes | C09 |
| chunk-06.plan.md | 10 Settings categories | C09 |
| chunk-07.plan.md | 1 Permission-rule selectors | C10 |
| chunk-07.plan.md | 2 Sandboxing boundary | C10 |
| chunk-07.plan.md | 3 Dangerous skip risk | C10 |
| chunk-07.plan.md | 4 EC2 sandbox-bypass lab | C10 |
| chunk-07.plan.md | 5 Settings customization | C09 |
| chunk-07.plan.md | 6 Permission rules/tool coverage | C10 |
| chunk-07.plan.md | 7 Permission modes/matching | C10 |
| chunk-08.plan.md | 1 Permission/sandbox/bypass | C10 |
| chunk-08.plan.md | 2 Built-in tool catalogue | C06 |
| chunk-08.plan.md | 3 Status/authentication | C11 |
| chunk-08.plan.md | 4 Debug/session logs | C11 |
| chunk-08.plan.md | 5 Agent SDK built-in tools | C06 |
| chunk-08.plan.md | 6 Tool-choice modes | C06 |
| chunk-08.plan.md | 7 JSON Schema | C06 |
| chunk-08.plan.md | 8 Structured JSON via tool use | C06 |
| chunk-08.plan.md | 9 Prompt specificity | C05 |
| chunk-08.plan.md | 10 Human review/calibration | C05 |
| chunk-08.plan.md | 11 Multi-source synthesis | C07 |
| chunk-09.plan.md | 1 Independent multi-instance review | C05 |
| chunk-09.plan.md | 2 Validation/retry/remediation | C04 |
| chunk-09.plan.md | 3 Large-context failures | C07 |
| chunk-09.plan.md | 4 Persisted facts/filtered output | C07 |
| chunk-09.plan.md | 5 Context-safe exploration | C07 |
| chunk-09.plan.md | 6 Explorer/synthesizer contracts | C07 |
| chunk-09.plan.md | 7 Orchestration recovery gaps | C04 |
| chunk-09.plan.md | 8 Provenance/observability/rate limits | C11 |
| chunk-10.plan.md | 1 Skills/coordinators/procedures | C08 |
| chunk-10.plan.md | 2 Batch processing | C13 |
| chunk-10.plan.md | 3 MCP discovery | C06 |
| chunk-10.plan.md | 4 MCP resources/tools | C06 |
| chunk-10.plan.md | 5 Claude Code GitHub Actions | C11 |
| chunk-10.plan.md | 6 Support-agent escalation | C13 |

## Open questions for the human

1. Provide official Anthropic guide/version/date/URL, title, code or correction to `CCA-F`, domains, weights, and exact objectives.
2. Confirm transcript format/score/time facts or omit them until official guide confirms.
3. Confirm whether prompt/structured output and context/reliability are separate official domains.
4. Confirm 13 chapters or merge C11 into C08/C06. Current split preserves diagnostics/automation decision boundaries.
5. Confirm target versions for Agent SDK, Claude Code, MCP, hooks, tool choice, task/agent naming, sessions/settings, sandbox, and GitHub Action behavior.
6. Resolve overlapping coverage: C04/C07 reliability; C03/C12 delegation; C08/C11 Claude Code. Current boundaries are recovery, evidence/context, architecture/definition, workflow/diagnostic.
7. Confirm neutral replacement of hiring, legal, customer-data, cloud VM, web/API, and GitHub examples where needed.
8. Confirm official scope for batch, GitHub Actions, support escalation, and MCP resource/tool distinctions.
9. Transcript chunk plans remain untouched by this task. Before implementation, source owners must mark transcript-only score/time/count and version-sensitive SDK/CLI facts **UNVERIFIED** in source planning evidence, including chunk-01 orientation claims; this master plan already applies that boundary.

**Self-critique:** Brittleness: official-guide reconciliation can change all manifest/domain/objective wording and practice allocation. Hidden coupling: registry, verifier, launcher, topic pages, and source-plan evidence remain future dependencies. Rollback: this planning stage reverts by restoring/deleting only `PLAN.md` and `README.md`. Order: official guide before registry avoids drifting static pages. Test gap: plan Markdown can be ASCII/heading/constraint checked, but `tools/verify.ps1` is implementation-only and must run after future topic files exist.