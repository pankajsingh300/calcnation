# CalcNation — Site Navigation & URLs

## Production URL
- **Live Site**: https://calcnation-jade.vercel.app

---

## Main Pages

### Homepage & Core
- **Homepage**: `/index.html` or `/` 
- **About**: `/about.html`
- **Privacy Policy**: `/privacy.html`
- **Contact**: `/contact.html`
- **Blog Hub**: `/blog/`

---

## Blog Articles (6 Articles)

1. **Playwright for Beginners** → `/blog/playwright-beginners-guide.html`
   - Keywords: Playwright, E2E testing, automation
   - Length: ~8 min read, 1500+ words

2. **Robot Framework Guide** → `/blog/robot-framework-guide.html`
   - Keywords: Robot Framework, keyword-driven, QA automation
   - Length: ~8 min read, 1500+ words

3. **API Testing Best Practices** → `/blog/api-testing-guide.html`
   - Keywords: API testing, REST, Postman, pytest, automation
   - Length: ~10 min read, 2000+ words

4. **Test Data Generation** → `/blog/test-data-strategies.html`
   - Keywords: Test data, Faker, mock APIs, fixtures, data-driven
   - Length: ~7 min read, 1200+ words

5. **CI/CD Automation** → `/blog/ci-cd-automation.html`
   - Keywords: GitHub Actions, CI/CD, Playwright, automation
   - Length: ~9 min read, 1600+ words

6. **Selector Strategy** → `/blog/selector-strategy.html`
   - Keywords: CSS selectors, XPath, test automation, flaky tests
   - Length: ~6 min read, 1000+ words

---

## Finance Tools

- **Mortgage Calculator**: `/finance/mortgage-calculator.html`
- **EMI Calculator**: `/finance/emi-calculator.html`
- **Compound Interest**: `/finance/compound-interest-calculator.html`
- **Tip Calculator**: `/tools/tip-calculator.html`

All support 6 currencies: USD, EUR, GBP, INR, JPY, AUD

---

## PDF Tools (8 Tools)

- **Compress PDF**: `/pdf/compress.html`
- **Merge PDF**: `/pdf/merge.html`
- **Split PDF**: `/pdf/split.html`
- **PDF to JPG**: `/pdf/pdf-to-jpg.html`
- **JPG to PDF**: `/pdf/jpg-to-pdf.html`
- **PDF to Word**: `/pdf/pdf-to-word.html`
- **Rotate PDF**: `/pdf/rotate.html`
- **Unlock PDF**: `/pdf/unlock.html`

---

## Developer Tools (6 Tools)

- **JSON Formatter**: `/dev/json-formatter.html`
- **Base64 Encoder**: `/dev/base64.html`
- **Regex Tester**: `/dev/regex-tester.html`
- **URL Encoder**: `/dev/url-encoder.html`
- **JWT Decoder**: `/dev/jwt-decoder.html`
- **UUID Generator**: `/dev/uuid.html`

---

## Health Tools (5 Tools)

- **BMI Calculator**: `/tools/bmi-calculator.html`
- **Calorie Calculator**: `/health/calorie-calculator.html`
- **Pregnancy Due Date**: `/health/pregnancy-due-date.html`
- **Water Intake Calculator**: `/health/water-calculator.html`
- **Age Calculator**: `/tools/age-calculator.html`

---

## General Tools (4 Tools)

- **QR Code Generator**: `/tools/qr-code-generator.html`
- **Password Generator**: `/tools/password-generator.html`
- **Word Counter**: `/tools/word-counter.html`
- **Character Counter**: `/tools/character-counter.html`

---

## Social Media Tools (13 Tools)

- **YouTube Money Calculator**: `/social/youtube-money-calculator.html`
- **YouTube CPM Calculator**: `/social/youtube-cpm-calculator.html`
- **YouTube Channel Analyzer**: `/social/youtube-channel-analyzer.html`
- **YouTube Title Generator**: `/social/youtube-title-generator.html`
- **YouTube Tag Generator**: `/social/youtube-tag-generator.html`
- **YouTube Thumbnail Resizer**: `/social/youtube-thumbnail-resizer.html`
- **TikTok Money Calculator**: `/social/tiktok-money-calculator.html`
- **Instagram Engagement Calculator**: `/social/instagram-engagement.html`
- **Influencer Earnings**: `/social/influencer-earnings.html`
- **Best Time to Post**: `/social/best-time-to-post.html`
- **Caption Generator**: `/social/caption-generator.html`
- **Hashtag Generator**: `/social/hashtag-generator.html`
- **Social Media Image Resizer**: `/social/social-media-image-resizer.html`

