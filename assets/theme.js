/* File URLs have separate localStorage objects, so theme persistence across pages is not guaranteed. */
(function(){
  var root = document.documentElement;
  var theme = 'dark';
  try {
    var stored = localStorage.getItem('dls-theme');
    if (stored === 'light' || stored === 'dark') theme = stored;
  } catch (e) {}
  root.setAttribute('data-theme', theme);
  function bindToggle() {
    var button = document.getElementById('theme-toggle');
    if (!button) return;
    var label = button.querySelector('.theme-label');
    function syncLabel() {
      var isLight = root.getAttribute('data-theme') === 'light';
      if (label) label.textContent = isLight ? 'Light' : 'Dark';
      button.setAttribute('aria-pressed', isLight ? 'true' : 'false');
    }
    syncLabel();
    button.addEventListener('click', function(){
      var next = root.getAttribute('data-theme') === 'light' ? 'dark' : 'light';
      root.setAttribute('data-theme', next);
      try { localStorage.setItem('dls-theme', next); } catch (e) {}
      syncLabel();
    });
  }
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', bindToggle);
  } else {
    bindToggle();
  }
})();
