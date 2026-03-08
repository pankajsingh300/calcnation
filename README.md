# ⚡ CalcNation — Phase 1 Complete

> 📁 **tools.json** now holds the master list of every tool. The homepage search script fetches it automatically, so you only need to update one file when adding or removing tools.


## What's Built in This Package

```
calcnation/
├── index.html                  ← Homepage with search, category cards, popular tools
├── assets/
│   ├── css/main.css            ← All shared styles
│   └── js/utils.js             ← Shared JavaScript utilities
└── pdf/
    ├── compress.html           ← ✅ Compress PDF (fully working)
    ├── merge.html              ← ✅ Merge PDF (fully working, drag to reorder)
    ├── split.html              ← ✅ Split PDF (fully working, page ranges)
    ├── pdf-to-jpg.html         ← ✅ PDF to JPG (fully working, with ZIP download)
    ├── jpg-to-pdf.html         ← ✅ JPG to PDF (fully working, multiple images)
    └── pdf-to-word.html        ← 🚧 Coming in Phase 2
```

---

## 🚀 HOW TO DEPLOY (Step by Step)

### Step 1 — Install Required Tools
Download and install these (all free):
- **VS Code**: https://code.visualstudio.com/
- **Git**: https://git-scm.com/
- **Node.js**: https://nodejs.org/

### Step 2 — Create Accounts (All Free)
- **GitHub**: https://github.com (for storing code)
- **Vercel**: https://vercel.com (for hosting — free forever for this type of site)

### Step 3 — Set Up GitHub
```bash
# Open terminal / command prompt and run:
git init
git add .
git commit -m "Phase 1: Homepage + 5 PDF tools"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/calcnation.git
git push -u origin main
```

### Step 4 — Deploy to Vercel
1. Go to https://vercel.com
2. Click "New Project"
3. Connect your GitHub account
4. Select the calcnation repository
5. Click Deploy → Your site is LIVE in 60 seconds!

### Step 5 — Connect Your Domain
1. Buy your domain on GoDaddy/Namecheap (₹800–1200/year)
2. In Vercel → Settings → Domains → Add your domain
3. Follow the DNS instructions Vercel gives you
4. Done — usually takes 10–30 minutes to go live

---

## 🌐 What's Fully Working Right Now

| Tool | Status | Feature |
|------|--------|---------|
| Homepage | ✅ | Search, category cards, animated |
| Compress PDF | ✅ | Upload → compress → download |
| Merge PDF | ✅ | Multiple files, drag to reorder |
| Split PDF | ✅ | Page ranges, every N pages, all pages |
| PDF to JPG | ✅ | Choose DPI, quality, download ZIP |
| JPG to PDF | ✅ | Multiple images, drag to reorder |

All tools:
- Work 100% in browser (no server)
- Files never leave device
- Mobile responsive
- SEO titles and meta descriptions set

---

## 📋 WHAT TO DO NEXT (Your Checklist)

### Day 1
- [ ] Install VS Code, Git, Node.js
- [ ] Create GitHub account
- [ ] Create Vercel account
- [ ] Upload code to GitHub
- [ ] Deploy to Vercel (free URL like calcnation.vercel.app)
- [ ] Test all 5 tools work correctly

### Day 2–3
- [ ] Buy your domain name (calcnation.com or similar)
- [ ] Connect domain to Vercel
- [ ] Create Google Search Console account
- [ ] Submit your sitemap

### Week 2
- [ ] Come back to Claude and say "Let's do Phase 2 SEO setup"

---

## 💬 How to Continue with Claude

Every time you come back, tell Claude:

> "I am building CalcNation.com — a multi-niche tools website with PDF tools,
> developer tools, finance calculators and health calculators. I am a software
> engineer targeting global English audience for passive income.
> Currently on Phase [X] of 8."

Then say what you want to build next.

---

## 🐛 Common Issues & Fixes

**Site not loading locally?**
Just open index.html directly in Chrome. No server needed.

**PDF tool not working?**
Some PDF features need the site to run on a server (not file://). 
Use VS Code Live Server extension, or deploy to Vercel first.

**Files too big for GitHub?**
Run: `git lfs install` to handle large files.

---

Built with ❤️ by Claude AI — Anthropic
