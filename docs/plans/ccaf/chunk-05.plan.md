## Chunk metadata

- Topic: Claude Certified Architect - Foundations; slug: `ccaf`; exam code supplied: `CCA-F` (UNVERIFIED).
- Source: Andrew Brown course transcript, `chunk4`, local lines 1-1841, absolute transcript lines L7365-L9205. Read in four required slices: local 1-500, 501-1000, 1001-1500, 1501-1841.
- Scope: prompting examples and quality criteria; programmatic enforcement; handoffs; pre/post hooks; prompt chaining; dynamic adaptive decomposition; adaptive investigation; incomplete raw-findings introduction.
- Evidence status: course transcript, not official exam blueprint. Candidate objectives, chapter numbers, and assessment coverage require registry-first validation against authoritative CCA-F (UNVERIFIED) materials.
- Planning boundary: this document proposes static lesson content only. No code, dependencies, remote assets, build/server, registry edit, or topic folder is proposed here.

## Lesson inventory

| # | title | chunk line refs | one-line summary |
|---:|---|---|---|
| 1 | Examples for reliable output | L7365-L7425 | Output examples, including good and bad scored examples, improve consistency and reduce hallucinations. |
| 2 | Goal and quality-criteria-driven coordination | L7426-L7816 | Replace rigid procedural coordination with explicit goals, measurable criteria, evidence quality, and durable findings. |
| 3 | Programmatic enforcement gates | L7817-L8061 | Prompt instructions alone are unreliable; prerequisites and hooks can prevent invalid tool order. |
| 4 | Structured human handoff protocol | L8062-L8253 | Build a package before escalation so recipient gets needed context without searching conversation history. |
| 5 | UNVERIFIED: SDK pre- and post-tool hooks | L8254-L8339 | SDK hooks can intercept selected tool calls before and after execution, replacing a hand-rolled mechanism. |
| 6 | Prompt chaining | L8340-L8493 | A fixed sequential pipeline passes each call output to next call; suited to fixed-shape work. |
| 7 | Dynamic adaptive decomposition | L8494-L9176 | Coordinator changes next work, agents, depth, and order from intermediate evidence; generated dungeon demo exposes boundary and validation risks. |
| 8 | Adaptive investigation plan | L9177-L9200 | Each finding produces verification questions and targeted subtasks instead of executing an unchanged fixed plan. |
| 9 | Raw findings dilemma (partial) | L9201-L9205 | Passing findings as one text blob loses attribution; transcript stops before solution. |

## Per-lesson plan

### 1. Examples for reliable output

- Key concepts: few-shot output examples; output formatting; good and bad examples; scoring examples; output consistency; hallucination reduction (L7365-L7425).
- Exam-relevant facts: Transcript states examples help format output as intended, provide more consistent results, and reduce hallucinations. It says good and bad examples can both help, and scoring them can help further (L7365-L7425).
- Candidate objectives: `ccaf-cNN-o1` Draft: Given an output requirement, select example evidence that constrains desired format and distinguishes acceptable from unacceptable output.
- Glossary terms with g- slugs: `g-few-shot-example`; `g-output-format`; `g-positive-example`; `g-negative-example`; `g-example-scoring`; `g-hallucination`.
- Diagram candidates: Few-shot prompt to constrained response [archetype: process]; good versus bad versus scored example inputs [archetype: comparison].
- Comparison/decision table candidates with rows and columns: Rows: no example, desired-output example, good-and-bad examples, scored examples. Columns: output constraint, stated benefit, authoring cost, source support.
- MCQ candidates: 2. Applied stems: choose prompt addition for consistent structured output; choose why a negatively scored counterexample can be useful.
- Recall prompts: 3. Name two transcript-stated benefits of examples; distinguish good/bad examples from scoring them; state what examples constrain in a requested output.
- Confusion pairs with discriminator: few-shot example vs procedural instruction -- example demonstrates target result; procedure dictates steps. Good example vs bad example -- one models desired output, one bounds prohibited/undesired output.
- Common wrong turn misconceptions: Examples guarantee factual truth; transcript says they reduce hallucinations, not eliminate them. Only positive examples help; transcript explicitly permits good and bad examples.
- Causal step chains only if genuine: prompt supplies output examples -> model has target formatting evidence -> transcript reports more consistent results and reduced hallucinations (L7365-L7425).

