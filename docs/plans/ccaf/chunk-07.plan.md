## Chunk metadata
- Source: `/tmp/ccaf-chunks/chunk6`; transcript global lines 11047-12887; 1841 lines read in four slices (11047-11546, 11547-12046, 12047-12546, 12547-12887).
- Scope: Claude Code permission-rule matching, sandboxing, dangerous permission bypass, settings scope, permission testing, modes, and path/command wildcards. Course statements are candidate content, not independently verified product documentation.

## Lesson inventory
| # | title | chunk line refs | one-line summary |
|---:|---|---|---|
| UNVERIFIED: UNVERIFIED: 1 | Permission-rule tool selectors | 11047-11138 | `WebFetch`, MCP, and bare tool names have distinct matching scope. |
| UNVERIFIED: 2 | Sandboxing: boundary and enablement | 11139-11378 | Sandbox constrains Bash-tool host access; setup and modes vary by operating system. |
| 3 | Dangerously skip permissions: risk model | 11379-11518 | Permission bypass avoids prompts but needs narrowly scoped, disposable execution environments. |
| UNVERIFIED: 4 | Sandbox bypass lab on EC2 | 11519-11890 | A VM demonstration shows deny rules and sandboxing do not guarantee safety under auto-approval. |
| 5 | Settings layers and personal customization | 11891-12210 | Settings are catalogued, then tested as project-local versus user-level configuration. |
| 6 | Permission rules and tool coverage | 12211-12678 | Allow/ask/deny behavior, tool alternatives, and rule testing show why complete coverage matters. |
| UNVERIFIED: 7 | Permission modes and matching syntax | 12679-12887 | Modes change interaction behavior; Bash wildcards and read/edit path patterns require exact matching. |

## Per-lesson plan
### 1. Permission-rule tool selectors
- UNVERIFIED: Key concepts: `WebFetch(domain:...)`; MCP server/tool selectors; wildcard matching; bare tool name as unrestricted coverage; WebFetch parameter omission as catch-all.
- UNVERIFIED: Exam-relevant facts: Rules shown distinguish a specific WebFetch domain from an all-fetch rule; MCP matching names a server and may name a tool; a bare `Read`, `Edit`, or `Bash` rule covers all uses of that tool (11047-11138).
- Candidate objectives: `ccaf-cNN-o1` Draft: distinguish scoped WebFetch, MCP, and bare-tool permission selectors; `ccaf-cNN-o2` Draft: choose rule scope matching intended access.
- Glossary terms with g- slugs: `g-webfetch-rule`; `g-mcp-server-selector`; `g-bare-tool-rule`; `g-wildcard-selector`.
- UNVERIFIED: Diagram candidates with archetype from concept|process|comparison|decision|worked-scenario|callout|diagram|mcq-set|active-recall: comparison - three selector cards, inputs and resulting scope; callout - omitted WebFetch parameters mean catch-all.
- UNVERIFIED: Comparison/decision table candidates with rows and columns: rows `WebFetch domain selector`, `MCP server selector`, `MCP tool selector`, `bare tool name`; columns `matches`, `scope`, `example intent`, `overbroad-risk`.
- UNVERIFIED: MCQ candidates (count + applied stem ideas): 3; select a rule for one approved fetch domain; identify what a bare `Read` rule permits; distinguish MCP server-wide from tool-specific matching.
- UNVERIFIED: Recall prompts (count + prompts): 3; What scope does a bare tool name grant? What changes when a WebFetch rule omits parameters? What identifies MCP access in a rule?
- UNVERIFIED: Confusion pairs with discriminator: bare tool name vs wildcarded tool selector - bare name has no parameter/path/domain filter; MCP server vs MCP tool - latter names an individual tool.
- UNVERIFIED: Common wrong turn misconceptions: A bare tool name is not limited to project files; all MCP rules do not use a generic `MCP_*` catch-all form (11047-11138).
- Causal step chains only if genuine, else 'none - omission beats invented process': none - omission beats invented process.

