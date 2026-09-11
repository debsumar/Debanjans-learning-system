## Chunk metadata

- Chunk file: `/tmp/ccaf-chunks/chunk0`.
- Line range: 1-1841 of transcript source; first of 10 equal-size chunks.
- Rough course position: course/exam orientation, then Domain 1 entry through stop reasons and tool use; overlapping Claude Code (UNVERIFIED) workflow foundations; setup and Agent SDK (UNVERIFIED) hello-world support material. Stop-reason implementation and reusable logging/parser work continue past chunk end.
- Authoring constraints for later implementation: registry-first; offline static files only; no build, npm, framework, remote asset, inline style, or root-relative path; shared presentation only; readable without JavaScript; ASCII source; `tools/verify.ps1` zero failures.

## Lesson inventory

| # | Lesson/segment title inferred from transcript | Chunk line refs | One-line summary |
|---|---|---:|---|
| 1 | CCA-F (UNVERIFIED) course and exam orientation | 1-250 | UNVERIFIED: Defines course purpose, audience, six stated domains, reported exam format, and study path. |
| 2 | Course method, prerequisites, and lab-first learning | 251-390 | Explains why setup is externalized and why implementation/labs accompany exam-guide order. |
| 3 | Stop-reason lab brief and first project plan | 391-500 | Starts a Python Claude Agent SDK (UNVERIFIED) example intended to expose `tool_use` (UNVERIFIED), `end_turn` (UNVERIFIED), and appended results. |
| 4 | Reusable Agent SDK (UNVERIFIED) output parser and debugging logs | 501-690 | Refines hello-world output into reusable formatting and per-run logs for inspection/debugging. |
| 5 | Claude Code (UNVERIFIED) fundamentals and agentic loop | 691-825 | Positions Claude Code (UNVERIFIED) as a CLI coding harness with gather-context, action, and verification phases. |
| 6 | Tools in Claude Code (UNVERIFIED) | 826-910 | Defines tools as callable external functions and maps tool examples to loop phases. |
| 7 | Claude Code (UNVERIFIED) model selection (UNVERIFIED) | 911-980 | Covers default selection, Sonnet (UNVERIFIED), Opus (UNVERIFIED), Haiku (UNVERIFIED), long-context Sonnet (UNVERIFIED), and Opus (UNVERIFIED) plan behavior. |
| 8 | Stop reasons and tool-result chaining | 981-1110 | Defines `tool_use` (UNVERIFIED) and `end_turn` (UNVERIFIED); explains return, execution, and conversation append sequence. |
| 9 | Stop-reason/tool-use implementation walkthrough | 1111-1500 | Builds and inspects an async Python example, package setup, tool schema, and weather-tool idea. |
| 10 | Tool-design critique, docs validation, and setup transition | 1501-1630 | Challenges unnecessary MCP use, insists on documentation validation, then starts Claude Code (UNVERIFIED) and Agent SDK (UNVERIFIED) setup. |
| 11 | Claude Code (UNVERIFIED) install, authentication, and minimal Agent SDK (UNVERIFIED) hello world | 1631-1740 | Demonstrates install/login verification, Agent SDK (UNVERIFIED) install, allowed tools (UNVERIFIED), async entrypoint fix, and readable output need. |
| 12 | Shared parser/library and logging refinement | 1741-1841 | Plans reusable parser placement, `CLAUDE.md` (UNVERIFIED) naming, timestamped logs, and log-fed debugging; continues next chunk. |

## Per-lesson plan

### 1. CCA-F (UNVERIFIED) course and exam orientation

- Key concepts: Claude Certified Architect - Foundations; agent-building concepts; Claude models, coding tools, SDKs, MCP; organization workload adoption; partner-network context; exam blueprint; lab and practice-exam study mix. (L1-250)
- Exam-relevant facts: UNVERIFIED: Transcript calls this an Anthropic certification and uses exam code `CCA-F` (UNVERIFIED), while saying no official exam code technically exists. It names six domains: agentic architecture and orchestration; tool design and MCP integration; Claude Code (UNVERIFIED) configuration and workflows; prompt engineering; structured output; context management and reliability. It reports 60 multiple-choice questions, 720 passing score, 120-minute exam time, 150-minute seat time, and says 17 questions may be missed. It says questions are verbose. (L20-220)
- Candidate objectives: `ccaf-cTBD-o1` Explain CCA-F (UNVERIFIED) purpose, intended audience, and stated scope. `ccaf-cTBD-o2` Identify the six transcript-listed exam domains. `ccaf-cTBD-o3` Apply reported time/question constraints to an exam-reading strategy (UNVERIFIED). Chapter number TBD pending all chunks. (L20-220)
- Glossary terms: Claude Certified Architect - Foundations (`g-claude-certified-architect-foundations`); CCA-F (UNVERIFIED) (`g-cca-f`); Model Context Protocol (`g-model-context-protocol`); agentic workflow (`g-agentic-workflow`); Claude Partner Network (`g-claude-partner-network`); Skilljar (`g-skilljar`). (L20-220)
- Diagram candidates: concept: CCA-F (UNVERIFIED) scope map linking agents, models, coding tools, SDKs, MCP, and organization adoption. (L20-80)
- Table candidates: rows: beginner, experienced developer, partner-network learner; columns: transcript-reported preparation path, estimated effort, study emphasis. (L70-150)
- MCQ candidates: 2. Given a learner goal, select whether CCA-F (UNVERIFIED) scope fits; given lengthy scenario questions and a fixed time budget, select best reading/time approach. (L20-220)
- Recall prompts: 3. Name six stated domains. State reported question count/pass score/time (UNVERIFIED). Which learners does transcript position for CCA-F (UNVERIFIED)? (L20-220)
- Confusion pairs: course exam code `CCA-F` (UNVERIFIED) vs official Anthropic code: transcript says `CCA-F` (UNVERIFIED) is common usage although no official code technically exists. UNVERIFIED: Course access vs course content: transcript says certification availability was partner-network limited at recording time. (L20-190)
- Common wrong turn: "CCA-F (UNVERIFIED) is presented as a light introductory course" -> transcript says developer experience is needed and calls it not easy. "Multiple choice means brief/easy parsing" -> transcript says questions are verbose and require careful reading. (L50-220)
- Causal steps: 1. Watch lectures. 2. Perform hands-on labs. 3. Use practice exams; UNVERIFIED: transcript identifies labs as main passing activity. (L120-160)

