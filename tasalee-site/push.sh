#!/usr/bin/env bash
# One time setup. Create the repository first at https://github.com/new
# named tasalee-site, Public, with no README, no .gitignore and no licence.
set -e
REPO="${1:-https://github.com/shubhammalik1684/tasalee-site.git}"
git remote remove origin 2>/dev/null || true
git remote add origin "$REPO"
git branch -M main
git push -u origin main
echo
echo "Pushed. Now: Settings, Pages, deploy from branch main, folder root."
echo "Then set the custom domain to tasalee.online and add the DNS records"
echo "listed in GO-LIVE.md."