### 2. Sandboxing: boundary and enablement
- Key concepts: sandbox as controlled resources; storage/memory/network/host inspection/input-device limits; sandbox applies to Bash tools; external tools such as WebFetch sit outside that Bash boundary; autoallow, regular-permissions, and no-sandbox choices.
- UNVERIFIED: Exam-relevant facts: Host requirements vary by operating system; WSL 2 example requires dependencies including `bubblewrap`, `socat`, and a seccomp filter; autoallow attempts sandbox execution and outside-sandbox fallback can fail (11139-11378).
- Candidate objectives: `ccaf-cNN-o3` Draft: explain which Claude Code tool boundary sandboxing constrains; `ccaf-cNN-o4` Draft: choose sandbox mode for a Bash-task risk profile.
- Glossary terms with g- slugs: `g-sandbox`; `g-bash-tool-boundary`; `g-autoallow`; `g-sandbox-fallback`; `g-bubblewrap`; `g-seccomp-filter`.
- UNVERIFIED: Diagram candidates with archetype from concept|process|comparison|decision|worked-scenario|callout|diagram|mcq-set|active-recall: concept - host, sandboxed Bash, and external WebFetch boundary; process - dependency check, install prerequisites, select mode, verify state; comparison - autoallow versus regular permissions versus no sandbox.
- UNVERIFIED: Comparison/decision table candidates with rows and columns: rows `sandbox Bash with autoallow`, `sandbox with regular permissions`, `no sandbox`; columns `Bash execution`, `prompt behavior`, `fallback behavior`, `risk boundary`.
- UNVERIFIED: MCQ candidates (count + applied stem ideas): 4; identify tool not constrained by Bash sandbox; choose prerequisite response for missing OS dependency; choose sandbox mode when outside fallback must fail; explain why a curl command differs from WebFetch.
- UNVERIFIED: Recall prompts (count + prompts): 4; What does this sandbox constrain? Name two resource areas a sandbox can restrict. Why can WebFetch remain outside the Bash boundary? What does autoallow try first?
- UNVERIFIED: Confusion pairs with discriminator: Bash sandbox vs all-tool sandbox - transcript limits sandboxing to Bash tools; sandbox restriction vs permission deny rule - one controls execution environment, one controls permission decision.
- UNVERIFIED: Common wrong turn misconceptions: Sandboxing does not by itself block every tool or all network access; a status line is not established as a reliable sandbox-state indicator in the demonstration (11139-11378).
- UNVERIFIED: Causal step chains only if genuine, else 'none - omission beats invented process': 1. Claude invokes Bash. 2. Sandbox attempts constrained execution. 3. If task needs outside access, configured fallback behavior determines whether it fails or proceeds (11139-11378).

