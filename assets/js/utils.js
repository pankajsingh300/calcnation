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

// ── Currency helpers ────────────────────────────────────────────────────────
const currencyRates = {
  USD: 1, EUR: 0.93, GBP: 0.80, INR: 83.0, JPY: 140.0, AUD: 1.5
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
  convertInputs(prev, cur);
  document.querySelectorAll('[data-recalc-on-currency]').forEach(el => {
    try { window[el.dataset.recalcOnCurrency](); } catch(e) {}
  });
}

function formatCurrency(amount) {
  const cur = getCurrentCurrency();
  const rate = currencyRates[cur] || 1;
  const converted = amount * rate;
  if (cur === 'INR') {
    return '₹' + converted.toLocaleString('en-IN', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
  }
  const localeMap = { EUR: 'en-EU', GBP: 'en-GB', JPY: 'ja-JP', AUD: 'en-AU' };
  const locale = localeMap[cur] || 'en-US';
  return new Intl.NumberFormat(locale, { style: 'currency', currency: cur, minimumFractionDigits: 2, maximumFractionDigits: 2 }).format(converted);
}

function injectCurrencySelector() {
  const nav = document.querySelector('nav .nav-links');
  if (!nav || document.getElementById('currencySelect')) return;
  const sel = document.createElement('select');
  sel.id = 'currencySelect';
  sel.style.cssText = 'margin-left:8px;padding:6px 10px;background:var(--bg);color:var(--text);border:1px solid var(--border);border-radius:6px;font-size:14px;';
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
  document.querySelectorAll('.currency-symbol').forEach(el => el.textContent = getCurrentCurrency());
  const sel = document.getElementById('currencySelect');
  if (sel) sel.value = getCurrentCurrency();
}

function convertInputs(prev, cur) {
  if (prev === cur) return;
  const ratePrev = currencyRates[prev] || 1;
  const rateCur  = currencyRates[cur]  || 1;
  document.querySelectorAll('[data-currency-input]').forEach(input => {
    const v = parseFloat(input.value) || 0;
    input.value = (v * (rateCur / ratePrev)).toFixed(2);
  });
}

// ── Mega-menu overflow fix ──────────────────────────────────────────────────
function fixDropdownPosition(menu) {
  menu.style.left  = 'auto';
  menu.style.right = '0px';
  const rect     = menu.getBoundingClientRect();
  const overflow = rect.right - window.innerWidth + 12;
  if (overflow > 0) menu.style.right = overflow + 'px';
  if (rect.left < 12) { menu.style.right = 'auto'; menu.style.left = '0px'; }
}

// ── tools.json fetch (homepage search only) ─────────────────────────────────
// Only fetch on homepage where the search input exists
if (window.fetch && document.getElementById('searchInput') !== null) {
  fetch('/tools.json')
    .then(r => r.json())
    .then(data => {
      window.allTools = data;
      const input = document.getElementById('searchInput');
      if (input && input.value.trim()) input.dispatchEvent(new Event('input'));
    })
    .catch(e => console.error('Failed to load tools.json', e));
}

// ── Single DOMContentLoaded ─────────────────────────────────────────────────
document.addEventListener('DOMContentLoaded', () => {

  // FAQ accordion
  setupFAQ();

  // Currency selector + UI
  injectCurrencySelector();
  updateCurrencyUI();

  // Convert inputs if stored currency differs from default
  const cur = getCurrentCurrency();
  if (cur && cur !== 'INR') {
    convertInputs('INR', cur);
    document.querySelectorAll('[data-recalc-on-currency]').forEach(el => {
      try { window[el.dataset.recalcOnCurrency](); } catch(e) {}
    });
  }

  // ── Mobile nav toggle ────────────────────────────────────────────────────
  const navToggle = document.getElementById('navToggle') || document.querySelector('.nav-hamburger');
  const navLinks  = document.getElementById('navLinks');

  if (navToggle && navLinks) {
    navToggle.addEventListener('click', () => navLinks.classList.toggle('active'));

    // Close menu when a link is clicked
    navLinks.querySelectorAll('a').forEach(link => {
      link.addEventListener('click', () => navLinks.classList.remove('active'));
    });

    // Dropdown toggle on mobile
    document.querySelectorAll('.nav-dropdown-trigger').forEach(trigger => {
      trigger.addEventListener('click', e => {
        if (window.innerWidth <= 768) {
          e.preventDefault();
          trigger.closest('.nav-dropdown').classList.toggle('active');
        }
      });
    });
  }

  // ── Mega-menu overflow fix ───────────────────────────────────────────────
  document.querySelectorAll('.nav-dropdown').forEach(trigger => {
    trigger.addEventListener('mouseenter', () => {
      const wide = trigger.querySelector('.nav-dropdown-wide');
      if (wide) setTimeout(() => fixDropdownPosition(wide), 10);
    });
  });

  window.addEventListener('resize', () => {
    document.querySelectorAll('.nav-dropdown-wide').forEach(fixDropdownPosition);
  });

});

// Global mobile nav toggle (called from nav hamburger button onclick)
window.toggleMobileNav = function() {
  const links = document.getElementById('navLinks');
  if (links) links.classList.toggle('active');
};
