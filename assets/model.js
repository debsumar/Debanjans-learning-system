(() => {
  const text = node => node?.textContent.trim() ?? "";
  const make = (tag, className, label) => {
    const node = document.createElement(tag);
    if (className) node.className = className;
    if (label !== undefined) node.textContent = label;
    return node;
  };
  const init = model => {
    const table = model.querySelector("table.model-matrix");
    const headerRow = table?.tHead?.rows?.[0];
    const body = table?.tBodies?.[0];
    if (!table || !headerRow || !body) return;
    const headerCells = [...headerRow.cells];
    const scenarioHeaders = headerCells.slice(1);
    if (!headerCells[0] || !scenarioHeaders.length || scenarioHeaders.some(cell => !text(cell))) return;
    const rows = [...body.rows].map(row => {
      const optionCell = row.querySelector("th[scope='row']");
      const cells = scenarioHeaders.map((_, index) => row.cells[index + 1]);
      if (!optionCell || !text(optionCell) || cells.some(cell => !cell || !text(cell))) return null;
      return { row, optionCell, option: text(optionCell), cells, outcomes: cells.map(text) };
    });
    if (!rows.length || rows.some(row => !row)) return;
    const outcomes = [...new Set(rows.flatMap(row => row.outcomes))];
    const controls = make("div", "model-controls");
    const optionButtons = [];
    const scenarioButtons = [];
    const addGroup = (label, items, buttons, select) => {
      const group = make("div", "model-group");
      const title = make("span", "model-label", `${label}:`);
      const chips = make("div", "model-chips");
      chips.setAttribute("role", "group");
      chips.setAttribute("aria-label", label);
      items.forEach((item, index) => {
        const button = make("button", "model-chip", item);
        button.type = "button";
        button.setAttribute("aria-pressed", "false");
        button.addEventListener("click", () => {
          select(index);
          buttons.forEach((chip, chipIndex) => chip.setAttribute("aria-pressed", String(chipIndex === index)));
          update();
        });
        buttons.push(button);
        chips.append(button);
      });
      group.append(title, chips);
      controls.append(group);
    };
    let optionIndex = -1;
    let scenarioIndex = -1;
    const prediction = make("div", "model-predict");
    const verdict = make("div", "model-verdict");
    const reset = make("button", "model-reset", "Reset");
    verdict.setAttribute("role", "status");
    verdict.setAttribute("aria-live", "polite");
    verdict.hidden = true;
    prediction.hidden = true;
    const reveal = predictionValue => {
      const outcome = rows[optionIndex]?.outcomes[scenarioIndex];
      if (!outcome) return;
      const result = predictionValue === undefined
        ? `Outcome: ${outcome}.`
        : predictionValue === outcome
          ? `Outcome: ${outcome}. Prediction matched.`
          : `Outcome: ${outcome}. Prediction did not match.`;
      verdict.textContent = result;
      verdict.hidden = false;
      prediction.hidden = true;
    };
    outcomes.forEach(outcome => {
      const button = make("button", "model-prediction", outcome);
      button.type = "button";
      button.addEventListener("click", () => reveal(outcome));
      prediction.append(button);
    });
    const skip = make("button", "model-skip", "Reveal outcome");
    skip.type = "button";
    skip.addEventListener("click", () => reveal());
    prediction.prepend(make("span", "model-label", "Predict:"), skip);
    reset.addEventListener("click", () => {
      optionIndex = -1;
      scenarioIndex = -1;
      optionButtons.forEach(button => button.setAttribute("aria-pressed", "false"));
      scenarioButtons.forEach(button => button.setAttribute("aria-pressed", "false"));
      update();
    });
    controls.append(reset);
    const update = () => {
      rows.forEach((item, index) => {
        const selected = index === optionIndex;
        item.row.classList.toggle("is-selected", selected);
        item.optionCell.classList.toggle("is-selected", selected);
        item.cells.forEach(cell => cell.classList.remove("is-hit"));
      });
      scenarioHeaders.forEach((cell, index) => cell.classList.toggle("is-selected", index === scenarioIndex));
      prediction.hidden = true;
      verdict.hidden = true;
      if (optionIndex < 0 || scenarioIndex < 0) return;
      rows[optionIndex].cells[scenarioIndex].classList.add("is-hit");
      prediction.hidden = false;
      verdict.textContent = "Choose a prediction, or reveal the outcome.";
      verdict.hidden = false;
    };
    addGroup(model.dataset.modelRows || "Options", rows.map(row => row.option), optionButtons, index => { optionIndex = index; });
    addGroup(model.dataset.modelCols || "Failure scenarios", scenarioHeaders.map(text), scenarioButtons, index => { scenarioIndex = index; });
    model.insertBefore(controls, table);
    model.insertBefore(prediction, table);
    model.insertBefore(verdict, table);
  };
  const start = () => document.querySelectorAll("[data-model]").forEach(init);
  if (document.readyState === "loading") document.addEventListener("DOMContentLoaded", start, { once: true });
  else start();
})();