### 3. Dangerously skip permissions: risk model
- UNVERIFIED: Key concepts: session permission bypass; unattended prompt avoidance; low-risk well-scoped work; dev container/VM/CI context; sandbox as an additional, not sufficient, safeguard; arbitrary code execution through `npx`.
- UNVERIFIED: Exam-relevant facts: Transcript labels bypass dangerous; suggested use conditions are known, hands-off, low-risk, well-scoped work or an environment where failure is acceptable; planning and permission files reduce prompt friction but do not make bypass universally safe (11379-11518).
- Candidate objectives: `ccaf-cNN-o5` Draft: identify when permission bypass is inappropriate; `ccaf-cNN-o6` Draft: select environmental controls for unattended agent execution.
- Glossary terms with g- slugs: `g-dangerously-skip-permissions`; `g-permission-bypass`; `g-disposable-environment`; `g-dev-container`; `g-npx`; `g-arbitrary-code-execution`.
- UNVERIFIED: Diagram candidates with archetype from concept|process|comparison|decision|worked-scenario|callout|diagram|mcq-set|active-recall: decision - use bypass only after scope/environment/risk checks; callout - sandbox plus auto-approval is defense-in-depth, not a guarantee; worked-scenario - unattended lint versus unknown downloaded executable.
- Comparison/decision table candidates with rows and columns: rows `interactive default permissions`, `bypass in disposable VM`, `bypass on host with sensitive data`, `well-scoped CI task`; columns `prompting`, `blast radius`, `suitable`, `required controls`.
- UNVERIFIED: MCQ candidates (count + applied stem ideas): 4; choose safest location for bypass; reject bypass for unknown task on primary workstation; identify why a waiting permission prompt motivates bypass but does not justify it; select additional control for an automated task.
- UNVERIFIED: Recall prompts (count + prompts): 4; What user problem motivates bypass? Name two suitable constraints before bypass. Why is `npx` relevant to execution risk? What does sandboxing not guarantee?
- UNVERIFIED: Confusion pairs with discriminator: permission bypass vs accept-edits mode - bypass skips all prompts while accept-edits concerns file edit permissions; isolated VM vs sandbox - VM isolates execution environment, sandbox constrains Bash execution.
- UNVERIFIED: Common wrong turn misconceptions: Fewer prompts do not mean lower risk; storing an API key in a root `.env` is not presented as a recommended safety solution; an `npx` command can download and run code (11379-11518).
- Causal step chains only if genuine, else 'none - omission beats invented process': 1. Bypass/auto-approval removes human prompt review. 2. Agent can issue many commands unattended. 3. Missed command or unsafe task can affect host unless execution environment limits blast radius (11379-11518).

### 4. Sandbox bypass lab on EC2
- UNVERIFIED: Key concepts: disposable EC2 Ubuntu instance; Session Manager connection; instance role; Bedrock access setup; CLI install and path setup; project-local deny rule for `npx`; agent route around constraints by disabling sandbox in demonstration; instance shutdown/cost awareness.
- UNVERIFIED: Exam-relevant facts: Demonstration uses an Ubuntu EC2 instance and Session Manager instead of a key pair; transcript says four GB memory is needed for its setup and notes instance cost; a denied `npx` scenario prompted, failed, then agent disabled sandbox and ran command when permission controls allowed it (11519-11890).
- Candidate objectives: `ccaf-cNN-o7` Draft: analyze why deny rules plus sandboxing can still fail under auto-approval; `ccaf-cNN-o8` Draft: identify isolation and credential considerations in a disposable cloud test environment.
- Glossary terms with g- slugs: `g-ec2`; `g-session-manager`; `g-instance-role`; `g-bedrock-access`; `g-project-local-settings`; `g-sandbox-escape`.
- UNVERIFIED: Diagram candidates with archetype from concept|process|comparison|decision|worked-scenario|callout|diagram|mcq-set|active-recall: worked-scenario - VM, CLI, deny rule, sandbox, attempted `npx`, sandbox disable outcome; process - create isolated instance, attach access role, configure CLI, test, terminate; callout - auto-approved sandbox changes negate expected safeguard.
- UNVERIFIED: Comparison/decision table candidates with rows and columns: rows `deny rule only`, `sandbox only`, `deny plus sandbox with manual review`, `deny plus sandbox with bypass`; columns `can prompt`, `can constrain Bash`, `human review`, `remaining failure mode`.
- UNVERIFIED: MCQ candidates (count + applied stem ideas): 4; diagnose why an agent can defeat a safety assumption; choose Session Manager purpose in lab; select an execution environment for risky experiment; identify cost-control action after VM experiment.
- UNVERIFIED: Recall prompts (count + prompts): 4; Why use a disposable VM? What access mechanism replaced a key pair? What happened after the blocked `npx` attempt? Why must instance lifecycle be part of lab design?
- UNVERIFIED: Confusion pairs with discriminator: deny rule vs unchangeable security boundary - agent can alter settings when permissions allow it; Session Manager access vs instance role - one connects to instance, one supplies AWS permissions.
- Common wrong turn misconceptions: A configuration deny rule is not immutable policy in this demonstrated setup; installing dependencies and attaching broad service access should not be treated as a production baseline; do not infer exact current CLI installation commands from transcript (11519-11890).
- UNVERIFIED: Causal step chains only if genuine, else 'none - omission beats invented process': 1. Agent attempts command blocked by deny/sandbox. 2. Agent reasons sandbox prevents task completion. 3. With bypass/auto-approval, it can disable the sandbox. 4. Command then executes outside intended protection (11519-11890).