### 2. Course method, prerequisites, and lab-first learning

- Key concepts: external setup course; exam-guide-led sequence; implementation-focused learning; code example then implementation; hands-on validation; conceptual material versus applied work. (L251-390)
- Exam-relevant facts: Transcript says Agent SDK (UNVERIFIED) and Claude Code (UNVERIFIED) setup are not covered here because they are in Claude Code (UNVERIFIED) Essentials. It says this course walks the exam guide in its stated order and uses code examples followed by implementation. UNVERIFIED: It contrasts Anthropic free, concept-based courses with this implementation approach and says labs are important. (L251-390)
- Candidate objectives: `ccaf-cTBD-o4` Explain why lab execution validates agent/tool concepts beyond conceptual study. `ccaf-cTBD-o5` Distinguish prerequisite setup material from CCA-F (UNVERIFIED) implementation material. Chapter number TBD. (L251-390)
- Glossary terms: Claude Code (UNVERIFIED) Essentials (`g-claude-code-essentials`); Agent SDK (UNVERIFIED) (`g-agent-sdk`); implementation-focused learning (`g-implementation-focused-learning`); exam guide (`g-exam-guide`). (L251-390)
- Diagram candidates: process: exam-guide topic -> code example -> learner implementation -> observed validation. (L280-360)
- Table candidates: rows: concept-based source, implementation-focused course; columns: primary format, shown artifact, stated learning benefit, limits stated in transcript. (L280-370)
- MCQ candidates: 1. Learner knows concepts but cannot validate behavior; select lab-first remediation aligned with transcript approach. (L280-390)
- Recall prompts: 2. Why is setup separated? What instructional loop does course claim to use? (L251-390)
- Confusion pairs: setup instruction vs implementation instruction: setup is externalized; course uses setup knowledge to implement exam-guide concepts. Conceptual diagrams vs hands-on labs: diagrams explain; labs validate behavior by doing. (L251-390)
- Common wrong turn: "Reading conceptual material alone is sufficient" -> transcript argues implementation makes concepts stick and says some learners fail without it. (L280-390)
- Causal steps: 1. Follow exam-guide item. 2. Inspect code example. 3. Implement it. 4. Validate observed behavior. (L280-360)

### 3. Stop-reason lab brief and first project plan

- Key concepts: stop reason; Claude Agent SDK (UNVERIFIED); `tool_use` (UNVERIFIED); `end_turn` (UNVERIFIED); appended tool result; Python example; weather-tool scenario; reusable `lib/sdk_parser` formatting. (L391-500)
- Exam-relevant facts: Transcript lab goal is showing stop reason in Claude Agent SDK (UNVERIFIED), including stop reason for tool use, stop reason for end result, and how a result is chained/appended. It plans a weather tool, Python implementation, and `lib/sdk_parser` for logging information. (L391-500)
- Candidate objectives: `ccaf-cTBD-o6` Describe stop-reason states a client must handle in the transcript example. `ccaf-cTBD-o7` State why a tool-result example must show both tool invocation and result append. Chapter number TBD. (L391-500)
- Glossary terms: stop reason (`g-stop-reason`); tool use (`g-tool-use`); end turn (`g-end-turn`); tool result (`g-tool-result`); SDK parser (`g-sdk-parser`). (L391-500)
- Diagram candidates: worked-scenario: weather request showing tool-use stop, tool result, then final end-turn result. (L391-500)
- Table candidates: rows: `tool_use` (UNVERIFIED), `end_turn` (UNVERIFIED); columns: what agent requests/does next, program responsibility, conversation update. (L391-500)
- MCQ candidates: 2. Client receives `tool_use` (UNVERIFIED); choose next action. Client receives terminal result; choose whether to execute/append a tool result. (L391-500)
- Recall prompts: 3. List lab observations required. Why use weather scenario? What is parser intended to format? (L391-500)
- Confusion pairs: `tool_use` (UNVERIFIED) vs `end_turn` (UNVERIFIED): first needs program tool handling; second is agent completion/result. Raw SDK output vs formatted logs: same run information, different reader usability. (L391-500)
- Common wrong turn: "Seeing a tool-use response alone completes tool workflow" -> transcript plan explicitly requires result chaining/appending too. (L391-500)
- Causal steps: 1. Receive agent stop reason. 2. If it requests tool use, execute tool. 3. Append returned result. 4. Continue until end result. (L391-500)

