## Chunk metadata

- UNVERIFIED: Topic: Claude Certified Architect - Foundations (`ccaf`); exam code: `CCA-F`.
- Source: Andrew Brown course transcript, `/tmp/ccaf-chunks/chunk7`.
- Global transcript coverage: lines 12888-14728; local chunk lines 1-1841.
- Scope: Claude Code permission/sandbox behavior; built-in tools and diagnostics; Agent SDK tool use; tool choice; JSON Schema and structured output; prompt specificity; human review/confidence calibration; opening of multi-source synthesis.
- Boundary: starts mid permission/sandbox demonstration (12888); ends mid synthesis implementation setup (14728). Treat implementation-specific observations and speaker corrections as course notes, not unverified product guarantees.

## Lesson inventory

| # | title | chunk line refs | one-line summary |
|---:|---|---|---|
| UNVERIFIED: 1 | Permission rules, sandbox, and dangerous permission skipping | 12888-13093 | Demo observes explicit deny rules, sandbox constraints, network approval, and risk of skipping approvals. |
| UNVERIFIED: 2 | Claude Code built-in tool catalogue and default permissions | 13094-13176 | Reviews built-in tools, asterisk permission marking, and explicit allow/ask/deny framing. |
| UNVERIFIED: UNVERIFIED: 3 | Status command and authentication recognition | 13177-13292 | Shows how status output distinguishes subscription, API-key, Bedrock, and logged-out states. |
| UNVERIFIED: 4 | Debug command and session logs | 13293-13368 | Enables verbose session logging, captures a problem description, and inspects diagnostic output. |
| UNVERIFIED: 5 | Agent SDK built-in tools | 13369-13484 | Explains read, grep, glob, edit, bash, and agent use in an SDK example. |
| UNVERIFIED: 6 | Tool choice modes | 13485-13544 | Compares `auto`, `any`, named `tool`, and `none`, including structured-output and looping implications. |
| UNVERIFIED: 7 | JSON Schema and tool input schemas | 13545-13588 | Defines schema properties, types, enums, nested objects, and required inputs for tools. |
| UNVERIFIED: 8 | Structured JSON via tool use | 13589-14097 | Builds a triage example, corrects tool-choice assumptions, and exposes validation and loop boundaries. |
| 9 | Prompt specificity and false positives | 14098-14146 | Connects vague prompts to broad, costly, off-target agent work; requires constrained task instructions. |
| 10 | Human review workflows and confidence calibration | 14147-14580 | Uses field-level confidence, stratified sampling, and per-field/per-document accuracy instead of a single aggregate. |
| 11 | Multi-source synthesis and information preservation | 14581-14728 | Introduces claim-source mappings, source attribution, and explicit treatment of credible-source conflicts. |

## Per-lesson plan

### 1. Permission rules, sandbox, and dangerous permission skipping

- UNVERIFIED: Key concepts: local explicit deny rule; command-pattern matching; sandbox; network request approval; sandbox retry/disable behavior observed in demo; `--dangerously-skip-permissions`; queued-command attention risk.
- UNVERIFIED: Exam-relevant facts: permission restrictions and sandbox are separate layers in the demonstrated flow; an explicit denial may require correct command-pattern form; skipping permissions removes approval prompts for potentially dangerous commands; transcript demonstrates a command changing sandbox state after failure (12888-13093), so present as risk observation, not security assurance.
- Candidate objectives: `ccaf-cNN-o1` (NN TBD): Explain permission-rule and sandbox roles, and assess risk before bypassing approval controls; `ccaf-cNN-o2` (NN TBD): Diagnose why a command is blocked without treating a bypass flag as a routine fix.
- Glossary terms with g- slugs: `g-permission-rule`; `g-explicit-deny`; `g-sandbox`; `g-network-approval`; `g-dangerously-skip-permissions`.
- UNVERIFIED: Diagram candidates with archetype: process - command request -> permission rule -> sandbox/network decision -> allow, deny, or retry path; callout - approval-bypass warning beside `--dangerously-skip-permissions`.
- UNVERIFIED: Comparison/decision table candidates with rows and columns: rows `explicit deny`, `sandbox restriction`, `network approval`, `dangerous skip flag`; columns `control point`, `demo observation`, `risk if bypassed`, `safe investigation step`.
- UNVERIFIED: MCQ candidates: 3; applied stems: command fails because sandbox cannot write required cache; rule intended to deny `mpx` does not match invoked command; user has many queued commands and considers skipping approval prompts.
- UNVERIFIED: Recall prompts: 3; Name two distinct control layers shown in the demo; Why can a command-pattern deny rule fail to block intended invocation? What operational risk increases when approvals are skipped?
- UNVERIFIED: Confusion pairs with discriminator: sandbox vs permission rule - sandbox constrains execution environment while rule governs tool/command authorization; network approval vs dangerous-skip-permissions - network prompt is a connection gate while skip flag suppresses command approval prompts.
- UNVERIFIED: Common wrong turn misconceptions: `--dangerously-skip-permissions` makes execution safe; sandbox failure proves permission rule is absent; a partial command name necessarily matches every command invocation.
- UNVERIFIED: Causal step chains only if genuine: 1. Command requests execution. 2. Permission and sandbox checks apply. 3. Missing cache write capability causes sandbox failure in demo. 4. Retrying with sandbox disabled changes protection state; therefore reassess before proceeding.

