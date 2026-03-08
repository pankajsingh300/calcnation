#!/bin/bash
# CalcNation Phase 2 — Auto Head Updater
# Run this from inside your calcnation folder

echo "🚀 Starting Phase 2 head section updates..."

# ── INDEX.HTML ──
cat > /tmp/index_head.html << 'INDEXHEAD'
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>CalcNation — Free Online Tools, PDF Utilities & Calculators</title>
<meta name="description" content="300+ free online tools in one place. Compress PDF, merge PDF, developer tools, finance calculators, health calculators. No signup, no upload — works in your browser.">
<meta name="keywords" content="free online tools, pdf compressor, merge pdf, compress pdf, pdf to jpg, jpg to pdf, split pdf, bmi calculator, mortgage calculator, json formatter">
<meta name="author" content="CalcNation">
<meta name="robots" content="index, follow, max-snippet:-1, max-image-preview:large, max-video-preview:-1">
<link rel="canonical" href="https://calcnation-jade.vercel.app/">
<meta property="og:type" content="website">
<meta property="og:url" content="https://calcnation-jade.vercel.app/">
<meta property="og:title" content="CalcNation — 300+ Free Online Tools & Calculators">
<meta property="og:description" content="Free PDF tools, developer utilities, finance and health calculators. No signup required. Your files never leave your device.">
<meta property="og:site_name" content="CalcNation">
<meta property="og:locale" content="en_US">
<meta name="twitter:card" content="summary_large_image">
<meta name="twitter:title" content="CalcNation — 300+ Free Online Tools">
<meta name="twitter:description" content="Free PDF tools, developer utilities, finance and health calculators. No signup. Works in your browser.">
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "WebSite",
  "name": "CalcNation",
  "url": "https://calcnation-jade.vercel.app",
  "description": "Free online tools including PDF utilities, developer tools, finance calculators and health calculators.",
  "potentialAction": {
    "@type": "SearchAction",
    "target": {
      "@type": "EntryPoint",
      "urlTemplate": "https://calcnation-jade.vercel.app/?q={search_term_string}"
    },
    "query-input": "required name=search_term_string"
  }
}
</script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link rel="dns-prefetch" href="https://unpkg.com">
<link rel="icon" type="image/svg+xml" href="data:image/svg+xml,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 100 100'><text y='.9em' font-size='90'>⚡</text></svg>">
<link rel="stylesheet" href="assets/css/main.css">
</head>
INDEXHEAD

# Replace head in index.html
python3 -c "
import re, sys
content = open('index.html').read()
new_head = open('/tmp/index_head.html').read()
result = re.sub(r'<head>.*?</head>', new_head, content, flags=re.DOTALL)
open('index.html', 'w').write(result)
print('✅ index.html updated')
"