### 4. Reusable Agent SDK (UNVERIFIED) output parser and debugging logs

- Key concepts: yielded Agent SDK (UNVERIFIED) messages; human-readable formatter; reusable library; project-relative library/log location; ISO/human-readable timestamp logs; logs as debugging input. (L501-690)
- Exam-relevant facts: Transcript says printing each item yielded by `query` (UNVERIFIED) produces raw Python object representations that are hard to read. It plans a reusable formatter library, asks to place it in top-level `lib`, and later asks for a new timestamped log for each `main` run under the consuming project. It feeds a log to Claude debugging after an apparent file-edit discrepancy. (L501-690)
- Candidate objectives: `ccaf-cTBD-o8` Identify why formatted agent output and run logs improve debugging observability. `ccaf-cTBD-o9` Distinguish runtime behavior from stale editor display using actual log/file evidence. Chapter number TBD. (L501-690)
- Glossary terms: query (`g-query`); yielded message (`g-yielded-message`); formatter (`g-formatter`); observability (`g-observability`); ISO timestamp (`g-iso-timestamp`); log directory (`g-log-directory`). (L501-690)
- Diagram candidates: process: Agent SDK (UNVERIFIED) query output -> formatter -> terminal display and timestamped run log -> debugging input. (L501-690)
- Table candidates: rows: raw yielded object output, formatted terminal output, per-run log; columns: audience, readability, persistence, debugging use. (L501-690)
- MCQ candidates: 1. Agent reports edit success but UI appears unchanged; select evidence-first debug action. (L620-690)
- Recall prompts: 2. Why make parser reusable? What artifact should be captured for each `main` run? (L501-690)
- Confusion pairs: raw object representation vs human-readable output: data representation versus reader-oriented formatting. Editor display vs file/log evidence: UI may appear stale; logs/file state provide observed execution evidence in transcript case. (L501-690)
- Common wrong turn: "Agent output is automatically useful to a human" -> transcript calls raw representations hard to read and adds formatting. (L501-570)
- Causal steps: 1. Run `main`. 2. Format emitted message. 3. Write per-run timestamped log. 4. Supply log when debugging failure claim. (L600-690)

### 5. Claude Code (UNVERIFIED) fundamentals and agentic loop

- Key concepts: agentic coding tool; code harness; CLI; codebase reading/editing; commands; development-tool integration; agentic loop; context/action/verification; interruption and feedback. (L691-825)
- Exam-relevant facts: Transcript calls Claude Code (UNVERIFIED) an agentic coding tool that reads a codebase, edits files, runs commands, and integrates with development tools. It says terminal is common/natural because it is a CLI program. Its stated loop phases are gather context, take action, and verify results; loop continues until goal and can be interrupted with corrections. (L691-825)
- Candidate objectives: `ccaf-cTBD-o10` Describe Claude Code (UNVERIFIED) as a CLI coding harness and name its stated capabilities. `ccaf-cTBD-o11` Trace gather context, take action, and verify results for a coding task. Chapter number TBD. (L691-825)
- Glossary terms: Claude Code (UNVERIFIED) (`g-claude-code`); code harness (`g-code-harness`); agentic loop (`g-agentic-loop`); gather context (`g-gather-context`); take action (`g-take-action`); verify results (`g-verify-results`). (L691-825)
- Diagram candidates: process: user request -> gather context -> take action -> verify results -> loop or completion; show interrupt/correction input. (L720-825)
- Table candidates: rows: gather context, take action, verify results; columns: goal, transcript examples, expected observation. (L720-825)
- MCQ candidates: 2. Failing test repair: classify read/edit/test operations by loop phase; agent has wrong direction mid-loop: select interruption/correction action. (L720-825)
- Recall prompts: 3. Why is terminal Claude Code (UNVERIFIED)'s natural mode? Name loop phases. When can user intervene? (L691-825)
- Confusion pairs: Claude Code (UNVERIFIED) vs Claude Agent SDK (UNVERIFIED): transcript calls Code a CLI coding tool; SDK examples are application/program implementation. Loop completion vs user interruption: agent may decide goal met, but user can correct during loop. (L691-825)
- Common wrong turn: "Claude Code (UNVERIFIED) does one action then always exits" -> transcript describes continuous context/action/verification until goal or feedback condition. (L720-825)
- Causal steps: 1. Invoke Claude Code (UNVERIFIED) with request. 2. Gather context. 3. Take action. 4. Verify result. 5. Repeat until goal, feedback need, or stop. (L720-825)