### 2. Claude Code built-in tool catalogue and default permissions

- Key concepts: built-in tool list; alphabetical discovery; agent; ask-user-question; bash; cron operations; edit; plan/worktree controls; glob; grep; LSP; notebook editing; read; task operations; tool search; web fetch/search; write; permission asterisk.
- UNVERIFIED: Exam-relevant facts: transcript says tools marked with an asterisk require permissions; unmarked tools are described as generally read-only or non-impacting, but can still be explicitly allow/ask/deny controlled; tool parameters may require identifiers such as task IDs (13094-13176).
- Candidate objectives: `ccaf-cNN-o3` (NN TBD): Classify built-in tools by action and permission impact; `ccaf-cNN-o4` (NN TBD): Apply explicit allow, ask, or deny policy to a tool rather than infer safety solely from default prompting.
- Glossary terms with g- slugs: `g-built-in-tool`; `g-tool-permission`; `g-read-only-tool`; `g-task-id`; `g-language-server-protocol`.
- UNVERIFIED: Diagram candidates with archetype: comparison - tool groups `read/search`, `write/edit`, `execute`, `orchestrate`; concept - asterisk marker linked to permission-required meaning.
- UNVERIFIED: Comparison/decision table candidates with rows and columns: rows `read`, `glob`, `grep`, `edit`, `bash`, `agent`, `write`; columns `stated purpose`, `reads or changes`, `permission marker discussed`, `example decision`.
- UNVERIFIED: MCQ candidates: 3; applied stems: select tool for matching file names vs file contents; identify tool type requiring approval in default mode; choose policy treatment for an unmarked tool that organization still wishes to deny.
- UNVERIFIED: Recall prompts: 3; What does the transcript say an asterisk indicates? Distinguish glob from grep. Why can explicit policy still matter for an unmarked tool?
- UNVERIFIED: Confusion pairs with discriminator: glob vs grep - glob discovers file paths by pattern while grep searches file contents; default non-prompt behavior vs explicit allow - absence of initial prompt does not preclude policy control.
- UNVERIFIED: Common wrong turn misconceptions: all unmarked tools are harmless; bash and edit are interchangeable at policy level; tool list alone identifies every parameter required for a call.
- Causal step chains only if genuine: none - omission beats invented process.

### 3. Status command and authentication recognition

