# 📚 MegaMap Lock Documentation Index

Welcome! Here's a guide to all the documentation files and what each one contains.

---

## 📖 Core Documentation

### 1. **[README.md](README.md)** 📝
**Main documentation - START HERE**
- Project overview and features
- Security details
- Local usage instructions
- Quick examples

### 2. **[SETUP_GITHUB_ACTION.md](SETUP_GITHUB_ACTION.md)** 🤖
**Complete GitHub Action setup guide (Hebrew)**
- Step-by-step setup instructions
- How to enable GitHub Pages
- Configure environment variables
- Authentication & tokens
- Running the workflows
- Troubleshooting guide

### 3. **[SETUP_SUMMARY.md](SETUP_SUMMARY.md)** ✅
**Executive summary of what was set up**
- List of all created workflows
- Quick start steps
- How everything works together
- Common tasks
- Security notes

### 4. **[CONFIGURATION_CHECKLIST.md](CONFIGURATION_CHECKLIST.md)** ✓
**Printable checklist for setup**
- Phase-by-phase setup checklist
- Quick reference variables
- Verification URLs
- Quick troubleshooting
- Emergency reference

---

## 🤖 GitHub Actions Workflows

These are automatic (and manual) processes that run in the cloud:

### **`.github/workflows/sync-encrypted-file.yml`**
🔄 Syncs encrypted file from MEGAMAP repository
- **Runs:** Daily at 00:00 UTC (or manually)
- **Does:** Downloads encrypted file and commits to megamap-lock
- **Requires:** Variables in Settings > Variables

### **`.github/workflows/encrypt-file.yml`**
🔐 Encrypts CSV files through GitHub UI
- **Runs:** Manual trigger through Actions UI
- **Does:** Takes a CSV URL, encrypts it, saves as .enc
- **Usage:** No command line needed!

### **`.github/workflows/deploy.yml`**
🚀 Deploys to GitHub Pages
- **Runs:** Every push to master/main
- **Does:** Publishes your site automatically

---

## 🛠️ Utility Files

### **`setup.sh`** 🚀
Interactive bash script to help configure the workflow.
```bash
bash setup.sh
```

### **`.gitignore`**
Prevents committing temporary files (but allows `.enc` files).

---

## 💻 Application Files

### **`index.html`**
The main web interface - what users see when they visit your site.
- Decryption form (Hebrew interface)
- Data table viewer
- Search & filter
- CSV export

### **`encrypt.js`**
Node.js command-line tool for encrypting CSV files locally.
```bash
node encrypt.js data.csv data.csv.enc "password"
```

---

## 🗺️ How to Navigate This Documentation

### "I'm just starting out"
1. Read: [README.md](README.md)
2. Follow: [SETUP_SUMMARY.md](SETUP_SUMMARY.md)
3. Use: [CONFIGURATION_CHECKLIST.md](CONFIGURATION_CHECKLIST.md)

### "I want detailed step-by-step instructions"
→ Read: [SETUP_GITHUB_ACTION.md](SETUP_GITHUB_ACTION.md)

### "I want a quick reference I can print"
→ Use: [CONFIGURATION_CHECKLIST.md](CONFIGURATION_CHECKLIST.md)

### "I'm troubleshooting an error"
1. Check: [SETUP_GITHUB_ACTION.md](SETUP_GITHUB_ACTION.md#troubleshooting)
2. Check: GitHub Actions logs
3. Check: Browser console (F12)

### "I want to understand the workflows"
→ Read: [SETUP_SUMMARY.md](SETUP_SUMMARY.md#-how-it-all-works-together)

---

## 🔐 Security & Privacy

All documentation follows these security principles:
- ✅ Encryption happens in browser (never on servers)
- ✅ Passwords are never transmitted
- ✅ GitHub tokens have minimal permissions
- ✅ Temporary files are cleaned up
- ✅ All information is transparent

---

## 📞 Getting Help

### For Setup Questions
→ See [SETUP_GITHUB_ACTION.md](SETUP_GITHUB_ACTION.md)

### For Configuration Issues
→ Use [CONFIGURATION_CHECKLIST.md](CONFIGURATION_CHECKLIST.md)

### For GitHub-specific Help
→ Visit https://docs.github.com/en/actions

### For Security Questions
→ Review [README.md](README.md) Security section

---

## 🚀 Quick Links

- **Your Repository:** Replace `[USERNAME]` in URLs below:
  - Main: `https://github.com/[USERNAME]/megamap-lock`
  - Pages: `https://[USERNAME].github.io/megamap-lock/`
  - Actions: `https://github.com/[USERNAME]/megamap-lock/actions`
  - Settings: `https://github.com/[USERNAME]/megamap-lock/settings`

- **GitHub Docs:**
  - GitHub Actions: https://docs.github.com/en/actions
  - GitHub Pages: https://docs.github.com/en/pages
  - Personal Access Tokens: https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens

---

## 📝 Document Status

- ✅ README.md - Main documentation
- ✅ SETUP_GITHUB_ACTION.md - Detailed guide (Hebrew)
- ✅ SETUP_SUMMARY.md - Quick overview
- ✅ CONFIGURATION_CHECKLIST.md - Printable checklist
- ✅ DOCS_INDEX.md - This file

**Last Updated:** June 2026

---

**Start with [README.md](README.md) or [SETUP_SUMMARY.md](SETUP_SUMMARY.md) 👈**
