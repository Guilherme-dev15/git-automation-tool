e# 🧠 Git Automation CLI (`gitmenu`)

An interactive terminal tool to manage Git branches like a pro — switch, merge, and delete branches with full-color previews using [FZF](https://github.com/junegunn/fzf). Designed for productivity, clarity, and absolute ease of use — even for beginners.

![Git Automation CLI Banner](https://raw.githubusercontent.com/guibanks/git-automation-cli/main/banner.png) <!-- (adicione depois um banner aqui se quiser) -->

---

## 📦 Features

✅ Switch between branches with visual preview  
✅ Merge any branch into current with diff preview  
✅ Delete branches safely with confirmation  
✅ Highlights current branch, selections, and status  
✅ Full English interface — accessible for all levels  
✅ Includes Git repository validation  
✅ Clean color-coded UI with FZF

---

## 🖼️ Preview

> ⚡ Live terminal preview (GIF soon...)

```bash
$ gitmenu
📦 MAIN MENU
→ 🔁 Switch Branch
→ 🔀 Merge Branch
→ 🗑️ Delete Branch
→ 🚪 Exit

Current Branch: develop
Preview: git log --oneline --graph --color
allows easy Git branch management (switch, merge, delete) using FZF and a colorized terminal interface. 

## Usage

Run \`./gitmenu\` to start the interactive menu.

## Installation

\`\`\`bash
chmod +x gitmenu
mv gitmenu ~/.local/bin/
\`\`\`

Then run: \`gitmenu\` from anywhere.
" > README.md

git add README.md
git commit -m "Add README"
git push