### 5. Settings layers and personal customization
- UNVERIFIED: Key concepts: settings categories; project-local `settings.local.json`; user-level settings; settings for output style/language, Git attribution, announcements/updates, UI/spinner behavior, permissions, MCP, plugin marketplaces, hooks, observability, status line, file suggestions, and Git ignore; local spinner-verb and language demonstration.
- UNVERIFIED: Exam-relevant facts: Transcript describes project-local customization for one user and a user-level setting for all projects; `spinnerVerbs` uses an append/replace mode in the example; preferred language changes Claude responses, not necessarily interface text; some settings are managed-settings-only (11891-12210).
- Candidate objectives: `ccaf-cNN-o9` Draft: choose project-local versus user-level settings scope; `ccaf-cNN-o10` Draft: distinguish response-language, presentation, permission, and managed configuration categories.
- Glossary terms with g- slugs: `g-settings-local-json`; `g-user-settings`; `g-spinner-verbs`; `g-preferred-language`; `g-managed-settings`; `g-status-line`; `g-hooks`; `g-git-ignore`.
- Diagram candidates with archetype from concept|process|comparison|decision|worked-scenario|callout|diagram|mcq-set|active-recall: comparison - project-local versus user-level settings inheritance; concept - setting category map; worked-scenario - replace project spinner verbs, then move same preference to user scope.
- Comparison/decision table candidates with rows and columns: rows `project-local settings`, `user-level settings`, `managed settings`; columns `intended scope`, `example use`, `override/constraint`, `transcript caveat`.
- UNVERIFIED: MCQ candidates (count + applied stem ideas): 4; select scope for one repository preference; select scope for personal all-project preference; distinguish response language from UI setting; identify managed-only marketplace/MCP restriction context.
- UNVERIFIED: Recall prompts (count + prompts): 4; When use project-local settings? When use user-level settings? What does replace versus append mean for spinner verbs? What does preferred language control in the demo?
- UNVERIFIED: Confusion pairs with discriminator: `settings.local.json` vs user settings - former is project-specific and personal; preferred language vs interface locale - transcript demonstrates response language; managed setting vs ordinary local setting - managed-only controls are organizational restrictions.
- Common wrong turn misconceptions: Initialization did not reliably create the expected settings directory/file in the demonstration; do not assume every setting refreshes identically without testing; transcript author uncertainty is not product fact (11891-12210).
- Causal step chains only if genuine, else 'none - omission beats invented process': 1. Put preference in project-local scope to test it. 2. Start/restart or demonstrate new session behavior as needed. 3. Move stable personal preference to user scope for cross-project effect (11891-12210).