# ── COMPRESS.HTML ──
python3 -c "
import re
content = open('pdf/compress.html').read()
new_head = '''<head>
<meta charset=\"UTF-8\">
<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">
<title>Compress PDF Free Online — Reduce PDF File Size Instantly | CalcNation</title>
<meta name=\"description\" content=\"Compress PDF files online for free. Reduce PDF size by up to 80% without losing quality. No upload to server — runs entirely in your browser. Instant, private, free.\">
<meta name=\"keywords\" content=\"compress pdf, reduce pdf size, pdf compressor online free, shrink pdf, pdf file size reducer\">
<meta name=\"robots\" content=\"index, follow\">
<link rel=\"canonical\" href=\"https://calcnation-jade.vercel.app/pdf/compress.html\">
<meta property=\"og:type\" content=\"website\">
<meta property=\"og:url\" content=\"https://calcnation-jade.vercel.app/pdf/compress.html\">
<meta property=\"og:title\" content=\"Compress PDF Free Online | CalcNation\">
<meta property=\"og:description\" content=\"Compress PDF files online for free. Reduce PDF size by up to 80%. No upload required.\">
<meta property=\"og:site_name\" content=\"CalcNation\">
<meta name=\"twitter:card\" content=\"summary\">
<script type=\"application/ld+json\">
{
  \"@context\": \"https://schema.org\",
  \"@type\": \"SoftwareApplication\",
  \"name\": \"PDF Compressor\",
  \"applicationCategory\": \"UtilitiesApplication\",
  \"operatingSystem\": \"Web Browser\",
  \"offers\": { \"@type\": \"Offer\", \"price\": \"0\", \"priceCurrency\": \"USD\" },
  \"description\": \"Free online PDF compressor. Reduce PDF file size without losing quality.\",
  \"url\": \"https://calcnation-jade.vercel.app/pdf/compress.html\"
}
<\/script>
<script type=\"application/ld+json\">
{
  \"@context\": \"https://schema.org\",
  \"@type\": \"FAQPage\",
  \"mainEntity\": [
    { \"@type\": \"Question\", \"name\": \"Is my PDF uploaded to a server?\", \"acceptedAnswer\": { \"@type\": \"Answer\", \"text\": \"No. Everything happens in your browser. Your PDF never leaves your device.\" } },
    { \"@type\": \"Question\", \"name\": \"Is this tool really free?\", \"acceptedAnswer\": { \"@type\": \"Answer\", \"text\": \"Yes, completely free forever. No subscription, no watermarks, no limits.\" } }
  ]
}
<\/script>
<link rel=\"icon\" type=\"image/svg+xml\" href=\"data:image/svg+xml,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 100 100'><text y='.9em' font-size='90'>⚡</text></svg>\">
<link rel=\"stylesheet\" href=\"../assets/css/main.css\">
</head>'''
result = re.sub(r'<head>.*?</head>', new_head, content, flags=re.DOTALL)
open('pdf/compress.html', 'w').write(result)
print('✅ pdf/compress.html updated')
"

# ── MERGE.HTML ──
python3 -c "
import re
content = open('pdf/merge.html').read()
new_head = '''<head>
<meta charset=\"UTF-8\">
<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">
<title>Merge PDF Files Free Online — Combine Multiple PDFs Into One | CalcNation</title>
<meta name=\"description\" content=\"Merge multiple PDF files into one document online for free. Drag to reorder pages. No upload to server — 100% private, instant, no signup required.\">
<meta name=\"keywords\" content=\"merge pdf, combine pdf files, join pdf online free, merge pdf files into one, pdf merger online\">
<meta name=\"robots\" content=\"index, follow\">
<link rel=\"canonical\" href=\"https://calcnation-jade.vercel.app/pdf/merge.html\">
<meta property=\"og:type\" content=\"website\">
<meta property=\"og:url\" content=\"https://calcnation-jade.vercel.app/pdf/merge.html\">
<meta property=\"og:title\" content=\"Merge PDF Files Free — Combine PDFs Online | CalcNation\">
<meta property=\"og:description\" content=\"Merge multiple PDFs into one file online. Drag to reorder. Free, private, no signup.\">
<meta property=\"og:site_name\" content=\"CalcNation\">
<meta name=\"twitter:card\" content=\"summary\">
<script type=\"application/ld+json\">
{
  \"@context\": \"https://schema.org\",
  \"@type\": \"SoftwareApplication\",
  \"name\": \"PDF Merger\",
  \"applicationCategory\": \"UtilitiesApplication\",
  \"operatingSystem\": \"Web Browser\",
  \"offers\": { \"@type\": \"Offer\", \"price\": \"0\", \"priceCurrency\": \"USD\" },
  \"description\": \"Free online PDF merger. Combine multiple PDF files into one. Drag to reorder.\",
  \"url\": \"https://calcnation-jade.vercel.app/pdf/merge.html\"
}
<\/script>
<link rel=\"icon\" type=\"image/svg+xml\" href=\"data:image/svg+xml,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 100 100'><text y='.9em' font-size='90'>⚡</text></svg>\">
<link rel=\"stylesheet\" href=\"../assets/css/main.css\">
</head>'''
result = re.sub(r'<head>.*?</head>', new_head, content, flags=re.DOTALL)
open('pdf/merge.html', 'w').write(result)
print('✅ pdf/merge.html updated')
"

