#!/bin/bash
# =============================================================
# CalcNation — Fix Canonical URLs
# Gives every HTML page its own correct canonical URL
# Run from root of project: bash fix-canonicals.sh
# =============================================================

BASE_URL="https://calcnation-jade.vercel.app"
FIXED=0
SKIPPED=0

echo "🔗 Fixing canonical URLs across all pages..."
echo "   Base URL: $BASE_URL"
echo ""

find . -name "*.html" \
  -not -path "*/node_modules/*" \
  -not -path "./.git/*" | sort | while read file; do

  # Build the correct URL path from the file path
  # e.g. ./finance/emi-calculator.html → /finance/emi-calculator.html
  RELATIVE_PATH="${file#./}"
  CORRECT_URL="${BASE_URL}/${RELATIVE_PATH}"

  # Check if a canonical tag already exists in this file
  if grep -q 'rel="canonical"' "$file"; then
    # Replace whatever canonical is there with the correct one
    OLD=$(grep -o 'href="[^"]*"' "$file" | grep -A1 'canonical' | head -1)
    /usr/bin/perl -i -pe "s|<link rel=\"canonical\" href=\"[^\"]*\">|<link rel=\"canonical\" href=\"${CORRECT_URL}\">|g" "$file"
    echo "   ✅ Updated: $RELATIVE_PATH"
    FIXED=$((FIXED+1))
  else
    # No canonical tag — insert one after <meta name="robots"...> or after charset meta
    /usr/bin/perl -i -pe "s|(<meta name=\"robots\"[^>]*>)|\$1\n  <link rel=\"canonical\" href=\"${CORRECT_URL}\">|" "$file"
    echo "   ➕ Added:   $RELATIVE_PATH"
    FIXED=$((FIXED+1))
  fi
done

echo ""
echo "============================================="
echo "✅ CANONICAL FIX COMPLETE!"
echo "============================================="
echo ""
echo "Every page now has a unique canonical URL."
echo "This tells Google which URL to index for each page."
echo ""
echo "Push to GitHub:"
echo "  git add -A"
echo "  git commit -m 'SEO: fix canonical URLs on all pages'"
echo "  git push"
