# CCA-F transcript audit: chunk 10

Scope: transcript `/tmp/ccaf-chunks/chunk9`, L16570-L18407. Source read fully in 500-line slices. Routing checked in `docs/plans/ccaf/chunk-10.plan.md` and `docs/plans/ccaf/PLAN.md`; all `topics/ccaf/*.html` searched. Exam format, scores, timings, and version-sensitive SDK/CLI details are deliberately excluded. Focus: batch processing, MCP, automation, and escalation.

Consolidation note: audit directory contained `chunk-01.findings.md` through `chunk-08.findings.md` only. `chunk-09.findings.md` was absent at audit time. The final work order de-duplicates all eight available prior findings plus this chunk-10 finding; it cannot truthfully claim unavailable chunk-09 findings.

## Coverage tally

| Chunk lesson | Transcript lines | Routed chapter | Shipped page evidence | Verdict |
|---|---:|---|---|---|
| Skills, coordinators, and procedure placement | L16570-L16630 | C08 | `08-claude-code-workflows.html#harness`; `data-mcq="c08-q06"`, `c08-q07`; `data-recall="c08-r07"`: description supports invocation, skill owns procedure, coordinator guidance stays light. | COVERED |
| Batch processing | L16631-L16774 | C13 | `13-batch-and-escalation.html#batch`, `#batch-choice`; `c13-q01`, `c13-q02`; `c13-r01`, `c13-r02`: deferred cost-sensitive work, collection identity plus request correlation, later retrieval, and no response-dependent interaction. | COVERED |
| MCP discovery | L16775-L16859 | C06 | `06-tools-mcp-structured-output.html#mcp`; `c06-r09`: configured/installed servers, connection-time discovery, flat agent-visible list without usable origin identity. | COVERED |
| MCP resources versus tools | L16860-L17040 | C06 | `06-tools-mcp-structured-output.html#mcp`; `c06-q09`, `c06-q10`; `c06-r10`: resource read-data intent, tool action intent, list versus create/update/delete todo, no immutability claim. It omits transcript-stated reduced back-and-forth/faster-read rationale. | PARTIAL |
| Claude Code with GitHub Actions | L17041-L17855 | C11 | `11-diagnostics-automation.html#actions`, `#validate-change`; `c11-q04`; `c11-r04`: event, authority, secret, runner latency, branch/PR inspection, validation, review. It does not name source examples of issue/PR comment event routing or distinguish event configuration from an assumed PR result. | PARTIAL |
| Support-agent escalation | L17856-L18407 | C13 | `13-batch-and-escalation.html#escalation`, `#support-state`; `c13-q03`, `c13-q04`; `c13-r03`, `c13-r04`: immediate explicit-human escalation; supported frustration response; policy ambiguity; legal/fraud dispute; failed/repeated request; multiple-match clarification; state progression. | COVERED |

## Missing content

(a) Transcript fact absent from every shipped page:

- MCP resources are presented as a read-data path with less back-and-forth and faster results than repeated tool-style access (L16827-L16856). This matters because read/action intent alone does not explain why a learner would prefer a resource for suitable data retrieval. Add a bounded benefit statement to `topics/ccaf/06-tools-mcp-structured-output.html#mcp`: resource is a read-data design choice that the transcript associates with less back-and-forth; it is not an immutability guarantee.
- Automation source examples include workflow events from an issue or PR comment, issue creation/assignment, and a configured event-to-action path (L17041-L17067, L17152-L17160, L17529-L17545). This matters because an event trigger must be deliberately configured and tested; a mention or issue does not itself prove a branch or PR will exist. Add concise event examples and an explicit trigger-to-observed-artifact check to `topics/ccaf/11-diagnostics-automation.html#actions`.
- The source shows batch tool use cannot perform interactive round trips: batch forces one tool call and direct extraction rather than a response-dependent tool loop (L16675-L16683). `13-batch-and-escalation.html#batch-choice` states the consequence, but not the mechanism. Add one sentence there: deferred batch shape cannot support an interactive tool-result round trip.

(b) No transcript fact in this chunk directly contradicts shipped C08, C11, C13, or C06 teaching.

(c) Do not add back excluded product details: source's up-to-24-hour/no-guaranteed-SLA statement, exact workflow YAML, action/API-key setup, and SDK/server syntax remain time-sensitive (L16642-L16645, L17359-L17486, L17529-L17545).

## Wrong or distorted content

| Page text | Transcript evidence | Corrected wording |
|---|---|---|
| `06-tools-mcp-structured-output.html#mcp`: "Read data directly through a mapped resource or schema." | Source initially describes direct read/schema mapping, then observes the resource implementation is still a callable function and frames read-only as intended use, not enforcement (L16850-L16856, L16908-L16912, L17023-L17040). | "Expose read-data through a resource schema or resource handler. It can still use callable server logic; resource denotes read-data intent, not bypass of server logic or enforced immutability." |

## Unsupported additions