# ── SPLIT.HTML ──
python3 -c "
import re
content = open('pdf/split.html').read()
new_head = '''<head>
<meta charset=\"UTF-8\">
<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">
<title>Split PDF Free Online — Extract PDF Pages by Range | CalcNation</title>
<meta name=\"description\" content=\"Split a PDF into multiple files or extract specific pages online for free. Choose by page range or split every N pages. No upload — 100% private browser tool.\">
<meta name=\"keywords\" content=\"split pdf, extract pages from pdf, pdf splitter online free, separate pdf pages, divide pdf online\">
<meta name=\"robots\" content=\"index, follow\">
<link rel=\"canonical\" href=\"https://calcnation-jade.vercel.app/pdf/split.html\">
<meta property=\"og:type\" content=\"website\">
<meta property=\"og:url\" content=\"https://calcnation-jade.vercel.app/pdf/split.html\">
<meta property=\"og:title\" content=\"Split PDF Free — Extract Pages Online | CalcNation\">
<meta property=\"og:description\" content=\"Split PDF by page range or extract specific pages online. Free, instant, 100% private.\">
<meta property=\"og:site_name\" content=\"CalcNation\">
<meta name=\"twitter:card\" content=\"summary\">
<script type=\"application/ld+json\">
{
  \"@context\": \"https://schema.org\",
  \"@type\": \"SoftwareApplication\",
  \"name\": \"PDF Splitter\",
  \"applicationCategory\": \"UtilitiesApplication\",
  \"operatingSystem\": \"Web Browser\",
  \"offers\": { \"@type\": \"Offer\", \"price\": \"0\", \"priceCurrency\": \"USD\" },
  \"description\": \"Free online PDF splitter. Split by page range, every N pages, or extract all pages.\",
  \"url\": \"https://calcnation-jade.vercel.app/pdf/split.html\"
}
<\/script>
<link rel=\"icon\" type=\"image/svg+xml\" href=\"data:image/svg+xml,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 100 100'><text y='.9em' font-size='90'>⚡</text></svg>\">
<link rel=\"stylesheet\" href=\"../assets/css/main.css\">
</head>'''
result = re.sub(r'<head>.*?</head>', new_head, content, flags=re.DOTALL)
open('pdf/split.html', 'w').write(result)
print('✅ pdf/split.html updated')
"

# ── PDF-TO-JPG.HTML ──
python3 -c "
import re
content = open('pdf/pdf-to-jpg.html').read()
new_head = '''<head>
<meta charset=\"UTF-8\">
<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">
<title>PDF to JPG Converter Free Online — Convert PDF Pages to Images | CalcNation</title>
<meta name=\"description\" content=\"Convert PDF pages to high-quality JPG images online for free. Choose DPI and quality. All pages converted instantly. No upload to server — private and free.\">
<meta name=\"keywords\" content=\"pdf to jpg, convert pdf to image, pdf to jpeg online free, pdf to png converter, save pdf as image\">
<meta name=\"robots\" content=\"index, follow\">
<link rel=\"canonical\" href=\"https://calcnation-jade.vercel.app/pdf/pdf-to-jpg.html\">
<meta property=\"og:type\" content=\"website\">
<meta property=\"og:url\" content=\"https://calcnation-jade.vercel.app/pdf/pdf-to-jpg.html\">
<meta property=\"og:title\" content=\"PDF to JPG Free — Convert PDF to Image Online | CalcNation\">
<meta property=\"og:description\" content=\"Convert PDF pages to JPG or PNG images. Choose DPI, download all as ZIP. Free and private.\">
<meta property=\"og:site_name\" content=\"CalcNation\">
<meta name=\"twitter:card\" content=\"summary\">
<script type=\"application/ld+json\">
{
  \"@context\": \"https://schema.org\",
  \"@type\": \"SoftwareApplication\",
  \"name\": \"PDF to JPG Converter\",
  \"applicationCategory\": \"UtilitiesApplication\",
  \"operatingSystem\": \"Web Browser\",
  \"offers\": { \"@type\": \"Offer\", \"price\": \"0\", \"priceCurrency\": \"USD\" },
  \"description\": \"Convert PDF pages to JPG or PNG images. Choose resolution and quality. Download all as ZIP.\",
  \"url\": \"https://calcnation-jade.vercel.app/pdf/pdf-to-jpg.html\"
}
<\/script>
<link rel=\"icon\" type=\"image/svg+xml\" href=\"data:image/svg+xml,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 100 100'><text y='.9em' font-size='90'>⚡</text></svg>\">
<link rel=\"stylesheet\" href=\"../assets/css/main.css\">
</head>'''
result = re.sub(r'<head>.*?</head>', new_head, content, flags=re.DOTALL)
open('pdf/pdf-to-jpg.html', 'w').write(result)
print('✅ pdf/pdf-to-jpg.html updated')
"

