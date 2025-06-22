#!/bin/bash

# Encerra o script se o comando anterior falhar
function exit_exception () {
    local status=$1
    if [ $status -ne 0 ]; then
        echo "Exiting..."
        exit 1
    fi
}

# Verifica se há mudanças locais não commitadas
function has_local_changes() {
    if ! git diff --quiet || ! git diff --cached --quiet; then
        return 0
    else
        return 1
    fi
}

# Função genérica para selecionar uma branch com FZF
function select_branch() {
    git branch | fzf +m \
        --height=40% \
        --layout=reverse \
        --border \
        --preview 'git log --oneline $(echo {} | tr -d "* ")' \
        --color bg:#222222,preview-bg:#333333
}

# Trocar de branch com verificação de mudanças locais
function switch_branch() {
    selected=$(select_branch)
    exit_exception $?

    selected=$(echo "$selected" | tr -d '* ')

    if has_local_changes; then
        echo "Você tem mudanças locais não commitadas. Por favor, commit ou stash antes de trocar de branch."
        exit 1
    fi

    echo "Switching to branch: $selected"
    git switch "$selected"
}

# Realizar merge de outra branch na atual
function merge_branch() {
    selected=$(git branch | fzf +m \
        --height=100% \
        --layout=reverse \
        --border \
        --preview 'git diff $(git branch --show-current) $(echo {} | tr -d "* ")' \
        --color bg:#222222,preview-bg:#333333
    )
    exit_exception $?

    selected=$(echo "$selected" | tr -d '* ')

    if has_local_changes; then
        echo "Você tem mudanças locais não commitadas. Por favor, commit ou stash antes de fazer merge."
        exit 1
    fi

    echo "Fazendo merge da branch '$selected' na atual..."
    git merge "$selected"
}

# Exemplo de uso
switch_branch
# merge_branch  # Descomente para usar
