#!/bin/bash

# 🚀 Quick Setup Script for MegaMap Lock GitHub Action
# This script helps you configure the GitHub Action to sync encrypted files

set -e

echo "🔐 MegaMap Lock - GitHub Action Setup"
echo "====================================="
echo ""

# Check if we're in a git repository
if [ ! -d ".git" ]; then
    echo "❌ Error: Not in a git repository"
    echo "Please run this script from the root of your megamap-lock repository"
    exit 1
fi

echo "This script will help you set up the GitHub Action to sync encrypted files."
echo ""
echo "You'll need to provide:"
echo "  1. The MEGAMAP repository owner (e.g., ShebaMicrobiomeCenter)"
echo "  2. The MEGAMAP repository name (e.g., MEGAMAP)"
echo "  3. The path to the encrypted file in MEGAMAP (e.g., data/latest-light.csv.enc)"
echo ""

read -p "Enter MEGAMAP repository owner: " megamap_owner
read -p "Enter MEGAMAP repository name: " megamap_repo
read -p "Enter encrypted file path in MEGAMAP: " megamap_file_path

# Get current repo info
current_owner=$(git config user.name 2>/dev/null || echo "")
current_repo=$(git remote -v | head -1 | sed 's/.*\/\([^ ]*\).*/\1/' | sed 's/\.git$//')

echo ""
echo "Summary:"
echo "  MEGAMAP Owner: $megamap_owner"
echo "  MEGAMAP Repo: $megamap_repo"
echo "  File Path: $megamap_file_path"
echo "  Your Repo: $current_repo"
echo ""
read -p "Is this correct? (y/n) " -n 1 -r
echo ""

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "❌ Cancelled"
    exit 1
fi

echo ""
echo "✅ Configuration saved!"
echo ""
echo "Next steps:"
echo "1. Go to: https://github.com/$(git config user.name)/$current_repo/settings/variables"
echo "2. Create these variables:"
echo ""
echo "   Variable Name: MEGAMAP_OWNER"
echo "   Value: $megamap_owner"
echo ""
echo "   Variable Name: MEGAMAP_REPO"
echo "   Value: $megamap_repo"
echo ""
echo "   Variable Name: MEGAMAP_FILE_PATH"
echo "   Value: $megamap_file_path"
echo ""
echo "3. If MEGAMAP is a private repository:"
echo "   - Go to: https://github.com/settings/tokens"
echo "   - Create a new Personal Access Token (classic)"
echo "   - Grant permissions: repo (full)"
echo "   - Copy the token"
echo ""
echo "4. Go to: https://github.com/$(git config user.name)/$current_repo/settings/secrets/actions"
echo "   - Create a new Secret:"
echo "   - Name: MEGAMAP_TOKEN"
echo "   - Value: [paste your token here]"
echo ""
echo "5. Edit .github/workflows/sync-encrypted-file.yml"
echo "   - Uncomment the MEGAMAP_TOKEN line if needed"
echo ""
echo "6. Push your changes:"
echo "   git add -A"
echo "   git commit -m 'Configure GitHub Action for MEGAMAP sync'"
echo "   git push"
echo ""
echo "7. Your GitHub Action will start syncing!"
echo "   - Check: https://github.com/$(git config user.name)/$current_repo/actions"
echo ""
echo "For more help, see: SETUP_GITHUB_ACTION.md"
