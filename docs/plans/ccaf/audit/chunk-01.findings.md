# Chunk 01 audit findings

Scope: transcript `/tmp/ccaf-chunks/chunk0`, lines 1-1841; shipped CCA-F pages and whole-topic grep. Findings exclude deliberate omission of reported exam format, scores, timing, and version-sensitive SDK/CLI install specifics. "Unsupported" means unsupported by chunk 01; retain only if an owning later chunk supplies a citation.

## Coverage tally

| Chunk lesson | Transcript lines | Routed chapter | Shipped evidence | Verdict |
|---|---:|---|---|---|
| 1. Course and exam orientation | 20-220 | C01 | `01-agent-loops.html#orientation`, `#skills`: transcript-only exam claims treated as unverified. Reported format excluded by audit rule. | COVERED |
| 2. Course method, prerequisites, lab-first learning | 241-294 | C01 | `01-agent-loops.html#weather-trace`, `#skills`, `data-mcq="c01-q07"`: inspect, implement, validate. No coverage of setup being deliberately externalized to keep it current and non-repetitive. | PARTIAL |
| 3. Stop-reason lab brief | 295-500 | C01 | `01-agent-loops.html#stop-reasons`, `#tool-turn`, `#weather-trace`: weather request, dispatch, result append, terminal response. | COVERED |
| 4. Reusable SDK parser and debug logs | 501-690, 920-999, 1120-1213 | C11 | `11-diagnostics-automation.html#run-evidence`: formatted output, logs, persisted artifact versus UI. No reusable parser/library, project-relative log, ISO timestamp, or one-log-per-run teaching. | PARTIAL |
| 5. Claude Code fundamentals and loop | 1233-1321 | C08 | `08-claude-code-workflows.html#agentic-loop`, `#harness`: coding harness; gather context, act, verify, feedback. | COVERED |
| 6. Tools in Claude Code | 1322-1401 | C06 | `06-tools-mcp-structured-output.html#tool-selection`: tool as callable external code, name/input/output; failing-test read/edit/test sequence. Specific source examples for API/database/system-state context and compile/log/compare verification are compressed. | PARTIAL |
| 7. Claude Code model selection | 1402-1460 | C08 | `08-claude-code-workflows.html#models`: generic complexity/speed/context/planning decision. Omits source's same-model-per-loop rule, default/Sonnet/Opus/Haiku mapping, 1M Sonnet, Opus Plan switch, and subscription/API visibility distinction. | PARTIAL |
| 8. Stop reasons and tool-result chaining | 1479-1581 | C01 | `01-agent-loops.html#stop-reasons`, `#tool-turn`, `#weather-trace`; `data-mcq="c01-q01"`, `c01-q04`. | COVERED |
| 9. Tool-use implementation walkthrough | 1584-1841 | C01, C06 | `01-agent-loops.html#tool-turn`; `06-tools-mcp-structured-output.html#schemas`, `#tool-selection`. Tool definition, input, handler boundary, prerequisite errors covered. Missing source rule that a prescriptive tool description improves correct selection. | PARTIAL |
| 10. Tool-design critique and documentation validation | 483-553, 1501-1630 | C06 | `06-tools-mcp-structured-output.html#mcp`: direct function/bounded endpoint may be simpler than an MCP layer; validate uncertain documentation. | COVERED |
| 11. Claude Code install/auth and Agent SDK hello world | 564-918 | C08 | `08-claude-code-workflows.html#setup-boundaries`, `#harness`: narrow smoke-test boundary, CLI versus SDK, async flow requires separate application validation. Exact commands/install details excluded by audit rule. | COVERED |
| 12. Shared parser/library and logging refinement | 1002-1213, 1741-1841 | C11 | `11-diagnostics-automation.html#run-evidence`: logs/artifacts outweigh UI/completion wording. Reusable `lib/sdk_parser`, `CLAUDE.md`, project-relative timestamped logs, and log-fed debugging are absent. | PARTIAL |

## Missing content

