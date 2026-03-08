// CalcNation — Nav Loader
// Fetches /assets/components/nav.html and injects it into every page

(function () {
  // Find the root path based on how deep the current page is
  var depth = window.location.pathname.split('/').filter(Boolean).length;
  // If we're at root (index.html) depth is 0 or 1
  // If in a subfolder (pdf/compress.html) depth is 2
  var root = depth <= 1 ? '/' : '/';

  fetch(root + 'assets/components/nav.html')
    .then(function (r) { return r.text(); })
    .then(function (html) {
      // Create a wrapper and insert at top of body
      var wrapper = document.createElement('div');
      wrapper.innerHTML = html;
      var nav = wrapper.firstElementChild;
      document.body.insertBefore(nav, document.body.firstChild);
      initNav();
    })
    .catch(function (e) {
      console.warn('Nav loader failed:', e);
    });

  function initNav() {
    var hamburger = document.getElementById('navToggle');
    var navLinks  = document.getElementById('navLinks');

    // ── Mobile toggle ────────────────────────────────────────────────────
    if (hamburger && navLinks) {
      hamburger.addEventListener('click', function () {
        navLinks.classList.toggle('open');
      });
    }

    // ── Dropdown behaviour ───────────────────────────────────────────────
    document.querySelectorAll('.nav-dropdown').forEach(function (dropdown) {
      var trigger = dropdown.querySelector('.nav-dropdown-trigger');
      var menu    = dropdown.querySelector('.nav-dropdown-menu');

      if (!trigger || !menu) return;

      // Desktop: hover
      dropdown.addEventListener('mouseenter', function () {
        if (window.innerWidth > 768) {
          closeAll();
          menu.classList.add('open');
          fixPosition(menu);
        }
      });
      dropdown.addEventListener('mouseleave', function () {
        if (window.innerWidth > 768) {
          menu.classList.remove('open');
        }
      });

      // Mobile + click: toggle
      trigger.addEventListener('click', function (e) {
        e.stopPropagation();
        var isOpen = menu.classList.contains('open');
        closeAll();
        if (!isOpen) {
          menu.classList.add('open');
          if (window.innerWidth > 768) fixPosition(menu);
        }
      });
    });

    // Close all dropdowns when clicking outside
    document.addEventListener('click', function () { closeAll(); });

    // Close mobile nav when a link is clicked
    document.querySelectorAll('.nav-dropdown-menu a, .nav-link-plain').forEach(function (link) {
      link.addEventListener('click', function () {
        if (navLinks) navLinks.classList.remove('open');
        closeAll();
      });
    });

    // Reposition on resize
    window.addEventListener('resize', function () {
      closeAll();
      if (navLinks) navLinks.classList.remove('open');
    });
  }

  function closeAll() {
    document.querySelectorAll('.nav-dropdown-menu.open').forEach(function (m) {
      m.classList.remove('open');
    });
  }

  // Keep dropdown on screen — shift left if it overflows right edge
  function fixPosition(menu) {
    menu.style.left = '0';
    var rect     = menu.getBoundingClientRect();
    var overflow = rect.right - (window.innerWidth - 12);
    if (overflow > 0) {
      menu.style.left = '-' + overflow + 'px';
    }
  }
})();
