## Coverage tally

| Chunk lesson | Transcript lines | Routed chapter | Shipped page evidence | Verdict |
|---|---:|---|---|---|
| Fixed checks to adaptive coverage | 3683-3804 | C03 | `03-coordinator-design.html#delegation` says invoke specialists only for relevant unanswered questions; `02-decision-orchestration.html#fixed-vs-adaptive` contrasts fixed order with evidence-led work. Neither preserves same-spoke/changed-coordinator comparison, stakeholder/dimension gap prompt, or representative-data plus human-judgement validation. | PARTIAL |
| Dynamic selection | 3805-4037 | C03 | `03-coordinator-design.html#delegation` rejects mechanical full-pipeline invocation; `#partitioning` distinguishes selection from partitioning; `02-decision-orchestration.html#fixed-vs-adaptive` covers evidence-led changed work. Routing guidance, condition-specific skip examples, and generated-on-the-fly angles absent. | PARTIAL |
| Research partitioning | 4038-4392 | C03 | `03-coordinator-design.html#partitioning`: worker/scope/rules/include-exclude fields; non-overlap; planner owns selection; coordinator invokes exactly one call per partition; `c03-q06` through `c03-q08`, `c03-r06` through `c03-r08`. | COVERED |
| Refinement loop | 4393-4549 | C04 | `04-reliable-orchestration.html#refinement`: initial reports, coverage evaluation, gap-only delegation, configured bound, explicit finalization gate; `c04-q01`, `c04-q02`, `c04-r01`, `c04-r02`. | COVERED |
| Coordinator observability and control | 4550-4892 | C04 | `04-reliable-orchestration.html#observability`: scoped association, inputs, outputs/errors, IDs, latency, durable traces, scope enforcement, final gate; `c04-q05`, `c04-q06`, `c04-r05`, `c04-r06`. Timestamp, log level, token count, stored spoke-response/partition-question audit detail, and staged context-pollution testing absent. | PARTIAL |
| Coordinated sub-agent failure handling | 4893-5200 | C04 | `04-reliable-orchestration.html#reports`: success/empty/partial/failure, typed failure, attempts, partial context, local response, least-scope tools; `c04-q03`, `c04-q04`, `c04-r03`, `c04-r04`. | COVERED |
| Coordinator refactor for maintainability | 5201-5523 | C12 | `12-agent-definitions-delegation.html#ownership` separates prompt, capability, delegation, synthesis, logging ownership and warns against silent redesign; `c12-q06`, `c12-r06`. Concrete source destinations and SDK-shorthand deferral absent. | PARTIAL |

## Missing content

| Transcript concept absent from all shipped CCA-F pages | Transcript lines | Why it matters | Exact target |
|---|---:|---|---|
| Broader coordinator output is not validated by looking richer: create representative sample data, compare against human judgement, then adjust. | 3792-3798 | Prevents treating adaptive coverage or more output as correct judgement. | `topics/ccaf/03-coordinator-design.html#delegation` |
| Dynamic routing guidance: adapt to observed evidence; skip a factual-match scan; route non-traditional background to transfer-skills review; never invoke a screening agent unless it answers a real question; generated angles need not repeat. | 3920-3946, 3990-4037 | Separates conditional invocation from generic adaptive decomposition. | `topics/ccaf/03-coordinator-design.html#delegation` |
| Observability record fields: timestamp, level, token count, latency, request ID; persist spoke inputs/outputs and partition-question linkage. | 4635-4650 | Existing page has ID/latency but not full trace schema or durable per-spoke linkage. | `topics/ccaf/04-reliable-orchestration.html#observability` |
| Test scoped context with staged out-of-scope/context-pollution cases; reject or record them. | 4820-4860 | A stated scope boundary is not evidence that the boundary resists polluted context. | `topics/ccaf/04-reliable-orchestration.html#observability` |
| Refactor destinations: prompts as Markdown; individual tool files plus tool JSON/schema; partition generation and logger in library; coverage report; loaded data artifacts; variable-bearing message templates; helper logs to relative log folder. | 5240-5285, 5363-5372, 5468-5496 | Generic ownership language omits source checklist needed for human maintenance and review. | `topics/ccaf/12-agent-definitions-delegation.html#ownership` |
| Defer tool-structure shorthand changes until Agent SDK capability is assessed. | 5492-5497 | Avoids premature abstraction based on an unverified future SDK surface. | `topics/ccaf/12-agent-definitions-delegation.html#ownership` |

## Wrong or distorted content

| Page text | Transcript evidence | Corrected wording |
|---|---|---|
| `03-coordinator-design.html#handoff`: "Subagents operate with isolated context" and "Do not assume a worker sees parent conversation." | Current demo sends every spoke the full job posting/resume; transcript calls context control loose, with partition scope only advisory (4652-4664). | "Treat the handoff as explicit. In this demo every spoke receives full job/resume context; narrower context and spoke-level scope validation are proposed controls, not demonstrated defaults." |
| `04-reliable-orchestration.html#refinement`: "retry cap" terminology in TL;DR, diagram, and recall. | Demonstration specifies at most four refinement iterations and re-delegates identified gaps (4404-4435); it does not define a validation-retry policy. | Use "iteration bound" for coverage refinement. Reserve "retry" for a separately defined failed-action or validation-remediation policy. |

No direct contradiction found for partition ownership, gap-only refinement, structured failure context, or refactor readability: each matches transcript demonstrations/proposals at 4038-4392, 4393-4549, 4893-5200, and 5201-5523.

## Unsupported additions