### 2. Goal and quality-criteria-driven coordination

- Key concepts: procedural prompt rigidity; coordinator goal; quality criteria; concrete checklist; delegation scope; stopping condition; evidence finding; source diversity; excerpt; quality breakdown; incremental persistence; aggregation (L7426-L7816).
- Exam-relevant facts: Rigid fixed steps can fail when a step breaks or task does not fit script. Goal plus criteria lets coordinator judge result quality. Criteria shown include quantity, coverage axes, source quality, and specific information. Findings should preserve evidence/excerpt and cited research document, not treat item itself as source. Logging-only scores do not enforce or measure criteria. Persisting findings after each batch protects data if loop/program stops. Demo showed repeated/weak sources, formatting/missing-field errors, and incomplete aggregation despite a reported summary (L7426-L7816).
- Candidate objectives: `ccaf-cNN-o2` Draft: Design coordinator instructions around outcome and explicit quality criteria rather than a brittle fixed procedure. `ccaf-cNN-o3` Draft: Evaluate an evidence record for attribution, excerpt, coverage, source diversity, and durable persistence.
- Glossary terms with g- slugs: `g-coordinator`; `g-goal`; `g-quality-criteria`; `g-quality-checklist`; `g-finding`; `g-evidence-excerpt`; `g-source-attribution`; `g-source-diversity`; `g-quality-breakdown`; `g-incremental-persistence`; `g-aggregation`.
- Diagram candidates: Goal and criteria driving coordinator evaluation [archetype: decision]; finding lifecycle from collection to persisted evidence to summary [archetype: process]; weak-source/repetition failure callout [archetype: callout].
- Comparison/decision table candidates with rows and columns: Rows: fixed procedural coordinator, goal-and-criteria coordinator, logging-only quality score, measured quality feedback. Columns: adaptation to failure, criteria visibility, enforcement/measurement, stated limitation.
- MCQ candidates: 4. Applied stems: choose revised coordinator prompt after a required step fails; identify missing evidence field; select persistence point that avoids losing batch findings after crash; identify why many records from same source undermine a research result.
- Recall prompts: 5. Why can fixed procedures break; list three qualities a finding should retain; distinguish source document from researched item; why is logging a score not quality enforcement; when should findings be persisted according to demo rationale.
- Confusion pairs with discriminator: goal vs quality criterion -- goal names desired outcome; criterion defines pass conditions. Finding source vs item identity -- source is document cited; item is subject being evaluated. Stored score vs enforced measure -- stored score records judgment; enforcement/measurement checks it.
- Common wrong turn misconceptions: Adding quality text means system verifies it; transcript says coordinator may only mentally remember it. More findings means better result; duplicates and weak/repeated sources can still make result poor. Wait until final output to persist findings; crash/loop exit can lose them.
- Causal step chains only if genuine: rigid step fails or task mismatches script -> coordinator cannot proceed as scripted; goal plus explicit criteria -> coordinator can evaluate result against stated standards (L7426-L7485). Finding collected -> persist after batch -> interruption occurs -> earlier finding data remains available (L7670-L7725).

### 3. Programmatic enforcement gates

