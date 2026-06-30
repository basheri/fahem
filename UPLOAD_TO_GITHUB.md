# Upload This Kit to GitHub from macOS

## Option A — GitHub website

1. Create a new empty repository without README, `.gitignore`, or license.
2. Extract `fahem-ai-claude-code-kit.zip`.
3. Upload the contents of the extracted folder, including the hidden `.claude` and `.github` folders.
4. Commit the upload.
5. Clone the repository locally and start Claude Code from the repository root.

## Option B — Terminal

Replace the repository URL:

```bash
cd ~/Downloads
unzip fahem-ai-claude-code-kit.zip
cd fahem-ai-claude-code-kit

git init
git branch -M main
git add .
git commit -m "chore: add Fahem AI Claude Code development kit"
git remote add origin https://github.com/USERNAME/fahem-ai.git
git push -u origin main
```

Verify hidden folders before committing:

```bash
ls -la
find .claude .github -maxdepth 3 -type f | sort
```

Then:

```bash
claude
```

Paste the instruction from `INITIALIZE_WITH_CLAUDE_CODE.md`.
