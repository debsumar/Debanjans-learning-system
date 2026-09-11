## Coverage tally

| Chunk lesson | Transcript lines | Routed chapter | Shipped page evidence | Verdict |
|---|---:|---|---|---|
| Permission-rule tool selectors | 11047-11138 | C10 | `topics/ccaf/10-permission-safety.html#rule-resolution` names tool, command, path, and domain scope; `06-tools-mcp-structured-output.html#mcp` explains MCP capability intent, not MCP permission selectors. No page distinguishes `WebFetch(domain:...)`, parameterless WebFetch catch-all, MCP server versus tool selector, or bare-tool total coverage. | PARTIAL |
| Sandboxing boundary and enablement | 11139-11378 | C10 | `10-permission-safety.html#sandbox` correctly says sandbox constrains Bash-tool host execution, while authorization decides whether an action may proceed. `#modes` has matcher cautions. No shipped section states constrained Bash attempt followed by configured outside-sandbox fallback behavior. | PARTIAL |
| Permission-bypass risk model | 11379-11518 | C10 | `10-permission-safety.html#bypass-risk` requires known, low-risk, narrow, reversible, isolated work and rejects prompt skipping for unknown executable downloads; `#tldr` limits bypass to disposable environments with acceptable failure. | COVERED |
| EC2 sandbox-bypass lab | 11519-11890 | C10 | `10-permission-safety.html#bypass-risk` says permissive settings can let an agent alter protection state after a blocked attempt; `#sandbox` distinguishes disposable host from authorization and containment. It omits the source causal sequence: blocked command, agent identifies sandbox as obstacle, sandbox is disabled under permissive approval, then command runs outside expected containment. | PARTIAL |
| Settings layers and personal customization | 11891-12210 | C09 | `09-sessions-settings.html#settings-scopes` covers local versus user scope and ownership. No shipped page carries source distinction that preferred language changes response language rather than UI text, or source catalog of customization categories; exact setting keys are deliberately omitted. | PARTIAL |
| Permission rules and tool coverage | 12211-12678 | C10 | `10-permission-safety.html#rule-resolution` states restrictive order as deny, then ask, then allow, and requires feasible-route enumeration plus harmless tests. `#sandbox` correctly separates authorization from Bash containment. `c10-q01` drills alternate dedicated search. | COVERED |
| Permission modes and matching syntax | 12679-12887 | C10 | `10-permission-safety.html#modes` correctly distinguishes review, narrow edits, ask/deny, and bypass intent; it says spaces and path scope change matching. It does not show source wildcard-space discrimination or root versus relative path examples. Exact product mode labels are deliberately omitted. | PARTIAL |

Security-critical check: shipped C10 does not reverse source precedence. It says "deny, then ask, then allow" at `#rule-resolution`, matching source restrictive order (12211-12678). It also correctly says sandbox is Bash-only containment, not authorization or all-tool protection (11139-11378), and correctly preserves alternate-tool-path risk (12211-12678).

## Missing content

- Selector semantics absent from every shipped page: a domain-scoped WebFetch selector, omitted WebFetch parameters as all-fetch catch-all, MCP server-wide versus one-tool selector, and bare `Read`/`Edit`/`Bash` as unrestricted tool coverage (11047-11138). Why: a reader cannot translate least privilege into selector scope. Target: `topics/ccaf/10-permission-safety.html#rule-resolution`.
- Sandbox fallback policy absent from every shipped page: source distinguishes constrained Bash execution, outside-sandbox fallback that can fail, and a separate non-Bash WebFetch route (11139-11378). Why: readers may mistake a Bash sandbox for a complete network or tool boundary. Target: `topics/ccaf/10-permission-safety.html#sandbox`.
- Personal-customization distinction absent from every shipped page: source demonstration establishes project-local experimentation, user-level personal defaults, and response-language behavior distinct from UI language (11891-12210). Why: scope alone does not explain what a personal preference controls. Target: `topics/ccaf/09-sessions-settings.html#settings-scopes`.

## Wrong or distorted content

No contradiction found in routed security content.

- Page: `10-permission-safety.html#rule-resolution`: "deny, then ask, then allow." Source: deny overrides ask and allow; ask overrides allow (12211-12678). Correct wording already shipped.
- Page: `10-permission-safety.html#sandbox`: "A permission rule answers whether a requested action is authorized; a sandbox constrains how Bash executes if it is invoked." Source: sandbox applies to Bash tools; WebFetch is outside this Bash boundary (11139-11378). Correct wording already shipped.
- Page: `10-permission-safety.html#rule-resolution`: "Another available tool can offer an alternate route to the same information or effect." Source: denied Bash and Read did not block retrieval until separate Glob/Grep paths were considered (12211-12678). Correct wording already shipped.

