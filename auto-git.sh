#!/bin/bash

function switch_branch(){
    # Use fzf para selecionar uma branch com preview dos últimos commits
    selected=$(git branch | fzf +m \
        --height 40% \
        --layout=reverse \
        --border \
        --preview 'git log --oneline $(echo {} | tr -d "* ")' \
        --color bg:#222222,preview-bg:#333333
    )

    # Verifica se o fzf foi cancelado (código de saída diferente de zero)
    if [ $? -ne 0 ]; then
        echo "Exiting..."
        exit 1
    fi

    # Remove o '* ' do branch selecionado (caso seja a branch atual)
    selected=$(echo "$selected" | tr -d '* ')

    echo "Switching to branch: $selected"

    git switch "$selected"
}

switch_branch
