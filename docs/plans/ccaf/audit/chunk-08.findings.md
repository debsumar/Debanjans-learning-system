## Coverage tally

| Chunk lesson | Transcript lines | Routed chapter | Shipped page evidence | Verdict |
|---|---:|---|---|---|
| Permission rules, sandbox, dangerous permission skipping | 12888-13093 | C10 | `topics/ccaf/10-permission-safety.html#rule-resolution`, `#sandbox`, `#modes`, `#bypass-risk`: narrow matchers, deny/ask/allow, Bash boundary, matcher tests, bypass warning, disposable environment. Does not teach network approval as a distinct observed gate. | PARTIAL |
| Built-in tool catalogue and default permissions | 13094-13176 | C06 | `topics/ccaf/06-tools-mcp-structured-output.html#tool-selection`: Read, Glob, Grep, Edit, Shell, Agent, least scope. No shipped treatment of asterisk permission marker, or fact that unmarked/default-nonprompt tools can still be explicitly allow/ask/deny controlled. | PARTIAL |
| Status and authentication recognition | 13177-13292 | C11 | `topics/ccaf/11-diagnostics-automation.html#status-debug`: observed provider, authentication state, tool state, reproducible symptom. Exact `/status` labels, API-key-source clues, Bedrock display, and competing-token flow are version-sensitive CLI specifics, intentionally not tallied missing. | PARTIAL |
| Debug command and session logs | 13293-13368 | C11 | `11-diagnostics-automation.html#status-debug`: symptom, status/tool state, controlled reproduction, diagnostic output, artifact inspection; `#tldr` and `c11-r03` require scoped/redacted sharing. Exact `/debug`, `--debug`, and log path omitted as version-sensitive CLI detail. | COVERED |
| Agent SDK built-in tools | 13369-13484 | C06 | `06-tools-mcp-structured-output.html#tool-selection`: correct Read/Glob/Grep/Edit/Shell/Agent discriminator table; `c06-q01`, `c06-q02`, `c06-r01`, `c06-r02`. | COVERED |
| Tool choice modes | 13485-13544 | C06 | `06-tools-mcp-structured-output.html#tool-choice`: `auto` optional, `any` requires one supplied tool, named tool requires specified tool, `none` prohibits tools; named response-loop break/termination warning. `c06-q06`-`c06-q08`, `c06-r07`-`c06-r08`, and `review.html` `rev-d12` reinforce it. | COVERED |
| JSON Schema and tool input schemas | 13545-13588 | C06 | `06-tools-mcp-structured-output.html#schemas`: primitive types, enum, required, nested object, array/items; semantic boundary; `c06-q03`-`c06-q05`, `c06-r04`-`c06-r06`. | COVERED |
| Structured JSON through tool use | 13589-14097 | C06 | `06-tools-mcp-structured-output.html#schemas` and `#tool-choice`: valid named choice, name requirement implied by "specified tool," schema-versus-semantic distinction, and forced named-loop termination. `c06-q05`, `c06-q08`, `c06-r08`. Lower-level-versus-Agent-SDK parameter exposure and invalid literal `force` are version-sensitive SDK details, intentionally not tallied missing. | COVERED |
| Prompt specificity and false positives | 14098-14146 | C05 | `topics/ccaf/05-prompt-output-quality.html#criteria`: target, input/location, expected behavior, exclusions, acceptance criteria; vague scope widens search/action, creates false positives, consumes compute. `c05-q03`, `c05-q04`, `c05-r03`, `c05-r04`. | COVERED |
| Human review and confidence calibration | 14147-14580 | C05 | `05-prompt-output-quality.html#review`: aggregate versus segmented accuracy, field confidence, stratified sample, human confirm/edit/defer, calibration distinction. `c05-q08`, `c05-q09`, `c05-r08`, `c05-r09`. | COVERED |
| Multi-source synthesis and information preservation | 14581-14728 | C07 | `topics/ccaf/07-evidence-context.html#findings`, `#synthesis`: source/location/excerpt/confidence, claim-source mapping, credible conflict attribution, publication/date context, structured findings. `c07-q01`-`c07-q03`, `c07-r01`-`c07-r04`. | COVERED |

Transcript final correction retained: `auto` can omit tools; `any` requires a supplied tool but permits selection; named `tool` fixes required tool and can loop in repeated requests; `none` prohibits tools (13485-13544, 13589-14097). Shipped C06 states same semantics and scopes loop risk to "the transcript pattern" in `#tool-choice`. No semantic reversal found.

## Missing content

| Transcript fact absent from all shipped pages | Lines | Why it matters | Exact target |
|---|---:|---|---|
| Network approval is a separate observed decision point from local permission matching and sandbox execution. Demo shows network connection prompt alongside sandbox/permission behavior. | 12955-13039 | Prevents false two-layer model: a command can be authorized and sandbox-eligible yet still need network approval. | `topics/ccaf/10-permission-safety.html#sandbox`; add `Network approval` row to control table and one sentence in diagram text equivalent. |
| Asterisk-marked built-in tools require permission in default framing; absence of asterisk/default prompt does not prevent explicit allow, ask, or deny policy. | 13094-13176 | Prevents learner inference that default nonprompt behavior means policy cannot restrict a tool. | `topics/ccaf/10-permission-safety.html#rule-resolution`; cross-link from `topics/ccaf/06-tools-mcp-structured-output.html#tool-selection`. |