- UNVERIFIED: Key concepts: `/status` in interactive CLI; status before opening interactive console; authentication method; first-party API; subscription; custom Anthropic API key; third-party Bedrock; credential flags; logged-out state; competing token detection; API spend reminder.
- UNVERIFIED: Exam-relevant facts: course identifies API-backed state through null subscription and a `manage key` indicator; subscription state does not show API-key source; custom key reports Anthropic API-key source; Bedrock is described as third-party and uses AWS credentials plus provider selection; status can show logged-in false and method none (13177-13292).
- Candidate objectives: `ccaf-cNN-o5` (NN TBD): Interpret status output to identify active authentication/provider mode; `ccaf-cNN-o6` (NN TBD): Resolve conflicting credentials by logging out, checking environment keys, and explicitly logging back in.
- UNVERIFIED: Glossary terms with g- slugs: `g-status-command`; `g-subscription-authentication`; `g-api-key`; `g-api-key-source`; `g-bedrock`; `g-environment-variable`; `g-authentication-method`.
- UNVERIFIED: Diagram candidates with archetype: decision - status indicators route to subscription, managed API key, custom API key, Bedrock, or logged-out interpretation.
- UNVERIFIED: Comparison/decision table candidates with rows and columns: rows `managed API key`, `subscription`, `custom API key`, `Bedrock`, `not logged in`; columns `provider label`, `subscription clue`, `key-source clue`, `remediation/recognition note`.
- UNVERIFIED: MCQ candidates: 4; applied stems: user must confirm whether direct API spend can occur; status displays null subscription and managed key; two tokens are detected; user expects Bedrock but sees first-party indicators.
- UNVERIFIED: Recall prompts: 4; Which clues distinguish subscription from API-key use in the course? What marks custom API-key usage? What steps address multiple configured tokens? Why check status before interactive use?
- UNVERIFIED: Confusion pairs with discriminator: managed API key vs custom API key - managed key is created through account login flow while custom source is explicitly reported; first-party vs Bedrock - Bedrock is described as third-party using AWS credentials/provider selection.
- UNVERIFIED: Common wrong turn misconceptions: every first-party status means subscription; API and subscription costs have identical implications; multiple tokens can be ignored if a session opens.
- UNVERIFIED: Causal step chains only if genuine: 1. Run status before session use. 2. Read authentication/provider and key-source indicators. 3. If unintended or multiple credentials appear, log out, inspect environment keys, then explicitly log in with intended method.

### 4. Debug command and session logs

- UNVERIFIED: Key concepts: `/debug`; debug logging for current session; `--debug` at startup; prompt to describe problem; reproduce issue; text log file; connections; enabled/disabled tools; diagnostic sharing uncertainty; sensitive-data review caveat.
- UNVERIFIED: Exam-relevant facts: debug mode writes verbose session information to a specific text file and asks for a problem description; transcript says startup debug can be enabled with `--debug`; logs shown include temporary files, permission-file details, connections, and tool state (13293-13368).
- Candidate objectives: `ccaf-cNN-o7` (NN TBD): Use debug mode to collect reproducible diagnostic evidence; `ccaf-cNN-o8` (NN TBD): Inspect debug artifacts before sharing because transcript does not establish their sensitivity guarantees.
- Glossary terms with g- slugs: `g-debug-mode`; `g-debug-log`; `g-reproduction`; `g-verbose-logging`; `g-session-diagnostics`.
- Diagram candidates with archetype: process - enable debug -> describe issue -> reproduce behavior -> locate log -> inspect/share through approved support path; callout - inspect logs for sensitive data before external disclosure.
- UNVERIFIED: Comparison/decision table candidates with rows and columns: rows `/debug during session`, `--debug at startup`; columns `when enabled`, `problem description flow`, `log outcome`, `best fit`.
- UNVERIFIED: MCQ candidates: 3; applied stems: bug cannot be reproduced after session has started; support asks for evidence about tool state; user plans to paste raw debug output externally.
- UNVERIFIED: Recall prompts: 3; What two ways of enabling debug are described? What does debug request from user? Name two data categories the observed log can contain.
- UNVERIFIED: Confusion pairs with discriminator: debug log vs agent answer - log records diagnostic/session detail while answer addresses task; `/debug` vs `--debug` - one enables in current interactive session and one starts session in debug mode.
- Common wrong turn misconceptions: debug automatically fixes code; a vague issue description is enough to reproduce fault; logs are proven non-sensitive because no secrets were noticed in one demo.
- Causal step chains only if genuine: 1. Enable debugging. 2. Describe and reproduce specific issue. 3. Inspect generated text log. 4. Redact/review before escalation or sharing.

### 5. Agent SDK built-in tools

