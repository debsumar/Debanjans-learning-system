# CCA-F transcript audit: chunk 02

Scope: transcript course lines 1842-3682. Routed by `docs/plans/ccaf/chunk-02.plan.md` and `docs/plans/ccaf/PLAN.md`. Cross-page grep covered every `topics/ccaf/*.html` page. Deliberate omissions of exam format, scores, timings, and version-sensitive SDK/CLI specifics are not findings.

## Coverage tally

| Chunk lesson | Transcript lines | Routed chapter | Shipped page evidence | Verdict |
|---|---:|---|---|---|
| Tool-use response handling and returned result | 1842-2231 | C01 | `01-agent-loops.html#stop-reasons`, `#tool-turn`, `#loop-exit`; correlation, dispatch, follow-up, structured exit, and bounded loop stated. | COVERED |
| Preconfigured/code-driven versus model-driven decisions | 2232-2461 | C02 | `02-decision-orchestration.html#decision-owner`, `#routing`; fixed conditions/state transitions, runtime model action selection, and billing/technical/general route all stated. | COVERED |
| Constrained routing, inventory tool loop, and safe termination | 2462-2841 | C01 | `01-agent-loops.html#loop-exit` covers structured completion plus maximum iteration; `02-decision-orchestration.html#routing` covers constrained routing. No shipped page states inventory must be checked before order. | PARTIAL |
| Hub-and-spoke coordinator architecture | 2842-2956 | C03 | `03-coordinator-design.html#hub-spoke`, `#delegation`; coordinator routing/context/error/observability ownership, no peer spoke path, and single/sequential/parallel choice stated. | COVERED |
| Job-screening coordinator walkthrough | 2957-3341 | C03 | `03-coordinator-design.html#hub-spoke` covers generic coordinator ownership only. No keyword scanner, deep evaluator, red-flag detector, literal-evidence rule, required three-agent order, or score aggregation appears on any shipped page. | PARTIAL |
| Narrow task decomposition | 3342-3682 | C02 | `02-decision-orchestration.html#coverage`, `#mcq` `c02-q05`, `c02-q06`; isolated-context failure and both review points covered. Only charging infrastructure from source EV omissions appears; five named omitted dimensions do not. | PARTIAL |

## Missing content

- Inventory-before-order constraint absent from every shipped page. Transcript instruction: verify inventory availability before ordering; demo exposes inventory, order, and notification tools (2642-2726). Why: concrete discriminator for model-selected multi-tool sequence versus merely exposing tools. Target: `topics/ccaf/01-agent-loops.html#tool-turn`; add one neutral sequence example: check inventory, return result, then order only when available.
- Coordinator-versus-generic-task-manager distinction absent. Transcript rejects a create/check/complete/list task manager as insufficient because a real coordinator owns decomposition, routing, invocation, collection, and aggregation (2962-3161). Why: prevents learners mistaking task CRUD for orchestration. Target: `topics/ccaf/03-coordinator-design.html#hub-spoke`; add concise comparison.
- Literal keyword-scanner evidence boundary absent. Transcript scanner reports each required job skill only when explicitly present in resume; it must not infer or extrapolate (3202-3231). Why: separates literal extraction from evaluative judgment. Target: `topics/ccaf/03-coordinator-design.html#handoff`; add a bounded worker example, explicitly framed as architecture mechanics rather than hiring advice.
- Job-screening spoke roles and aggregation absent. Transcript names keyword scanner, deep evaluator, red-flag detector, and score aggregator; coordinator selects, invokes, collects, and combines them (3162-3201). Why: concrete map of independent workers versus hub ownership. Target: `topics/ccaf/03-coordinator-design.html#hub-spoke`.
- Coordinator-required ordered execution absent. Transcript says run all three independent screening agents in specified order and skip none (3232-3286). Why: corrects false inference that independent workers must always execute concurrently. Target: `topics/ccaf/03-coordinator-design.html#delegation`.
- Five source EV coverage gaps absent from all shipped pages: government policies/subsidies, secondhand market, consumer sentiment/adoption barriers, lithium/cobalt supply chains, and grid-capacity implications (3351-3411). Charging infrastructure alone appears in `02-decision-orchestration.html#mcq` `c02-q05`. Why: source demonstration of how apparently sensible sales/battery/manufacturer decomposition can omit whole dimensions. Target: `topics/ccaf/02-decision-orchestration.html#coverage`; add compact initial-versus-missing-dimensions table.

