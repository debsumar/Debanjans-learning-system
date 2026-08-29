/* Shared theme boot and toggle. ES2026 syntax, loaded as a classic script.
   Not an ES module: `import` is CORS-blocked from file:// URLs.
   File URLs get a separate localStorage object per URL, so theme choice does not
   reliably follow the reader between pages opened from disk. It persists normally
   on the hosted copy. All storage access is guarded; blocked storage falls back to dark. */
(() => {
  const root = document.documentElement;

  let theme = 'dark';
  try {
    const stored = localStorage.getItem('dls-theme');
    if (stored === 'light' || stored === 'dark') theme = stored;
  } catch {}
  root.setAttribute('data-theme', theme);

  const bindToggle = () => {
    const button = document.getElementById('theme-toggle');
    if (!button) return;

    const label = button.querySelector('.theme-label');

    const syncLabel = () => {
      const isLight = root.getAttribute('data-theme') === 'light';
      if (label) label.textContent = isLight ? 'Light' : 'Dark';
      button.setAttribute('aria-pressed', String(isLight));
    };

    syncLabel();

    button.addEventListener('click', () => {
      const next = root.getAttribute('data-theme') === 'light' ? 'dark' : 'light';
      root.setAttribute('data-theme', next);
      try { localStorage.setItem('dls-theme', next); } catch {}
      syncLabel();
    });
  };

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', bindToggle);
  } else {
    bindToggle();
  }
})();