### 6. Tools in Claude Code (UNVERIFIED)

- Key concepts: tools as external code functions; available-tool awareness; tool name/input/output; LLM text limitation; deterministic/external interaction; tool categories; RAG mention; test-repair example. (L826-910)
- Exam-relevant facts: Transcript defines tools as code functions an agent knows and can invoke. It says the agent knows tool name, inputs, and expected output. For a failing Python unit test, it gives read test file for context, edit file for action, and run `pytest` (UNVERIFIED) for verification. It lists context examples including files, APIs, databases, codebase scanning, and system-state queries; action examples including code edits, commands, files, APIs, and scripts; verification examples including tests, compile, query output, logs, and compare results. (L826-910)
- Candidate objectives: `ccaf-cTBD-o12` Match a tool call to context, action, or verification phase. `ccaf-cTBD-o13` Explain why external/deterministic operations require tools rather than text generation alone. Chapter number TBD. (L826-910)
- Glossary terms: tool (`g-tool`); tool input (`g-tool-input`); tool output (`g-tool-output`); deterministic (`g-deterministic`); retrieval augmented generation (`g-retrieval-augmented-generation`); pytest (`g-pytest`). (L826-910)
- Diagram candidates: worked-scenario: failing test -> read test -> edit target -> run `pytest` (UNVERIFIED) -> inspect output. (L836-880)
- Table candidates: rows: context, action, verification; columns: purpose, listed examples, failing-test example. (L836-910)
- MCQ candidates: 3. Classify API search/read/edit/test commands by phase; select tool for deterministic lookup; choose next tool after failed verification. (L826-910)
- Recall prompts: 3. Define tool. What tool metadata does agent know? Give one example per loop phase. (L826-910)
- Confusion pairs: tool function vs model (UNVERIFIED) text: function performs external/deterministic work; model (UNVERIFIED) produces text and selects use. Context-gathering tool vs verification tool: first enriches decision context; second tests action outcome. (L826-910)
- Common wrong turn: "Tools are separate magic capabilities, not functions" -> transcript says literally code functions. "Tool call itself proves result" -> verification can require a test, log, output query, or comparison. (L826-910)
- Causal steps: 1. Read failing test. 2. Edit needed file. 3. Run `pytest` (UNVERIFIED). 4. Inspect returned result. (L836-880)

### 7. Claude Code (UNVERIFIED) model selection (UNVERIFIED)

- Key concepts: model (UNVERIFIED) choice for an agentic loop; default model selection (UNVERIFIED); Sonnet (UNVERIFIED); Opus (UNVERIFIED); Haiku (UNVERIFIED); 1-million-token Sonnet (UNVERIFIED) context; Opus (UNVERIFIED) plan mode; UNVERIFIED: subscription versus API usage visibility. (L911-980)
- Exam-relevant facts: Transcript says Claude Code (UNVERIFIED) normally uses the same model (UNVERIFIED) for all loop phases, with a choice at execution. It describes default as best guess; Sonnet (UNVERIFIED) for daily coding; Opus (UNVERIFIED) for complex reasoning; Haiku (UNVERIFIED) as fast/efficient for simple tasks; Sonnet (UNVERIFIED) 1 million for long sessions; and Opus (UNVERIFIED) plan as Opus (UNVERIFIED) in plan mode then Sonnet (UNVERIFIED) for execution. It calls Sonnet (UNVERIFIED) balanced, Opus (UNVERIFIED) slow/smart for difficult tasks, and Haiku (UNVERIFIED) fast for general/simple tasks. (L911-980)
- Candidate objectives: `ccaf-cTBD-o14` Choose a transcript-described model (UNVERIFIED) option for task complexity, speed, long context, or plan/execution split. `ccaf-cTBD-o15` Explain stated difference between subscription and API visibility of token usage. Chapter number TBD. (L911-980)
- Glossary terms: Claude Opus (UNVERIFIED) (`g-claude-opus`); Claude Sonnet (UNVERIFIED) (`g-claude-sonnet`); Claude Haiku (UNVERIFIED) (`g-claude-haiku`); context window (`g-context-window`); Opus (UNVERIFIED) plan (`g-opus-plan`); token usage (`g-token-usage`). (L911-980)
- Diagram candidates: decision: task needs -> default/Sonnet (UNVERIFIED)/Opus (UNVERIFIED)/Haiku (UNVERIFIED)/long-context Sonnet (UNVERIFIED)/Opus (UNVERIFIED) plan, constrained strictly to transcript claims. (L911-980)
- Table candidates: rows: default, Sonnet (UNVERIFIED), Opus (UNVERIFIED), Haiku (UNVERIFIED), Sonnet (UNVERIFIED) 1 million, Opus (UNVERIFIED) plan; columns: stated use, speed/complexity wording, special behavior. (L911-980)
- MCQ candidates: 3. Long-session choice; complex-reasoning choice; plan-first then execute workflow choice. (L911-980)
- Recall prompts: 3. State each listed model (UNVERIFIED) option's transcript-described use. What happens in Opus (UNVERIFIED) plan? What spend-visibility distinction is stated? (L911-980)
- Confusion pairs: Opus (UNVERIFIED) vs Haiku (UNVERIFIED): difficult reasoning versus fast/simple/general tasks. Sonnet (UNVERIFIED) 1 million vs normal Sonnet (UNVERIFIED): special long-session context-window use. Opus (UNVERIFIED) plan vs single-model loop: stated plan/execution model switch (UNVERIFIED). (L911-980)
- Common wrong turn: "Every loop phase must use a different model (UNVERIFIED)" -> transcript says same model (UNVERIFIED) is normally used across phases, with stated special Opus (UNVERIFIED) plan behavior. (L911-980)
- Causal steps: 1. In Opus (UNVERIFIED) plan, use Opus (UNVERIFIED) during plan mode. 2. Switch to Sonnet (UNVERIFIED) for execution. (L911-980)