- Key concepts: Agent SDK; read; grep; glob; edit; bash; agent; file content search vs filename discovery; sandbox treatment of bash; coding-harness baseline tools.
- UNVERIFIED: Exam-relevant facts: read loads files; grep searches file contents; glob discovers files matching a pattern; edit changes files; bash can perform broad shell actions; transcript calls these core tools for a coding harness and shows an example that exercises glob, read, grep, bash, edit, and agent (13369-13484).
- Candidate objectives: `ccaf-cNN-o9` (NN TBD): Choose an SDK built-in tool by required operation and least necessary scope; `ccaf-cNN-o10` (NN TBD): Explain why broad shell capability changes sandbox and authorization considerations.
- Glossary terms with g- slugs: `g-agent-sdk`; `g-read-tool`; `g-grep-tool`; `g-glob-tool`; `g-edit-tool`; `g-bash-tool`; `g-agent-tool`.
- UNVERIFIED: Diagram candidates with archetype: comparison - user task mapped to read, grep, glob, edit, bash, or agent; process - discover files -> read contents -> search definitions -> edit -> execute/test, labeled as example workflow rather than mandatory sequence.
- UNVERIFIED: Comparison/decision table candidates with rows and columns: rows `read`, `grep`, `glob`, `edit`, `bash`, `agent`; columns `stated capability`, `search target`, `mutation capability`, `scope concern`.
- UNVERIFIED: MCQ candidates: 4; applied stems: locate all calculator filenames; find `def` occurrences in a path; alter a known file; delegate bounded subtask; choose least broad operation.
- UNVERIFIED: Recall prompts: 4; Distinguish glob and grep. Which tool loads a file? Which tool changes a file? Why is bash broader than the named tools?
- UNVERIFIED: Confusion pairs with discriminator: read vs grep - read retrieves a file while grep searches matching content; glob vs grep - path pattern vs content pattern; edit vs bash - edit targets file modifications while bash exposes general shell execution.
- UNVERIFIED: Common wrong turn misconceptions: glob searches inside source text; bash is required for every task; agent replaces need to define task boundaries.
- Causal step chains only if genuine: none - omission beats invented process.

### 6. Tool choice modes

- UNVERIFIED: Key concepts: low-level Anthropic SDK; Agent SDK limitation stated by course; `auto`; `any`; named `tool`; `none`; end turn; structured JSON edge case; forced tool iteration; loop termination.
- UNVERIFIED: Exam-relevant facts: `auto` may use no tool; `any` must select some tool from supplied list; named `tool` requires a named tool and, in demonstrated loop, did not reach end turn without explicit break; `none` disables tool use; course says this option is available in low-level Anthropic SDK rather than its Agent SDK wrapper (13485-13544).
- Candidate objectives: `ccaf-cNN-o11` (NN TBD): Select tool-choice mode for optional, required-any, required-specific, or prohibited tool use; `ccaf-cNN-o12` (NN TBD): Identify loop risk when a response loop forces a named tool every request.
- Glossary terms with g- slugs: `g-tool-choice`; `g-auto-tool-choice`; `g-any-tool-choice`; `g-named-tool-choice`; `g-none-tool-choice`; `g-end-turn`; `g-low-level-sdk`.
- UNVERIFIED: Diagram candidates with archetype: decision - output requirement and tool constraint -> `auto`, `any`, named `tool`, or `none`; process - response loop with named tool -> tool result appended -> repeat unless explicit break condition.
- UNVERIFIED: Comparison/decision table candidates with rows and columns: rows `auto`, `any`, named `tool`, `none`; columns `tool required`, `tool selection`, `may return no tool/text`, `loop/end-turn implication`.
- UNVERIFIED: MCQ candidates: 4; applied stems: JSON consumer fails if text returns without tool use; system must call one among several tools; workflow must call exact `submit_triage`; workflow must prohibit tools.
- UNVERIFIED: Recall prompts: 4; Which mode permits no tool call? Which requires one supplied tool but lets model choose? Which mode names exact tool? Why can named tool cause a loop in shown response pattern?
- UNVERIFIED: Confusion pairs with discriminator: `any` vs named `tool` - any requires some listed tool, named mode requires one specified tool; `auto` vs `none` - auto may decide to use tool while none forbids it; Agent SDK vs low-level SDK - course locates tool-choice control in low-level SDK.
- UNVERIFIED: Common wrong turn misconceptions: `any` means tool call is optional; named tool guarantees one-and-done response; every Anthropic SDK layer exposes identical tool-choice parameter.
- Causal step chains only if genuine: 1. Named tool mode requires a tool each API request. 2. Loop appends returned tool result. 3. Next request again requires tool. 4. Add explicit break/termination handling or select mode that permits end turn.

### 7. JSON Schema and tool input schemas

