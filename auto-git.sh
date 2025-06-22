#!/bin/bash

# ========== Utilitários ==========
function exit_exception () {
    local status=$1
    if [ $status -ne 0 ]; then
        echo -e "\033[1;31m❌ Erro. Saindo...\033[0m"
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

function current_branch() {
    git branch --show-current
}

function print_title() {
    echo -e "\033[1;35m$1\033[0m"
    echo
}

# ========== Funções principais ==========

function switch_branch() {
    print_title "🔁 Trocar de Branch"
    echo -e "📍 Branch atual: \033[1;36m$(current_branch)\033[0m"

    selected=$(git branch | fzf +m \
        --header="🔁 Selecione a branch para trocar" \
        --height=40% \
        --layout=reverse \
        --border \
        --preview 'git log --oneline --graph --decorate $(echo {} | tr -d "* ")' \
        --color fg:#dddddd,bg:#1e1e1e,preview-bg:#2e2e2e
    )
    exit_exception $?

    selected=$(echo "$selected" | tr -d '* ')
    echo -e "✅ Branch selecionada: \033[1;32m$selected\033[0m"

    if has_local_changes; then
        echo -e "\n\033[1;33m⚠️  Você tem mudanças locais não commitadas. Faça commit ou stash antes de trocar de branch.\033[0m"
        exit 1
    fi

    echo -e "\n🔄 Trocando para: \033[1;36m$selected\033[0m"
    git switch "$selected"
}

function merge_branch() {
    print_title "🔀 Merge de Branch"
    echo -e "📍 Branch atual: \033[1;36m$(current_branch)\033[0m"

    selected=$(git branch | fzf +m \
        --header="🔀 Selecione a branch que será mesclada" \
        --height=40% \
        --layout=reverse \
        --border \
        --preview 'git diff $(git branch --show-current) $(echo {} | tr -d "* ")' \
        --color fg:#dddddd,bg:#1e1e1e,preview-bg:#2e2e2e
    )
    exit_exception $?

    selected=$(echo "$selected" | tr -d '* ')
    echo -e "✅ Branch selecionada para merge: \033[1;32m$selected\033[0m"

    if has_local_changes; then
        echo -e "\n\033[1;33m⚠️  Você tem mudanças locais não commitadas. Faça commit ou stash antes de fazer merge.\033[0m"
        exit 1
    fi

    echo -e "\n🔀 Fazendo merge de \033[1;36m$selected\033[0m para \033[1;36m$(current_branch)\033[0m..."
    git merge "$selected"
}

function delete_branch() {
    print_title "🗑️ Deletar Branch"
    echo -e "📍 Branch atual: \033[1;36m$(current_branch)\033[0m"

    selected=$(git branch | grep -v '^\*' | fzf +m \
        --header="🗑️ Selecione a branch que deseja deletar (exceto a atual)" \
        --height=40% \
        --layout=reverse \
        --border \
        --preview 'git log --oneline $(echo {} | tr -d "* ")' \
        --color fg:#dddddd,bg:#1e1e1e,preview-bg:#2e2e2e
    )
    exit_exception $?

    selected=$(echo "$selected" | tr -d '* ')
    echo -e "⚠️  Você selecionou: \033[1;31m$selected\033[0m"

    echo -e "\n\033[1;33mTem certeza que deseja deletar a branch '\033[1;31m$selected\033[1;33m'?\033[0m"
    read -p $'\033[1;33mDigite "sim" para confirmar: \033[0m' confirm

    if [[ "$confirm" == "sim" ]]; then
        git branch -D "$selected"
        echo -e "\033[1;31m🗑️ Branch '$selected' deletada.\033[0m"
    else
        echo -e "\033[1;32m✅ Cancelado. Nenhuma branch foi deletada.\033[0m"
    fi
}

# ========== Menu ==========
function main_menu() {
    action=$(echo -e "🔁 Trocar de Branch\n🔀 Fazer Merge\n🗑️ Deletar Branch\n🚪 Sair" | fzf \
        --header="📦 MENU PRINCIPAL — Selecione uma opção" \
        --height=20% \
        --layout=reverse \
        --border \
        --color fg:#ffffff,bg:#1e1e1e,prompt:#00ffff,preview-bg:#2e2e2e \
        --prompt="👉 ")

    case "$action" in
        "🔁 Trocar de Branch")
            switch_branch
            ;;
        "🔀 Fazer Merge")
            merge_branch
            ;;
        "🗑️ Deletar Branch")
            delete_branch
            ;;
        "🚪 Sair")
            echo -e "\033[1;34m👋 Saindo...\033[0m"
            exit 0
            ;;
        *)
            echo -e "\033[1;31m❌ Ação inválida.\033[0m"
            exit 1
            ;;
    esac
}

# Executar menu
main_menu
