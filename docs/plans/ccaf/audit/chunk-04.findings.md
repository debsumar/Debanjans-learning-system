# Chunk 04 audit findings

Scope: transcript lines 5524-7364. Source read in four 500-line slices. Routing checked in `docs/plans/ccaf/chunk-04.plan.md` and `docs/plans/ccaf/PLAN.md`; all `topics/ccaf/*.html` searched. Version-sensitive SDK/API names treated as transcript observations, not timeless product facts.

## Coverage tally

| Chunk lesson | Transcript lines | Routed chapter | Shipped page evidence | Verdict |
|---|---:|---|---|---|
| Structured findings and run observability | 5524-5794 | C07 | `07-evidence-context.html#findings` requires source, location, excerpt, confidence; `11-diagnostics-automation.html#run-evidence` distinguishes completion wording from durable artifact. No list-versus-structured mismatch, silent record failure, fallback conversion, or run-log diagnostic path. | PARTIAL |
| Few-shot prompting and scoped research task | 5795-5920 | C05 | `05-prompt-output-quality.html#examples` defines few-shot prompting and limits examples to output constraints. No measurement-extraction task, tool-progress limitation, web-access distinction, or explicit task-pool extension. | PARTIAL |
| Agent definition | 5921-6165 | C12 | `12-agent-definitions-delegation.html#agent-definition` covers pre-message blueprint, routing description, prompt/system instruction, tool controls, model, turns; `#sdk-parity` requires target-language/version validation. | COVERED |
| Parallel agent calls and permission review | 6166-6548 | C12 | `12-agent-definitions-delegation.html#delegation` requires independence, merge rule, least-scope tools, and rejects scheduling/internal-loop inference; `10-permission-safety.html#modes` and `#bypass-risk` cover bypass risk. | COVERED |
| Refactoring coordinator code for ownership | 6549-6892 | C12 | `12-agent-definitions-delegation.html#ownership` covers named boundaries, explicit I/O, stateless grouping, testing, preserved workflow, logs/reports; `11-diagnostics-automation.html#validate-change` requires runtime/artifact validation. | COVERED |
| Direct SDK to Agent SDK port | 6893-7136 | C11 | `11-diagnostics-automation.html#validate-change` covers target language/version, dependency, tool boundary, and smoke testing. No direct-client versus decorator/MCP-server comparison, internal-MCP qualification, or tool-factory/closure move. | PARTIAL |
| Agent tool architecture | 7137-7222 | C03/C12 | `03-coordinator-design.html#handoff` covers isolated context, own task/tool boundary, and explicit handoff; `12-agent-definitions-delegation.html#delegation` rejects assumed parallel scheduling. No parent-blocking default or `task` to `agent` historical-name caveat. | PARTIAL |
| Task-tool follow-along and name migration | 7223-7364 | C12 | `03-coordinator-design.html` MCQ `c03-q04` covers researcher-to-writer dependency; `10-permission-safety.html#bypass-risk` covers removing/avoiding bypass. No researcher/writer demonstration, lifecycle message categories, or version-caveated `task`/`agent` mismatch. | PARTIAL |

## Missing content