- Key concepts: declarative schema; JSON document structure; constraints; types `string`, `integer`, `boolean`, `number`; arrays/items; enum; nested object; required fields; tool input schema; location and unit example; Celsius/Fahrenheit enum.
- UNVERIFIED: Exam-relevant facts: transcript identifies enum and required fields as important for exam; enum restricts accepted values; required marks non-optional fields; models read JSON schema to determine expected tool input; Pydantic is mentioned as a Python library that can produce JSON Schema from class-like models (13545-13588).
- Candidate objectives: `ccaf-cNN-o13` (NN TBD): Design or interpret a tool input schema with type, enum, nested object, array, and required constraints; `ccaf-cNN-o14` (NN TBD): Use enums and required fields to constrain generated tool arguments.
- Glossary terms with g- slugs: `g-json-schema`; `g-schema-property`; `g-enum`; `g-required-field`; `g-array-items`; `g-nested-object`; `g-tool-input-schema`; `g-pydantic`.
- Diagram candidates with archetype: concept - tool input schema annotating property type, enum, and required list; worked-scenario - weather-like input with required location and constrained unit.
- UNVERIFIED: Comparison/decision table candidates with rows and columns: rows `string`, `integer`, `boolean`, `number`, `array`, `object`, `enum`, `required`; columns `schema role`, `constraint/example from transcript`, `tool-input consequence`.
- UNVERIFIED: MCQ candidates: 4; applied stems: tool accepts only Celsius or Fahrenheit; caller omits required location; nested record needed; list of values required; choose schema construct for fixed values.
- UNVERIFIED: Recall prompts: 4; What does enum constrain? What does required express? Name four primitive types listed. How does schema affect tool argument generation?
- Confusion pairs with discriminator: enum vs required - enum restricts allowed value set while required requires property presence; array vs object - array holds items while object contains named properties; schema validity vs semantic correctness - schema constrains format, not factual quality.
- UNVERIFIED: Common wrong turn misconceptions: required validates whether value is factually correct; enum makes a field optional; JSON Schema is only documentation and not an input contract.
- Causal step chains only if genuine: 1. Define allowed properties and constraints. 2. Supply schema as tool input contract. 3. Model generates arguments against contract. 4. Tool receives constrained structure; semantic correctness still needs separate handling.

### 8. Structured JSON via tool use

- UNVERIFIED: Key concepts: raw support ticket; triage record; `submit_triage`; tool input/output; MCP server; Agent SDK vs lower-level Anthropic SDK; allowed tools; tool-choice correction from unsupported `force` to named `tool`; required tool name; response loop; `end_turn`; syntax vs semantic errors; Pydantic as practical additional validation; batch reliability testing.
- UNVERIFIED: Exam-relevant facts: course finds Agent SDK does not expose underlying tool-choice parameter, so it converts example to lower-level SDK; API error rejects `force` and accepts `auto`, `any`, named `tool`, or `none`; named tool choice needs a name; named-tool loop repeatedly calls tool until explicit break; strict tool schemas reduce syntax errors but do not prevent semantic errors (13589-14097).
- Candidate objectives: `ccaf-cNN-o15` (NN TBD): Implement structured output through a tool contract while selecting SDK layer that exposes required controls; `ccaf-cNN-o16` (NN TBD): Diagnose invalid tool-choice type/name errors and response-loop termination; `ccaf-cNN-o17` (NN TBD): Separate schema-format validation from semantic validation and reliability testing.
- Glossary terms with g- slugs: `g-structured-output`; `g-structured-json`; `g-submit-triage`; `g-tool-result`; `g-mcp-server`; `g-semantic-error`; `g-syntax-error`; `g-response-loop`; `g-batch-testing`.
- UNVERIFIED: Diagram candidates with archetype: process - raw ticket -> model -> `submit_triage` structured arguments -> tool -> result -> end turn or controlled loop; worked-scenario - missing tool-choice name produces request error; callout - valid JSON/schema does not prove accurate triage.
- UNVERIFIED: Comparison/decision table candidates with rows and columns: rows `Agent SDK example`, `low-level Anthropic SDK example`, `auto`, `any`, named `tool`; columns `tool-choice exposure stated`, `tool-call guarantee`, `end-turn behavior`, `failure/loop concern`.
- UNVERIFIED: MCQ candidates: 5; applied stems: application must force `submit_triage`; request returns invalid tool-choice type; named tool choice lacks name; tool executes repeatedly in `while true`; JSON conforms but classification is wrong; choose appropriate validation layer.
- UNVERIFIED: Recall prompts: 5; Why did course switch SDK layers? Which token replaced `force` in corrected demo? What extra field does named tool choice require? Why can a forced named tool loop? What error class can strict schema not prevent?
- UNVERIFIED: Confusion pairs with discriminator: `force` vs named `tool` - transcript corrects `force` as invalid API type and uses `tool`; schema syntax validity vs semantic accuracy - structurally compliant record can still be wrong; `any` vs named `tool` - any permits end turn after tool result in demonstration while named tool continues unless controlled.
- UNVERIFIED: Common wrong turn misconceptions: forcing a tool guarantees correct output; `tool` choice means one call only; Agent SDK must expose every underlying API control; one successful run proves durable behavior.
- Causal step chains only if genuine: 1. Define tool schema and required fields. 2. Configure tool choice with valid type and, for named tool, name. 3. Model emits structured arguments. 4. Tool returns result. 5. Response handler must allow end turn or explicitly break forced-loop path. 6. Validate semantics separately and test repeated runs when reliability matters.

