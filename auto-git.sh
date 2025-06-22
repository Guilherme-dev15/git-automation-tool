#!/bin/bash

<<<<<<< HEAD
# =========🔍 Validação ==========
function validate_git_repository() {
    git status &>/dev/null
    if [ $? -eq 128 ]; then
        echo -e "\033[1;31m❌ This is not a Git repository. Exiting.\033[0m"
=======
# ========== 🧪 Git Repository Validation ==========
function validate_git_repository() {
    git status &>/dev/null
    if [ $? -eq 128 ]; then
        echo -e "\033[1;31m❌ Error: This is not a Git repository.\033[0m"
        echo -e "Please navigate into a Git repository folder and try again."
>>>>>>> main
        exit 1
    fi
}

<<<<<<< HEAD
# =========🛠 Utilitários ==========
function exit_exception () {
    local status=$1
    if [ $status -ne 0 ]; then
        echo -e "\033[1;31m❌ Operation aborted.\033[0m"
=======
# ========== ⚙️ Utilities ==========
function exit_exception () {
    local status=$1
    if [ $status -ne 0 ]; then
        echo -e "\033[1;31m❌ Operation cancelled.\033[0m"
>>>>>>> main
        exit 1
    fi
}

function has_local_changes() {
    ! git diff --quiet || ! git diff --cached --quiet
}

function current_branch() {
    git branch --show-current
}

<<<<<<< HEAD
function print_title() {
=======
function print_header() {
>>>>>>> main
    echo -e "\n\033[1;35m$1\033[0m"
    echo
}

<<<<<<< HEAD
# =========🔁 Switch Branch ==========
function switch_branch() {
    print_title "🔁 Switch Git Branch"
    echo -e "📍 Current branch: \033[1;36m$(current_branch)\033[0m"

    selected=$(git branch | fzf +m \
        --header="🔁 Select the branch to switch to" \
        --height=40% \
        --layout=reverse \
        --border \
        --ansi \
        --preview 'echo -e "\033[1;36mSwitch Branch:\033[0m\n\nChange your working branch.\nEnsure no local uncommitted changes exist.\n\n\033[1;32mPreview:\033[0m\n$(git log --oneline --graph --decorate --color=always $(echo {} | tr -d "* "))"' \
=======
# ========== 🔁 Switch Git Branch ==========
function switch_branch() {
    print_header "🔁 SWITCH BRANCH"
    echo -e "📍 You are currently on: \033[1;36m$(current_branch)\033[0m"

    selected=$(git branch | fzf +m \
        --header="🔁 Select a branch to switch to" \
        --height=50% \
        --layout=reverse \
        --border \
        --ansi \
        --preview 'echo -e "\033[1;36mPurpose:\033[0m\nChange your working branch.\n\n\033[1;32mTip:\033[0m Ensure there are no uncommitted changes.\n\n\033[1;34mBranch Preview:\033[0m\n$(git log --oneline --graph --decorate --color=always $(echo {} | tr -d "* "))"' \
>>>>>>> main
        --color fg:#ffffff,bg:#1e1e1e,preview-bg:#2e2e2e,hl:#00ffff,fg+:#00ff00,bg+:#333333
    )
    exit_exception $?

    selected=$(echo "$selected" | tr -d '* ')
<<<<<<< HEAD
    echo -e "✅ Selected: \033[1;32m$selected\033[0m"

    if has_local_changes; then
        echo -e "\033[1;33m⚠️ You have local uncommitted changes. Please commit or stash before switching.\033[0m"
=======
    echo -e "✅ You selected: \033[1;32m$selected\033[0m"

    if has_local_changes; then
        echo -e "\033[1;33m⚠️ Local changes detected. Please commit or stash them first.\033[0m"
>>>>>>> main
        exit 1
    fi

    git switch "$selected"
<<<<<<< HEAD
    echo -e "\n🔄 Switched to: \033[1;36m$selected\033[0m"
}

# =========🔀 Merge Branch ==========
function merge_branch() {
    print_title "🔀 Merge Git Branch"
    echo -e "📍 Current branch: \033[1;36m$(current_branch)\033[0m"

    selected=$(git branch | fzf +m \
        --header="🔀 Select the branch to merge into current" \
        --height=40% \
        --layout=reverse \
        --border \
        --ansi \
        --preview 'echo -e "\033[1;36mMerge Branch:\033[0m\n\nMerge the selected branch into the current one.\nMake sure working directory is clean.\n\n\033[1;32mDiff Preview:\033[0m\n$(git diff --color $(git branch --show-current) $(echo {} | tr -d "* "))"' \
=======
    echo -e "\n✅ Switched to branch: \033[1;36m$selected\033[0m"
}

# ========== 🔀 Merge Branch ==========
function merge_branch() {
    print_header "🔀 MERGE BRANCH"
    echo -e "📍 Current branch: \033[1;36m$(current_branch)\033[0m"

    selected=$(git branch | fzf +m \
        --header="🔀 Select a branch to merge into current" \
        --height=50% \
        --layout=reverse \
        --border \
        --ansi \
        --preview 'echo -e "\033[1;36mPurpose:\033[0m\nMerge selected branch into current one.\n\n\033[1;33mImportant:\033[0m Make sure the working directory is clean.\n\n\033[1;34mDifference Preview:\033[0m\n$(git diff --color $(git branch --show-current) $(echo {} | tr -d "* "))"' \
>>>>>>> main
        --color fg:#ffffff,bg:#1e1e1e,preview-bg:#2e2e2e,hl:#ffcc00,fg+:#00ff00,bg+:#444444
    )
    exit_exception $?

    selected=$(echo "$selected" | tr -d '* ')
<<<<<<< HEAD
    echo -e "✅ Selected for merge: \033[1;32m$selected\033[0m"

    if has_local_changes; then
        echo -e "\033[1;33m⚠️ Uncommitted changes detected. Please commit or stash before merging.\033[0m"
        exit 1
    fi

    echo -e "\n🔀 Merging \033[1;32m$selected\033[0m into \033[1;36m$(current_branch)\033[0m..."
    git merge "$selected"
}

# =========🗑️ Delete Branch ==========
function delete_branch() {
    print_title "🗑️ Delete Git Branch"
    echo -e "📍 Current branch: \033[1;36m$(current_branch)\033[0m"

    selected=$(git branch | grep -v '^\*' | fzf +m \
        --header="🗑️ Select a branch to delete (excluding current)" \
        --height=40% \
        --layout=reverse \
        --border \
        --ansi \
        --preview 'echo -e "\033[1;31mDelete Branch:\033[0m\n\nDeletes the selected branch locally.\n⚠️ This cannot be undone.\n\n\033[1;32mRecent Commits:\033[0m\n$(git log --oneline --color=always $(echo {} | tr -d "* "))"' \
=======
    echo -e "✅ You selected to merge: \033[1;32m$selected\033[0m"

    if has_local_changes; then
        echo -e "\033[1;33m⚠️ Uncommitted changes detected. Please commit or stash first.\033[0m"
        exit 1
    fi

    echo -e "\n🔃 Merging \033[1;32m$selected\033[0m into \033[1;36m$(current_branch)\033[0m..."
    git merge "$selected"
}

# ========== 🗑️ Delete Branch ==========
function delete_branch() {
    print_header "🗑️ DELETE BRANCH"
    echo -e "📍 Current branch: \033[1;36m$(current_branch)\033[0m"

    selected=$(git branch | grep -v '^\*' | fzf +m \
        --header="🗑️ Select a branch to delete (cannot delete current)" \
        --height=50% \
        --layout=reverse \
        --border \
        --ansi \
        --preview 'echo -e "\033[1;31mWARNING:\033[0m This action is irreversible.\n\n\033[1;36mBranch Info:\033[0m\n$(git log --oneline --color=always $(echo {} | tr -d "* "))"' \
>>>>>>> main
        --color fg:#ffffff,bg:#1e1e1e,preview-bg:#2e2e2e,hl:#ff5555,fg+:#ff3333,bg+:#333333
    )
    exit_exception $?

    selected=$(echo "$selected" | tr -d '* ')
<<<<<<< HEAD
    echo -e "⚠️ Selected for deletion: \033[1;31m$selected\033[0m"

    echo -e "\n\033[1;33mAre you sure you want to delete '\033[1;31m$selected\033[1;33m'?\033[0m"
    read -p $'\033[1;33mType "yes" to confirm: \033[0m' confirm

    if [[ "$confirm" == "yes" ]]; then
        git branch -D "$selected"
        echo -e "\033[1;31m🗑️ Branch '$selected' deleted.\033[0m"
    else
        echo -e "\033[1;32m✅ Cancelled. Branch not deleted.\033[0m"
    fi
}

# =========📦 Menu ==========
function main_menu() {
    action=$(echo -e "🔁 Switch Branch\n🔀 Merge Branch\n🗑️ Delete Branch\n🚪 Exit" | fzf \
        --header="📦 MAIN MENU — Choose an option" \
        --height=20% \
        --layout=reverse \
        --border \
        --ansi \
        --preview 'echo -e "\033[1;36mGit Manager Help:\033[0m\n\n🔁 Switch Branch:\n  Checkout another branch.\n\n🔀 Merge Branch:\n  Merge selected into current.\n\n🗑️ Delete Branch:\n  Permanently delete a local branch.\n\n🚪 Exit:\n  Quit the script."' \
        --color fg:#ffffff,bg:#1e1e1e,fg+:#00ffcc,bg+:#2a2a2a,hl:#ffff00,preview-bg:#2e2e2e \
        --prompt="👉 ")

    case "$action" in
        "🔁 Switch Branch")
            switch_branch
            ;;
        "🔀 Merge Branch")
            merge_branch
            ;;
        "🗑️ Delete Branch")
            delete_branch
            ;;
        "🚪 Exit")
            echo -e "\033[1;34m👋 Exiting...\033[0m"
            exit 0
            ;;
        *)
            echo -e "\033[1;31m❌ Invalid selection.\033[0m"
            exit 1
            ;;
    esac
}

# =========🚀 Execução ==========
=======
    echo -e "⚠️ You selected to delete: \033[1;31m$selected\033[0m"

    echo -e "\n\033[1;33mAre you sure?\033[0m Type \033[1;31mYES\033[0m to confirm:"
    read -r confirm

    if [[ "$confirm" == "YES" ]]; then
        git branch -D "$selected"
        echo -e "\033[1;31m🗑️ Branch '$selected' deleted.\033[0m"
    else
        echo -e "\033[1;32m✅ Cancelled. No changes made.\033[0m"
    fi
}

# ========== 📦 Main Menu ==========
function main_menu() {
    while true; do
        action=$(echo -e "🔁 Switch Branch\n🔀 Merge Branch\n🗑️ Delete Branch\n🚪 Exit" | fzf \
            --header="📦 MAIN MENU — Use arrows ↑↓ to navigate, Enter to select" \
            --height=40% \
            --layout=reverse \
            --border \
            --ansi \
            --preview 'echo -e "\033[1;36mGit Assistant:\033[0m\n\n🔁 Switch Branch:\n  Move between Git branches.\n\n🔀 Merge Branch:\n  Merge another branch into the current one.\n\n🗑️ Delete Branch:\n  Remove local branch (irreversible).\n\n🚪 Exit:\n  Quit the tool."' \
            --color fg:#ffffff,bg:#1e1e1e,fg+:#00ffcc,bg+:#2a2a2a,hl:#ffff00,preview-bg:#2e2e2e \
            --prompt="👉 Choose: ")

        case "$action" in
            "🔁 Switch Branch") switch_branch ;;
            "🔀 Merge Branch") merge_branch ;;
            "🗑️ Delete Branch") delete_branch ;;
            "🚪 Exit")
                echo -e "\033[1;34m👋 Goodbye!\033[0m"
                break
                ;;
            *) echo -e "\033[1;31m❌ Invalid option.\033[0m";;
        esac
    done
}

# ========== 🚀 Start ==========
>>>>>>> main
validate_git_repository
main_menu
