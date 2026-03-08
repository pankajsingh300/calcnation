// CalcNation Shared Utilities

function formatBytes(bytes) {
  if (bytes === 0) return '0 B';
  const k = 1024;
  const sizes = ['B', 'KB', 'MB', 'GB'];
  const i = Math.floor(Math.log(bytes) / Math.log(k));
  return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + ' ' + sizes[i];
}

function showToast(msg, type = 'success') {
  let toast = document.getElementById('toast');
  if (!toast) {
    toast = document.createElement('div');
    toast.id = 'toast';
    toast.className = 'toast';
    document.body.appendChild(toast);
  }
  toast.textContent = msg;
  toast.className = `toast ${type} show`;
  setTimeout(() => toast.classList.remove('show'), 3500);
}

function setupDragDrop(zone, onFiles) {
  zone.addEventListener('dragover', e => { e.preventDefault(); zone.classList.add('drag-over'); });
  zone.addEventListener('dragleave', () => zone.classList.remove('drag-over'));
  zone.addEventListener('drop', e => {
    e.preventDefault(); zone.classList.remove('drag-over');
    onFiles([...e.dataTransfer.files]);
  });
}

function setupFAQ() {
  document.querySelectorAll('.faq-q').forEach(q => {
    q.addEventListener('click', () => {
      const a = q.nextElementSibling;
      const arrow = q.querySelector('.faq-arrow');
      const isOpen = a.classList.contains('open');
      document.querySelectorAll('.faq-a').forEach(x => x.classList.remove('open'));
      document.querySelectorAll('.faq-arrow').forEach(x => x.textContent = '▾');
      if (!isOpen) { a.classList.add('open'); if (arrow) arrow.textContent = '▴'; }
    });
  });
}

// Progress bar helper
function setProgress(pct, label = '') {
  const bar = document.querySelector('.progress-bar');
  const lbl = document.querySelector('.progress-label');
  const wrap = document.querySelector('.progress-wrap');
  if (bar) bar.style.width = pct + '%';
  if (lbl && label) lbl.textContent = label;
  if (wrap) wrap.classList.toggle('show', pct > 0 && pct < 100);
}

document.addEventListener('DOMContentLoaded', setupFAQ);


// ── Mega-menu overflow fix ──────────────────────────────────────────────────
// Repositions any .nav-dropdown-wide so it never clips outside the viewport
(function() {
  function fixDropdownPosition(menu) {
    // Reset first
    menu.style.left = 'auto';
    menu.style.right = '0px';
    var rect = menu.getBoundingClientRect();
    var overflow = rect.right - window.innerWidth + 12; // 12px gutter
    if (overflow > 0) {
      menu.style.right = (overflow) + 'px';
    }
    if (rect.left < 12) {
      menu.style.right = 'auto';
      menu.style.left = '0px';
    }
  }

  document.addEventListener('DOMContentLoaded', function() {
    var triggers = document.querySelectorAll('.nav-dropdown');
    triggers.forEach(function(trigger) {
      trigger.addEventListener('mouseenter', function() {
        var wide = this.querySelector('.nav-dropdown-wide');
        if (wide) {
          // Small delay to let browser paint
          setTimeout(function() { fixDropdownPosition(wide); }, 10);
        }
      });
    });
    // Also fix on resize
    window.addEventListener('resize', function() {
      var menus = document.querySelectorAll('.nav-dropdown-wide');
      menus.forEach(fixDropdownPosition);
    });
  });
})();