- Key concepts: prompt-guidance unreliability; prerequisite gate; routing; tool-call hook; pre-tool check; post-tool check; structural prevention; allowed-tool matching; custom versus SDK-provided hook system (L7817-L8061).
- Exam-relevant facts: Transcript says agent may ignore instructions in long conversations or unusual inputs. A prerequisite gate makes skipping prerequisite structurally impossible. A hook is function logic firing automatically before or after tool call; it can gate a call. Route-based checking and pre/post hook checks are shown. Demo initially used custom gates, then refactored toward callback/lambda-style hook logic. Later SDK hooks can match all hooks or a specific allowed tool (L7817-L8061).
- Candidate objectives: `ccaf-cNN-o4` Draft: Choose a programmatic prerequisite gate when a tool action must not run before required state exists. `ccaf-cNN-o5` Draft: Place validation logic in pre- or post-tool hook (UNVERIFIED) based on whether it must block or inspect an action.
- Glossary terms with g- slugs: `g-enforcement-gate`; `g-prerequisite`; `g-routing`; `g-tool-call`; `g-pre-tool-hook`; `g-post-tool-hook`; `g-structural-enforcement`; `g-callback`.
- Diagram candidates: Research prerequisite blocking synthesis delegation [archetype: decision]; route check versus pre/post hook placement [archetype: comparison].
- Comparison/decision table candidates with rows and columns: Rows: prompt instruction, route prerequisite check, pre-tool hook (UNVERIFIED), post-tool hook (UNVERIFIED). Columns: execution timing, can block invalid call, intended responsibility, transcript limitation.
- MCQ candidates: 3. Applied stems: prevent synthesis before research completion; choose pre versus post hook for required-state check; identify weakness of instruction-only enforcement.
- Recall prompts: 4. Why may prompt guidance fail; define prerequisite gate; state hook timing choices; explain "structurally impossible" in this context.
- Confusion pairs with discriminator: prompt guidance vs gate -- guidance requests behavior; gate blocks invalid progression. Pre-tool hook vs post-tool hook (UNVERIFIED) -- pre runs before call and can block; post runs after call for subsequent logic/inspection.
- Common wrong turn misconceptions: Exact prompt wording guarantees sequence. A post-tool hook (UNVERIFIED) can prevent an already-run invalid tool action. A custom hook system is automatically preferable; transcript later favors provided SDK support when available.
- Causal step chains only if genuine: required research absent -> precondition check fails -> synthesis tool is not allowed to proceed -> research must run first (L7817-L7870).

### 4. Structured human handoff protocol

- Key concepts: escalation; structured handoff package; conversation-history avoidance; handoff builder; staged handoff; human recipient; attempted automated action (L8062-L8253).
- Exam-relevant facts: Handoff protocol is a structured package assembled before escalation so receiver has needed information without digging through conversation history. Demo uses an order/refund scenario: look up order, attempt refund, clear fraud flag/simulate backend, build handoff, escalate. UNVERIFIED: It required correct asynchronous client/API-key setup to run; automated attempt then escalated to customer/human (L8062-L8253).
- Candidate objectives: `ccaf-cNN-o6` Draft: Define the purpose and minimum contextual role of a structured handoff before human escalation. `ccaf-cNN-o7` Draft: Identify when escalation package construction belongs in a tool-execution loop.
- Glossary terms with g- slugs: `g-handoff-protocol`; `g-escalation`; `g-handoff-package`; `g-conversation-history`; `g-human-in-the-loop`; `g-handoff-builder`; `g-staging`.
- Diagram candidates: Automated attempt to structured package to human escalation [archetype: process]; handoff payload versus history search [archetype: comparison].
- Comparison/decision table candidates with rows and columns: Rows: unstructured escalation, structured handoff before escalation. Columns: receiver context, history search required, assembled-before-escalation, transcript outcome.
- MCQ candidates: 2. Applied stems: choose improvement when human recipient lacks context; identify correct point to create package after tool loop detects escalation.
- Recall prompts: 3. Define handoff protocol; state why history digging is undesirable; name ordering shown between automated attempt, handoff build, and escalation.
- Confusion pairs with discriminator: handoff package vs raw conversation history -- package is intentionally structured/assembled; history is uncurated prior exchange. Escalation trigger vs handoff builder -- trigger decides to escalate; builder prepares recipient context.
- Common wrong turn misconceptions: Escalate first and let recipient reconstruct context. A handoff is merely notification; transcript defines it as a structured package containing needed information.
- Causal step chains only if genuine: automated loop detects need for human escalation -> build structured handoff -> stage/pass package -> human receives context without digging through prior conversation (L8062-L8253).

### 5. SDK pre- and post-tool hooks