### 9. Prompt specificity and false positives

- UNVERIFIED: Key concepts: vague instruction; false positive; broad codebase search; unrelated files; compute/time cost; specific issue definition; constrained audit; plan mode as possible task clarification aid.
- UNVERIFIED: Exam-relevant facts: course says vague prompts can cause agents to work on wrong files and generate broad, expensive results; prompt `fix the login bug` lacks needed scope; specificity improves predictability and efficiency, though vague prompting can sometimes work (14098-14146).
- Candidate objectives: `ccaf-cNN-o18` (NN TBD): Rewrite vague agent tasks into bounded, testable instructions; `ccaf-cNN-o19` (NN TBD): Explain how specificity reduces false positives, compute use, and review burden.
- UNVERIFIED: Glossary terms with g- slugs: `g-prompt-specificity`; `g-vague-prompt`; `g-false-positive`; `g-task-scope`; `g-compute-cost`; `g-plan-mode`.
- Diagram candidates with archetype: comparison - vague code-review request vs constrained single-issue audit; decision - insufficient task details -> clarify target, location, expected behavior, and boundary before execution.
- Comparison/decision table candidates with rows and columns: rows `fix login bug`, `audit codebase for issues`, `audit specified issue in specified area`; columns `scope clarity`, `likely search breadth`, `false-positive risk`, `compute/time implication`, `reviewability`.
- UNVERIFIED: MCQ candidates: 3; applied stems: agent edits unrelated app after generic request; team needs audit of one vulnerability category; user asks why broad request consumes compute; select improved prompt details.
- UNVERIFIED: Recall prompts: 3; Define false positive in this agent-work context. Why can `fix the login bug` be insufficient? Name two costs of vague scope.
- Confusion pairs with discriminator: vague prompt vs open-ended exploration - vague prompt lacks intended boundary while deliberate exploration can state broad goal; false positive vs model refusal - false positive does unwanted work while refusal declines or cannot proceed.
- Common wrong turn misconceptions: broader prompt always finds more useful defects; plan mode replaces requirement details; a result that changes files proves task was understood.
- Causal step chains only if genuine: 1. Vague prompt leaves target undefined. 2. Agent broadens search/action. 3. Unrelated candidates arise. 4. Compute, time, and review burden increase. 5. Specific boundaries narrow work and improve relevance.

### 10. Human review workflows and confidence calibration

- Key concepts: aggregate accuracy; hidden distribution; document type; field complexity; stratified random sampling; field-level confidence; human review; low-confidence routing; confirmation/edit/defer actions; per-field and per-document accuracy; calibration gap; CUAD dataset from Hugging Face in demonstration; law-firm contract-intake example; auto-approve threshold; model extraction caveat.
- UNVERIFIED: Exam-relevant facts: a single 90 percent aggregate can conceal different performance by document type, field, or factor; stratified sampling deliberately includes each category; field confidence can vary within one document; course demo tracks accuracy by field/document and routes lower-confidence items for human review; demonstration selects 511 dataset rows after download and correction, but dataset behavior is lab-specific (14147-14580).
- Candidate objectives: `ccaf-cNN-o20` (NN TBD): Design human review using field-level confidence and explicit review routing; `ccaf-cNN-o21` (NN TBD): Evaluate model quality with stratified samples and segmented accuracy rather than aggregate-only metrics; `ccaf-cNN-o22` (NN TBD): Record reviewer confirmation, edit, or deferral for calibration and accuracy measurement.
- Glossary terms with g- slugs: `g-confidence-calibration`; `g-aggregate-accuracy`; `g-stratified-random-sampling`; `g-field-level-confidence`; `g-human-review`; `g-auto-approve-threshold`; `g-calibration-gap`; `g-cuad`.
- UNVERIFIED: Diagram candidates with archetype: process - document -> field extraction/confidence -> threshold routing -> reviewer confirm/edit/defer -> per-field/per-document metrics; comparison - aggregate-only score vs segmented metrics; worked-scenario - contract clause extraction at 73 percent receives review rather than automatic acceptance.
- Comparison/decision table candidates with rows and columns: rows `aggregate accuracy`, `accuracy by document type`, `accuracy by field`, `field-level confidence`, `stratified sample`; columns `information retained`, `hidden-risk exposure`, `review-routing value`, `course example`.
- UNVERIFIED: MCQ candidates: 5; applied stems: system reports 90 percent overall but fails one clause category; team randomly samples dominant document type only; one extraction has high date confidence and low vendor confidence; select fields for attorney review; choose metric/report for calibration issue.
- UNVERIFIED: Recall prompts: 5; Why can aggregate accuracy hide risk? What makes sampling stratified? Give example of different field confidences. What review actions are shown? Which two accuracy dimensions are tracked in demo?
- UNVERIFIED: Confusion pairs with discriminator: confidence score vs measured accuracy - confidence is model certainty signal for an item/field while accuracy compares outputs with expected values; random sampling vs stratified sampling - stratified deliberately represents each category; auto-approve threshold vs human review - threshold routes outcome while review supplies decision/correction data.
- Common wrong turn misconceptions: 90 percent aggregate ensures all categories are safe; document-level confidence is enough for every field; low confidence proves result false; sample coverage emerges automatically from random selection.
- Causal step chains only if genuine: 1. Extract fields and record field-level confidence. 2. Route according to approval/review threshold. 3. Reviewer confirms, edits, or defers. 4. Compare output to expected/corrected values by field and document category. 5. Use segmented results and stratified samples to expose calibration gaps.