# ── JPG-TO-PDF.HTML ──
python3 -c "
import re
content = open('pdf/jpg-to-pdf.html').read()
new_head = '''<head>
<meta charset=\"UTF-8\">
<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">
<title>JPG to PDF Converter Free Online — Convert Images to PDF | CalcNation</title>
<meta name=\"description\" content=\"Convert JPG, PNG, WebP images to PDF online for free. Combine multiple images into one PDF. No upload to server — instant, private, no watermarks, no signup.\">
<meta name=\"keywords\" content=\"jpg to pdf, image to pdf converter online free, convert jpg to pdf, png to pdf, multiple images to pdf\">
<meta name=\"robots\" content=\"index, follow\">
<link rel=\"canonical\" href=\"https://calcnation-jade.vercel.app/pdf/jpg-to-pdf.html\">
<meta property=\"og:type\" content=\"website\">
<meta property=\"og:url\" content=\"https://calcnation-jade.vercel.app/pdf/jpg-to-pdf.html\">
<meta property=\"og:title\" content=\"JPG to PDF Free — Convert Images to PDF Online | CalcNation\">
<meta property=\"og:description\" content=\"Convert JPG, PNG, WebP to PDF. Combine multiple images. Free, instant, no watermarks.\">
<meta property=\"og:site_name\" content=\"CalcNation\">
<meta name=\"twitter:card\" content=\"summary\">
<script type=\"application/ld+json\">
{
  \"@context\": \"https://schema.org\",
  \"@type\": \"SoftwareApplication\",
  \"name\": \"JPG to PDF Converter\",
  \"applicationCategory\": \"UtilitiesApplication\",
  \"operatingSystem\": \"Web Browser\",
  \"offers\": { \"@type\": \"Offer\", \"price\": \"0\", \"priceCurrency\": \"USD\" },
  \"description\": \"Convert JPG, PNG, WebP images to a PDF document. Combine multiple images. No watermarks.\",
  \"url\": \"https://calcnation-jade.vercel.app/pdf/jpg-to-pdf.html\"
}
<\/script>
<link rel=\"icon\" type=\"image/svg+xml\" href=\"data:image/svg+xml,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 100 100'><text y='.9em' font-size='90'>⚡</text></svg>\">
<link rel=\"stylesheet\" href=\"../assets/css/main.css\">
</head>'''
result = re.sub(r'<head>.*?</head>', new_head, content, flags=re.DOTALL)
open('pdf/jpg-to-pdf.html', 'w').write(result)
print('✅ pdf/jpg-to-pdf.html updated')
"

echo ""
echo "🎉 All done! All 6 files updated successfully."
echo ""
echo "Now run:"
echo "  git add ."
echo "  git commit -m 'Phase 2: SEO, sitemap, robots.txt, schema markup'"
echo "  git push"