- Key concepts: Agent SDK (UNVERIFIED); pre-tool-use hook (UNVERIFIED); post-tool-use hook (UNVERIFIED); tool matching; all-tools match; specific allowed-tool match; hook failure; query async generator; built-in support versus custom implementation (L8254-L8339).
- Exam-relevant facts: Transcript corrects an initial mistaken claim: pre/post hooks are built into Agent SDK (UNVERIFIED), not the separate Claude Code (UNVERIFIED) CLI feature. It names pre-tool use, post-tool use, and failure-related behavior; hooks can match all or specific allowed tools (UNVERIFIED). Demo prints pre/post behavior and is presented as cleaner than custom hook system (L8254-L8339).
- Candidate objectives: `ccaf-cNN-o8` Draft: Distinguish Agent SDK (UNVERIFIED) tool hooks from unrelated CLI capability and select tool-scoped matching when needed.
- Glossary terms with g- slugs: `g-agent-sdk`; `g-pre-tool-use`; `g-post-tool-use`; `g-tool-matcher`; `g-allowed-tool`; `g-hook-failure`; `g-async-generator`.
- Diagram candidates: Built-in tool hook interception for all tools or selected tool [archetype: comparison].
- Comparison/decision table candidates with rows and columns: Rows: custom hook system, Agent SDK (UNVERIFIED) built-in hook, match-all hook (UNVERIFIED), specific-tool hook (UNVERIFIED). Columns: implementation burden, scope, timing, transcript position.
- MCQ candidates: 2. Applied stems: choose API layer for pre/post tool interception; select matching strategy when only one destructive/controlled tool needs a check.
- Recall prompts: 3. What correction does transcript make about hook availability; name two hook timings; distinguish match-all from tool-specific matching.
- Confusion pairs with discriminator: Agent SDK (UNVERIFIED) vs Claude Code (UNVERIFIED) CLI feature -- transcript attributes built-in hooks to SDK, not CLI feature. Match all vs specific tool -- scope is every matched call versus named allowed tool.
- Common wrong turn misconceptions: Python SDK (UNVERIFIED) has no pre/post hooks. A hook configuration only supports two global hooks and cannot specialize per allowed tool.
- Causal step chains only if genuine: tool call selected -> matching pre-tool hook (UNVERIFIED) runs -> tool executes -> matching post-tool hook (UNVERIFIED) runs (L8254-L8339).

### 6. Prompt chaining

- Key concepts: prompt chain; sequential pipeline; series of calls/agents; output passed forward; fixed work shape; document processing; content transformation; ETL pipeline; bug-identify/propose/apply example (L8340-L8493).
- Exam-relevant facts: Prompt chaining is sequential calls where each output feeds next. It suits document processing, content transformation, ETL, and tasks whose work shape is fixed regardless of content. It predates current agent loops and can use LLM calls rather than agents. Demo sequence identifies bugs, proposes fixes, then applies fixes; saved input is required for meaningful processing (L8340-L8493).
- Candidate objectives: `ccaf-cNN-o9` Draft: Select prompt chaining for a fixed, known-order transformation pipeline and identify its data-flow contract.
- Glossary terms with g- slugs: `g-prompt-chaining`; `g-sequential-pipeline`; `g-intermediate-output`; `g-fixed-work-shape`; `g-document-processing`; `g-content-transformation`; `g-etl`.
- Diagram candidates: Input to identify bugs to propose fixes to apply fixes [archetype: process]; fixed prompt chain versus adaptive coordinator [archetype: comparison].
- Comparison/decision table candidates with rows and columns: Rows: prompt chain, agentic loop, dynamic adaptive decomposition. Columns: order known upfront, next-step selection, suitable task shape, source example.
- MCQ candidates: 3. Applied stems: choose architecture for fixed document transformation; distinguish chain from adaptive investigation; diagnose pipeline output when source file was not saved.
- Recall prompts: 4. Define prompt chaining; list two stated suitable uses; what passes between steps; why is it not a new LLM concept.
- Confusion pairs with discriminator: prompt chaining vs dynamic decomposition -- chain order is fixed; decomposition changes work from intermediate evidence. Agent versus LLM call -- transcript says either can participate in chain.
- Common wrong turn misconceptions: Prompt chaining requires autonomous agent loop. Chaining is best whenever task is open-ended; transcript reserves it for fixed shape.
- Causal step chains only if genuine: input -> identify bugs -> propose fixes -> apply fixes -> transformed output (L8340-L8493).