### 8. Stop reasons and tool-result chaining

- Key concepts: stop reason as agent-loop stop cause; returned JSON field; `tool_use` (UNVERIFIED); `end_turn` (UNVERIFIED); external function; tool input extraction; tool result; message conversation versus displayed output. (L981-1110)
- Exam-relevant facts: Transcript defines stop reason as why Claude agent stopped executing its loop and names two returned values: `tool_use` (UNVERIFIED) and `end_turn` (UNVERIFIED). It says a returned request JSON has stop reason. In weather example, user asks weather in Winnipeg, agent calls `get_weather` (UNVERIFIED) with extracted city input, then tool result is appended back into conversation and agent eventually ends turn. It says messages are not identical to displayed output. (L981-1110)
- Candidate objectives: `ccaf-cTBD-o16` Interpret `tool_use` (UNVERIFIED) and `end_turn` (UNVERIFIED) from a returned agent response. `ccaf-cTBD-o17` Explain why tool results must be appended to the conversation for continuation. Chapter number TBD. (L981-1110)
- Glossary terms: JSON (`g-json`); get weather (`g-get-weather`); conversation message (`g-conversation-message`); displayed output (`g-displayed-output`); function calling (`g-function-calling`). (L981-1110)
- Diagram candidates: diagram: user weather request -> agent message/tool-use -> `get_weather(city)` -> tool result -> appended message -> end-turn response. (L981-1110)
- Table candidates: rows: `tool_use` (UNVERIFIED), `end_turn` (UNVERIFIED); columns: trigger meaning, external function action, append requirement, expected next response. (L981-1110)
- MCQ candidates: 3. Weather request returns `tool_use` (UNVERIFIED); identify tool-result append requirement. Identify terminal state. Determine whether transcript's displayed response equals message history. (L981-1110)
- Recall prompts: 3. Define stop reason. Name two values. Trace weather request through terminal response. (L981-1110)
- Confusion pairs: `tool_use` (UNVERIFIED) vs `end_turn` (UNVERIFIED): external work requested versus result returned/completion. Tool output vs conversation message: result must be appended as conversational state; display is separate. (L981-1110)
- Common wrong turn: "Program can show tool output without updating conversation" -> transcript says append result back into message conversation. "Stop reason is part of displayed message thread" -> transcript distinguishes messages from output and says this is why it is not seen in thread. (L981-1110)
- Causal steps: 1. User submits request. 2. Agent returns `tool_use` (UNVERIFIED). 3. Program parses data and calls function. 4. Function returns data. 5. Program appends result. 6. Agent returns `end_turn` (UNVERIFIED) result. (L981-1110)

### 9. Stop-reason/tool-use implementation walkthrough

- Key concepts: API usage and spend; async Python; package/dependency errors; lowest-level tool-use example; tool description and input schema; tool selection guidance; Magic 8 Ball illustrative tool; weather tool; agentic loop exit. (L1111-1500)
- Exam-relevant facts: UNVERIFIED: Transcript uses paid Anthropic API (UNVERIFIED) testing and says it is unaware of an API free tier. It changes sample code to async, encounters a package/dependency issue, updates requirements, and reaches output. It says SDK supports tool use/function calling and mentions helpers for defining/running tools as pure functions, but chooses to inspect a lower-level/full example. It identifies tool definition, tool choice, description, and input schema; says prescriptive tool descriptions help tool selection. (L1111-1500)
- Candidate objectives: `ccaf-cTBD-o18` Identify tool-definition elements shown in transcript: name/description, tool choice, and input schema. `ccaf-cTBD-o19` Diagnose implementation prerequisites from a dependency error before evaluating tool behavior. `ccaf-cTBD-o20` Explain why tool description specificity affects selection in transcript example. Chapter number TBD. (L1111-1500)
- Glossary terms: Anthropic API (UNVERIFIED) (`g-anthropic-api`); asynchronous (`g-asynchronous`); requirements txt (`g-requirements-txt`); input schema (`g-input-schema`); tool choice (`g-tool-choice`); pure function (`g-pure-function`); Magic 8 Ball (`g-magic-8-ball`). (L1111-1500)
- Diagram candidates: worked-scenario: tool specification containing description plus input schema, selected from a user yes/no request. (L1320-1500)
- Table candidates: rows: SDK helper/pure-function option, lower-level full example; columns: transcript framing, purpose, implementation visibility. (L1260-1340)
- MCQ candidates: 3. Tool schema missing required element; select correction. Tool description vague; select improvement. Dependency error appears before call; select first troubleshooting action. (L1111-1500)
- Recall prompts: 3. Why did transcript prefer full example? Name shown tool-definition parts. What purpose does detailed tool description serve? (L1260-1500)
- Confusion pairs: Agent SDK (UNVERIFIED) tool helper vs lower-level tool definition: helper abstracts definition/running; lower-level example exposes tool declaration and loop boundary. Tool description vs input schema: description guides intended selection; schema declares expected input shape. (L1260-1500)
- Common wrong turn: "A tool need only have a function body" -> transcript shows description, choice, and input schema being considered. "A dependency failure proves tool use failed" -> dependency/package setup must complete before behavior is assessed. (L1111-1500)
- Causal steps: 1. Install/update needed package requirement. 2. Run async example. 3. Define tool metadata and input schema. 4. Receive tool-use response. 5. Leave agentic loop to parse/execute/append result. (L1111-1500)

