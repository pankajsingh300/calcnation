#!/bin/bash
# =============================================================
# CalcNation — Generate Sitemap
# Auto-scans all HTML files and builds a complete sitemap.xml
# Run from root of project: bash generate-sitemap.sh
# =============================================================

BASE_URL="https://calcnation-jade.vercel.app"
OUTPUT="sitemap.xml"
TODAY=$(date +%Y-%m-%d)

echo "🗺️  Generating sitemap..."
echo ""

# Start sitemap
cat > "$OUTPUT" << XMLHEADER
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
XMLHEADER

# Priority rules:
# 1.0  = homepage
# 0.9  = high-traffic tool pages (pdf, popular tools)
# 0.8  = all other tool pages
# 0.6  = blog pages
# 0.4  = static pages (about, privacy, contact)

add_url() {
  local path="$1"
  local priority="$2"
  local changefreq="$3"
  echo "  <url>" >> "$OUTPUT"
  echo "    <loc>${BASE_URL}/${path}</loc>" >> "$OUTPUT"
  echo "    <lastmod>${TODAY}</lastmod>" >> "$OUTPUT"
  echo "    <changefreq>${changefreq}</changefreq>" >> "$OUTPUT"
  echo "    <priority>${priority}</priority>" >> "$OUTPUT"
  echo "  </url>" >> "$OUTPUT"
}

# Homepage — highest priority
add_url "index.html" "1.0" "daily"

# PDF Tools — highest traffic
add_url "pdf/compress.html"     "0.9" "monthly"
add_url "pdf/merge.html"        "0.9" "monthly"
add_url "pdf/pdf-to-word.html"  "0.9" "monthly"
add_url "pdf/split.html"        "0.9" "monthly"
add_url "pdf/pdf-to-jpg.html"   "0.9" "monthly"
add_url "pdf/jpg-to-pdf.html"   "0.9" "monthly"
add_url "pdf/unlock.html"       "0.8" "monthly"
add_url "pdf/watermark.html"    "0.8" "monthly"
add_url "pdf/rotate.html"       "0.8" "monthly"

# Finance Tools
add_url "finance/emi-calculator.html"               "0.9" "monthly"
add_url "finance/mortgage-calculator.html"          "0.9" "monthly"
add_url "finance/compound-interest-calculator.html" "0.8" "monthly"

# Health Tools
add_url "health/calorie-calculator.html"  "0.9" "monthly"
add_url "health/pregnancy-due-date.html"  "0.8" "monthly"
add_url "health/water-calculator.html"    "0.8" "monthly"

# Dev Tools
add_url "dev/json-formatter.html"   "0.9" "monthly"
add_url "dev/base64.html"           "0.8" "monthly"
add_url "dev/regex-tester.html"     "0.8" "monthly"
add_url "dev/jwt-decoder.html"      "0.8" "monthly"
add_url "dev/uuid.html"             "0.8" "monthly"
add_url "dev/hash-generator.html"   "0.8" "monthly"
add_url "dev/url-encoder.html"      "0.8" "monthly"
add_url "dev/diff-checker.html"     "0.8" "monthly"
add_url "dev/markdown.html"         "0.8" "monthly"
add_url "dev/timestamp.html"        "0.8" "monthly"
add_url "dev/color-converter.html"  "0.8" "monthly"
add_url "dev/lorem-ipsum.html"      "0.8" "monthly"
add_url "dev/sql-formatter.html"    "0.8" "monthly"
add_url "dev/html-formatter.html"   "0.8" "monthly"
add_url "dev/xml-formatter.html"    "0.8" "monthly"
add_url "dev/css-minifier.html"     "0.8" "monthly"
add_url "dev/js-minifier.html"      "0.8" "monthly"
add_url "dev/cron.html"             "0.8" "monthly"

# Social / YouTube Tools
add_url "social/youtube-money-calculator.html"  "0.9" "monthly"
add_url "social/youtube-cpm-calculator.html"    "0.8" "monthly"
add_url "social/youtube-tag-generator.html"     "0.8" "monthly"
add_url "social/youtube-title-generator.html"   "0.8" "monthly"
add_url "social/youtube-thumbnail-resizer.html" "0.8" "monthly"
add_url "social/youtube-channel-analyzer.html"  "0.8" "monthly"
add_url "social/video-length-optimizer.html"    "0.8" "monthly"
add_url "social/tiktok-money-calculator.html"   "0.9" "monthly"
add_url "social/instagram-engagement.html"      "0.8" "monthly"
add_url "social/hashtag-generator.html"         "0.8" "monthly"
add_url "social/influencer-earnings.html"       "0.8" "monthly"
add_url "social/best-time-to-post.html"         "0.8" "monthly"
add_url "social/caption-generator.html"         "0.8" "monthly"
add_url "social/social-media-image-resizer.html" "0.8" "monthly"

# Viral / Quick Tools
add_url "tools/qr-code-generator.html"    "0.9" "monthly"
add_url "tools/password-generator.html"   "0.8" "monthly"
add_url "tools/word-counter.html"         "0.8" "monthly"
add_url "tools/bmi-calculator.html"       "0.9" "monthly"
add_url "tools/age-calculator.html"       "0.8" "monthly"
add_url "tools/tip-calculator.html"       "0.8" "monthly"
add_url "tools/love-calculator.html"      "0.8" "monthly"
add_url "tools/random-name-picker.html"   "0.8" "monthly"
add_url "tools/random-team-generator.html" "0.8" "monthly"
add_url "tools/dice-roller.html"          "0.8" "monthly"
add_url "tools/barcode-generator.html"    "0.8" "monthly"
add_url "tools/text-case-converter.html"  "0.8" "monthly"
add_url "tools/character-counter.html"    "0.8" "monthly"
add_url "tools/fake-address-generator.html" "0.8" "monthly"

# Blog
add_url "blog/index.html"                    "0.7" "weekly"
add_url "blog/playwright-beginners-guide.html" "0.6" "monthly"
add_url "blog/api-testing-guide.html"         "0.6" "monthly"
add_url "blog/ci-cd-automation.html"          "0.6" "monthly"
add_url "blog/robot-framework-guide.html"     "0.6" "monthly"
add_url "blog/selector-strategy.html"         "0.6" "monthly"
add_url "blog/test-data-strategies.html"      "0.6" "monthly"

# Static pages
add_url "about.html"   "0.4" "yearly"
add_url "privacy.html" "0.4" "yearly"
add_url "contact.html" "0.4" "yearly"

# Close sitemap
echo "</urlset>" >> "$OUTPUT"

# Count URLs
COUNT=$(grep -c "<loc>" "$OUTPUT")

echo "============================================="
echo "✅ SITEMAP GENERATED: sitemap.xml"
echo "   Total URLs: $COUNT"
echo "   Last modified: $TODAY"
echo "============================================="
echo ""
echo "Push to GitHub:"
echo "  git add sitemap.xml"
echo "  git commit -m 'SEO: regenerate complete sitemap with all $COUNT pages'"
echo "  git push"
echo ""
echo "Then submit to Google Search Console:"
echo "  1. Go to https://search.google.com/search-console"
echo "  2. Click Sitemaps in left sidebar"
echo "  3. Enter: sitemap.xml"
echo "  4. Click Submit"
