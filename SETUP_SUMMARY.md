# 📚 MegaMap Lock - Setup Summary

## ✅ What Was Set Up

Your MegaMap Lock repository now has:

### 1. **GitHub Actions Workflows** (`.github/workflows/`)

#### 📥 `sync-encrypted-file.yml`
Automatically pulls encrypted file from your private MEGAMAP repository.
- **When:** Daily at 00:00 UTC (or manually via UI)
- **What it does:** Downloads the encrypted file from MEGAMAP and commits it to this repo
- **Configuration:** Needs variables in Settings > Variables

#### 🔐 `encrypt-file.yml`
Encrypts CSV files through the GitHub UI without needing the command line.
- **When:** Manual trigger through Actions UI
- **What it does:** Downloads a CSV, encrypts it, and commits the .enc file
- **Input:** CSV URL, password, output filename

#### 🚀 `deploy.yml`
Automatically publishes your site to GitHub Pages when you push changes.
- **When:** Every push to master/main branch
- **What it does:** Deploys the static content to GitHub Pages

---

### 2. **Configuration Files**

#### `.gitignore`
Prevents committing temporary files while allowing `.enc` encrypted files.

#### `SETUP_GITHUB_ACTION.md` 
Complete Hebrew guide with step-by-step instructions for:
- Enabling GitHub Pages
- Configuring environment variables
- Setting up authentication tokens
- Troubleshooting common issues

#### `setup.sh`
Interactive bash script to help configure the workflow variables.

---

## 🚀 Quick Start

### Step 1: Enable GitHub Pages
1. Go to **Settings** → **Pages**
2. Select "Deploy from a branch"
3. Choose `master` branch and `/(root)`
4. Your site will be live at: `https://[YOUR_USERNAME].github.io/megamap-lock/`

### Step 2: Configure the Sync Workflow
1. Go to **Settings** → **Variables**
2. Add these 3 variables:
   ```
   MEGAMAP_OWNER = ShebaMicrobiomeCenter
   MEGAMAP_REPO = megamap
   MEGAMAP_FILE_PATH = latest-light.csv.enc
   ```

### Step 3: (Optional) For Private MEGAMAP Repo
1. Create a Personal Access Token at GitHub Settings > Developer settings
2. Go to **Settings** → **Secrets** → **Actions**
3. Add secret:
   ```
   MEGAMAP_TOKEN = [your token]
   ```

### Step 4: Test
1. Go to **Actions**
2. Click **Sync Encrypted File from MEGAMAP**
3. Click **Run workflow**

---

## 📂 File Structure

```
megamap-lock/
├── .github/
│   └── workflows/
│       ├── deploy.yml                    # 🚀 Deploy to Pages
│       ├── sync-encrypted-file.yml       # 📥 Sync from MEGAMAP
│       └── encrypt-file.yml              # 🔐 Manual encryption
├── .gitignore                            # Git ignore rules
├── encrypt.js                            # Node.js encryption tool
├── index.html                            # Main web interface
├── README.md                             # Main documentation
├── SETUP_GITHUB_ACTION.md               # Detailed setup guide
└── setup.sh                             # Interactive setup script
```

---

## 🔄 How It All Works Together

```
User wants to decrypt data
        ↓
Opens: https://[USERNAME].github.io/megamap-lock/
        ↓
Selects encrypted file (.enc)
        ↓
Enters password
        ↓
Browser decrypts (AES-256-GCM, PBKDF2)
        ↓
Shows encrypted CSV data in table
        ↓
Can search, filter, download
```

**Daily Sync Process:**
```
GitHub Action timer triggers (00:00 UTC)
        ↓
Clones megamap-lock repo
        ↓
Authenticates to MEGAMAP (using GITHUB_TOKEN)
        ↓
Downloads: data/latest-light.csv.enc
        ↓
Commits to megamap-lock
        ↓
deploy.yml triggers automatically
        ↓
GitHub Pages updates
        ↓
New file available at your site
```

---

## 🔒 Security Notes

- ✅ **Encryption/Decryption:** Happens only in the browser, never on servers
- ✅ **Password:** Never transmitted, only used to derive keys locally
- ✅ **GitHub Token:** Has minimal permissions (repo read-only)
- ✅ **Storage:** Temporary files deleted after processing
- ✅ **localStorage:** Users can clear password anytime

---

## 📋 Common Tasks

### Manually Trigger Sync
1. Go to **Actions**
2. Select **Sync Encrypted File from MEGAMAP**
3. Click **Run workflow**

### Encrypt a New File
1. Go to **Actions**
2. Select **Encrypt File**
3. Provide CSV URL, password, output name
4. Done! File will be committed

### Change Sync Schedule
Edit `.github/workflows/sync-encrypted-file.yml`:
```yaml
schedule:
  - cron: '0 12 * * *'  # Change to 12:00 UTC
```

### Check Workflow Logs
1. Go to **Actions**
2. Click the workflow run
3. View step logs for errors

---

## 🐛 Troubleshooting

| Issue | Solution |
|-------|----------|
| "Repository not found" | Check MEGAMAP_OWNER, MEGAMAP_REPO, and token permissions |
| "File path not found" | Verify MEGAMAP_FILE_PATH exists in MEGAMAP repo |
| Pages not updating | Check **Actions** tab for failed deployments |
| Decryption fails | Verify password is correct and file is properly encrypted |

For detailed troubleshooting, see **SETUP_GITHUB_ACTION.md**

---

## 📖 Next Steps

1. **Review** the workflow files to understand the process
2. **Run** `setup.sh` (optional) to interactively configure
3. **Or manually** add variables to Settings > Variables
4. **Test** by running the workflow manually
5. **Share** your GitHub Pages URL with users who need the data

---

## 💡 Tips

- 📅 You can change the sync schedule (see SETUP_GITHUB_ACTION.md)
- 🔐 Use a strong password (at least 12 characters)
- 📊 The CSV can be as large as GitHub allows (free: 25 MB per file)
- 🚀 Each workflow run shows logs you can debug from
- 💾 Encrypted files are tracked in git (safe to store)

---

For more detailed information, read:
- **Main Docs:** [README.md](README.md)
- **Setup Guide:** [SETUP_GITHUB_ACTION.md](SETUP_GITHUB_ACTION.md)