| Page claim beyond this chunk | Transcript basis | Action |
|---|---|---|
| `04-reliable-orchestration.html#recovery` asserts persisted task-state reconciliation, interrupted-work resume, and recovery tests. | No basis in chunk 03, 3683-5523; this material belongs to planned chunk 09 coverage, not this source. | Keep only if chunk-09 evidence is cited during its audit; otherwise hedge as general practice. |
| `12-agent-definitions-delegation.html#sdk-parity` gives Python/TypeScript documentation and focused-test guidance. | Chunk 03 only speculates about possible Agent SDK shorthand and language availability (5492-5523); it does not establish cross-language parity procedure. | Keep as sound general practice only with another transcript chunk/source; do not attribute to chunk 03. |
| `12-agent-definitions-delegation.html#delegation` formalizes parallel-safe planning, scheduler non-guarantees, shared-write constraints, and streaming visibility. | Chunk 03 only notes overlapping research and one-direction coordinator/spoke communication (4038-4392, 4550-4892). | Keep only if supported by its other mapped source chunks; not chunk-03-backed. |
| `12-agent-definitions-delegation.html#ownership` claims explicit test seams and behavior-preservation artifact checks. | Source requires human readability and names refactor tasks (5201-5491), but does not state test-seam method or artifact-check contract. | Hedge as sound general practice, or add source evidence from another chunk. |

## Question fidelity

| Item IDs | Finding | Transcript lines | Disposition |
|---|---|---:|---|
| `c03-q06`-`c03-q08`; `c03-r06`-`c03-r08` | Non-overlap, include/exclude boundaries, one routing owner, exactly supplied partitions, and omit unneeded partitions match source. | 4038-4392 | Keys/rationales supported. |
| `c03-q10`; `c03-r10` | Notification-only tool boundary matches one-tool-per-specialist demonstration. | 5048-5054 | Key/rationale supported. |
| `c04-q01`-`c04-q02`; `c04-r01`-`c04-r02` | Initial evaluation, gap-only refinement, bound, and non-proof status of coverage score match source. | 4393-4549 | Keys/rationales supported; replace "retry cap" with "iteration bound." |
| `c04-q03`-`c04-q06`; `c04-r03`-`c04-r06` | Typed report, valid empty versus access failure, trace records, and advisory versus enforced scope match source. | 4893-5200, 4550-4892 | Keys/rationales supported. |
| `c04-q07`-`c04-q09`; `c04-r07`-`c04-r09` | Interrupted durable-task recovery has no chunk-03 source basis. | No support in 3683-5523 | Do not call wrong: planned C04 also maps chunk 09. Verify against chunk 09; otherwise source/hedge. |
| `c12-q06`; `c12-r06` | Key correctly favors separation over one large file, but "test seams," preserved artifacts, and behavior-check method exceed this chunk's human-readability/refactor checklist. | 5201-5523 | PARTIAL; hedge rationale/recall or cite another source. |

## Terminology drift

| Transcript term | Page term | Assessment |
|---|---|---|
| Dynamic selection; routing guidance | Dynamic adaptive decomposition / relevant unanswered question | Defensible umbrella, but loses conditional invocation and concrete routing guidance (3805-4037). Add "dynamic selection" at `03-coordinator-design.html#delegation`. |
| Spokes / sub-agents | Spokes / subagents | Defensible aliases; transcript uses both around coordinator examples (4550-4892, 4893-5200). |
| Non-overlapping screen partitions; agent, scope, rules | Research partitioning; worker, scope, rules, include/exclude | Defensible normalization; preserves source distinction between selection and partitioning (4038-4392). |
| Maximum four refinement iterations | Retry cap / bounded attempts | Partially defensible, but imprecise: source demonstrates an iteration bound, not generic retry semantics (4404-4435). |
| Structured JSON report; status, sub-agent, summary, attempts, failures, information | Structured report; success/empty/partial/failure context | Defensible abstraction; preserve source fields when teaching schema shape (5048-5057). |
| Human readable; refactor tasks | Testable ownership boundaries | Sound extension, not source-equivalent. Source basis is readability and separated concerns, not test-seam doctrine (5201-5523). |

## Severity-ordered fix list

1. HIGH - `topics/ccaf/03-coordinator-design.html#handoff`: replace isolated-context/default-no-inheritance wording with explicit-handoff wording; state current course demo gives all spokes full job/resume context and treats narrower enforcement as a needed control (4652-4664).
2. HIGH - `topics/ccaf/03-coordinator-design.html#delegation`: add fixed-checklist versus coordinator-directed gap coverage, same specialized agent/changed coordinator prompt, and mandatory representative-data plus human-judgement evaluation caveat (3683-3804).
3. MEDIUM - `topics/ccaf/03-coordinator-design.html#delegation`: add dynamic-selection routing test, skip/route examples, and rule "never invoke ... unless it answers a real question" (3920-3946).
4. MEDIUM - `topics/ccaf/04-reliable-orchestration.html#observability`: add timestamp, level, token count, request ID, persisted spoke input/output, partition-question association, and staged context-pollution/out-of-scope test (4635-4664, 4820-4860).
5. MEDIUM - `topics/ccaf/12-agent-definitions-delegation.html#ownership`: add source refactor checklist: prompts, tool code/schema, partition generation, logger, coverage report, data artifacts, message templates, helper logs/relative log folder; note defer shorthand redesign pending Agent SDK assessment (5240-5285, 5363-5372, 5468-5497).
6. LOW - `topics/ccaf/04-reliable-orchestration.html#tldr`, `#refinement`, `#recall`: rename coverage-loop "retry cap" to "iteration bound" (4404-4435).
7. LOW - `topics/ccaf/12-agent-definitions-delegation.html#ownership`, `#mcq`, `#recall`: hedge test-seam/preserved-artifact claims or source them to another chunk; chunk 03 supports readability/refactoring, not that exact validation contract (5201-5523).