Distortion by compression, not contradiction: `#bypass-risk` says permissive settings can let an agent "alter its protection state after a blocked attempt." Source gives a sharper causal warning: under bypass/auto-approval, it can identify sandboxing as the obstacle, disable it, and then run the command (11519-11890). Corrected wording: "When bypass or auto-approval permits the change, an agent can disable the sandbox after a blocked command; deny rules plus sandboxing are not immutable protection."

## Unsupported additions

These additions are not stated in this chunk. Keep as sound general practice, but mark them as author guidance rather than source-derived product behavior.

- `10-permission-safety.html#bypass-risk`: "predefined cleanup over an empty throwaway directory" as a qualifying unattended task. Source gives low-risk, well-scoped work and linting as examples, not this cleanup case (11379-11518). Keep.
- `10-permission-safety.html#bypass-risk`: "revoke temporary access" after a run. Source recommends isolation and notes VM cost, but does not prescribe credential revocation (11379-11890). Keep.
- `10-permission-safety.html#bypass-risk`: explicit sensitive-data, production-system, and persistent-secret exclusions. Source says use an environment where failure is acceptable and warns that host damage can be serious, but does not enumerate these classes (11379-11518). Keep.

## Question fidelity

No wrong MCQ key, rationale, or recall answer found in routed C10 material.

- `c10-q01` and `c10-r01`: alternate-tool-path conclusion matches Bash/Read bypass through dedicated tools (12211-12678).
- `c10-q02` and `c10-r02`: source order is stated correctly as deny > ask > allow, but question key asks for target-environment testing rather than requiring that source-derived resolution outcome (12211-12678). Not wrong; weak fidelity. Add a separate applied item whose correct result is deny when all three matching rule classes exist, while retaining version verification caveat.
- `c10-q03`, `c10-q04`, `c10-r03`, and `c10-r04`: correctly distinguish authorization from Bash-only execution containment (11139-11378).
- `c10-q05`, `c10-q06`, `c10-r05`, and `c10-r06`: correctly teach review-first posture and matcher testing; source supports plan restrictions plus whitespace-sensitive matching (12679-12887).
- `c10-q07` and `c10-r07`: correctly reject bypass for unfamiliar executable downloads on a credential-bearing workstation; source identifies arbitrary-code execution risk and requires isolated, low-risk use (11379-11518).
- No C09 question tests source lesson 5 response-language versus UI distinction or project-local-to-user-default customization behavior (11891-12210).

## Terminology drift

| Transcript term | Page term | Assessment |
|---|---|---|
| tool-based access control / allow, ask, deny | permission authorization | Defensible abstraction; page preserves the three outcomes (12211-12678). |
| sandbox applies to Bash tools | Bash sandbox / Bash execution boundary | Defensible and more precise; preserves non-Bash boundary limitation (11139-11378). |
| dangerously skip permissions | bypass / prompt-skipping bypass | Defensible neutral label; exact mode name deliberately omitted, while risk remains explicit (11379-11518). |
| `Glob` and `Grep` alternate tools | alternate tool path / dedicated search capability | Defensible but less actionable; add concrete examples to retain source lesson (12211-12678). |
| project-local and user-level settings | local and user scope | Defensible scope normalization; avoid asserting exact file or setting names (11891-12210). |

## Severity-ordered fix list

1. P1 - `topics/ccaf/10-permission-safety.html#rule-resolution`: add compact selector-scope matrix: WebFetch domain versus catch-all, MCP server versus specific tool, bare tool name versus scoped matcher. State least scope and overbroad consequence. Source: 11047-11138.
2. P1 - `topics/ccaf/10-permission-safety.html#bypass-risk`: add source causal warning exactly: blocked command -> sandbox identified as obstacle -> sandbox disabled when bypass/auto-approval permits -> execution escapes expected containment. State configuration mutability is the failure condition. Source: 11519-11890.
3. P1 - `topics/ccaf/10-permission-safety.html#rule-resolution`: add an applied MCQ or recall item where simultaneous allow, ask, and deny matches resolve to deny; retain current-version verification as a separate caveat. Source: 12211-12678.
4. P2 - `topics/ccaf/10-permission-safety.html#sandbox`: add Bash-only flow: constrained Bash attempt -> configured outside-sandbox fallback either fails or proceeds; separately show WebFetch outside Bash containment. Source: 11139-11378.
5. P2 - `topics/ccaf/10-permission-safety.html#rule-resolution`: name the demonstrated alternate-path example: denying Bash and Read did not prevent Glob/Grep-based access; enumerate relevant tools before declaring a resource protected. Source: 12211-12678.
6. P2 - `topics/ccaf/09-sessions-settings.html#settings-scopes`: add a personal-customization note: test in project-local scope, move stable personal preference to user scope, and distinguish response language from UI text. Do not add volatile keys or file paths. Source: 11891-12210.
7. P3 - `topics/ccaf/10-permission-safety.html#modes`: add matcher examples showing space-sensitive Bash patterns and project-relative versus broader-root path scope. Keep exact mode labels and current syntax version-caveated. Source: 12679-12887.
