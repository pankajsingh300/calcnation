#!/usr/bin/env python3
"""
CalcNation — Add FAQ + Schema markup to tool pages
Run from project root: python3 add-faq-schema.py
"""

import os, re

# ── FAQ + Schema data for each tool ──────────────────────────────────────────

TOOLS = {
    "finance/emi-calculator.html": {
        "schema_name": "EMI Calculator",
        "schema_desc": "Free online EMI calculator for personal, home, car and education loans. Calculate monthly installment, total interest and total payment instantly.",
        "schema_type": "FinanceApplication",
        "faqs": [
            ("What is EMI?", "EMI (Equated Monthly Installment) is a fixed monthly payment made to a lender to repay a loan over a set period. It includes both principal and interest components."),
            ("What is the formula used to calculate EMI?", "EMI = P × r × (1+r)^n / ((1+r)^n - 1), where P is the principal loan amount, r is the monthly interest rate (annual rate ÷ 12 ÷ 100), and n is the tenure in months."),
            ("How can I reduce my EMI?", "You can reduce EMI by increasing the loan tenure, making a larger down payment to reduce the principal, negotiating a lower interest rate, or prepaying part of the loan."),
            ("Is this EMI calculator free to use?", "Yes, CalcNation's EMI calculator is completely free. No signup, no hidden charges. Results are instant and calculated directly in your browser."),
            ("Can I use this for home loan, car loan and personal loan?", "Yes. This calculator works for any type of loan — home loan, car loan, personal loan, education loan. Just enter the loan amount, interest rate and tenure."),
        ]
    },
    "finance/mortgage-calculator.html": {
        "schema_name": "Mortgage Calculator",
        "schema_desc": "Free mortgage calculator to calculate monthly payments, total interest and amortization schedule for home loans.",
        "schema_type": "FinanceApplication",
        "faqs": [
            ("What is a mortgage calculator?", "A mortgage calculator helps you estimate your monthly home loan payments based on the loan amount, interest rate, loan term, and down payment."),
            ("What is the formula for mortgage calculation?", "Monthly Payment = P × r × (1+r)^n / ((1+r)^n - 1), where P is the loan principal (home value minus down payment), r is the monthly interest rate, and n is the total number of payments."),
            ("What is an amortization schedule?", "An amortization schedule shows each monthly payment broken down into principal and interest portions, and the remaining loan balance after each payment."),
            ("How much down payment do I need?", "Typically lenders require 10–20% down payment. A higher down payment reduces your monthly EMI and total interest paid over the loan term."),
            ("Is this mortgage calculator free?", "Yes, completely free. No registration required. All calculations happen instantly in your browser with no data sent to any server."),
        ]
    },
    "finance/compound-interest-calculator.html": {
        "schema_name": "Compound Interest Calculator",
        "schema_desc": "Free compound interest calculator to see how investments grow over time with monthly contributions and compounding.",
        "schema_type": "FinanceApplication",
        "faqs": [
            ("What is compound interest?", "Compound interest is interest calculated on both the initial principal and the accumulated interest from previous periods. It causes investments to grow exponentially over time."),
            ("What is the compound interest formula?", "A = P × (1 + r/n)^(nt), where A is the final amount, P is the principal, r is the annual interest rate, n is the number of times interest compounds per year, and t is the time in years."),
            ("What is the difference between compound and simple interest?", "Simple interest is calculated only on the principal. Compound interest is calculated on the principal plus accumulated interest, making it grow much faster over time."),
            ("How do monthly contributions affect growth?", "Regular monthly contributions significantly boost your final investment value through the power of compounding. Even small monthly amounts can make a huge difference over 10–20 years."),
            ("Is this investment calculator free?", "Yes, completely free to use. No signup needed. All calculations are done instantly in your browser."),
        ]
    },
    "tools/bmi-calculator.html": {
        "schema_name": "BMI Calculator",
        "schema_desc": "Free BMI calculator to check your Body Mass Index. Instantly find out if you are underweight, normal, overweight or obese.",
        "schema_type": "HealthApplication",
        "faqs": [
            ("What is BMI?", "BMI (Body Mass Index) is a measure of body fat based on height and weight. It is used to categorize individuals as underweight, normal weight, overweight, or obese."),
            ("What is the BMI formula?", "BMI = weight (kg) ÷ height (m)². For example, a person weighing 70kg at 1.75m height has a BMI of 70 ÷ (1.75 × 1.75) = 22.9."),
            ("What are the BMI categories?", "Underweight: below 18.5 | Normal weight: 18.5–24.9 | Overweight: 25–29.9 | Obese: 30 and above. These are standard WHO classifications."),
            ("Is BMI an accurate measure of health?", "BMI is a useful screening tool but has limitations. It does not account for muscle mass, age, sex, or body fat distribution. Consult a doctor for a complete health assessment."),
            ("Is this BMI calculator free?", "Yes, completely free with no signup required. Supports both metric (kg/cm) and imperial (lbs/inches) units."),
        ]
    },
    "health/calorie-calculator.html": {
        "schema_name": "Calorie Calculator",
        "schema_desc": "Free daily calorie calculator based on age, weight, height and activity level. Find your TDEE and calorie needs for weight loss or gain.",
        "schema_type": "HealthApplication",
        "faqs": [
            ("How are daily calorie needs calculated?", "Daily calorie needs are calculated using the Mifflin-St Jeor equation to find BMR (Basal Metabolic Rate), then multiplied by an activity factor to get TDEE (Total Daily Energy Expenditure)."),
            ("What is BMR?", "BMR (Basal Metabolic Rate) is the number of calories your body burns at complete rest to maintain basic functions like breathing, circulation and cell production."),
            ("How many calories should I eat to lose weight?", "A common approach is to create a 500 calorie daily deficit from your TDEE, which leads to approximately 0.5kg of weight loss per week. Always consult a nutritionist for personalised advice."),
            ("What is TDEE?", "TDEE (Total Daily Energy Expenditure) is the total number of calories you burn per day including all activities. Eating at your TDEE maintains your current weight."),
            ("Is this calorie calculator free?", "Yes, completely free. No account needed. Results are calculated instantly based on the Mifflin-St Jeor formula used by nutrition professionals worldwide."),
        ]
    },
    "tools/qr-code-generator.html": {
        "schema_name": "QR Code Generator",
        "schema_desc": "Free online QR code generator. Create QR codes for URLs, text, contact info instantly. Download as PNG. No signup required.",
        "schema_type": "WebApplication",
        "faqs": [
            ("What is a QR code?", "A QR code (Quick Response code) is a 2D barcode that can be scanned by smartphones to instantly open URLs, show text, share contact info, or trigger other actions."),
            ("How do I generate a QR code?", "Simply type or paste your URL or text into the input field and your QR code is generated instantly. Click download to save it as a PNG image."),
            ("Are QR codes generated here free to use?", "Yes, all QR codes generated on CalcNation are completely free. You can use them for personal or commercial purposes with no restrictions."),
            ("What can I encode in a QR code?", "You can encode website URLs, plain text, email addresses, phone numbers, SMS messages, Wi-Fi credentials, and more."),
            ("Do QR codes expire?", "QR codes generated here are static and never expire. As long as the destination URL is active, the QR code will work forever."),
        ]
    },
    "social/youtube-money-calculator.html": {
        "schema_name": "YouTube Money Calculator",
        "schema_desc": "Free YouTube money calculator to estimate earnings from your YouTube channel based on views, CPM and engagement rate.",
        "schema_type": "WebApplication",
        "faqs": [
            ("How much does YouTube pay per 1000 views?", "YouTube typically pays between $0.5 to $6 per 1000 views (RPM) depending on your niche, audience location, and time of year. Finance and tech channels earn more; entertainment channels earn less."),
            ("How is YouTube revenue calculated?", "YouTube revenue = (Total Views ÷ 1000) × RPM. RPM (Revenue Per Mille) is your actual earnings per 1000 views after YouTube takes its 45% cut from the advertiser CPM."),
            ("What is CPM on YouTube?", "CPM (Cost Per Mille) is what advertisers pay per 1000 ad impressions. RPM is what creators actually receive, which is typically 45–55% of the CPM rate."),
            ("How many views do you need to make $1000 on YouTube?", "At an average RPM of $2, you need approximately 500,000 views to earn $1000. At $5 RPM (finance/tech niche), you would need around 200,000 views."),
            ("Is this YouTube earnings calculator accurate?", "This calculator provides estimates based on average industry CPM and RPM data. Actual earnings vary based on niche, audience geography, ad formats, and seasonality."),
        ]
    },
    "pdf/compress.html": {
        "schema_name": "Compress PDF",
        "schema_desc": "Free online PDF compressor. Reduce PDF file size without losing quality. No upload to server, 100% private, works in browser.",
        "schema_type": "WebApplication",
        "faqs": [
            ("How does PDF compression work?", "PDF compression reduces file size by optimising embedded images, removing redundant data, and compressing text streams. Our tool processes your file entirely in your browser."),
            ("Will compressing a PDF reduce its quality?", "Our compressor uses smart compression that significantly reduces file size while maintaining readable quality. For most documents, the visual difference is minimal."),
            ("Is my PDF safe when I compress it here?", "Yes, completely safe. Your PDF never leaves your device — all processing happens locally in your browser. No files are uploaded to any server."),
            ("What is the maximum PDF file size I can compress?", "Our browser-based compressor works best with PDFs up to 50MB. For larger files, compression may take a bit longer depending on your device."),
            ("Is this PDF compressor free?", "Yes, completely free. No signup, no watermarks, no file limits. Compress as many PDFs as you want at no cost."),
        ]
    },
}