| Transcript concept absent from all shipped pages | Lines | Why it matters | Exact target |
|---|---:|---|---|
| Structured-findings failure chain: coordinator passes plain list where record operation expects structured finding; failure remains silent until error logging; fallback converts compatible natural output. | 5524-5685, 5766-5794 | Learner currently gets provenance fields but not root-cause discrimination between completed agent runs and empty findings artifact. | `07-evidence-context.html#findings` |
| Provenance minimum in demonstration: URL, document name, page number; add cited supporting excerpt as proposed improvement. | 5686-5765 | Page says generic source/location/excerpt, but omits concrete locator fields and does not distinguish implemented metadata from proposed excerpt enrichment. | `07-evidence-context.html#findings` |
| Tool-progress observation proves activity only, not returned-result quality; one agent needed web access while another did not. | 5795-5920 | Needed least-privilege and observability discriminator for research delegation. | `05-prompt-output-quality.html#criteria` |
| Measurement-extraction few-shot task. | 5795-5845 | Current few-shot section supplies broad output-quality examples, not source lesson's bounded extraction use case. | `05-prompt-output-quality.html#examples` |
| Small-port comparison: direct tool handling replaced with decorated functions plus SDK MCP server; transcript calls this internal MCP, requiring target-version validation. | 6981-7095 | C11 says validate ports but omits concrete architectural comparison and prevents learners from identifying ported tool-boundary changes. | `11-diagnostics-automation.html#validate-change` |
| Tool JSON can move out of coordinator through factory/closure pattern; run validates only demonstrated scenario. | 7096-7136 | Distinguishes ownership refactor from unsupported feature-equivalence claim. | `11-diagnostics-automation.html#validate-change` |
| Spawn normally blocks parent until one sub-agent reports back; spawn alone does not establish parallel work. | 7199-7212 | Pages correctly reject scheduling inference but omit parent-blocking behavior used by source to explain it. | `12-agent-definitions-delegation.html#delegation` |
| Historical `task`/current `agent` terminology conflict, plus task-start/task-progress/task-notification message categories. | 7137-7172, 7319-7364 | Learner needs version-validation response to emitted-name/doc mismatch and lifecycle-event interpretation. | `12-agent-definitions-delegation.html#sdk-parity` and `#delegation` |
| Researcher gathers three facts; writer converts them to short paragraphs; coordinator supplies topic and returns short answer. | 7223-7278 | Concrete handoff scenario would test isolated context, sequential dependency, and role boundaries. | `12-agent-definitions-delegation.html#delegation` |

## Wrong or distorted content

- `topics/ccaf/12-agent-definitions-delegation.html#agent-definition`: page says, "Use a distinctive identity or name as a reader-facing label. Write the description as routing language." Transcript says agent name "can cause it to trigger or not trigger" and description "is what's going to trigger the agent" (5966-6015). Page understates name as display-only. Correct: "Treat both name and description as routing-sensitive; use description to state invocation fit, and validate exact target-SDK selection behavior."
- `topics/ccaf/03-coordinator-design.html#delegation`: page says concurrent work does not prove "visible internal progress," correct; but no page states transcript's stronger qualified observation that Agent SDK internal-loop activity may be unavailable through SDK observation (6381-6450). This is omission, not contradiction. Add target-version caveat rather than claim universal invisibility.

## Unsupported additions

No high-confidence unsupported claim found among chunk-routed sections after applying transcript/version caveats. These claims go beyond this chunk and need either source attribution from their owning chunk or a hedge:

- `topics/ccaf/05-prompt-output-quality.html#examples`: "positive examples, negative examples, and scored examples can make formatting more consistent and reduce hallucinations." Chunk 04 only introduces few-shot measurement extraction (5795-5845); it does not support these three example classes or reduction claim. Keep only if chunk-05 evidence is cited/retained; otherwise hedge as general prompt-design practice.
- `topics/ccaf/07-evidence-context.html#synthesis` and `#context-loss`: conflict preservation, repeated-summarization precision loss, lost-in-the-middle, and field filtering have no basis in transcript lines 5524-7364. Likely other-chunk material; keep only with that source basis. Do not misattribute to chunk 04.
- `topics/ccaf/10-permission-safety.html#bypass-risk`: general workstation/disposable-host controls exceed chunk 04's narrow removal of generated `bypass permissions` during web-search example review (6451-6548; 7279-7318). Keep as sound general practice, but not as a chunk-04-derived claim.

## Question fidelity

