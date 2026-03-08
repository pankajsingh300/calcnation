#!/bin/bash
# =============================================================
# CalcNation — Site-wide Fix Script
# Run from root of your project: bash fix-site.sh
# =============================================================

PROJECT_DIR="$(pwd)"
echo "🚀 Starting CalcNation site fixes in: $PROJECT_DIR"
echo ""

# ── 1. Fix .gitignore ─────────────────────────────────────────
echo "1️⃣  Fixing .gitignore..."
if ! grep -q ".DS_Store" .gitignore 2>/dev/null; then
  echo ".DS_Store" >> .gitignore
  echo "node_modules/" >> .gitignore
  echo ".env" >> .gitignore
  echo "Thumbs.db" >> .gitignore
  echo "   ✅ Added .DS_Store, node_modules, .env, Thumbs.db to .gitignore"
else
  echo "   ✅ .gitignore already has .DS_Store"
fi

# Remove .DS_Store from git tracking
git rm --cached .DS_Store 2>/dev/null && echo "   ✅ Removed .DS_Store from git tracking" || echo "   ℹ️  No .DS_Store in git"
git rm --cached -r --ignore-unmatch **/.DS_Store 2>/dev/null

# ── 2. Fix footer copyright year across all HTML files ────────
echo ""
echo "2️⃣  Fixing footer copyright © 2024 → © 2025..."
COUNT=0
find . -name "*.html" -not -path "*/node_modules/*" | while read file; do
  if grep -q "© 2024 CalcNation" "$file"; then
    sed -i '' 's/© 2024 CalcNation/© 2025 CalcNation/g' "$file"
    echo "   ✅ Fixed: $file"
    COUNT=$((COUNT+1))
  fi
done
echo "   Done."

# ── 3. Add Open Graph tags to all HTML files ─────────────────
echo ""
echo "3️⃣  Adding Open Graph meta tags to pages missing them..."
find . -name "*.html" -not -path "*/node_modules/*" | while read file; do
  if ! grep -q "og:title" "$file"; then
    # Extract page title
    TITLE=$(grep -o '<title>[^<]*</title>' "$file" | sed 's/<[^>]*>//g' | head -1)
    DESC=$(grep -o 'content="[^"]*"' "$file" | grep -i "description\|calculate\|free\|tool" | head -1 | sed 's/content="//;s/"//')

    OG_TAGS="  <!-- Open Graph -->\n  <meta property=\"og:type\" content=\"website\">\n  <meta property=\"og:site_name\" content=\"CalcNation\">\n  <meta property=\"og:title\" content=\"${TITLE}\">\n  <meta property=\"og:description\" content=\"Free online tools — no signup, no limits.\">\n  <meta property=\"og:image\" content=\"https://calcnation-jade.vercel.app/assets/og-image.png\">\n  <meta name=\"twitter:card\" content=\"summary_large_image\">\n  <meta name=\"twitter:title\" content=\"${TITLE}\">"

    # Insert after last </meta> or before </head>
    sed -i '' "s|</head>|${OG_TAGS}\n</head>|" "$file"
    echo "   ✅ OG tags added: $file"
  fi
done
echo "   Done."

# ── 4. Add GA4 placeholder to all HTML files ─────────────────
echo ""
echo "4️⃣  Adding GA4 placeholder comment to pages missing it..."
GA4_COMMENT="  <!-- Google Analytics 4 — ADD YOUR ID BELOW WHEN READY -->\n  <!-- <script async src=\"https://www.googletagmanager.com/gtag/js?id=G-XXXXXXXXXX\"></script>\n  <script>window.dataLayer=window.dataLayer||[];function gtag(){dataLayer.push(arguments);}gtag('js',new Date());gtag('config','G-XXXXXXXXXX');</script> -->"

find . -name "*.html" -not -path "*/node_modules/*" | while read file; do
  if ! grep -q "googletagmanager\|G-XXXXXXXXXX" "$file"; then
    sed -i '' "s|</head>|${GA4_COMMENT}\n</head>|" "$file"
    echo "   ✅ GA4 placeholder added: $file"
  fi
done
echo "   Done."

# ── 5. Summary ────────────────────────────────────────────────
echo ""
echo "============================================="
echo "✅ ALL FIXES COMPLETE!"
echo "============================================="
echo ""
echo "NEXT STEPS:"
echo "  1. Copy assets/components/nav.html       (shared nav file)"
echo "  2. Copy assets/js/nav-loader.js          (nav injector)"
echo "  3. Copy 404.html                         (custom error page)"
echo "  4. When you get GA4 ID: replace G-XXXXXXXXXX in all files"
echo "  5. When AdSense approved: add ca-pub-XXXX to all <head> tags"
echo ""
echo "Push to GitHub:"
echo "  git add -A"
echo "  git commit -m 'Site-wide fixes: OG tags, copyright, gitignore, GA4 placeholders'"
echo "  git push"
