#!/usr/bin/env python3
"""
CalcNation — Add Internal Linking
Adds a "Related Tools" section to every page that doesn't have one.
Run from project root: python3 add-internal-links.py
"""

import os, re

# ── Related tools map ──────────────────────────────────────────────────────
RELATED = {
    # Finance
    "finance/emi-calculator.html": [
        ("🏠", "Mortgage Calculator", "/finance/mortgage-calculator.html"),
        ("📈", "Compound Interest", "/finance/compound-interest-calculator.html"),
        ("💵", "Tip Calculator", "/tools/tip-calculator.html"),
    ],
    "finance/mortgage-calculator.html": [
        ("📋", "EMI Calculator", "/finance/emi-calculator.html"),
        ("📈", "Compound Interest", "/finance/compound-interest-calculator.html"),
        ("💵", "Tip Calculator", "/tools/tip-calculator.html"),
    ],
    "finance/compound-interest-calculator.html": [
        ("📋", "EMI Calculator", "/finance/emi-calculator.html"),
        ("🏠", "Mortgage Calculator", "/finance/mortgage-calculator.html"),
        ("💵", "Tip Calculator", "/tools/tip-calculator.html"),
    ],
    # Health
    "health/calorie-calculator.html": [
        ("⚖️", "BMI Calculator", "/tools/bmi-calculator.html"),
        ("💧", "Water Intake", "/health/water-calculator.html"),
        ("👶", "Pregnancy Due Date", "/health/pregnancy-due-date.html"),
    ],
    "health/water-calculator.html": [
        ("🔥", "Calorie Calculator", "/health/calorie-calculator.html"),
        ("⚖️", "BMI Calculator", "/tools/bmi-calculator.html"),
        ("🎂", "Age Calculator", "/tools/age-calculator.html"),
    ],
    "health/pregnancy-due-date.html": [
        ("💧", "Water Intake", "/health/water-calculator.html"),
        ("🔥", "Calorie Calculator", "/health/calorie-calculator.html"),
        ("⚖️", "BMI Calculator", "/tools/bmi-calculator.html"),
    ],
    # Tools
    "tools/bmi-calculator.html": [
        ("🔥", "Calorie Calculator", "/health/calorie-calculator.html"),
        ("💧", "Water Intake", "/health/water-calculator.html"),
        ("🎂", "Age Calculator", "/tools/age-calculator.html"),
    ],
    "tools/qr-code-generator.html": [
        ("▌▌", "Barcode Generator", "/tools/barcode-generator.html"),
        ("🔐", "Password Generator", "/tools/password-generator.html"),
        ("📝", "Word Counter", "/tools/word-counter.html"),
    ],
    "tools/password-generator.html": [
        ("📱", "QR Generator", "/tools/qr-code-generator.html"),
        ("▌▌", "Barcode Generator", "/tools/barcode-generator.html"),
        ("🔡", "Case Converter", "/tools/text-case-converter.html"),
    ],
    "tools/word-counter.html": [
        ("🔢", "Character Counter", "/tools/character-counter.html"),
        ("🔡", "Case Converter", "/tools/text-case-converter.html"),
        ("📱", "QR Generator", "/tools/qr-code-generator.html"),
    ],
    "tools/character-counter.html": [
        ("📝", "Word Counter", "/tools/word-counter.html"),
        ("🔡", "Case Converter", "/tools/text-case-converter.html"),
        ("📱", "QR Generator", "/tools/qr-code-generator.html"),
    ],
    "tools/age-calculator.html": [
        ("⚖️", "BMI Calculator", "/tools/bmi-calculator.html"),
        ("🔥", "Calorie Calculator", "/health/calorie-calculator.html"),
        ("👶", "Pregnancy Due Date", "/health/pregnancy-due-date.html"),
    ],
    "tools/tip-calculator.html": [
        ("📋", "EMI Calculator", "/finance/emi-calculator.html"),
        ("🏠", "Mortgage Calculator", "/finance/mortgage-calculator.html"),
        ("📈", "Compound Interest", "/finance/compound-interest-calculator.html"),
    ],
    "tools/love-calculator.html": [
        ("🎯", "Name Picker", "/tools/random-name-picker.html"),
        ("👥", "Team Generator", "/tools/random-team-generator.html"),
        ("🎲", "Dice Roller", "/tools/dice-roller.html"),
    ],
    "tools/random-name-picker.html": [
        ("👥", "Team Generator", "/tools/random-team-generator.html"),
        ("❤️", "Love Calculator", "/tools/love-calculator.html"),
        ("🎲", "Dice Roller", "/tools/dice-roller.html"),
    ],
    "tools/random-team-generator.html": [
        ("🎯", "Name Picker", "/tools/random-name-picker.html"),
        ("🎲", "Dice Roller", "/tools/dice-roller.html"),
        ("❤️", "Love Calculator", "/tools/love-calculator.html"),
    ],
    "tools/dice-roller.html": [
        ("🎯", "Name Picker", "/tools/random-name-picker.html"),
        ("👥", "Team Generator", "/tools/random-team-generator.html"),
        ("❤️", "Love Calculator", "/tools/love-calculator.html"),
    ],
    "tools/barcode-generator.html": [
        ("📱", "QR Generator", "/tools/qr-code-generator.html"),
        ("🔐", "Password Generator", "/tools/password-generator.html"),
        ("📝", "Word Counter", "/tools/word-counter.html"),
    ],
    "tools/text-case-converter.html": [
        ("📝", "Word Counter", "/tools/word-counter.html"),
        ("🔢", "Character Counter", "/tools/character-counter.html"),
        ("📱", "QR Generator", "/tools/qr-code-generator.html"),
    ],
    "tools/fake-address-generator.html": [
        ("📱", "QR Generator", "/tools/qr-code-generator.html"),
        ("🔐", "Password Generator", "/tools/password-generator.html"),
        ("▌▌", "Barcode Generator", "/tools/barcode-generator.html"),
    ],
    # PDF
    "pdf/compress.html": [
        ("📎", "Merge PDF", "/pdf/merge.html"),
        ("✂️", "Split PDF", "/pdf/split.html"),
        ("🖼️", "PDF to JPG", "/pdf/pdf-to-jpg.html"),
    ],
    "pdf/merge.html": [
        ("🗜️", "Compress PDF", "/pdf/compress.html"),
        ("✂️", "Split PDF", "/pdf/split.html"),
        ("📝", "PDF to Word", "/pdf/pdf-to-word.html"),
    ],
    "pdf/split.html": [
        ("🗜️", "Compress PDF", "/pdf/compress.html"),
        ("📎", "Merge PDF", "/pdf/merge.html"),
        ("🖼️", "PDF to JPG", "/pdf/pdf-to-jpg.html"),
    ],
    "pdf/pdf-to-jpg.html": [
        ("📷", "JPG to PDF", "/pdf/jpg-to-pdf.html"),
        ("🗜️", "Compress PDF", "/pdf/compress.html"),
        ("📝", "PDF to Word", "/pdf/pdf-to-word.html"),
    ],
    "pdf/jpg-to-pdf.html": [
        ("🖼️", "PDF to JPG", "/pdf/pdf-to-jpg.html"),
        ("🗜️", "Compress PDF", "/pdf/compress.html"),
        ("📎", "Merge PDF", "/pdf/merge.html"),
    ],
    "pdf/pdf-to-word.html": [
        ("🗜️", "Compress PDF", "/pdf/compress.html"),
        ("📎", "Merge PDF", "/pdf/merge.html"),
        ("🖼️", "PDF to JPG", "/pdf/pdf-to-jpg.html"),
    ],
    "pdf/unlock.html": [
        ("🗜️", "Compress PDF", "/pdf/compress.html"),
        ("📎", "Merge PDF", "/pdf/merge.html"),
        ("✂️", "Split PDF", "/pdf/split.html"),
    ],
    "pdf/watermark.html": [
        ("🗜️", "Compress PDF", "/pdf/compress.html"),
        ("📎", "Merge PDF", "/pdf/merge.html"),
        ("🔒", "Unlock PDF", "/pdf/unlock.html"),
    ],
    "pdf/rotate.html": [
        ("🗜️", "Compress PDF", "/pdf/compress.html"),
        ("✂️", "Split PDF", "/pdf/split.html"),
        ("📎", "Merge PDF", "/pdf/merge.html"),
    ],
    # Dev
    "dev/json-formatter.html": [
        ("📄", "XML Formatter", "/dev/xml-formatter.html"),
        ("</>", "HTML Formatter", "/dev/html-formatter.html"),
        ("🔍", "Diff Checker", "/dev/diff-checker.html"),
    ],
    "dev/base64.html": [
        ("🔗", "URL Encoder", "/dev/url-encoder.html"),
        ("#", "Hash Generator", "/dev/hash-generator.html"),
        ("🔑", "JWT Decoder", "/dev/jwt-decoder.html"),
    ],
    "dev/regex-tester.html": [
        ("{}", "JSON Formatter", "/dev/json-formatter.html"),
        ("🔍", "Diff Checker", "/dev/diff-checker.html"),
        ("📄", "Markdown", "/dev/markdown.html"),
    ],
    "dev/jwt-decoder.html": [
        ("#", "Hash Generator", "/dev/hash-generator.html"),
        ("🔗", "URL Encoder", "/dev/url-encoder.html"),
        ("🆔", "UUID Generator", "/dev/uuid.html"),
    ],
    "dev/uuid.html": [
        ("🔑", "JWT Decoder", "/dev/jwt-decoder.html"),
        ("#", "Hash Generator", "/dev/hash-generator.html"),
        ("🔗", "URL Encoder", "/dev/url-encoder.html"),
    ],
    # Social
    "social/youtube-money-calculator.html": [
        ("📊", "CPM Calculator", "/social/youtube-cpm-calculator.html"),
        ("🎵", "TikTok Earnings", "/social/tiktok-money-calculator.html"),
        ("⭐", "Influencer Earnings", "/social/influencer-earnings.html"),
    ],
    "social/youtube-cpm-calculator.html": [
        ("💰", "YouTube Money", "/social/youtube-money-calculator.html"),
        ("🎵", "TikTok Earnings", "/social/tiktok-money-calculator.html"),
        ("⭐", "Influencer Earnings", "/social/influencer-earnings.html"),
    ],
    "social/tiktok-money-calculator.html": [
        ("💰", "YouTube Money", "/social/youtube-money-calculator.html"),
        ("📸", "Instagram Engagement", "/social/instagram-engagement.html"),
        ("⭐", "Influencer Earnings", "/social/influencer-earnings.html"),
    ],
    "social/instagram-engagement.html": [
        ("📸", "Instagram Engagement", "/social/instagram-engagement.html"),
        ("💰", "YouTube Money", "/social/youtube-money-calculator.html"),
        ("🎵", "TikTok Earnings", "/social/tiktok-money-calculator.html"),
    ],
    "social/hashtag-generator.html": [
        ("💬", "Caption Generator", "/social/caption-generator.html"),
        ("🕐", "Best Time to Post", "/social/best-time-to-post.html"),
        ("📐", "Image Resizer", "/social/social-media-image-resizer.html"),
    ],
}

# ── HTML template ──────────────────────────────────────────────────────────
def build_related(tools):
    cards = ""
    for emoji, name, url in tools:
        cards += f'<a href="{url}" class="related-card"><span class="related-card-icon">{emoji}</span><span class="related-card-name">{name}</span></a>\n    '
    return f"""<div class="related-tools"><h2>Related Tools</h2><div class="related-grid">
    {cards}</div></div>"""

# ── Main ───────────────────────────────────────────────────────────────────
fixed = 0
for filepath, tools in RELATED.items():
    if not os.path.exists(filepath):
        print(f"⚠️  Not found: {filepath}")
        continue

    content = open(filepath, encoding='utf-8').read()

    # Skip if already has related tools
    if 'related-tools' in content:
        print(f"⏭️  Already has related: {filepath}")
        continue

    related_html = build_related(tools)
    content = content.replace('</main>', related_html + '\n</main>', 1)
    open(filepath, 'w', encoding='utf-8').write(content)
    print(f"✅ Done: {filepath}")
    fixed += 1

print(f"\n🎉 Internal links added to {fixed} pages!")
print("\nPush to GitHub:")
print("  git add -A")
print('  git commit -m "SEO: add internal linking to all tool pages"')
print("  git push")
