/* Optional study enhancement. localStorage is per-file-URL under file://, so state does not follow the reader across pages opened from disk; hosted https copy works normally. */
(() => {
  "use strict";
  const KEY = "dls-study-state";
  const DEFAULT = { 1: 1, 2: 3, 3: 7, 4: 14, 5: 30 };
  const nodes = [...document.querySelectorAll("[data-recall], [data-mcq]")];
  if (!nodes.length) return;
  const chapter = document.body?.dataset.chapter ?? document.querySelector("[data-chapter]")?.dataset.chapter ?? "site";
  const readState = () => {
    try {
      const raw = globalThis.localStorage.getItem(KEY), parsed = raw ? JSON.parse(raw) : { items: {} };
      return parsed?.items && typeof parsed.items === "object" ? parsed : { items: {} };
    } catch { return { items: {} }; }
  };
  let state = readState();
  const items = [];
  const now = () => Date.now();
  const pad = value => String(value).padStart(2, "0");
  const dateAt = days => {
    const date = new Date();
    date.setHours(12, 0, 0, 0); date.setDate(date.getDate() + days);
    return `${date.getFullYear()}-${pad(date.getMonth() + 1)}-${pad(date.getDate())}`;
  };
  const keyFor = id => `${chapter}:${id}`;
  const writeState = () => {
    try { globalThis.localStorage.setItem(KEY, JSON.stringify(state)); }
    catch { /* Storage may be unavailable. */ }
  };
  const getState = key => {
    if (!state.items || typeof state.items !== "object") state.items = {};
    if (!state.items[key] || typeof state.items[key] !== "object") state.items[key] = {};
    return state.items[key];
  };
  const schedule = () => {
    const configured = globalThis.LEARNING_SYSTEM?.studyPolicy?.leitner ?? DEFAULT;
    const values = Array.isArray(configured) ? configured : Object.values(configured ?? {});
    const days = values.map(Number).filter(day => Number.isFinite(day) && day > 0);
    return days.length ? days : Object.values(DEFAULT);
  };
  const button = (label, classes, handler) => {
    const control = document.createElement("button");
    control.type = "button"; control.className = `theme-toggle pill study-control ${classes}`;
    control.textContent = label; control.addEventListener("click", handler);
    return control;
  };
  const mark = item => {
    const record = getState(item.key);
    item.node.classList.toggle("study-high-miss", record.confidence === "high" && record.grade === "missed");
    item.node.classList.toggle("study-mastered", record.grade === "got");
  };
  const renderRow = item => {
    const record = getState(item.key), row = item.row;
    row.replaceChildren();
    const prompt = document.createElement("span");
    prompt.className = "study-prompt";
    prompt.textContent = record.confidence ? `Confidence: ${record.confidence}`
      : record.confidenceSkippedAt ? "Confidence skipped" : "Confidence:";
    row.append(prompt);
    if (!record.confidence && !record.confidenceSkippedAt) {
      for (const value of ["low", "medium", "high"]) row.append(button(value[0].toUpperCase() + value.slice(1), "study-choice", () => {
        record.confidence = value; record.confidenceAt = now(); writeState();
        renderRow(item); mark(item); renderSummary();
      }));
      row.append(button("Skip", "study-skip", () => {
        record.confidenceSkippedAt = now(); writeState(); renderRow(item);
      }));
      return;
    }
    if (!record.grade) {
      row.append(button("Got it", "study-grade", () => grade(item, "got")));
      row.append(button("Missed it", "study-grade", () => grade(item, "missed")));
      return;
    }
    const status = document.createElement("span");
    status.className = `study-status ${record.grade === "got" ? "study-mastered" : ""}`;
    status.textContent = record.grade === "got" ? "Got it" : "Missed it";
    row.append(status);
    if (record.due) {
      const due = document.createElement("span");
      due.className = "study-due"; due.textContent = `Due ${record.due}`; row.append(due);
    }
  };
  const grade = (item, value) => {
    const record = getState(item.key), days = schedule();
    record.grade = value; record.gradedAt = now();
    record.box = value === "got" ? Math.min((record.box ?? 1) + 1, days.length) : 1;
    record.due = dateAt(days[record.box - 1]);
    writeState(); renderRow(item); mark(item); renderSummary();
  };
  const refresh = () => {
    for (const item of items) { renderRow(item); mark(item); }
    renderSummary();
  };
  const resetControls = mount => {
    const row = document.createElement("div"), label = document.createElement("span");
    row.className = "study-row study-control study-reset"; label.textContent = "Study history:"; row.append(label);
    row.append(button("Reset this chapter", "study-reset-button", () => {
      if (globalThis.confirm?.("Clear study history for this chapter?") !== true) return;
      for (const key of Object.keys(state.items ?? {})) if (key.startsWith(`${chapter}:`)) delete state.items[key];
      writeState(); refresh();
    }));
    row.append(button("Reset everything", "study-reset-button", () => {
      if (globalThis.confirm?.("Clear all study history?") !== true) return;
      state = { items: {} };
      try { globalThis.localStorage.removeItem(KEY); } catch { /* Storage may be unavailable. */ }
      refresh();
    }));
    mount.append(row);
  };
  const renderSummary = () => {
    const mount = document.getElementById("study-summary");
    if (!mount) return;
    mount.classList.add("study-summary", "study-control"); mount.replaceChildren();
    let attempted = 0, graded = 0, got = 0, due = 0;
    const misses = [], seen = new Set();
    for (const item of items) {
      const record = getState(item.key);
      if (record.attemptedAt) attempted += 1;
      if (record.grade) graded += 1;
      if (record.grade === "got") got += 1;
      if (record.due && record.due <= dateAt(0)) due += 1;
      if (record.confidence === "high" && record.grade === "missed" && !seen.has(item.key)) {
        seen.add(item.key); misses.push(item);
      }
    }
    const metrics = document.createElement("p");
    metrics.textContent = `Attempted: ${attempted} | Got-it rate: ${graded ? Math.round(got * 100 / graded) : 0}% | Due today: ${due}`;
    mount.append(metrics);
    if (misses.length) {
      const heading = document.createElement("strong"), list = document.createElement("ul");
      heading.className = "study-high-miss"; heading.textContent = "High-confidence misses"; mount.append(heading);
      for (const item of misses) {
        const entry = document.createElement("li"), objective = item.node.dataset.objective;
        entry.textContent = objective ? `${objective}: ${item.summary.textContent.trim()}` : item.summary.textContent.trim();
        list.append(entry);
      }
      mount.append(list);
    }
    resetControls(mount);
  };
  for (const node of nodes) {
    const summary = node.querySelector("summary"), id = node.dataset.recall ?? node.dataset.mcq;
    if (!summary || !id) continue;
    const item = { node, summary, key: keyFor(id), row: document.createElement("div") };
    item.row.className = "study-row study-control"; item.row.setAttribute("aria-live", "polite"); node.append(item.row);
    items.push(item);
    node.addEventListener("toggle", () => {
      if (!node.open) return;
      const record = getState(item.key);
      if (!record.attemptedAt) { record.attemptedAt = now(); writeState(); }
      renderRow(item); mark(item); renderSummary();
    });
    renderRow(item); mark(item);
  }
  renderSummary();
})();