(c) Page claims beyond this chunk. They are not contradictions; retain only as general practice or source them elsewhere.

- `13-batch-and-escalation.html#batch` says correlation works "even when completion order differs from submission order." Source establishes returned `custom_id` correlation but does not state an ordering guarantee or disorder case (L16668-L16677). Hedge to: "Use the request-level ID to associate each returned result with its original request."
- `11-diagnostics-automation.html#actions` calls the runner "isolated." Source says GitHub Actions must spin up an environment and is slow, but does not establish an isolation/security property (L17067-L17073). Keep only as general platform practice, not transcript evidence.
- `11-diagnostics-automation.html#actions` requires a human reviewer. Source demonstrates inspection, unclear PR association, duplicate branches, manual merge, conflict, and broken output; it supports review prudence but does not state a universal mandatory-review policy (L17601-L17852). Keep as sound repository governance guidance.

## Question fidelity

- `c08-q06`, `c08-q07`, and `c08-r07` are source-faithful: description/direct invocation, procedure in skill, and light coordinator guidance (L16570-L16630).
- `c13-q01`, `c13-q02`, `c13-r01`, and `c13-r02` are source-faithful for deferred cost-sensitive work, saved collection state, later checking, and per-request `custom_id` correlation (L16640-L16756). Revise only `c13-q02` rationale to remove its unsupported completion-order assertion.
- `c06-q09`, `c06-q10`, and `c06-r10` are source-faithful: list as resource; create/update/delete as tools; resource label does not enforce immutability (L16827-L16856, L16908-L17040).
- `c11-q04` and `c11-r04` correctly require trigger, authority, secret handling, branch/PR result, validation, and review before automation trust (L17041-L17073, L17486-L17545, L17601-L17852). Add one applied item distinguishing configured issue/PR event from assumed automatic PR creation.
- `c13-q03`, `c13-q04`, `c13-r03`, and `c13-r04` correctly distinguish explicit human request, frustration, ambiguity, multiple matches, and escalation (L18199-L18208, L18278-L18286, L18335-L18370).

## Terminology drift

| Transcript term | Page term | Assessment |
|---|---|---|
| Skill description; procedure in skill; light coordinator pointer | Description, procedure, coordinator guidance in `08-claude-code-workflows.html#harness` | Defensible compression; source roles preserved (L16570-L16630). |
| Batch ID and `custom_id` | Collection retrieval identity and request-level correlation identifier in `13-batch-and-escalation.html#batch` | Defensible product-neutral phrasing; retain literal `custom_id` in discriminator/recall (L16668-L16756). |
| MCP resource is read-only information; tool is action | Read-data intent versus action intent | Defensible and safer: source explicitly does not establish enforced read-only behavior (L16908-L17040). |
| MCP server tool list is "flat" with no server awareness | Flat agent-visible list without usable source-server identity | Defensible clarification (L16775-L16780). |
| GitHub Actions / Claude Code action | Repository automation | Defensible neutral abstraction if page retains event, action, branch/PR, latency, and validation boundary (L17041-L17073). |
| Bot handling -> escalation triggered -> human queued -> human active -> resolved | Bot -> triggered -> queued -> active -> resolved | Defensible compression of displayed source state labels (L18191-L18199). |

## Severity-ordered fix list

Available-audit consolidated work order. Deduplicated by target/change; citations retain owning transcript evidence. Do not change any page in this audit round.