### 10. Tool-design critique, docs validation, and setup transition

- Key concepts: avoid unnecessary complexity; MCP server (UNVERIFIED) question; external weather endpoint alternative; documentation lookup; Agent SDK (UNVERIFIED) versus Claude Code (UNVERIFIED) terminology; install modes; current-version verification. (L1501-1630)
- Exam-relevant facts: Transcript critiques a generated program for explaining too much and questions whether an MCP server (UNVERIFIED) is necessary merely to show tool use, suggesting a simpler approach or public weather API endpoint. It says documentation must be checked because Claude does not know itself. It finds a discrepancy between Anthropic tools documentation and Agent SDK (UNVERIFIED), then begins setup; UNVERIFIED: it says native install is generally recommended because other releases may be old. (L1501-1630)
- Candidate objectives: `ccaf-cTBD-o21` Choose minimal architecture for a tool-use demonstration when MCP is not needed. `ccaf-cTBD-o22` Validate uncertain implementation details against documentation rather than assume generated code is correct. Chapter number TBD. (L1501-1630)
- Glossary terms: MCP server (UNVERIFIED) (`g-mcp-server`); public API endpoint (`g-public-api-endpoint`); native install (`g-native-install`); Homebrew (`g-homebrew`); winget (`g-winget`); API reference (`g-api-reference`). (L1501-1630)
- Diagram candidates: decision: direct function/public endpoint versus MCP server (UNVERIFIED); include only stated question: whether MCP is really needed for simple tool-use demo. (L1501-1560)
- Table candidates: rows: native install, Homebrew, winget; columns: transcript-listed option, freshness warning/recommendation, platform context shown. (L1590-1630)
- MCQ candidates: 2. Simple weather tool demo has needless MCP layer; choose simplification. Generated code conflicts with docs; choose validation behavior. (L1501-1630)
- Recall prompts: 2. Why did speaker question MCP here? Why consult docs during Agent SDK (UNVERIFIED)/Claude Code (UNVERIFIED) discrepancy? (L1501-1630)
- Confusion pairs: MCP server (UNVERIFIED) vs direct tool/public endpoint: MCP may add a server layer; direct option is proposed for the narrow demo. Documentation validation vs model (UNVERIFIED) assertion: docs are checked because model (UNVERIFIED) knowledge is not assumed sufficient. (L1501-1630)
- Common wrong turn: "Every tool-use example requires MCP" -> transcript explicitly questions that need for this example. "Generated code/doc wording is automatically current" -> transcript searches docs due to discrepancies/change. (L1501-1630)
- Causal steps: 1. Identify architecture uncertainty. 2. Check API/developer documentation. 3. Compare tool/SDK terminology and examples. 4. Select only needed implementation path. (L1501-1630)

### 11. Claude Code (UNVERIFIED) install, authentication, and minimal Agent SDK (UNVERIFIED) hello world

