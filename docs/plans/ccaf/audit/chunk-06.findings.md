## Coverage tally

| Chunk lesson | Transcript lines | Routed chapter | Shipped page evidence | Verdict |
|---|---:|---|---|---|
| Findings provenance and structured output | 9206-9231, 9427-9590, 9686-9774 | C07 | `07-evidence-context.html#findings`: claim, source, document/page, excerpt, confidence; `#synthesis`; `c07-q01`, `c07-r01-r02` | PARTIAL |
| Fork-based session management | 9779-10111 | C09 | `09-sessions-settings.html#session-lifecycle`: shared baseline, isolated later state; `c09-q02`, `c09-r02`; global `03-coordinator-design.html#delegation` covers independent parallel work | PARTIAL |
| Resume/fork verification lab | 10112-10257 | C09 | `09-sessions-settings.html#version-checks`: target language/version/docs/controlled test; observe identifiers, isolation, workspace, artifacts; `c09-q11`, `c09-r11` | COVERED |
| Claude Code sessions and resume | 10258-10414 | C09 | `09-sessions-settings.html#session-lifecycle`: session as accumulated conversation state; resume; compatible workspace boundary; `c09-q01`, `c09-r01` | PARTIAL |
| Forking a Claude Code session | 10415-10490 | C09 | `09-sessions-settings.html#session-lifecycle`: fork preserves source and creates isolated branch; rename; `c09-q02`, `c09-q04`, `c09-r02-r04` | COVERED |
| Context inspection | 10491-10630 | C09 | `09-sessions-settings.html#context`: active-session category use/headroom, recheck after switch/resume; `c09-q05`, `c09-r05` | PARTIAL |
| Compact and clear | 10631-10807 | C09 | `09-sessions-settings.html#context`: compact retains summarized continuity; clear removes conversation history and is not terminal-screen clear; `c09-q06-q07`, `c09-r06-r07` | PARTIAL |
| Rename and rewind | 10808-10882 | C09 | `09-sessions-settings.html#session-lifecycle`: rename for identification; rewind can remove later history; `c09-q03-q04`, `c09-r03-r04` | PARTIAL |
| Settings scopes | 10883-10933 | C09 | `09-sessions-settings.html#settings-scopes`: managed/user/project/local owner and Git treatment; managed-only caveat; `c09-q08-q10`, `c09-r08-r10` | PARTIAL |
| Settings categories overview | 10934-11046 | C09 | No authentication, storage/persistence, environment, model-control, or output-style category teaching in C09. `08-claude-code-workflows.html#models` only gives general model-choice guidance. | MISSING |

## Missing content

| Transcript concept absent from every shipped page | Transcript lines | Why it matters | Exact target |
|---|---:|---|---|
| A true forked session has separate history and identity, can be resumed by that identity, and is distinct from manually copying baseline messages. C09 states isolation but never teaches durable branch identity/resumption distinction. | 9779-9796, 9995-10038, 10062-10105 | Prevents conflating parallel prompt copies with managed forked sessions. | `topics/ccaf/09-sessions-settings.html#session-lifecycle` |
| Web versus local session origin, and origin label versus project/workspace scope. C09 warns about compatible workspace but omits source-origin distinction and cross-origin continuation evidence. | 10258-10277, 10316-10414 | Learner can separate conversation origin from repository context rather than treating a web/local label as a workspace guarantee. | `topics/ccaf/09-sessions-settings.html#session-lifecycle` |
| Autocompact buffer: reserved context headroom used to summarize conversation history. Exact percentage may remain omitted. | 10491-10509 | Explains why displayed available capacity is not all ordinary working space and why autocompaction exists. | `topics/ccaf/09-sessions-settings.html#context` |
| Clear removes conversation history but does not remove project guidance or automemory. Do not assert current artifact names; teach retained non-conversation state distinction. | 10631-10659 | Prevents both destructive misunderstanding and false assumption that clear resets every persistent instruction/memory artifact. | `topics/ccaf/09-sessions-settings.html#context` |
| Rewind offers restore-conversation versus summarize-from-selected-point choices. C09 teaches only rewind/loss risk. | 10870-10876 | Completes rewind decision: restore history versus condense it. | `topics/ccaf/09-sessions-settings.html#session-lifecycle` |
| Higher scope wins settings conflicts. C09 tells readers to verify hierarchy but omits the transcript decision rule itself. | 10883-10933 | Scope selection needs both ownership and effective-value resolution. | `topics/ccaf/09-sessions-settings.html#settings-scopes` |
| Setting-category map: authentication, session/storage, environment, model, output/language; category-level effects. Exact keys, paths, provider names, retention value, and CLI strings can remain version-caveated. | 10934-11046 | Without it, learner cannot classify a configuration need before checking current docs/scope legality. | New `#settings-categories` section in `topics/ccaf/09-sessions-settings.html` |

No shipped page gives a focused review checklist for generated research code: preserve requested use case, use an actual agent definition when required, validate structured findings, and persist findings for later inspection. C07 has provenance fields, C12 has agent-definition boundaries, and C11 has durable-output evidence, but no page connects this review control. Source: 9406-9411, 9427-9463, 9540-9590, 9686-9774. Target: `topics/ccaf/07-evidence-context.html#findings`.

## Wrong or distorted content

