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
      if (label) label.textContent = root.getAttribute('data-theme') === 'light' ? 'Light' : 'Dark';
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