### 7. Dynamic adaptive decomposition

- Key concepts: intermediate findings; coordinator decision; open-ended research/investigation; evidence-led next step; agent selection/count/order; filesystem-organized agent prompts; shared world state; unvisited-room boundary; two-layer game engine/world generator; stopping conditions; token budget; programmatic guarantee; observability; generated-code validation (L8494-L9176).
- Exam-relevant facts: Dynamic adaptive decomposition changes what happens next, agents called, call count, and order from intermediate findings; suited to open-ended work where depth/width is unknown. Coordinator prompt says assess findings after each step and choose more research, another angle, or synthesis; do not follow fixed sequence. Dungeon spec uses coordinator plus agents such as room builder, code writer, lore consistency, combat, and puzzle; shared world state is intended to preserve coherence. Clarified boundary: AI fires once for an unvisited room, then room becomes permanent and code engine controls play. Demo/review found prompt-folder output did not necessarily match expected Agent SDK (UNVERIFIED) pattern, asserted "move to unknown room" but lacked programmatic guarantee, had missing environment/configuration handling, and generated output failed to produce expected person/lore entries. Transcript recommends smaller, observable, known-base implementation rather than mass generation (L8494-L9176).
- Candidate objectives: `ccaf-cNN-o10` Draft: Select dynamic adaptive decomposition when intermediate findings must determine subsequent work. `ccaf-cNN-o11` Draft: Define a programmatic boundary that limits model invocation to eligible novel state. `ccaf-cNN-o12` Draft: Assess generated multi-agent implementation for stated behavior, state persistence, configuration, observability, and actual output.
- Glossary terms with g- slugs: `g-dynamic-adaptive-decomposition`; `g-intermediate-finding`; `g-evidence-led-routing`; `g-orchestrator`; `g-subagent`; `g-world-state`; `g-unvisited-room`; `g-game-engine`; `g-world-generator`; `g-stopping-condition`; `g-token-budget`; `g-observability`; `g-programmatic-guarantee`.
- Diagram candidates: Intermediate evidence to coordinator decision to selected next subagent [archetype: decision]; two-layer code game engine plus one-time world generator [archetype: concept]; unvisited room generation then permanent state [archetype: process]; generated-demo failure evidence [archetype: worked-scenario].
- Comparison/decision table candidates with rows and columns: Rows: fixed plan, prompt chain, dynamic adaptive decomposition. Columns: next action fixed or evidence-driven, unknown depth/width support, suitable task, control risk. Separate rows: prompt-only boundary, programmatic gate. Columns: invocation guarantee, testability, transcript concern.
- MCQ candidates: 5. Applied stems: choose decomposition for novel investigation; identify trigger that should invoke generator under stated dungeon boundary; select missing control when prompt says only unknown rooms but no gate exists; diagnose failed generated system despite valid-looking prompt/artifacts; select why known reusable base is preferred over generating everything at once.
- Recall prompts: 6. What changes dynamically; name three decisions coordinator makes; state one-time unvisited-room boundary; distinguish code engine from generator; list two review failures in demo; explain why a prompt assertion is not guarantee.
- Confusion pairs with discriminator: prompt chaining vs dynamic decomposition -- known sequential shape versus evidence-selected next work. Prompt constraint vs programmatic gate -- asserted behavior versus structural enforcement. World generator vs game engine -- generates novel world content versus runs ongoing game rules. Agent folder as prompt storage vs expected SDK agent definition -- transcript observed they may not be same pattern.
- Common wrong turn misconceptions: Dynamic means model should evaluate every player input. File layout alone proves Agent SDK (UNVERIFIED) integration. A model instruction such as "only unknown room" guarantees it. Successful type/build/config work proves behavior. Generated mass code needs no incremental validation.
- Causal step chains only if genuine: intermediate finding -> coordinator asks what remains unknown/what could change conclusion -> targeted next agent/task selected -> new evidence changes next decision (L8494-L8585). Player enters unvisited room -> generator runs once -> room blueprint resolves -> room becomes permanent -> code engine handles later play without model revisiting that room (L8680-L8795, stated boundary).