- Source-specific model-choice matrix is absent from every shipped page. Transcript says one chosen model normally serves all loop phases; default selects a best guess; Sonnet fits daily coding; Opus fits complex reasoning; Haiku is fast/efficient for simple work; 1M Sonnet fits long sessions; Opus Plan uses Opus for planning then Sonnet for execution (lines 1408-1458). This is the actual discrimination content behind C08 model selection, not an installer detail. Add to `08-claude-code-workflows.html#models` as a clearly recording-time, version-sensitive matrix.
- Tool-description specificity is absent from every shipped page. Transcript changes a description to a prescriptive instruction because it helps the agent select the correct tool (lines 1804-1834), then contrasts an ambiguous add-two-numbers example with a yes/no Magic 8 Ball tool (lines 1817-1837). It matters because a schema gives argument shape, while description guides selection. Add to `06-tools-mcp-structured-output.html#tool-selection` before `#schemas`.
- Reusable support-code and per-run log contract is absent from every shipped page. Transcript requests a reusable top-level `lib/sdk_parser` plus import README (lines 920-999), then a new project-relative `logs` file with human-readable ISO timestamp for each `main` run (lines 1120-1137), and supplies that log for debugging a stale editor view (lines 1182-1213). It matters because evidence collection must be reproducible, not merely a generic instruction to retain logs. Add to `11-diagnostics-automation.html#run-evidence`.
- Course-boundary rationale is absent from every shipped page. Setup is externalized to Claude Code Essentials so this course avoids repeated/bloated material and can stay current when setup changes; this course instead follows exam-guide order and code-example -> implementation learning (lines 241-294). This is lower-priority study-method context, not a product claim. Add a compact note to `01-agent-loops.html#orientation` or `08-claude-code-workflows.html#setup-boundaries`.

## Wrong or distorted content

No direct factual contradiction was found for the source-backed stop-reason, append, loop, smoke-test, or log/UI claims. Two statements misattribute material not present in chunk 01 to "the transcript":

- `06-tools-mcp-structured-output.html#mcp` says, "The transcript describes tools from configured servers being discovered into a flat agent-visible list; that list does not preserve a usable source-server identity for selection." Chunk 01 only questions whether an MCP server is needed for a simple tool-use demonstration and proposes a simpler/public-endpoint alternative (lines 483-512); it does not teach configured-server discovery or flat-list provenance. Correct wording: "Later-source/version-sensitive claim: verify target MCP discovery behavior; chunk 01 only establishes that MCP is unnecessary for this narrow demonstration."
- `06-tools-mcp-structured-output.html#tool-choice` says, "In the transcript pattern, named tool requires the particular tool name... [and] can again require the named tool instead of allowing end turn." Chunk 01 reaches `tool choice` only as an observed field in a lower-level example (lines 1745-1804); it does not teach named-tool modes or their looping behavior before chunk end. Correct wording: "This is a later-source/version-sensitive control-mode claim, not chunk 01 evidence."

## Unsupported additions

These are not contradicted by chunk 01, but need a later-source citation or explicit general-practice hedge.

- `01-agent-loops.html#tool-turn`: "It returns the output with the tool use ID for the specific invocation." Chunk 01 teaches parse -> function -> returned data -> append (lines 1551-1581), but never names a tool-use ID or correlation requirement. Keep as sound protocol practice only with a later-source citation; otherwise hedge as "where the target protocol provides an invocation ID."
- `01-agent-loops.html#loop-exit`: "Use a bounded iteration guard" and "Text can appear while tool work remains." Chunk 01 distinguishes response/message conversation from displayed output and identifies stop reason as JSON control state (lines 1497-1581); it does not establish an iteration cap or this text-order assertion. Keep as sound general practice, labelled source-external.
- `06-tools-mcp-structured-output.html#tool-selection`: "Choose the least-scope capability" plus Read/Glob/Grep/Edit/Shell/Agent capability matrix. Chunk 01 teaches tools as external code functions, and gives read -> edit -> pytest as an example (lines 1322-1401); it does not state least-authority policy or define Glob/Grep/Agent boundaries. Keep only as general practice or cite owning later chunks.
- `06-tools-mcp-structured-output.html#schemas`: JSON Schema primitives, enums, nested objects, arrays, required fields, and semantic-versus-schema validation. Chunk 01 ends after identifying that an input schema is needed (lines 1804-1841); it supplies none of these rules. Keep if later source supports them; otherwise hedge all as general schema practice.
- `11-diagnostics-automation.html#status-debug`: provider state, enabled tool state, and its full four-step diagnostic procedure go beyond the source's concrete status/login, output-formatting, log, and stale-editor example (lines 615-653, 873-999, 1120-1213). Keep as sound general practice, but do not present it as chunk-01-derived.

## Question fidelity