## Wrong or distorted content

- `topics/ccaf/03-coordinator-design.html#partitioning` says: "Partition planner plus coordinator" and "Planner selects and partitions"; it later says "The planner should own selection and partitioning; the coordinator should delegate the supplied partitions exactly once." Transcript says the coordinator itself owns decomposition, decides which spokes to invoke, delegates, and aggregates; specifically, a decomposer is not a separate subagent in proper hub-and-spoke design (3061-3201). Correction: "Coordinator owns decomposition, selection, routing, delegation, and aggregation. A planner may be an internal implementation aid, but must not become an independent routing owner."
- `topics/ccaf/03-coordinator-design.html#delegation` says: "Use sequential delegation only when later work needs an earlier result." Dependency is source guidance for multi-step sequential work (2922-2956), but transcript job-screening requires three independent workers to run in an explicit order without skipping (3232-3286). Correction: "Use sequential delegation when a later task needs an earlier result, or when coordinator policy requires an order; use parallel work only when independence and policy both permit it."
- `topics/ccaf/03-coordinator-design.html#handoff` says subagents have "assigned tools" and must receive "only the tool capability needed." Chunk source establishes isolated peer context and coordinator-controlled context sharing (2862-2956, 3061-3201), not a least-privilege tool-allocation rule. Correction: hedge as sound general practice or cite its actual later source; do not attribute it to this lesson.

## Unsupported additions

These statements may be sound general practice or supported by later chunks, but chunk 02 supplies no basis. Keep only with an explicit cross-chunk source; otherwise hedge.

- `01-agent-loops.html#tool-turn` and `#weather-trace`: "inspect prerequisite or dependency errors first" and broader "evidence-first" diagnostic ordering. Chunk 02 gives tool name/input extraction and result correlation, not a diagnostic priority rule (2052-2231). Keep as sound general practice, marked non-transcript guidance, or move to diagnostics chapter.
- `03-coordinator-design.html#partitioning`: non-overlap, include/exclude rules, a separate partition planner, and one-call-per-partition policy. Chunk 02 covers task decomposition and delegation, but not this partition-planner model (2902-2956, 3061-3201). Hedge or cite later source. Do not keep the separate owner claim because it conflicts with transcript.
- `03-coordinator-design.html#delegation`: "concurrent scheduling or visible internal progress" caveat and permission-boundary language. Chunk 02 establishes task independence versus sequential dependency, not scheduler observability or permissions (2922-2956). Keep as sound general practice only.
- `03-coordinator-design.html#handoff`: expected result shape and least-scope tool capability. Chunk 02 supports explicit context transfer through coordinator, but not those fields or capability minimization (2862-2956, 3061-3201). Hedge or cite later source.
- `02-decision-orchestration.html#coverage`: bounded refinement loop, finalization gate, score movement, representative data, and human evaluation. Chunk 02 supports review before delegation or after aggregation and gap coverage (3412-3466), not universal bounded-refinement or quality-evaluation rules. Later-source support may exist; otherwise keep as clearly labeled general practice.

## Question fidelity

