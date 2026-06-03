# 🎯 MegaMap Lock - Configuration Checklist

## ✅ Setup Checklist

### Phase 1: Initial Setup
- [ ] Repository is on GitHub (public or private)
- [ ] Clone the megamap-lock repository to your machine
- [ ] You have admin access to megamap-lock repository
- [ ] You have read access to MEGAMAP repository

### Phase 2: GitHub Pages
- [ ] Go to repository **Settings** → **Pages**
- [ ] Select "Deploy from a branch"
- [ ] Choose branch: `master` (or `main`)
- [ ] Choose folder: `/(root)`
- [ ] Click **Save**
- [ ] Wait ~1-2 minutes for deployment
- [ ] Verify site is live at: `https://[USERNAME].github.io/megamap-lock/`

### Phase 3: Environment Variables
- [ ] Go to repository **Settings** → **Variables**
- [ ] Create variable: `MEGAMAP_OWNER`
  - Value: (e.g., `ShebaMicrobiomeCenter`)
- [ ] Create variable: `MEGAMAP_REPO`
  - Value: (e.g., `MEGAMAP`)
- [ ] Create variable: `MEGAMAP_FILE_PATH`
  - Value: (e.g., `data/latest-light.csv.enc`)

### Phase 4: Authentication (If MEGAMAP is Private)
- [ ] Go to GitHub **Settings** → **Developer settings** → **Personal access tokens** → **Tokens (classic)**
- [ ] Click **Generate new token (classic)**
- [ ] Name: "megamap-sync"
- [ ] Check permission: `repo` (full repository access)
- [ ] Click **Generate token**
- [ ] **Copy the token** (you won't see it again!)
- [ ] Go to megamap-lock **Settings** → **Secrets and variables** → **Actions**
- [ ] Click **New repository secret**
- [ ] Name: `MEGAMAP_TOKEN`
- [ ] Value: [paste your token]

### Phase 5: Test the Workflow
- [ ] Go to megamap-lock **Actions** tab
- [ ] Find "Sync Encrypted File from MEGAMAP"
- [ ] Click **Run workflow** → **Run workflow**
- [ ] Wait for completion (should take 30 seconds - 2 minutes)
- [ ] Check if the `.enc` file appears in your repository
- [ ] Verify GitHub Pages shows the new file

### Phase 6: Verify Everything Works
- [ ] Open your GitHub Pages URL: `https://[USERNAME].github.io/megamap-lock/`
- [ ] You should see the MegaMap interface
- [ ] Select the `.enc` file that was downloaded
- [ ] Enter the password for that file
- [ ] Click "פענוח וצפייה"
- [ ] Data should appear in a table
- [ ] Try searching and filtering
- [ ] Download as CSV to test export

---

## 📋 Reference Variables

Copy these as needed:

**For MEGAMAP Repository:**
```
MEGAMAP_OWNER = ShebaMicrobiomeCenter
MEGAMAP_REPO = megamap
MEGAMAP_FILE_PATH = latest-light.csv.enc
```

**For GitHub Token (if private):**
```
Select permissions:
✓ repo (full control of private repositories)
✓ read:user
```

---

## 🔍 Verification URLs

Paste your username in place of `[USERNAME]`:

- **Your Repository:** `https://github.com/[USERNAME]/megamap-lock`
- **GitHub Pages Site:** `https://[USERNAME].github.io/megamap-lock/`
- **Settings > Pages:** `https://github.com/[USERNAME]/megamap-lock/settings/pages`
- **Settings > Variables:** `https://github.com/[USERNAME]/megamap-lock/settings/variables`
- **Settings > Secrets:** `https://github.com/[USERNAME]/megamap-lock/settings/secrets/actions`
- **Actions Tab:** `https://github.com/[USERNAME]/megamap-lock/actions`

---

## 🆘 Quick Troubleshooting

### "Workflow failed"
→ Check **Actions** tab, click the failed run, view logs

### "Repository not found"
→ Verify `MEGAMAP_OWNER` and `MEGAMAP_REPO` are correct

### "Authentication failed"
→ Verify GitHub token has `repo` permission (not expired)

### "Pages not loading"
→ Check **Settings > Pages** is enabled and deployment succeeded

### "Can't decrypt file"
→ Verify password is correct, file was encrypted with same password

---

## 📞 Need Help?

1. **Read:** [SETUP_GITHUB_ACTION.md](SETUP_GITHUB_ACTION.md) - Complete guide in Hebrew
2. **Check:** [SETUP_SUMMARY.md](SETUP_SUMMARY.md) - Overview of what was set up
3. **Browse:** GitHub Actions logs for specific error messages
4. **GitHub Docs:** https://docs.github.com/en/actions

---

## 🔐 Remember

- 🔑 Store your GitHub token securely (don't share)
- 🔐 Use a strong password for encryption
- 📝 Write down which password goes with which file
- 🗑️ Delete tokens if you don't need them anymore
- 📋 Keep this checklist for future reference