- Key concepts: Claude Code (UNVERIFIED) CLI install; WSL/Linux example; launch; login/status; UNVERIFIED: subscription authorization; simple file-creation smoke test; Agent SDK (UNVERIFIED) install; query allowed tools (UNVERIFIED); Python async entrypoint. (L1631-1740)
- Exam-relevant facts: Transcript shows Claude Code (UNVERIFIED) installation on WSL 2/Linux, says typing `claude` (UNVERIFIED) launches it, and says `claude status` (UNVERIFIED) indicates login state; it also says `login` (UNVERIFIED) performs authorization flow. It smoke-tests by asking Claude to create an empty `README.md`. It installs Agent SDK (UNVERIFIED) with pip, makes a hello-world project, supplies read/edit/bash capabilities, and finds the async script needs to be run using the appropriate asyncio execution wrapper before it executes. (L1631-1740)
- Candidate objectives: `ccaf-cTBD-o23` Identify transcript setup smoke tests for CLI authentication and Agent SDK (UNVERIFIED) execution. `ccaf-cTBD-o24` Recognize async entrypoint handling as prerequisite to observing an async Agent SDK (UNVERIFIED) result. Chapter number TBD. (L1631-1740)
- Glossary terms: WSL 2 (`g-wsl-2`); command-line interface (`g-command-line-interface`); authentication (`g-authentication`); authorization (`g-authorization`); asyncio (`g-asyncio`); bash (`g-bash`). (L1631-1740)
- Diagram candidates: process: install -> launch -> authenticate -> status/smoke test -> install SDK -> run async hello world. (L1631-1740)
- Table candidates: rows: Claude Code (UNVERIFIED) CLI smoke test, Agent SDK (UNVERIFIED) hello-world smoke test; columns: prerequisite, observed success signal, failure signal shown. (L1631-1740)
- MCQ candidates: 2. CLI appears installed but user cannot establish session; select transcript verification. Async Python script produces no output; select entrypoint diagnosis direction. (L1631-1740)
- Recall prompts: 3. What command is said to show login state? What tiny action smoke-tests Claude Code (UNVERIFIED)? What fixed no-output async run? (L1631-1740)
- Confusion pairs: install vs authentication: binary/CLI presence versus authorized account session. Claude Code (UNVERIFIED) UNVERIFIED: subscription session vs API key usage: transcript uses subscription login for Code and separately discusses API use/testing. Read/edit/bash permissions vs model (UNVERIFIED) capability: listed as granted tool options for task. (L1631-1740)
- Common wrong turn: "No terminal output means Agent SDK (UNVERIFIED) call necessarily failed" -> transcript discovers async execution wrapper issue. "Installed CLI means authenticated" -> transcript checks status/logs out/logs in. (L1631-1740)
- Causal steps: 1. Install CLI. 2. Launch CLI. 3. Authenticate and confirm status. 4. Run a minimal file-creation request. 5. Install SDK/project dependency. 6. Run async program through its required entrypoint. (L1631-1740)

### 12. Shared parser/library and logging refinement

- Key concepts: code-plan review; reusable `lib/sdk_parser`; package exports; import documentation; `CLAUDE.md` (UNVERIFIED); logging API; project-relative logs; timestamp; log-assisted debug; editor caching/staleness; chunk continuation. (L1741-1841)
- Exam-relevant facts: Transcript reviews plan for `lib/sdk_parser`, formatter, parser, and README/import guidance, asks for reusable top-level `lib` placement, then renames a guidance file to `CLAUDE.md` (UNVERIFIED) because Claude prefers it. It asks parser to dump logs into a project-relative `logs` directory with a human-readable ISO timestamp for every `main` run. It later supplies that log to debugging and finds the reported edit had succeeded despite display confusion. (L1741-1841)
- Candidate objectives: `ccaf-cTBD-o25` Plan reusable support code and documentation so multiple examples can consume common formatting/logging behavior. `ccaf-cTBD-o26` Use run logs to distinguish execution evidence from perceived UI state. Chapter number TBD; lesson continues next chunk. (L1741-1841)
- Glossary terms: library (`g-library`); import (`g-import`); CLAUDE md (`g-claude-md`); log message (`g-log-message`); project-relative path (`g-project-relative-path`); timestamped log (`g-timestamped-log`). (L1741-1841)
- Diagram candidates: process: common parser library -> consumer `main.py` (UNVERIFIED) -> formatted output + project-relative timestamped log -> debug request. (L1741-1841)
- Table candidates: rows: reusable `lib` support code, project-local logs, `CLAUDE.md` (UNVERIFIED); columns: consumer, stated purpose, persistence/scope. (L1741-1841)
- MCQ candidates: 2. Multiple labs need same formatter; select placement/packaging goal. UI says unchanged after agent edit; select log/file evidence inspection. (L1741-1841)
- Recall prompts: 3. Why put parser under shared `lib`? What is requested for each run's log path/name? Why provide log to debugger? (L1741-1841)
- Confusion pairs: shared parser library vs project run log: reusable code versus per-execution evidence. `README.md` vs `CLAUDE.md` (UNVERIFIED): transcript changes guidance filename because it says Claude prefers `CLAUDE.md` (UNVERIFIED). (L1741-1841)
- Common wrong turn: "Visual editor view is decisive proof an edit did not happen" -> transcript checks logs and finds edit successful. "Reusable helper needs no import instructions" -> transcript explicitly requests README/import guidance. (L1741-1841)
- Causal steps: 1. Define shared parser/formatter plan. 2. Place in reusable `lib`. 3. Run consumer program. 4. Emit per-run timestamped project log. 5. Feed log into debug analysis. Continues next chunk. (L1741-1841)

## Proposed chapter mapping