### 8. Adaptive investigation plan

- Key concepts: finding as decision signal; fixed plan limitation; uncertainty question; conclusion-changing evidence; verification claim; targeted subtask (L9177-L9200).
- Exam-relevant facts: Each finding is not merely collected data; it reshapes required next work. Coordinator questions shown: what remains unknown, what result could change conclusion, and which claim needs verification. These questions generate targeted research subtasks. Fixed plan does not change after execution (L9177-L9200).
- Candidate objectives: `ccaf-cNN-o13` Draft: Convert a finding into verification questions and a targeted next research subtask.
- Glossary terms with g- slugs: `g-adaptive-investigation`; `g-decision-signal`; `g-uncertainty`; `g-verification-claim`; `g-targeted-subtask`; `g-fixed-plan`.
- Diagram candidates: Finding to uncertainty questions to targeted subtask to new evidence [archetype: process].
- Comparison/decision table candidates with rows and columns: Rows: fixed investigation plan, adaptive investigation plan. Columns: response to finding, task generation, conclusion-risk handling, stated limitation.
- MCQ candidates: 2. Applied stems: choose next question after ambiguous finding; identify adaptive action when one claim could reverse conclusion.
- Recall prompts: 3. State three coordinator questions; why is a finding more than data; what is generated from questions.
- Confusion pairs with discriminator: finding as data vs finding as signal -- signal changes later work. More research vs targeted verification -- targeted work resolves stated uncertainty/claim.
- Common wrong turn misconceptions: Execute all planned research before interpreting any finding. Adaptive plan means random extra tasks; transcript ties tasks to explicit uncertainty and verification questions.
- Causal step chains only if genuine: finding arrives -> identify unknown/conclusion-changing possibility/claim needing verification -> generate targeted subtask -> perform research on that subtask (L9177-L9200).

### 9. Raw findings dilemma (partial)

- Key concepts: raw finding; single text blob; inter-agent transfer; attribution loss; synthesis-agent limitation (L9201-L9205).
- Exam-relevant facts: Transcript only establishes problem: raw findings passed as one blob lose attributions, and synthesis agent cannot tell something not completed before chunk end. Do not infer solution from this chunk (L9201-L9205).
- Candidate objectives: `ccaf-cNN-o14` Draft: Identify attribution loss risk when transferring multiple raw findings as an undifferentiated text blob.
- Glossary terms with g- slugs: `g-raw-finding`; `g-findings-blob`; `g-attribution-loss`; `g-synthesis-agent`.
- Diagram candidates: Unstructured findings blob losing source links before synthesis [archetype: callout].
- Comparison/decision table candidates with rows and columns: Rows: raw text blob, structured finding record. Columns: attribution retained, source/excerpt separation, synthesis traceability, source support. Mark structured-record outcome as gap: not stated in this chunk.
- MCQ candidates: 1. Applied stem: identify failure caused by handing synthesis one undifferentiated evidence blob.
- Recall prompts: 2. What is lost in raw findings blob; what limitation does this create for synthesis according to incomplete source.
- Confusion pairs with discriminator: raw finding content vs attribution -- content is claim/evidence text; attribution links it to origin. Do not extend beyond L9205.
- Common wrong turn misconceptions: Transcript supplies a complete remedy here; it ends mid-explanation. A blob preserves evidence provenance automatically.
- Causal step chains only if genuine: raw findings combined into single blob -> attributions lost -> synthesis agent cannot distinguish provenance; final consequence/source remedy is incomplete (L9201-L9205).

## Proposed chapter mapping

