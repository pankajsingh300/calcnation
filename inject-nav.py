#!/usr/bin/env python3
"""
Run from project root: python3 inject-nav.py
- Removes any existing inline <nav>...</nav> blocks
- Adds <script src="/assets/js/nav-loader.js"> before </body>
- Appends nav CSS to main.css if not already there
"""
import os, re

NAV_SCRIPT = '<script src="/assets/js/nav-loader.js"></script>'
NAV_CSS_LINK = '<link rel="stylesheet" href="/assets/css/main.css">'

fixed = 0
skipped = 0

for root, dirs, files in os.walk('.'):
    dirs[:] = [d for d in dirs if d not in ['.git', 'node_modules']]
    for f in files:
        if not f.endswith('.html'):
            continue
        path = os.path.join(root, f)
        try:
            content = open(path, encoding='utf-8').read()
        except:
            continue

        changed = False

        # 1. Remove existing inline <nav>...</nav>
        cleaned = re.sub(r'<nav[\s\S]*?</nav>', '', content, flags=re.DOTALL)
        if cleaned != content:
            content = cleaned
            changed = True

        # 2. Add nav-loader.js before </body> if not already there
        if NAV_SCRIPT not in content and '</body>' in content:
            content = content.replace('</body>', NAV_SCRIPT + '\n</body>', 1)
            changed = True

        if changed:
            open(path, 'w', encoding='utf-8').write(content)
            print(f'✅ {path}')
            fixed += 1
        else:
            skipped += 1

print(f'\n🎉 Done! Fixed: {fixed}, Skipped: {skipped}')
print('\nNext steps:')
print('  git add -A')
print('  git commit -m "feat: inject shared nav on all pages via nav-loader.js"')
print('  git push')
