echo "# Git Automation CLI

This tool allows easy Git branch management (switch, merge, delete) using FZF and a colorized terminal interface. 

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