- `c12-q01`: keyed answer "The agent description and its routing language" is too exclusive. Transcript makes both name and description selection-sensitive (5966-6015). Revise stem/key to ask which definition surfaces to inspect first; key: "agent name and description, especially task-specific routing wording."
- `c03-q04`: key sequential delegation is correct, but stem says researcher returns "verified facts." Transcript only says researcher gathers three facts before writer makes short paragraphs (7223-7278); no verification step stated. Replace "verified facts" with "gathered facts."
- `c12-q03`, `c12-q04`, `c12-q05`, `c12-q06`, `c12-r01` through `c12-r06`, `c03-q05`, `c03-q09`, `c03-r04`, `c03-r05`, `c03-r09`, `c11-q05`, and `c11-q06`: keys/rationales align with transcript claims at 5921-6165, 6166-6548, 6549-7136, and 7137-7222. No change found.
- No shipped MCQ/recall IDs cover format-mismatch/fallback diagnosis (5524-5794), tool-progress-versus-quality (5795-5920), internal-MCP port comparison (6981-7095), lifecycle message types (7319-7335), or `task`/`agent` version mismatch (7336-7364).

## Terminology drift

| Transcript term | Page term | Assessment |
|---|---|---|
| `prompt` is system prompt | `stable system-level instruction` in `12-agent-definitions-delegation.html#agent-definition` | Defensible clarification; transcript explicitly equates prompt with system prompt (5966-6015). |
| `tools` / `allowed tools`; `disallowed tools`; `max turns`; `model` | "tool controls," "turn limit," "model choice" | Defensible only with existing target-SDK/version qualification; transcript warns language bindings differ (6016-6165). |
| `parallel agent calls` / `parallel tool calls` | "parallel-safe planning" | Defensible abstraction. Preserve caveat that source demonstrates coordinator instruction, not scheduler guarantee (6166-6380). |
| `task tool` versus `agent tool` | Pages use `Agent` but omit migration | Incomplete. Add version-caveated alias: transcript observed historical `task` and allowed `agent`, but could not confirm API documentation (7137-7172, 7336-7364). |
| `internal MCP server` | Generic `MCP server` / `Agent SDK` | Incomplete. Add transcript-only/internal qualifier and target-version validation; do not imply remote MCP deployment (6981-7095). |

## Severity-ordered fix list

1. High - `topics/ccaf/07-evidence-context.html#findings`: add structured-findings mismatch path: plain list -> structured record expectation -> silent failure -> empty artifact; add error logging and compatible fallback conversion. Cite 5524-5685, 5766-5794.
2. High - `topics/ccaf/12-agent-definitions-delegation.html#agent-definition`: replace display-only name framing with name-and-description routing sensitivity; revise `c12-q01` and rationale. Cite 5966-6015.
3. High - `topics/ccaf/12-agent-definitions-delegation.html#sdk-parity` and `#delegation`: add `task`/`agent` historical-name caveat, lifecycle messages, parent-blocking qualification, and explicit target-version/runtime validation. Cite 7137-7222, 7319-7364.
4. Medium - `topics/ccaf/11-diagnostics-automation.html#validate-change`: add direct SDK versus Agent SDK comparison; decorators, SDK MCP server, internal-MCP caveat, tool-factory/closure relocation, and smoke-test boundary. Cite 6893-7136.
5. Medium - `topics/ccaf/05-prompt-output-quality.html#examples` and `#criteria`: add measurement extraction, tool-progress-versus-quality, and task-scoped web access; source-specific few-shot material belongs here. Cite 5795-5920.
6. Medium - `topics/ccaf/07-evidence-context.html#findings`: name source URL, document, page, and optional supporting excerpt; distinguish existing metadata from proposed excerpt enrichment. Cite 5686-5765.
7. Low - `topics/ccaf/03-coordinator-design.html#delegation`, MCQ `c03-q04`: replace unsupported "verified facts" with "gathered facts." Cite 7223-7278.
8. Low - `topics/ccaf/05-prompt-output-quality.html#examples`, `07-evidence-context.html#synthesis`, `#context-loss`, and `10-permission-safety.html#bypass-risk`: retain only with owning-chunk evidence or mark as general practice; not supported by chunk 04 alone. Cite 5795-5920, 6451-6548, 7279-7318.