No direct contradiction found. C07/C09 preserve core source distinctions: provenance versus confidence (9206-9231); fork versus resume versus rewind (9779-9796, 10415-10490, 10808-10882); active-session context (10491-10630); compact versus clear (10631-10807); and managed/user/project/local scope ownership (10883-10933).

Material omission does not equal contradiction: C09 version caveats are appropriate because source repeatedly requires verification of generated code and SDK behavior (9779-9832, 9995-10038, 10112-10257). They should not replace the missing stable conceptual distinctions listed above.

## Unsupported additions

| Page claim | Transcript basis | Disposition |
|---|---|---|
| `07-evidence-context.html#findings`: "A schema can require fields, but valid structure alone does not establish that a source supports a claim or that a confidence value is calibrated." | Chunk establishes structured/validated JSON need and exposes a finding missing origin, but does not state this full schema-versus-semantic/calibration rule: 9427-9463, 9540-9590, 9765-9774. | Keep as sound general practice; hedge as a review rule, not transcript assertion. |
| `09-sessions-settings.html#version-checks`: use a "reversible test on non-sensitive data." | Chunk requires empirical verification and shows controlled artifact deletion/rerun, but does not state this exact safety formulation: 10112-10257. | Keep as sound general practice. |

No other routed-page addition needs deletion from this chunk audit. C07 synthesis/conflict, durable-artifact, and precision material may be sourced by other planned chunks; this audit cannot classify it unsupported solely because it is outside 9206-11046.

## Question fidelity

No wrong key or rationale found among chunk-aligned questions. `c07-q01`/`c07-r01` correctly require source, location, and evidence rather than confidence alone (9206-9231, 9765-9774). `c09-q01-q07` and `c09-r01-r07` correctly distinguish resume, fork, rewind, rename, active-session context, compact, and clear (10258-10882). `c09-q08-q10` and `c09-r08-r10` correctly map scope ownership and Git treatment (10883-10933). `c09-q11-q12` and `c09-r11-r12` correctly require target-version verification (9779-9832, 10112-10257).

Missing assessed distinctions: no `data-mcq`/`data-recall` item tests fork session identity/resumption versus copied-message branches (9779-9796, 9995-10038); web/local origin versus workspace scope (10258-10414); autocompact reserve purpose (10491-10509); clear retaining non-conversation artifacts (10631-10659); rewind restore versus summarize (10870-10876); scope precedence (10883-10933); or category classification and cleanup-zero consequences (10934-11046). Add IDs after approved C09 count-contract revision; do not fabricate IDs in this audit.

## Terminology drift

| Transcript term | Page term | Assessment |
|---|---|---|
| "provenence" typo | "provenance" in `07-evidence-context.html#findings` | Defensible correction. Source meaning is origin/attribution: 9206-9231. |
| "fork-based session management" / `forkSession` | "session fork" / "fork" in `09-sessions-settings.html#session-lifecycle` | Defensible product-neutral teaching term, but add separate-history/identity/resume distinction: 9779-9796, 9995-10038. |
| context command | context-window inspection | Defensible command-neutral phrasing; retain active-session category/headroom meaning: 10491-10630. |
| web session / local session | no equivalent teaching term | Not defensible as complete coverage; add origin label distinct from workspace scope: 10258-10277, 10316-10414. |
| managed settings / user settings / project settings / local settings | managed/user/project/local scope | Defensible compression. Add higher-scope precedence: 10883-10933. |
| automemory / `CLAUDE.md` | no retained-nonconversation-state term | Concept missing, not merely a deliberate command/file-name omission: 10631-10659. |

## Severity-ordered fix list

1. High. `topics/ccaf/09-sessions-settings.html`; add new `#settings-categories` after `#settings-scopes`. Teach category map and cleanup-zero persistence consequences: auth, storage/persistence, environment, model controls, output style; retain version caveat and omit volatile key/path/provider strings. Source: 10934-11046.
2. High. `topics/ccaf/09-sessions-settings.html#session-lifecycle`; add forked-session identity/history/resume distinction and explicit contrast with copied baseline messages. Source: 9779-9796, 9995-10038, 10062-10105.
3. High. `topics/ccaf/09-sessions-settings.html#settings-scopes`; state source rule that higher scope takes precedence, alongside current-doc verification for exact implementation. Source: 10883-10933.
4. Medium. `topics/ccaf/09-sessions-settings.html#context`; add autocompact reserve purpose and clear-versus-retained-nonconversation-state distinction. Do not add fixed percentage or product file names. Source: 10491-10509, 10631-10659.
5. Medium. `topics/ccaf/09-sessions-settings.html#session-lifecycle`; add rewind choice: restore older conversation versus summarize from selected point; retain later-history-loss warning. Source: 10808-10882.
6. Medium. `topics/ccaf/09-sessions-settings.html#session-lifecycle`; add web/local origin label versus workspace/project-context distinction and wrong-directory failure boundary. Do not assert current UI/command syntax. Source: 10258-10277, 10316-10414.
7. Medium. `topics/ccaf/07-evidence-context.html#findings`; add generated-research implementation review: preserve requested use case, inspect agent definition/schema validation, and verify persisted findings remain inspectable. Source: 9406-9411, 9427-9463, 9540-9590, 9686-9774.
8. Low. `topics/ccaf/09-sessions-settings.html#mcq` and `#recall`; after contract approval, add items for fixes 2-5. Source: 9779-9796, 10491-10509, 10631-10659, 10808-10933.
