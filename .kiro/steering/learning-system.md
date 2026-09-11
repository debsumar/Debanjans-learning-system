# Learning system invariants

This repo is an offline-first, static certification learning system.
Detailed runbooks: `/add-topic`, `/author-page`, `/author-diagram`,
`/author-questions`, and `/verify-system` skills.

- No build step, framework, npm, or dependencies.
- Source is ASCII only.
- Paths are relative only; no remote assets.
- ES2026 syntax belongs in CLASSIC scripts only.
- Never use ES modules: `import` is CORS-blocked from `file://`.
- Colour literals belong only inside `:root` blocks.
- No inline `<style>` blocks.
- Presentation lives in `assets/`; never duplicate it in pages.
- Every page stays readable with JavaScript disabled.
- `C:\K4U\AZ900-Notes` is untouched original rollback source; never modify it.
- Run the verifier and require 0 failures before committing.
- On macOS or Linux with PowerShell: `pwsh -NoProfile -File ./tools/verify.ps1`.
- Without a local PowerShell runtime, the `verify` GitHub Actions workflow runs it on every push and pull request; a red run blocks the change.
- On Windows: `powershell -NoProfile -ExecutionPolicy Bypass -File .\tools\verify.ps1`.
- `localStorage` is per-file-URL when pages open from disk.
- Study and theme state therefore do not follow readers across disk pages.
- State works across pages on hosted GitHub Pages.
- Authored components are declared in `assets/registry.js` and enforced by `tools\verify.ps1`.
- `assets/registry.js` is author-side data; no page loads it.
- `assets/model.js` loads after `assets/study.js`, only on model pages.
- Static `table.model-matrix` is source of truth; model harness derives interaction from it.

Steering is always in context. Skills load on demand as slash commands.

- Keep shipped shell and study markup contracts unchanged.
- Keep shared CSS as sole presentation source.
- Verify changed files remain ASCII-only.
- Do not commit with any verifier failure.