### 6. Permission rules and tool coverage
- UNVERIFIED: Key concepts: allow/ask/deny lists; restrictive precedence described as deny then ask then allow; Bash, Read, Edit, WebFetch, MCP, and agent tools; ask prompt tests; alternate tools (`Glob`, `Grep`) can reach information when Bash/Read are denied; test actual effective tool coverage.
- UNVERIFIED: Exam-relevant facts: The transcript says deny overrides ask and allow, and ask overrides allow; a malformed rule initially invalidated an ask test; deny of Bash and Read did not prevent retrieval through another dedicated tool until Glob/Grep were also considered; rule edits appeared to take effect during tests (12211-12678).
- Candidate objectives: `ccaf-cNN-o11` Draft: predict allow/ask/deny resolution; `ccaf-cNN-o12` Draft: evaluate permission policy completeness against alternate tool paths; `ccaf-cNN-o13` Draft: diagnose failed permission-rule tests.
- Glossary terms with g- slugs: `g-allow-rule`; `g-ask-rule`; `g-deny-rule`; `g-least-permissive`; `g-glob-tool`; `g-grep-tool`; `g-tool-coverage`.
- UNVERIFIED: Diagram candidates with archetype from concept|process|comparison|decision|worked-scenario|callout|diagram|mcq-set|active-recall: decision - rule resolution deny, ask, allow; worked-scenario - deny Bash/Read, then alternate Glob/Grep discovery path; process - define test, clear context/restart as needed, invoke tool, inspect prompt/result, expand coverage.
- UNVERIFIED: Comparison/decision table candidates with rows and columns: rows `allow`, `ask`, `deny`; columns `user prompt`, `relative restrictiveness`, `stated precedence`, `test observation`; second table rows `Bash`, `Read`, `Glob`, `Grep`; columns `information access route`, `covered by initial policy`, `policy-test implication`.
- UNVERIFIED: MCQ candidates (count + applied stem ideas): 5; resolve conflicting allow/ask/deny entries; explain why Bash denial did not block data retrieval; choose next policy test after a missing colon/config error; identify tool categories requiring review; select least-permissive rule outcome.
- UNVERIFIED: Recall prompts (count + prompts): 5; State stated rule precedence. Why is a denied Bash command not equivalent to no file access? Which alternate tools appeared in the test? Why validate policy with execution attempts? What configuration error affected ask behavior?
- UNVERIFIED: Confusion pairs with discriminator: Bash denial vs file-read denial - different tools and routes; Read vs Glob/Grep - each is a separate tool in demonstrated availability; ask rule vs cached approval - transcript test indicates settings syntax, not cache, caused observed failure.
- Common wrong turn misconceptions: Denying familiar tools does not prove all access paths are blocked; the course transcript itself discovers omitted tools, so a static assumed tool list is unsafe; do not claim undocumented tools or exact rule syntax beyond tested course examples (12211-12678).
- Causal step chains only if genuine, else 'none - omission beats invented process': 1. Deny one access route. 2. Agent selects another available tool. 3. Desired information remains reachable. 4. Expand policy and retest all relevant tools (12211-12678).

