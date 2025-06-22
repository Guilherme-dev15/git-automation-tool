#!/bin/bash

function exit_exception (){
    local status=$1
    if [ $status -ne 0 ]; then
        echo "Exiting..."
        exit 1
    fi
}

function has_local_changes() {
    if ! git diff --quiet || ! git diff --cached --quiet; then
        return 0
    else
        return 1
    fi
}

function switch_branch(){
    selected=$(git branch | fzf +m \
        --height 40% \
        --layout=reverse \
        --border \
        --preview 'git log --oneline $(echo {} | tr -d "* ")' \
        --color bg:#222222,preview-bg:#333333
    )

    exit_exception $?

    selected=$(echo "$selected" | tr -d '* ')

    # Verifica se há mudanças locais antes de trocar
    if has_local_changes; then
        echo "Você tem mudanças locais não commitadas. Por favor, commit ou stash antes de trocar de branch."
        exit 1
    fi

    echo "Switching to branch: $selected"

    git switch "$selected"
}

switch_branch