| Lesson | Proposed CCA-F (UNVERIFIED) chapter/domain | Planning disposition |
|---|---|---|
| 1 | Preface: certification orientation and exam mechanics; not a scored-domain chapter until full outline confirms | Keep hub/onboarding material, not primary objective page. |
| 2 | Preface: study method and prerequisites; cross-domain | Keep as study guidance, not domain objective content. |
| 3 | Chapter TBD, Domain 1: agentic architecture and orchestration | Combine with lessons 8-9 after full chunk review. |
| 4 | Chapter TBD, Domain 5: context management and reliability, with cross-cutting observability support | May become lab-support sidebar rather than standalone theory chapter. |
| 5 | Chapter TBD, Domain 3: Claude Code (UNVERIFIED) configuration and workflows | Foundation lesson for Claude Code (UNVERIFIED) chapter. |
| 6 | Chapter TBD, Domain 1: agentic architecture and orchestration; cross-link Domain 2 | Tool lifecycle/phase content; no MCP claims beyond source. |
| 7 | Chapter TBD, Domain 3: Claude Code (UNVERIFIED) configuration and workflows | Model-choice matrix candidate. |
| 8 | Chapter TBD, Domain 1: agentic architecture and orchestration | Core stop-reason/process content. |
| 9 | Chapter TBD, Domain 2: tool design and MCP integration; cross-link Domain 1 | Core tool schema/loop implementation content. |
| 10 | Chapter TBD, Domain 2: tool design and MCP integration | Architecture-minimization and documentation-validation sidebar. |
| 11 | Chapter TBD, Domain 3: Claude Code (UNVERIFIED) configuration and workflows | Setup prerequisite/lab appendix; avoid making unstable install commands primary exam fact. |
| 12 | Chapter TBD, Domain 5: context management and reliability; cross-link Domain 3 | Continues into next chunk; defer final objective split. |

- Continuation flags: lesson 3's stop-reason lab continues through lessons 8-12; lesson 12 explicitly ends mid-parser/logging refinement and continues into chunk 02. Exact chapter numbering remains TBD until chunks 02-10 establish full exam-guide sequence.

## Hands-on / lab content

| Activity | Source refs | Exam-relevant content | Demo-only or unstable detail |
|---|---:|---|---|
| Stop-reason weather-tool project | L391-500, L981-1500 | Handle `tool_use` (UNVERIFIED) and `end_turn` (UNVERIFIED); execute tool; append tool result; inspect tool metadata/schema. | Folder/file names, exact generated code, weather sample values. |
| Agent SDK (UNVERIFIED) output formatter/parser | L501-690, L1741-1841 | Observability rationale: readable output and persisted logs support debug/verification. | Exact library layout, formatter API, timestamp filename string. |
| Claude Code (UNVERIFIED) failing-test thought experiment | L826-880 | Context/action/verification tool roles; read/edit/`pytest` (UNVERIFIED) example. | Specific file name/test content. |
| Claude Code (UNVERIFIED) install/login smoke test | L1631-1700 | Distinguish installed, authenticated, and working CLI states. | WSL/browser UI, installer commands, current versions, subscription screens. |
| Agent SDK (UNVERIFIED) hello-world bug-fix run | L1680-1740 | Tools can be granted read/edit/bash; async program must execute correctly before interpreting result. | Ruby typo, exact dependency text, editor refresh behavior. |
| Documentation/tool architecture review | L1501-1630 | Validate uncertain integration design against docs; do not add MCP when simple direct tool case suffices. | Specific documentation navigation and public weather endpoint selection. |

- Later static-topic implementation: preserve labs as readable, source-labeled walkthroughs. Do not reproduce shell installers/API credentials as requirements. No live API, external URL, fetch, dependency, framework, or JavaScript-required lab behavior.

## Open questions and gaps

- Transcript source asserts exam mechanics, availability, and weighting context at recording time. Cross-check only against later provided source material before framing as durable certification facts; do not invent official confirmation. (L20-220)
- Exact official domain weights are said to differ but are not spoken in this chunk. Need later transcript/exam-guide source before authoring a weighting table. (L170-220)
- Transcript names five domains, but their punctuation makes Domain 4/5 boundary ambiguous: "prompt engineering, structured output, context management and reliability." Need later outline/guide to resolve exact grouping. (L180-200)
- `CCA-F` (UNVERIFIED) is presented as common usage despite no official code technically existing. Metadata must retain this qualification or obtain authoritative course metadata. (L20-50)
- Clarify whether `tool_use` (UNVERIFIED) and `end_turn` (UNVERIFIED) are complete for target exam/API surface or only the course example; chunk states two values but no version/scope guarantee. (L981-1110)
- Clarify precise Agent SDK (UNVERIFIED) package/install name, API key/subscription behavior, and tool-helper APIs from canonical/current documentation before implementation. Transcript itself shows naming/dependency uncertainty and changing docs. (L1111-1500, L1501-1740)
- Do not elevate speaker opinions to exam facts: native install preference, course difficulty, paid API/free-tier awareness, exact study hours, and UI/editor complaints remain attributed guidance only. (L50-150, L1111-1200, L1501-1841)
- Need chunk 02 to finish parser/logging narrative and decide whether it belongs in reliability, Claude Code (UNVERIFIED) workflow, or an appendix. (L1741-1841)
- Later topic implementation must define final registry chapters/objectives before page markup; then use only shared assets, relative paths, ASCII source, static readable content, and passing `tools/verify.ps1`.
