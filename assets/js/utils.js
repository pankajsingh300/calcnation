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

// currency selector and formatting helpers
const currencyRates = {
  USD: 1,
  EUR: 0.93,
  GBP: 0.80,
  INR: 83.0,
  JPY: 140.0,
  AUD: 1.5
};

function getCurrentCurrency() {
  return localStorage.getItem('currency') || 'INR';
}

function setCurrentCurrency(cur) {
  if (!currencyRates[cur]) return;
  const prev = getCurrentCurrency();
  if (prev === cur) return;
  localStorage.setItem('currency', cur);
  updateCurrencyUI();
  // convert any inputs that carry data-currency-input
  convertInputs(prev, cur);
  // trigger recalculations if pages have global calc functions
  document.querySelectorAll('[data-recalc-on-currency]').forEach(fnEl => {
    try { window[fnEl.dataset.recalcOnCurrency](); } catch(e) {}
  });
}

function formatCurrency(amount) {
  const cur = getCurrentCurrency();
  const rate = currencyRates[cur] || 1;
  const options = { style: 'currency', currency: cur, minimumFractionDigits: 2, maximumFractionDigits: 2 };
  return new Intl.NumberFormat('en-US', options).format(amount * rate);
}

function injectCurrencySelector() {
  const nav = document.querySelector('nav .nav-links');
  if (!nav) return;
  const sel = document.createElement('select');
  sel.id = 'currencySelect';
  sel.style.marginLeft = '8px';
  sel.style.padding = '6px 10px';
  sel.style.background = 'var(--bg)';
  sel.style.color = 'var(--text)';
  sel.style.border = '1px solid var(--border)';
  sel.style.borderRadius = '6px';
  sel.style.fontSize = '14px';
  Object.keys(currencyRates).forEach(cur => {
    const opt = document.createElement('option');
    opt.value = cur;
    opt.textContent = cur;
    sel.appendChild(opt);
  });
  sel.value = getCurrentCurrency();
  sel.addEventListener('change', e => setCurrentCurrency(e.target.value));
  nav.appendChild(sel);
}

function updateCurrencyUI() {
  // update any elements that show currency symbol
  document.querySelectorAll('.currency-symbol').forEach(el => {
    el.textContent = getCurrentCurrency();
  });
  const sel = document.getElementById('currencySelect');
  if (sel) sel.value = getCurrentCurrency();
}

function convertInputs(prev, cur) {
  if (prev === cur) return;
  const ratePrev = currencyRates[prev] || 1;
  const rateCur = currencyRates[cur] || 1;
  document.querySelectorAll('[data-currency-input]').forEach(input => {
    const v = parseFloat(input.value) || 0;
    const newVal = v * (rateCur / ratePrev);
    // always keep two decimal places regardless of step
    input.value = newVal.toFixed(2);
  });
}

function ensureMobileToggle() {
  const nav = document.querySelector('nav');
  if (!nav) return;
  if (!document.getElementById('navToggle')) {
    const btn = document.createElement('button');
    btn.className = 'nav-toggle';
    btn.id = 'navToggle';
    btn.setAttribute('aria-label', 'Menu');
    btn.textContent = '☰';
    // insert before links for easier styling
    nav.insertBefore(btn, nav.firstChild.nextSibling);
  }
}

// build dropdown menus for categories using tools.json data
function populateDropdowns(tools) {
  const pdfLinks = tools.filter(t => t.cat === 'PDF Tools');
  const devLinks = tools.filter(t => t.cat === 'Dev Tools');
  function buildMenu(wrapper, list) {
    if (!list.length) return;
    const menu = document.createElement('div');
    menu.className = 'nav-dropdown-menu';
    list.forEach(t => {
      const a = document.createElement('a');
      a.href = t.url;
      a.innerHTML = `<span>${t.icon}</span> ${t.name}`;
      menu.appendChild(a);
    });
    wrapper.appendChild(menu);
  }
  document.querySelectorAll('nav .nav-links a').forEach(a => {
    const text = a.textContent.trim();
    if (text === 'PDF Tools' || text === 'Dev Tools') {
      const wrapper = document.createElement('div');
      wrapper.className = 'nav-dropdown';
      a.classList.add('nav-dropdown-trigger');
      a.textContent = text + ' ▾';
      a.parentNode.insertBefore(wrapper, a);
      wrapper.appendChild(a);
      buildMenu(wrapper, text === 'PDF Tools' ? pdfLinks : devLinks);
    }
  });
}

// fetch the tool list for dropdowns as well as search on page load
if (window.fetch) {
  fetch('tools.json')
    .then(r => r.json())
    .then(data => {
      allTools = data; // used by index search
      populateDropdowns(data);
      // re-run search if needed
      const input = document.getElementById('searchInput');
      if (input && input.value.trim()) {
        input.dispatchEvent(new Event('input'));
      }
    })
    .catch(e => console.error('Failed to load tools.json', e));
}

document.addEventListener('DOMContentLoaded', () => {
  setupFAQ();
  injectCurrencySelector();
  updateCurrencyUI();
  ensureMobileToggle();

  // make sure inputs match stored currency on load
  const cur = getCurrentCurrency();
  if (cur && cur !== 'INR') {
    convertInputs('INR', cur);
    document.querySelectorAll('[data-recalc-on-currency]').forEach(fnEl => {
      try { window[fnEl.dataset.recalcOnCurrency](); } catch(e) {}
    });
  }

  // mobile nav toggle (index.html used to have inline script)
  const navToggle = document.getElementById('navToggle');
  if (navToggle) {
    navToggle.addEventListener('click', () => {
      const links = document.getElementById('navLinks');
      if (links) links.classList.toggle('open');
    });
  }
});


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