---

## Automation Tools (3 Tools - Placeholder, Ready for Implementation)

- **Test Data Generator**: `/automation/test-data-generator.html` (create)
- **Selector Inspector**: `/automation/selector-inspector.html` (create)
- **API Mock Server**: `/automation/api-mock.html` (create)

---

## SEO & Utilities

- **Sitemap**: `/sitemap.xml`
- **Robots.txt**: `/robots.txt`
- **Tools Master List**: `/tools.json` (JSON config, 30+ tools)
- **Google Analytics**: Integrated (UA tracking ID needed)

---

## Local Testing

### Prerequisites
- Node.js 14+ (for testing)
- Python 3 (for http.server)

### Run Locally
```bash
# Option 1: Python simple server
cd calcnation/
python -m http.server 8000

# Option 2: VS Code Live Server
# Right-click index.html → "Open with Live Server"

# Option 3: Node.js http-server
npx http-server
```

Visit: `http://localhost:8000` (or `http://localhost:5500` for Live Server)

### Run Tests
```bash
npm install
npm test
```

---

## Quick Links for SEO Content

### Automation Testing Keywords
- Playwright testing
- Robot Framework automation
- API testing guide
- Test automation best practices
- E2E testing tutorial
- QA automation
- Selenium alternatives
- Test data generation

### Developer Keywords
- JSON formatter
- Base64 encoder
- URL encoder
- JWT decoder
- Regex tester
- UUID generator

### Finance Keywords
- Mortgage calculator
- EMI calculator
- Loan calculator
- Compound interest calculator
- Financial planning tools

---

## Common Tasks

### View All Tools
Visit homepage search bar or `/index.html` and browse by category

### Access Blog
- Hub: `/blog/`
- Individual articles: `/blog/{article-name}.html`

### Update Tools
Edit `/tools.json` and run `./update-seo.sh`

### Add New Blog Article
1. Create new HTML file in `/blog/`
2. Use existing blog article as template
3. Add card entry to `/blog/index.html`
4. Commit and push to GitHub

### Test Multi-Currency
1. Open any finance calculator
2. Click currency dropdown (top-right)
3. Select different currency
4. Refresh—it remembers your choice via localStorage

---

## File Management

### Adding a New Tool
1. Create HTML file in appropriate category folder
2. Add entry to `tools.json`: `{ "name": "...", "icon": "...", "cat": "...", "url": "..." }`
3. Update nav/footer manually if needed
4. Run `./update-seo.sh` to inject meta tags
5. Commit and push

### Updating SEO
```bash
./update-seo.sh
```
This auto-generates meta tags for all pages using tools.json

---

## API Endpoints & Data Sources

**All processing is client-side. No external APIs needed except:**

- Google Fonts (via CDN)
- Google Analytics (optional, UA-XXXXX-Y)
- Unpkg.com (for optional libraries)

**Tools use:**
- pdf-lib.min.js — PDF processing in browser
- pdfjs — PDF parsing
- jszip — File compression
- All run locally in browser

---

## Troubleshooting

### Currency Conversion Not Working
- Clear localStorage: DevTools → Application → Clear all
- Refresh page
- Try again

### Blog Links Returning 404
- Verify file exists in `/blog/`
- Check relative paths `../` are correct
- Ensure HTML files are committed to git

### Tools Not Appearing in Search
- Check `tools.json` for correct structure
- Verify `allTools` array is loaded (view console)
- Refresh browser

### PDF Tools Not Working
- Requires HTTPS or localhost (security restriction)
- Check browser console for errors
- May need to use Live Server locally

---

## Deployment

### Current Host
- **Vercel** (automatic deployment from GitHub)
- Connected to: github.com/pankajsingh300/calcnation

### Deploy Steps
```bash
git add .
git commit -m "Your message"
git push origin main
# Vercel auto-deploys from main branch
```

### Custom Domain
Configure in Vercel dashboard → Settings → Domains

---

## Support

- **Website**: calcnation-jade.vercel.app
- **GitHub**: github.com/pankajsingh300/calcnation
- **Contact Form**: `/contact.html`
- **Email**: hello@calcnation.com (add in contact form)

---

**Last Updated**: January 2026