### 11. Multi-source synthesis and information preservation

- Key concepts: synthesis agent; findings; scratchpads; source attribution; claim-source mapping; compressed summarization; conflict/contradiction; deduplication; credible conflicting statistics; publication/date metadata; structured sub-agent output; final answer questions; movie-source example; incomplete lesson.
- UNVERIFIED: Exam-relevant facts: transcript states source attribution can be lost when findings are compressed without claim-source mappings; it calls for sub-agent structured claim-source mappings and annotating credible-source conflicts with source attribution; it suggests publication/date information for source outputs; implementation discussion is incomplete at chunk end (14581-14728).
- Candidate objectives: `ccaf-cNN-o23` (NN TBD): Preserve claim-to-source mappings through synthesis; `ccaf-cNN-o24` (NN TBD): Present conflicting credible-source claims with attribution rather than silently collapsing them; `ccaf-cNN-o25` (NN TBD): Require structured finding outputs that retain source, confidence, tags, and claim details where applicable.
- Glossary terms with g- slugs: `g-synthesis`; `g-finding`; `g-source-attribution`; `g-claim-source-mapping`; `g-conflicting-statistics`; `g-deduplication`; `g-scratchpad`; `g-structured-finding`.
- Diagram candidates with archetype: process - sources -> explorer findings with claim/source/confidence -> synthesis preserves mappings -> attributed answer with conflicts; callout - compression without claim-source mapping loses provenance.
- Comparison/decision table candidates with rows and columns: rows `unmapped summary`, `structured claim-source mapping`, `deduplicated finding`, `conflicting credible findings`; columns `source retained`, `conflict visibility`, `reviewability`, `final-answer treatment`.
- UNVERIFIED: MCQ candidates: 4; applied stems: two credible publications disagree on statistic; synthesizer merges statements but drops origin; sub-agent returns claim with confidence but no source; answer must present a conflict without inventing reconciliation.
- UNVERIFIED: Recall prompts: 4; How is attribution lost during summarization? What should structured sub-agent output preserve? How should credible conflict be represented? Why include publication/date details when available?
- Confusion pairs with discriminator: source attribution vs confidence - attribution identifies origin while confidence expresses certainty; deduplication vs conflict resolution - deduplication removes duplicates while conflict remains when credible claims differ; synthesis vs collection - collection gathers findings while synthesis combines them while preserving provenance.
- UNVERIFIED: Common wrong turn misconceptions: a final summary need not retain claim origin; conflicting sources should be averaged or silently choose one; confidence score substitutes for citation/source mapping.
- Causal step chains only if genuine: 1. Explorer gathers findings. 2. Each finding retains claim and source mapping, with available confidence/tags/date metadata. 3. Synthesizer combines findings. 4. Deduplicate duplicates but annotate unresolved credible conflicts. 5. Generate final response that preserves source attribution.

## Proposed chapter mapping

