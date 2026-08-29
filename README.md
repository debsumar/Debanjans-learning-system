<div align="center">

# 🎓 Debanjan's Learning System

**One theme at the root. Infinite topics underneath.**
Offline-first certification notes. No build, no server, no network.

![Build](https://img.shields.io/badge/build-none-5db872?style=for-the-badge&labelColor=141413)
![Deps](https://img.shields.io/badge/deps-0-d97757?style=for-the-badge&labelColor=141413)
![Runs](https://img.shields.io/badge/runs_on-file%3A%2F%2F-d4a017?style=for-the-badge&labelColor=141413)
![Theme](https://img.shields.io/badge/theme-dark_%2B_light-b3552d?style=for-the-badge&labelColor=141413)

</div>

---

## ⚡ Run it

```bash
start index.html          # Windows
open  index.html          # macOS / Linux
```

That's it. Double-clicking the file also works.

---

## 🏗️ Architecture

Presentation flows **down**. Nothing flows up. A new topic costs one folder + one card.

```mermaid
graph TD
  L["🏠 index.html<br/><b>launcher</b>"]
  C["🎨 assets/theme.css<br/><i>the only stylesheet</i>"]
  J["⚙️ assets/theme.js<br/><i>theme boot + toggle</i>"]
  H["📘 topics/az-900/<br/><b>hub + 11 chapters</b>"]
  T["🖌️ topic.css<br/><i>accent only, 10 lines</i>"]
  F["➕ topics/next/<br/><i>drop-in</i>"]

  L --> H
  L -.-> F
  C -.-> L & H & F
  J -.-> L & H & F
  T --> H

  classDef p fill:#d97757,stroke:#faf9f5,stroke-width:2px,color:#141413,font-weight:bold
  classDef t fill:#1f1e1c,stroke:#d4a27f,stroke-width:2px,color:#faf9f5
  classDef f fill:#141413,stroke:#5db872,stroke-width:2px,color:#5db872,stroke-dasharray:5 5
  class L,C,J p
  class H,T t
  class F f
```

```text
📁 index.html          launcher
📁 assets/             theme.css · theme.js      ← all presentation
📁 docs/               THEME.md · NEW-TOPIC.md
📁 topics/az-900/      topic.css + 12 pages      ← content only
```

---

## 🎨 Palette

Colour literals live **only** in the two `:root` blocks. Everything else uses `var(--token)`.

| | Token | Dark | Light | |
|:--|:--|:--|:--|:--|
| ![](https://img.shields.io/badge/-141413?style=flat-square&color=141413) | `--bg` | `#141413` | `#faf9f5` | ![](https://img.shields.io/badge/-faf9f5?style=flat-square&color=faf9f5) |
| ![](https://img.shields.io/badge/-1f1e1c?style=flat-square&color=1f1e1c) | `--surface` | `#1f1e1c` | `#ffffff` | ![](https://img.shields.io/badge/-ffffff?style=flat-square&color=ffffff) |
| ![](https://img.shields.io/badge/-d97757?style=flat-square&color=d97757) | `--accent` | `#d97757` | `#b3552d` | ![](https://img.shields.io/badge/-b3552d?style=flat-square&color=b3552d) |
| ![](https://img.shields.io/badge/-5db872?style=flat-square&color=5db872) | `--good` | `#5db872` | `#2f7a44` | ![](https://img.shields.io/badge/-2f7a44?style=flat-square&color=2f7a44) |
| ![](https://img.shields.io/badge/-d4a017?style=flat-square&color=d4a017) | `--warn` | `#d4a017` | `#8a6100` | ![](https://img.shields.io/badge/-8a6100?style=flat-square&color=8a6100) |

<details>
<summary><b>+8 more tokens</b></summary>

`--surface-2` `--border` `--text` `--muted` `--accent-soft` `--accent-dim` `--row` `--code`
Non-colour: `--radius` `8px` · `--maxw` `72rem` · `--font` · `--font-serif` · `--mono`

</details>

---

## 🌗 Theming

```mermaid
flowchart LR
  A["theme.css<br/>:root<br/>dark"] --> B["theme.css<br/>light override"] --> C["topic.css<br/>accent"] --> D["✨ var(--token)"]
  classDef s fill:#1f1e1c,stroke:#d97757,color:#faf9f5
  classDef o fill:#d97757,stroke:#faf9f5,color:#141413,font-weight:bold
  class A,B,C s
  class D o
```

`theme.js` runs in `<head>` **before** the stylesheets, with no `defer` — it sets `data-theme` pre-paint, so a saved light theme never flashes dark. Key: `dls-theme`.

> [!NOTE]
> `localStorage` over `file://` is browser-policy dependent. The toggle always works on the current page; persistence across navigation is not guaranteed. Blocked storage falls back to dark, silently.

---

## 📄 Page contract

Three lines replaced a 107-line inline stylesheet:

```html
<script src="../../assets/theme.js"></script>
<link rel="stylesheet" href="../../assets/theme.css">
<link rel="stylesheet" href="topic.css">
```

🔒 Script first → no flash · `topic.css` last → accent wins · `../../` never `/` → `file://` safe

---

## ➕ Add a topic

```mermaid
flowchart LR
  A["1️⃣ topics/slug/"] --> B["2️⃣ topic.css<br/>3 colours"] --> C["3️⃣ pages"] --> D["4️⃣ one card<br/>in launcher"] --> E["✅ done"]
  classDef s fill:#1f1e1c,stroke:#d4a27f,color:#faf9f5
  classDef d fill:#5db872,stroke:#faf9f5,color:#141413,font-weight:bold
  class A,B,C,D s
  class E d
```

Platform files stay untouched. A topic's entire identity is ten lines:

```css
:root { --accent: #d97757; --accent-soft: #d4a27f; --accent-dim: rgba(217,119,87,.10); }
:root[data-theme="light"] { --accent: #b3552d; --accent-soft: #8a4522; --accent-dim: rgba(179,85,45,.08); }
```

📖 [`docs/NEW-TOPIC.md`](docs/NEW-TOPIC.md) · [`docs/THEME.md`](docs/THEME.md)

---

## 📚 Topics

### ![AZ-900](https://img.shields.io/badge/AZ--900-Azure_Fundamentals-0078d4?style=flat-square&logo=microsoftazure&logoColor=white) · 12 pages

<details>
<summary><b>11 chapters, mapped to exam domains</b></summary>

| # | Chapter | Domain |
|:--|:--|:--|
| 01 | Cloud computing | ☁️ Concepts · 25-30% |
| 02 | Benefits of cloud services | ☁️ Concepts · 25-30% |
| 03 | Cloud service types | ☁️ Concepts · 25-30% |
| 04 | Core architectural components | 🏛️ Architecture · 35-40% |
| 05 | Compute and networking | 🏛️ Architecture · 35-40% |
| 06 | Storage services | 🏛️ Architecture · 35-40% |
| 07 | Identity, access, security | 🏛️ Architecture · 35-40% |
| 08 | Cost management | 🛡️ Governance · 30-35% |
| 09 | Governance and compliance | 🛡️ Governance · 30-35% |
| 10 | Managing and deploying resources | 🛡️ Governance · 30-35% |
| 11 | Monitoring tools | 🛡️ Governance · 30-35% |

Each page ships diagrams, comparison tables, confusion callouts, MCQs and active recall. The hub adds a live filter and a cross-chapter confusion index.

</details>

---

## 📐 Rules

| ❌ Never | 💥 Because |
|:--|:--|
| Build step or server | Must open years from now, toolchain-free |
| Remote asset or web font | Works with the network off |
| Non-ASCII byte in markup | Mojibake under `file://` — use `&mdash;` `&middot;` |
| `/assets/...` path | Resolves to filesystem root under `file://` |
| Colour outside `:root` | Would break one of the two themes |
| CSS inside a page | The exact problem this repo killed |

---

## 📊 Impact

<div align="center">

| | Before | After |
|:--|:--:|:--:|
| Stylesheet copies | `12` | **`1`** |
| Page weight | `399 KB` | **`303 KB`** |
| Files to change a colour | `12` | **`1`** |
| Inline theme scripts | `13` | **`0`** |
| Topics supported | `1` hardcoded | **`N`** drop-in |

</div>

<details>
<summary><b>🔍 Verification</b> — all static checks passed</summary>

`<style>` tags: **0** · retired `az900-theme` key: **0** · asset refs correct: **36/36** · `defer`/`async`: **0** · missing selectors: **0** · dead links or anchors: **0** · non-ASCII bytes: **0** · remote assets: **0** · toggle hooks: **13/13** · source folder modified: **no**

Needs a human eye: rendered dark/light appearance, and whether the theme sticks across pages in your browser.

</details>

---

## ♻️ Rollback

The original flat folder was **copied, never moved**. It sits outside this repo, unmodified.

`git restore <path>` → one file · `git revert <sha>` → one commit · recopy → everything

---

<div align="center">

**Built to still work in ten years.**
No framework · no bundler · no CDN · no lock file

</div>