# ── HTML templates ─────────────────────────────────────────────────────────

def build_schema(name, desc, app_type, faqs):
    faq_schema = []
    for q, a in faqs:
        faq_schema.append(f'''    {{
      "@type": "Question",
      "name": "{q}",
      "acceptedAnswer": {{"@type": "Answer", "text": "{a}"}}
    }}''')

    return f'''<script type="application/ld+json">
{{
  "@context": "https://schema.org",
  "@graph": [
    {{
      "@type": "WebApplication",
      "name": "{name}",
      "description": "{desc}",
      "applicationCategory": "{app_type}",
      "operatingSystem": "Any",
      "offers": {{"@type": "Offer", "price": "0", "priceCurrency": "USD"}},
      "url": "https://calcnation-jade.vercel.app"
    }},
    {{
      "@type": "FAQPage",
      "mainEntity": [
{chr(10).join(faq_schema)}
      ]
    }}
  ]
}}
</script>'''


def build_faq_html(faqs):
    items = ""
    for i, (q, a) in enumerate(faqs):
        items += f"""
  <div class="faq-item" onclick="toggleFaq(this)">
    <div class="faq-q">
      <span>{q}</span>
      <span class="faq-icon">+</span>
    </div>
    <div class="faq-a">{a}</div>
  </div>"""

    return f"""
<section class="faq-section">
  <h2>// Frequently Asked Questions</h2>
  <div class="faq-list">{items}
  </div>
</section>

<style>
.faq-section{{max-width:800px;margin:40px auto;padding:0 20px;}}
.faq-section h2{{font-size:13px;font-weight:700;color:var(--text3);text-transform:uppercase;letter-spacing:1.5px;margin-bottom:16px;}}
.faq-list{{display:flex;flex-direction:column;gap:8px;}}
.faq-item{{background:var(--bg2);border:1px solid var(--border);border-radius:var(--radius-sm);overflow:hidden;cursor:pointer;transition:border-color 0.2s;}}
.faq-item:hover{{border-color:var(--accent);}}
.faq-q{{display:flex;justify-content:space-between;align-items:center;padding:16px 20px;font-weight:600;font-size:15px;color:var(--text);gap:12px;}}
.faq-icon{{font-size:20px;color:var(--accent);flex-shrink:0;transition:transform 0.2s;}}
.faq-a{{display:none;padding:0 20px 16px;font-size:14px;color:var(--text3);line-height:1.7;}}
.faq-item.open .faq-a{{display:block;}}
.faq-item.open .faq-icon{{transform:rotate(45deg);}}
</style>

<script>
function toggleFaq(el){{el.classList.toggle('open');}}
</script>"""


# ── Main processing ────────────────────────────────────────────────────────

fixed = 0
for filepath, data in TOOLS.items():
    if not os.path.exists(filepath):
        print(f"⚠️  Not found: {filepath}")
        continue

    content = open(filepath, encoding='utf-8').read()

    # Skip if already has FAQ
    if 'faq-section' in content or 'FAQPage' in content:
        print(f"⏭️  Already has FAQ: {filepath}")
        continue

    # Build schema + FAQ HTML
    schema = build_schema(
        data['schema_name'],
        data['schema_desc'],
        data['schema_type'],
        data['faqs']
    )
    faq_html = build_faq_html(data['faqs'])

    # Insert schema before </head>
    content = content.replace('</head>', schema + '\n</head>', 1)

    # Insert FAQ before </main>
    content = content.replace('</main>', faq_html + '\n</main>', 1)

    open(filepath, 'w', encoding='utf-8').write(content)
    print(f"✅ Done: {filepath}")
    fixed += 1

print(f"\n🎉 FAQ + Schema added to {fixed} pages!")
print("\nPush to GitHub:")
print("  git add -A")
print('  git commit -m "SEO: add FAQ sections and Schema markup to 8 top tools"')
print("  git push")
