/**
 * CalcNation — Shared Nav & Footer Loader
 * Injects nav and footer from a single source file into every page.
 * To update nav across ALL pages, edit only: /assets/components/nav.html
 */

(function () {
  // ── Inject Nav ──────────────────────────────────────────────────
  const navPlaceholder = document.getElementById('nav-placeholder');
  if (navPlaceholder) {
    fetch('/assets/components/nav.html')
      .then(r => r.text())
      .then(html => {
        navPlaceholder.innerHTML = html;
        highlightActiveLink();
      })
      .catch(() => {
        // Fallback: show minimal nav if fetch fails
        navPlaceholder.innerHTML = '<nav><a href="/index.html" class="nav-logo">⚡ CalcNation</a></nav>';
      });
  }

  // ── Inject Footer ───────────────────────────────────────────────
  const footerPlaceholder = document.getElementById('footer-placeholder');
  if (footerPlaceholder) {
    footerPlaceholder.innerHTML = `
      <footer>
        <div style="margin-bottom:16px">
          <a href="/index.html" class="nav-logo" style="font-size:18px">⚡ CalcNation</a>
        </div>
        <div style="display:flex;gap:16px;flex-wrap:wrap;justify-content:center;margin-bottom:12px">
          <a href="/pdf/compress.html">PDF Tools</a>
          <a href="/dev/json-formatter.html">Dev Tools</a>
          <a href="/finance/mortgage-calculator.html">Finance</a>
          <a href="/health/calorie-calculator.html">Health</a>
          <a href="/tools/qr-code-generator.html">Tools</a>
          <a href="/blog/">Blog</a>
          <a href="/about.html">About</a>
          <a href="/privacy.html">Privacy</a>
          <a href="/contact.html">Contact</a>
        </div>
        <div>© ${new Date().getFullYear()} CalcNation · 60+ free tools · No signup · Your files stay private</div>
      </footer>`;
  }

  // ── Highlight Active Nav Link ───────────────────────────────────
  function highlightActiveLink() {
    const path = window.location.pathname;
    document.querySelectorAll('nav a').forEach(link => {
      if (link.getAttribute('href') && path.endsWith(link.getAttribute('href').replace(/^\//, ''))) {
        link.style.color = 'var(--accent)';
      }
    });
  }

  // ── Mobile Nav Toggle ───────────────────────────────────────────
  window.toggleMobileNav = function () {
    const links = document.getElementById('navLinks');
    if (links) links.classList.toggle('nav-open');
  };
})();