Not listed as missing: exact command matching syntax, `/status` output labels, `/debug`/`--debug` invocation, log paths, Agent SDK parameter availability, and rejected `force` literal. These are version-sensitive CLI or SDK specifics under audit instruction (12888-14097).

## Wrong or distorted content

No confirmed contradiction.

- Shipped `06-tools-mcp-structured-output.html#tool-choice` says: "In the transcript pattern, named tool requires the particular tool name" and "can again require the named tool instead of allowing end turn." This correctly preserves the demonstrated loop condition, rather than falsely claiming every named-tool use loops (13589-14097).
- Shipped `06-tools-mcp-structured-output.html#schemas` says: "Schema validation checks format constraints. Semantic correctness still needs task rules, evidence, or review." This matches strict-schema syntax reduction without semantic-error prevention (13545-13588, 13970-14097).
- Shipped `05-prompt-output-quality.html#review` says confidence is a routing signal, not measured accuracy. This matches field-level confidence, segmented accuracy, and stratified review distinction (14147-14580).

## Unsupported additions

No confirmed unsupported addition in routed coverage.

- `06-tools-mcp-structured-output.html#mcp` contains MCP discovery/resource/tool material, but master routing assigns that material to chunk-10 as well; this chunk-only audit cannot call it unsupported (12888-14728; `docs/plans/ccaf/PLAN.md`, chunk-10 lessons 3-4).
- `11-diagnostics-automation.html#actions`, `07-evidence-context.html#context-loss`, and durable-artifact detail extend adjacent chunk routes. They are outside this chunk's lesson claims, not contradictions of them (12888-14728).
- C10 disposable-environment and least-privilege advice is sound general practice, framed as safety guidance; transcript demo supports bypass risk and protection-state concern (12888-13093). Keep.

## Question fidelity

No wrong or unsupported key, rationale, or recall answer found for chunk-routed items.

- `c06-q06` / `c06-r07`: `auto` optional. Correct (13485-13544).
- `c06-q07`: `any` requires one supplied tool, model selects it. Correct (13485-13544, 13970-14097).
- `c06-q08` / `c06-r08`: named `submit_triage` in repeated response loop needs explicit break or termination strategy. Correct; wording properly limits claim to forced-loop pattern (13589-14097).
- `c06-q03`-`c06-q05` / `c06-r04`-`c06-r06`: enum, required/nested schema, and semantic-error boundary. Correct (13545-13588, 13970-14097).
- `c05-q03`, `c05-q04`, `c05-r03`, `c05-r04`: bounded instruction avoids broad false-positive work. Correct (14098-14146).
- `c05-q08`, `c05-q09`, `c05-r08`, `c05-r09`: segmented accuracy, stratified sampling, field-level routing, confidence versus measured accuracy. Correct (14147-14580).
- `c07-q01`-`c07-q03` / `c07-r01`-`c07-r04`: provenance, claim-source mappings, and attributed credible conflict. Correct (14581-14728).
- Gap, not bad key: no `data-mcq` or `data-recall` tests the asterisk/default-permission versus explicit-policy distinction (13094-13176).

## Terminology drift

| Transcript term | Shipped term | Assessment |
|---|---|---|
| "GP" / grep for file-content search | `Grep` | Defensible normalization. Transcript describes content search, versus Glob path discovery (13369-13484). |
| `tool_choice` type `tool` after correction; speaker contrasts invalid remembered `force` | `named tool` | Defensible learner-facing term. It avoids presenting corrected-away `force` as valid and retains required-specific-tool meaning (13589-14097). |
| `end turn` / `end_turn` | `end turn` and structured completion | Defensible. Page distinguishes structured completion from visible text; source uses end turn as loop terminal state (13485-13544, 13970-14097). |
| field-level confidence score | field-level confidence / routing signal | Defensible and more precise: page explicitly separates it from measured accuracy (14147-14580). |
| claim-source mappings / source attribution | provenance plus claim-source mappings | Defensible. Page keeps specific mapping term in `#synthesis`; provenance names origin/location evidence (14581-14728). |

## Severity-ordered fix list

1. High: `topics/ccaf/10-permission-safety.html#sandbox` -- add network approval as separate observed gate beside permission authorization and Bash sandbox; state it as transcript demonstration, not universal product guarantee (12955-13039).
2. Medium: `topics/ccaf/10-permission-safety.html#rule-resolution` -- add default permission-marker rule: asterisk indicates permission-required in transcript catalogue; unmarked/default-nonprompt does not remove explicit allow/ask/deny policy (13094-13176).
3. Low: `topics/ccaf/06-tools-mcp-structured-output.html#tool-selection` -- cross-link C10 policy note from built-in-tool table; add one sentence that least-scope selection and permission policy are separate decisions (13094-13176).
4. Low: `topics/ccaf/06-tools-mcp-structured-output.html#mcq` or `#recall` -- add/replace one item testing asterisk/default permission marker versus explicit policy; preserve existing correct tool-choice set (13094-13176).