| Proposed chapter | Lessons | Draft scope | Evidence and boundary |
|---|---|---|---|
| CCA-F (UNVERIFIED) chapter TBD: Prompt quality and evidence evaluation | 1-2, 9 | Examples, quality criteria, findings, attribution, persistence, source quality | L7365-L7816 and L9201-L9205. Treat official domain placement as unresolved. |
| CCA-F (UNVERIFIED) chapter TBD: Agent control and orchestration | 3, 5-6 | Gates, hooks, fixed chains, tool-call timing | L7817-L8493. Keep prompt guidance separate from structural enforcement. |
| CCA-F (UNVERIFIED) chapter TBD: Escalation and human collaboration | 4 | Structured handoffs before escalation | L8062-L8253. Transcript scenario is illustrative, not certification requirement. |
| CCA-F (UNVERIFIED) chapter TBD: Adaptive multi-agent design | 7-8 | Evidence-led decomposition, bounded invocation, state, validation, adaptive investigation | L8494-L9200. Preserve distinction between conceptual pattern and flawed demo implementation. |

Suggested ordering: prompt/output evidence -> coordinator quality -> enforcement/hooks -> handoff -> fixed chains -> adaptive decomposition -> adaptive investigation -> attribution continuation. Keep raw-findings solution in later chunk until source continuation is read.

## Hands-on / lab content

- Lab candidate: revise a coordinator prompt from fixed steps to outcome plus concrete quality criteria. Inspect whether criteria include coverage, evidence/source requirements, stopping condition, and explicit quality feedback. Source: L7426-L7665. Assessment: learner labels what is prompt-only versus measured/enforced; no claim that transcript solution fully enforces it.
- Lab candidate: simulate multi-batch finding collection and identify safe persistence boundary. Failure injection: stop after a batch; expected conceptual result is already-written findings survive. Source rationale: L7670-L7725. Do not prescribe implementation/API beyond transcript.
- Lab candidate: map a research-before-synthesis requirement into precondition, pre-tool check, tool execution, post-tool inspection. Source: L7817-L8061. Assessment: invalid synthesis attempt is blocked before tool call.
- Lab candidate: prepare a structured escalation handoff from supplied tool-loop state; peer reviewer must answer case without searching prior conversation. Source: L8062-L8253. Assess context completeness, not customer/refund domain correctness.
- Lab candidate: classify fixed pipeline versus adaptive coordinator from scenarios. Source: L8340-L9200. Assessment: learner selects prompt chain only when work shape/order is known.
- Lab candidate: review dungeon demo design and locate stated boundary, missing guarantee, configuration issue, and observed missing output. Source: L8494-L9176. Treat as architecture critique, not production game build; transcript demo is explicitly incomplete/failing.

## Open questions and gaps

- Official CCA-F (UNVERIFIED) blueprint, domain names, scoring weights, objective verbs, and authoritative terminology are absent. Keep all `ccaf-cNN-oM` IDs provisional until registry-first mapping.
- Exact lesson/chapter count and `NN` chapter numbers are unknown; coordinate with all chunks before assigning stable IDs.
- Raw-findings dilemma ends at L9205. Read next chunk before teaching a structured-transfer remedy or asserting which provenance fields synthesis needs.
- Transcript presents agent/SDK/CLI behavior conversationally and includes an initial hook-availability correction. Verify current product/API behavior against approved authoritative sources before publishing facts as certification guidance.
- Examples use Python, TypeScript, SDK/API keys, environment configuration, and `npm` in source demos. They are course artifacts only; topic implementation must retain repository invariants: static offline files, no build, no dependencies, classic scripts only if any later interactive enhancement is approved.
- Quality criteria demo reports source repetition, errors, and uncertain quality; do not present output as validated benchmark or claim Haiku (UNVERIFIED)/model choice is exam requirement.
- Dungeon generated implementation lacks demonstrated programmatic invocation gate and fails expected content generation. Use it as failure-analysis evidence, not reference architecture.
- Need continuation/source confirmation for raw findings, schema/attribution design, error handling, stop criteria, hook error semantics, and whether any pattern is named in official CCA-F (UNVERIFIED) assessment.