1. P1 - `topics/ccaf/03-coordinator-design.html#partitioning`, `data-mcq="c03-q07"`, `data-recall="c03-r08"`: restore coordinator ownership of decomposition, selection, routing, delegation, and aggregation. Remove separate planner ownership/"delegate supplied partitions exactly once" rule. Source: L3061-L3201.
2. P1 - `topics/ccaf/03-coordinator-design.html#handoff`: replace claimed default isolated/no-parent context with explicit-handoff wording; state source demo supplied all job/resume context and treats narrowed scoped context as a control to validate. Source: L4652-L4664.
3. P1 - `topics/ccaf/04-reliable-orchestration.html`, new `#enforcement-gates`: separate evaluation/finalization gate from structural prerequisite gate. Teach pre-tool block and post-tool inspection for research-before-synthesis. Source: L7817-L8061.
4. P1 - `topics/ccaf/02-decision-orchestration.html`, new `#adaptive-boundaries`: teach model-generated state versus code-owned execution; enforce one-time generation for unvisited state, persist resulting state, and validate generated behavior incrementally. Source: L8494-L9176.
5. P1 - `topics/ccaf/07-evidence-context.html#findings`: add plain-list versus structured-finding mismatch, silent empty artifact, error logging, compatible fallback conversion, and URL/document/page locator fields. Source: L5524-L5685, L5686-L5794.
6. P1 - `topics/ccaf/09-sessions-settings.html#settings-scopes`, new `#settings-categories`: add higher-scope precedence plus category map for authentication, storage/persistence, environment, model, and output preferences; retain product-key/version caveats. Source: L10883-L11046.
7. P1 - `topics/ccaf/09-sessions-settings.html#session-lifecycle`: distinguish managed fork history/identity/resume from manually copied messages; add web/local origin versus workspace context and rewind restore-versus-summarize choice. Source: L9779-L9796, L9995-L10105, L10258-L10414, L10808-L10882.
8. P1 - `topics/ccaf/10-permission-safety.html#rule-resolution`, `#sandbox`, `#bypass-risk`: add selector-scope matrix, network approval as distinct observed gate, Bash-only fallback boundary, and blocked-command -> bypass-permitted sandbox-disable -> escape causal warning. Source: L11047-L11138, L11139-L11378, L11519-L11890, L12955-L13039.
9. P1 - `topics/ccaf/08-claude-code-workflows.html#models`: add recording-time, version-caveated model matrix: same model normally across loop phases; default, Sonnet, Opus, Haiku, long-context Sonnet, and plan/execution split. Source: L1408-L1458.
10. P1 - `topics/ccaf/13-batch-and-escalation.html#support-state`: add automated attempt -> structured handoff package -> escalation sequence so recipient need not search conversation history. Preserve this separately from queue lifecycle. Source: L8062-L8253.
11. P2 - `topics/ccaf/05-prompt-output-quality.html#criteria` and `07-evidence-context.html#findings`: add source diversity, per-finding quality feedback, cited-document versus researched-item distinction, and supporting excerpt. Source: L7426-L7816.
12. P2 - `topics/ccaf/03-coordinator-design.html#delegation`: add policy-required sequential ordering as well as dependency ordering; add dynamic selection, skip/route examples, human-judgement validation, and "only invoke a worker that answers a real question." Source: L2922-L2956, L3232-L3286, L3683-L4037.
13. P2 - `topics/ccaf/04-reliable-orchestration.html#observability`: add timestamp, level, token count, request ID, persisted spoke input/output, partition-question linkage, and context-pollution tests. Rename coverage-loop "retry cap" to "iteration bound." Source: L4393-L4435, L4635-L4664, L4820-L4860.
14. P2 - `topics/ccaf/11-diagnostics-automation.html#run-evidence`, `#validate-change`: add reusable parser/per-run relative log pattern and direct-SDK versus Agent-SDK port comparison, including internal-MCP caveat, tool-factory ownership, and target validation. Source: L920-L1213, L6893-L7136.
15. P2 - `topics/ccaf/11-diagnostics-automation.html#actions`: add configured issue/PR-comment/issue-event examples, trigger-to-action-to-observed-branch/PR check, and source latency reason. Do not add secret values or unqualified API-key/subscription claims. Source: L17041-L17073, L17152-L17160, L17486-L17545, L17601-L17852.
16. P2 - `topics/ccaf/06-tools-mcp-structured-output.html#tool-selection`, `#mcp`: add prescriptive tool-description versus schema distinction; correct resource wording to allow callable server logic; add source-stated less-back-and-forth rationale and batch noninteractive mechanism where relevant. Source: L1804-L1837, L16675-L16683, L16827-L17040.
17. P2 - `topics/ccaf/12-agent-definitions-delegation.html#agent-definition`, `#sdk-parity`, `#delegation`, `#ownership`: make both name and description routing-sensitive; add historical `task`/`agent` caveat, lifecycle messages, parent-blocking qualification, source refactor destinations, and defer shorthand redesign pending target-SDK validation. Source: L5921-L6165, L7137-L7364, L5201-L5523.
18. P2 - `topics/ccaf/09-sessions-settings.html#context`: add autocompact reserved-headroom purpose and clear-versus-retained-nonconversation-state distinction; omit fixed percentages and volatile artifact names. Source: L10491-L10509, L10631-L10659.
19. P2 - `topics/ccaf/10-permission-safety.html#rule-resolution`, `#modes`; `06-tools-mcp-structured-output.html#tool-selection`: add default permission-marker versus explicit-policy distinction, demonstrated Glob/Grep alternate path, and matcher space/path-scope examples. Source: L12211-L12887, L13094-L13176.
20. P3 - `topics/ccaf/06-tools-mcp-structured-output.html`, new version-caveated `#tool-hooks`: teach conceptual pre-tool/post-tool timing and all-tool versus named-tool matching only after target SDK/version verification. Source: L8254-L8339.
21. P3 - Question/recall sections in C03, C04, C06, C09, C10, C11, C12, C13: correct identified source drifts, then add only approved-count-contract items for coordinator ownership, prerequisite gates, session identity/settings precedence, selector scope, trigger-versus-PR outcome, MCP resource rationale, and handoff package. Source: L3061-L3201, L7817-L8061, L9779-L11046, L11047-L12887, L16827-L17040, L17041-L17852.
22. P3 - When `docs/plans/ccaf/audit/chunk-09.findings.md` becomes available, merge its unique source-backed fixes into this list before implementation; do not treat its absence as evidence that no work remains.