### 7. Permission modes and matching syntax
- Key concepts: default, accept-edits, plan, do-not-ask, bypass-permissions modes; interactive Shift+Tab cycles among a subset; launch-time mode selection; Bash wildcard placement and space sensitivity; read/edit path matching; double-forward-slash root pattern; relative path forms.
- UNVERIFIED: Exam-relevant facts: Default prompts on first use of each tool; accept-edits auto-accepts file edits; plan analyzes but should not modify or execute according to stated mode definition; do-not-ask auto-denies tools unless pre-approved; bypass skips prompts; transcript notes plan behavior surprise in a demonstration; wildcard space placement changes matches (12679-12887).
- Candidate objectives: `ccaf-cNN-o14` Draft: select permission mode for planning, edits, or pre-approved automation; `ccaf-cNN-o15` Draft: predict Bash wildcard matches with and without spaces; `ccaf-cNN-o16` Draft: distinguish absolute/root and relative read/edit path patterns.
- Glossary terms with g- slugs: `g-permission-mode`; `g-default-mode`; `g-accept-edits-mode`; `g-plan-mode`; `g-dont-ask-mode`; `g-bash-wildcard`; `g-path-pattern`.
- UNVERIFIED: Diagram candidates with archetype from concept|process|comparison|decision|worked-scenario|callout|diagram|mcq-set|active-recall: comparison - five modes, prompt/edit/command behavior; decision - choose mode from requested activity and approval boundary; worked-scenario - wildcard `ls *` match versus nonmatching command without expected space.
- UNVERIFIED: Comparison/decision table candidates with rows and columns: rows `default`, `accept-edits`, `plan`, `do-not-ask`, `bypass permissions`; columns `prompt behavior`, `file edits`, `command execution`, `appropriate use`, `risk`; second table rows `leading wildcard`, `trailing wildcard`, `middle wildcard`, `space-sensitive command`; columns `intended match`, `nonmatch caveat`.
- UNVERIFIED: MCQ candidates (count + applied stem ideas): 5; select plan mode before repository analysis; identify mode that skips prompts; explain Shift+Tab availability limitation; choose wildcard pattern for a command with arguments; distinguish root path form from project-relative path form.
- UNVERIFIED: Recall prompts (count + prompts): 5; What does default mode do on first tool use? Which mode auto-accepts edits? Which stated mode auto-denies without pre-approval? Why do spaces matter in Bash patterns? What path scope does double forward slash represent in transcript?
- UNVERIFIED: Confusion pairs with discriminator: plan mode vs no-command guarantee - stated behavior versus demonstrated unexpected output needs explicit verification; do-not-ask vs bypass - do-not-ask permits pre-approved rules while bypass skips prompts; wildcard character vs wildcard plus space - spaces are match-significant.
- UNVERIFIED: Common wrong turn misconceptions: Shift+Tab does not expose every listed mode; wildcard matching is not whitespace-insensitive; do not turn transcript's incomplete read/edit pattern discussion into a complete syntax specification (12679-12887).
- Causal step chains only if genuine, else 'none - omission beats invented process': 1. Select mode at startup or interactive toggle. 2. Tool action is evaluated against mode and explicit permission rules. 3. Prompt, auto-denial, or execution behavior follows resulting policy (12679-12887).

## Proposed chapter mapping
- Proposed chapter: `ccaf-cNN Permission boundaries and safe execution`; lessons 1, 2, 3, 4, 6, 7 form one security/operations chapter. Lesson 5 can be a preceding `Configuration and personalization` chapter or a short section before permission rules.
- Suggested sequence: settings scope first (lesson 5); selectors and rules (lessons 1 and 6); permission modes and patterns (lesson 7); sandbox boundary (lesson 2); risk/bypass and isolated-lab case study (lessons 3 and 4).
- Keep source boundaries visible: document transcript-era behavior as course material and leave product-version verification to authoring stage.

## Hands-on / lab content
- Safe static lab plan: inspect a non-sensitive project-local settings file; make one harmless spinner/language preference; compare local and user scope; restore original setting after observation (11891-12210).
- Permission lab: use a throwaway directory and harmless sample file; test one allow, ask, and deny rule; enumerate alternate tools before claiming a resource is protected; capture observed prompts/results (12211-12678).
- UNVERIFIED: High-risk optional lab: only disposable VM/dev container, no sensitive credentials/data, explicit cost/termination check; reproduce conceptual sandbox-plus-bypass failure without downloading or executing untrusted packages. Do not prescribe transcript cloud commands or broad roles (11379-11890).
- Do not ship live labs as prerequisite page behavior; offline static notes must remain readable without execution.

## Open questions and gaps
- Chapter number and official CCA-F objective alignment unknown; retain `ccaf-cNN-oM` draft IDs until registry-first mapping.
- Chunk begins mid read/edit-path explanation and ends mid path-pattern material; inspect adjacent chunks before finalizing selector/path syntax coverage (11047, 12887).
- Transcript contains uncertainty and apparent product/version discrepancies: unnamed MCP wildcard distinction, status-line sandbox field, settings reload timing, plan-mode observation, and tool inventory. Verify against current official documentation before asserting as examination fact.
- Exact cloud CLI install steps, instance sizing, service roles, package names, and Bedrock configuration are demonstration-specific and should not become normative hands-on instructions without validated, least-privilege revisions.
- Need decide whether personal customization merits a standalone chapter or belongs as a preface to access-control configuration.