- `c03-q07`: wrong key/rationale. Key A says a coordinator adding an angle creates a second routing owner because "planning owns selection and partitioning." This adopts the page's contradicting planner ownership. Transcript says coordinator owns decomposition/routing and decides which spokes to call (3061-3201). Replace stem/rationale with: external planner output can inform the coordinator, but coordinator remains accountable for deciding and revising delegated scope.
- `c03-r08`: wrong answer. "The planner should own selection and partitioning; the coordinator should delegate the supplied partitions exactly once" contradicts coordinator-owned decomposition (3061-3201). Replace with coordinator-owned decomposition wording.
- `c01-q05` and `c01-r04`: unsupported as chunk-02 questions. Their asserted first diagnostic check is tool metadata/input schema/prerequisites; source teaches parsing requested tool name/input and returning correlated result, not that diagnostic order (2052-2231). Delete, retarget to a diagnostics source, or reword to ask source-supported dispatch/correlation.
- `c02-q05`, `c02-q06`, `c02-r05`, and `c02-r06`: source-faithful for isolated workers, pre-delegation review, aggregation-stage coverage review, and targeted gaps (3342-3466). No key defect.
- `c01-q01`, `c01-q02`, `c01-q03`, `c01-q08`, `c01-r01`, `c01-r02`, `c01-r03`, `c01-r07`, and `c01-r08`: source-faithful for dispatch, `tool_use_id`, structured completion, text unreliability, and maximum-iteration guard (1842-2231, 2642-2841).
- `c03-q01` through `c03-q05`, `c03-r01` through `c03-r05`: source-faithful for hub routing, no peer spoke path, coordinator responsibilities, and dependency-based single/sequential/parallel selection, subject to the ordered-policy qualification above (2842-2956).

## Terminology drift

| Transcript term | Page term | Assessment |
|---|---|---|
| Preconfigured decision tree / code-driven decision-making (2232-2381) | "Code-owned route" in `02-decision-orchestration.html#decision-owner` | Defensible shorthand. Keep first-use transcript term beside alias. |
| Model-driven decision-making (2382-2461) | "Model-owned next action" | Defensible, but page should retain "model-driven" as canonical glossary term. |
| Tool sequence, state machine, series of steps (2252-2341) | Prompt chain in `02-decision-orchestration.html#fixed-vs-adaptive` | Not equivalent. Prompt chaining is a later page concept; do not use it as replacement for source tool sequence/state machine. |
| `stop_reason` / `end_turn` (2642-2841) | "Structured completion" in `01-agent-loops.html#loop-exit` | Defensible abstraction, but preserve source labels in a version-caveated implementation note. |
| Subagent/spoke and coordinator (2842-2956) | Same terms in `03-coordinator-design.html#hub-spoke` | Defensible and source-faithful. |
| Narrow task decomposition (3342-3466) | Partitioning / selection in `03-coordinator-design.html#partitioning` | Related but distinct. Use "decomposition" for broad-task coverage creation; reserve partitioning for later-source non-overlap design. |

## Severity-ordered fix list

1. HIGH - `topics/ccaf/03-coordinator-design.html#partitioning`; remove separate planner ownership, restore coordinator-owned decomposition/routing, then correct `c03-q07` and `c03-r08` (3061-3201).
2. HIGH - `topics/ccaf/03-coordinator-design.html#delegation`; qualify "only when" dependency rule with transcript's coordinator-mandated ordered independent screening workers (2922-2956, 3232-3286).
3. MEDIUM - `topics/ccaf/03-coordinator-design.html#hub-spoke` and `#handoff`; add concise generic-task-manager contrast, named job-screening spokes, literal-only keyword rule, and aggregation; avoid presenting automated hiring recommendation as normative (2962-3231).
4. MEDIUM - `topics/ccaf/02-decision-orchestration.html#coverage`; add EV initial scopes plus all six omitted dimensions, not charging alone (3351-3411).
5. MEDIUM - `topics/ccaf/01-agent-loops.html#tool-turn`; add inventory-check-before-order example or neutral equivalent (2642-2726).
6. LOW - `topics/ccaf/01-agent-loops.html#weather-trace`, `#mcq`, and `#recall`; remove or source `c01-q05`/`c01-r04` diagnostic-priority claim (2052-2231).
7. LOW - `topics/ccaf/01-agent-loops.html#loop-exit` and `topics/ccaf/02-decision-orchestration.html#decision-owner`; retain `stop_reason`/`end_turn` and tool-sequence/state-machine labels beside abstractions, with version caveat where implementation-specific (2252-2341, 2642-2841).