- `01-agent-loops.html`, `data-mcq="c01-q02"`: key B, "The tool use ID," is unsupported by chunk 01. Transcript teaches only tool-use request, function execution, returned data, and append (lines 1551-1581). Replace with an applied question whose key is "append the returned tool result to the message conversation," or add a later-source ID citation.
- `01-agent-loops.html`, `data-recall="c01-r07"`: "It maps output to the exact requested invocation..." is unsupported for the same reason (lines 1551-1581). Replace with the append-to-conversation responsibility, or hedge/cite later source.
- `01-agent-loops.html`, `data-mcq="c01-q08"` and `data-recall="c01-r02"`, `c01-r08`: maximum iteration guard as required loop control is unsupported by chunk 01. Transcript gives `tool_use` and `end_turn` control values (lines 1479-1529), not a maximum-turn policy. Retain only as explicit general practice.
- `06-tools-mcp-structured-output.html`, `data-mcq="c06-q03"` through `c06-q10` and `data-recall="c06-r04"` through `c06-r10`: schema internals, `auto`/`any`/named/`none`, named-tool loop risk, MCP resources, and MCP discovery have no chunk-01 basis. The only source evidence is the existence of tool choice and input schema in a lower-level example (lines 1745-1841). Verify against their owning later chunks before retaining.
- `08-claude-code-workflows.html`, `data-mcq="c08-q03"`, `c08-q04`, `data-recall="c08-r03"`, `c08-r04`: broadly compatible with the source, but under-test its key discriminators. Add one item on normal single-model loop behavior and one on Opus Plan's Opus-planning/Sonnet-execution split (lines 1408-1424).

## Terminology drift

| Transcript term | Shipped term | Assessment |
|---|---|---|
| `tool_use` and `end_turn` returned stop-reason values (lines 1479-1529) | "tool-use state" and "terminal state" in `01-agent-loops.html#stop-reasons` | Partly defensible prose, but loses exact response tokens. Use both: prose explanation plus literal tokens in code formatting. |
| Stop reason: why Claude stopped executing its loop; returned JSON field (lines 1479-1501) | "structured response state" in `01-agent-loops.html#stop-reasons` | Defensible clarification, but add returned JSON-field wording to preserve source precision. |
| Tool use also known as function calling (lines 1745-1752) | "callable external code" / "tool use" in C01/C06 | Incomplete. Add "function calling" as source alias in `06-tools-mcp-structured-output.html#tool-selection`. |
| Claude Agent SDK / Agent SDK, with transcript naming uncertainty (lines 372-409, 696-709) | "Agent SDK" in `08-claude-code-workflows.html#harness` | Defensible normalization; retain version/name caveat. |
| "Claude Code is an agentic coding tool" and "code harness" (lines 1233-1264) | "coding-harness loop" in `08-claude-code-workflows.html#agentic-loop` | Defensible, accurate compression. |

## Severity-ordered fix list

1. High - `topics/ccaf/08-claude-code-workflows.html#models`: add source-qualified model matrix: same model normally across loop phases; default, Sonnet, Opus, Haiku, 1M Sonnet, and Opus Plan -> Sonnet execution. Cite transcript lines 1408-1458; retain a version-sensitive caveat.
2. High - `topics/ccaf/01-agent-loops.html#tool-turn`, `data-mcq="c01-q02"`, `data-recall="c01-r07"`: remove unsupported universal tool-use-ID rule or conditionalize it on target protocol support; replace question/recall with chunk-supported result append. Source lines 1551-1581.
3. High - `topics/ccaf/06-tools-mcp-structured-output.html#mcp` and `#tool-choice`: remove "the transcript describes" attribution for MCP discovery/flat-list identity and named-tool looping, or cite their actual later chunks. Chunk-01 evidence only supports questioning MCP for a simple demo. Source lines 483-512, 1745-1804.
4. Medium - `topics/ccaf/06-tools-mcp-structured-output.html#tool-selection`: add source lesson that prescriptive tool descriptions help correct selection; distinguish it from input schema. Source lines 1804-1837.
5. Medium - `topics/ccaf/11-diagnostics-automation.html#run-evidence`: add reusable parser/library, project-relative human-readable ISO timestamp log per `main` run, and log-led resolution of stale UI evidence. Source lines 920-999, 1120-1213.
6. Medium - `topics/ccaf/01-agent-loops.html#loop-exit`, `data-mcq="c01-q08"`, `data-recall="c01-r02"`, `c01-r08`: label maximum iteration caps and text-order assertions as general practice, not transcript fact. Source lines 1479-1581.
7. Medium - `topics/ccaf/06-tools-mcp-structured-output.html#schemas`, `data-mcq="c06-q03"` through `c06-q10`, `data-recall="c06-r04"` through `c06-r10`: cite owning later chunks or label as non-chunk-01 general material; this transcript only reaches the phrase "input schema." Source lines 1745-1841.
8. Low - `topics/ccaf/01-agent-loops.html#stop-reasons`: print literal `tool_use`, `end_turn`, and returned JSON-field terminology alongside current readable paraphrases. Source lines 1479-1529.
9. Low - `topics/ccaf/01-agent-loops.html#orientation` or `topics/ccaf/08-claude-code-workflows.html#setup-boundaries`: add compact setup-externalization/course-method rationale. Source lines 241-294.
