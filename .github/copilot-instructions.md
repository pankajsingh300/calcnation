# CalcNation AI Helper Instructions

This repository is a **static multi‑tool website** composed of plain HTML, CSS and a little vanilla
JavaScript. There is no build system, framework or server‑side code – every page is a self‑contained
`.html` file under a category directory (`pdf/`, `dev/`, `social/`, `tools/`, `finance/`,
`health/`). The homepage (`index.html`) and a shared stylesheet/utility script live at the top level.

## Big picture
- **Structure**: `index.html` is the landing page with a search bar, category cards and
  hard‑coded arrays describing every tool. Style lives in `assets/css/main.css`, shared JS in
  `assets/js/utils.js` and `assets/js/pdf-lib.min.js` for PDF manipulation.
- **Navigation**: Each tool page copies the same `<nav>` markup. Update manually, or copy from an
  existing page when you add a new one. Mega‑menus are handled in CSS/JS in `utils.js`.
- **Search**: A hard‑coded `allTools` array near the bottom of `index.html` drives the in‑page
  autocomplete. Every new tool must be added there (name, emoji icon, category string, url).
- **SEO & meta tags**: Every page includes a `<head>` section with canonical URLs, og/twitter
  tags, schema JSON‑LD, etc. A helper script `update-seo.sh` rewrites these for phase‑2
  metadata; run it whenever you change titles/descriptions or add new pages.
- **Processing**: Tools that handle files (PDFs, images) run entirely in the browser using
  `pdf-lib.min.js` and `FileReader`; `showToast`, `setProgress`, `setupDragDrop` from `utils.js` are
  reused. There is **no server call** – files never leave the user’s device.

## Developer workflows
1. **Local testing**: open `index.html` (or any tool page) directly in Chrome for UI tweaks. For
   PDF/drag‑and‑drop features you need a server; use VS Code Live Server extension or
   `python -m http.server` in the project root.
2. **Adding a new tool**:
   - Copy an existing `.html` page and adjust markup/inline script.
   - Add the new page’s entry to the `allTools` array in `index.html` (and update counts in the
     category cards manually).
   - Place the file in the appropriate folder and add a link in the nav/mega‑menu.
   - Run `./update-seo.sh` to inject the proper `<head>` or update manually.
3. **SEO updates**: `update-seo.sh` is a bash script with Python one‑liners that replaces the
   `<head>` tag of each page. It uses the hard‑coded deployment URL
   (`https://calcnation-jade.vercel.app`). Modify the script when the domain changes.
4. **Deployment**: commit to GitHub and connect the repo to Vercel (as described in
   `README.md`). Vercel serves the static files automatically; the canonical URLs in `<head>`
   should match the deployed domain.
5. **Maintenance**: When a tool’s functionality is extended, update its HTML/JS and re‑run the
   SEO script. Remove stale entries from `allTools` and nav if a page is deleted.

## Project conventions
- **Emoji icons**: icons are always simple unicode emojis; they appear in `allTools` and nav.
- **Relative links**: pages reference assets with relative paths (`../assets/...`). Keep folder
  depth correct when moving files.
- **CSS utility classes**: `tool-input`, `tool-box`, `related-tools`, etc., are defined in
  `main.css`. Use them for consistency.
- **JavaScript style**: inline `<script>` blocks at the bottom of tool pages. No modules or
  bundling; plain ES5/ES6 is fine. Use `document.getElementById` and straightforward DOM
  logic.
- **Meta formatting**: follow the existing pattern for titles and descriptions, which include the
  tool name and the brand (`CalcNation`). The canonical link must point to the Vercel URL.

## Integration points & dependencies
- **pdf-lib.min.js**: third‑party library for PDF processing; used by all tools under `pdf/`.
  It lives in `assets/js` and is referenced by the PDF pages.
- **Google Fonts**: loaded via `<link>` tags in the `<head>` of every page. No other external
  network resources except the fonts and `unpkg.com` preconnect hints in the SEO script.
- **update-seo.sh**: only external tooling dependency is `python3` for string replacement. The
  script is part of the repo.
- **Sitemap & robots**: `sitemap.xml` and `robots.txt` exist at root and are updated manually.

## Tips for AI agents
- When asked to add/change a tool, always search for similar examples (e.g. open
  `age-calculator.html`) and mimic the structure.
- Update both the navigation menus and the `allTools` list for the homepage search.
- For global style changes, edit `assets/css/main.css` only; avoid sprinkling inline styles.
- Run `grep` for class names like `tool-box` or `toast` to see where they are used.
- If a new feature requires persistent data or complex logic, note that there is no backend;
  any state must live in `localStorage` or in‑page JS.
- Remember to commit the updated `update-seo.sh` if the domain or meta templates change.
- If you add a new folder or category, adjust the nav dropdown structure in `index.html`
  accordingly and add a corresponding `<div class="cat-card ...">` in the homepage categories.

> **Note:** This project is intentionally simple. The main effort is copying and adapting
> existing HTML patterns and keeping the SEO script in sync. Avoid over‑engineering.

---

Please review this draft and let me know if any sections are unclear or missing details so we can iterate.