| Proposed chapter | Lesson inventory items | Draft objective range | Rationale and boundaries |
|---|---|---|---|
| UNVERIFIED: C? Claude Code safety, permissions, and diagnostics | 1-4 | `ccaf-cNN-o1` through `ccaf-cNN-o8` | Keep authorization/sandbox, tool policy, auth-status recognition, and debugging together; status facts require current official-product verification. |
| UNVERIFIED: C? Tool-enabled agent foundations | 5-8 | `ccaf-cNN-o9` through `ccaf-cNN-o17` | Build from tool selection to schema and structured-output control; separate tool-choice API-layer caveat from timeless concepts. |
| C? Reliable agent task design and review | 9-10 | `ccaf-cNN-o18` through `ccaf-cNN-o22` | Pair scope control with human oversight, calibration, and segmented quality evaluation. |
| C? Evidence-preserving multi-agent synthesis | 11 | `ccaf-cNN-o23` through `ccaf-cNN-o25` | Hold as an opening section until adjacent chunks establish full synthesis workflow and official blueprint coverage. |

- Chapter numbers remain TBD. Resolve ordered map only after all ten chunk plans and official CCA-F objectives are reconciled.
- Cross-links: lesson 6 tool-choice decisions support lesson 8 structured output; lesson 9 prompt scope reduces review burden in lesson 10; lesson 11 provenance is a separate quality dimension from lesson 10 confidence.

## Hands-on / lab content

| Source demo | Transcript refs | Static lesson/lab plan | Evidence and guardrail |
|---|---|---|---|
| UNVERIFIED: Permission deny and sandbox experiment | 12888-13093 | Explain scenario with decision table and risk callout; ask learner to identify policy, sandbox, network, and bypass states. No executable command exercise. | Demo invokes package tooling/network and changes protection state; topic remains offline/static. |
| Status recognition | 13177-13292 | Provide anonymized status-output cases as text and ask learner to identify intended authentication/provider state. | Do not reproduce credentials or require account access. |
| Debug evidence review | 13293-13368 | Provide mock log fragments and ask learner to identify reproduction detail, tool state, and redaction concern. | Use fabricated, ASCII-only examples; do not publish actual logs. |
| UNVERIFIED: Built-in tool selection | 13369-13484 | Scenario matrix: select read, grep, glob, edit, bash, or agent for bounded task. | No SDK execution needed. |
| UNVERIFIED: UNVERIFIED: Tool-choice and triage workflow | 13485-14097 | Trace structured ticket -> `submit_triage` -> result -> end turn/loop; diagnose invalid `force`, missing name, and missing break cases. | State transcript correction; no code, API key, or live tool call. |
| Confidence-calibrated review | 14147-14580 | Static contract-field examples with confidence values; learner routes auto-approve/review and compares aggregate vs segmented report. | Use synthetic data only; source demo downloads dataset and installs packages, neither suitable for offline page. |
| Evidence-preserving synthesis | 14581-14728 | Give two conflicting attributed findings; learner builds claim-source map and writes conflict-preserving summary. | Complete after later transcript material confirms workflow details. |

## Open questions and gaps

- Lesson 1 starts mid-demo. Read chunk6 before assigning its exact course lesson title, preceding rule configuration, or claims about permission matching.
- Lesson 11 ends mid-implementation. Read chunk8 before finalizing synthesis artifacts, conflict-resolution method, scratchpad role, and lab scope.
- Official CCA-F blueprint is not in this chunk. Verify all draft objectives, weighting, terminology, and chapter numbers against authoritative exam material before registry work.
- UNVERIFIED: Transcript contains corrections/uncertainty: `force` tool-choice claim is corrected to named `tool` (13589-14097); speaker is uncertain about some tool catalog details, support path, log sensitivity, and SDK parity. Preserve correction and do not turn uncertainty into fact.
- UNVERIFIED: Validate current product behavior for `/status`, `/debug`, built-in tools, permission markers, sandbox behavior, Agent SDK API surface, and tool-choice syntax. Course describes product state as observed during recording.
- Human-review example uses a legal contract dataset and law-firm framing. Confirm whether CCA-F expects this domain example or use neutral synthetic examples to avoid unsupported legal-domain implications.
- Need adjacent chunks to determine whether prompt specificity, calibration, and synthesis are separate exam domains or subsections of one reliability chapter.
- Implementation phase must stay registry-first, use relative local assets only, retain JS-disabled readability, use no build/npm/remote assets, keep source ASCII-only, and pass `tools/verify.ps1` after future content work.
