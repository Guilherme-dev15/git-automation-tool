#!/bin/bash

# Use fzf to select a branch from the list of git branches with preview of recent commits
selected=$(git branch | fzf \
    --height 40% \
    --layout=reverse \
    --border \
    --preview 'git log --oneline $(echo {} | tr -d "* ")' \
    --color bg:#222222,preview-bg:#333333
)

# Remove the leading '* ' if the branch is currently checked out
selected=$(echo "$selected" | tr -d '* ')

# Print the selected branch name
echo "Switching to branch: $selected"

# Switch to the selected branch
git switch "$selected"
