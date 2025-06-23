## 📄 `README.md` EM PORTUGUÊS

````markdown
# 🧠 GitMenu – Automação de Branches via Terminal

Uma ferramenta interativa no terminal para gerenciar branches do Git de forma rápida, segura e visual. Troque, faça merge e exclua branches com menus coloridos usando [FZF](https://github.com/junegunn/fzf), com pré-visualização ao vivo e interface amigável para todos os níveis de usuário.

---

## 🚀 Funcionalidades

✅ Trocar de branch com visualização do log  
✅ Fazer merge entre branches com preview de diferenças (diff)  
✅ Deletar branches com confirmação e preview  
✅ Interface 100% em inglês para uso universal  
✅ Detecção automática se o diretório não é um repositório Git  
✅ Cores destacadas para melhorar a navegação  
✅ Feito com Shell Script puro + FZF + Git

---

## 🖼️ Exemplo visual (em breve GIF)

```bash
$ gitmenu

📦 MAIN MENU
🔁 Switch Branch
🔀 Merge Branch
🗑️ Delete Branch
🚪 Exit

📍 Current Branch: develop
👁️ Preview: git log --oneline --graph --color
````

---

## 📦 Instalação

### 1. Clone este repositório

```bash
git clone https://github.com/SEU_USUARIO/git-automation-cli.git
cd git-automation-cli
```

### 2. Torne o script executável e mova para o PATH

```bash
chmod +x gitmenu
mv gitmenu ~/.local/bin/
```

> Se necessário, adicione o caminho ao `.bashrc` ou `.zshrc`:

```bash
export PATH="$HOME/.local/bin:$PATH"
```

### 3. Execute de qualquer lugar:

```bash
gitmenu
```

---

## 🧩 Pré-requisitos

* **Git instalado**
* **fzf** instalado ([Guia oficial](https://github.com/junegunn/fzf#installation))
* Terminal compatível com ANSI colors (ex: bash, zsh)

---

## 🛠️ Como funciona

| Ação               | O que faz                                                                          |
| ------------------ | ---------------------------------------------------------------------------------- |
| 🔁 Trocar branch   | Lista todas as branches com pré-visualização do log da selecionada                 |
| 🔀 Merge de branch | Permite escolher uma branch para fazer merge na atual, mostrando diferenças (diff) |
| 🗑️ Deletar branch | Remove uma branch local com preview e confirmação                                  |
| 🚪 Sair            | Encerra o programa com mensagem amigável                                           |
| 🧪 Validação       | Verifica se o diretório atual é um repositório Git válido                          |

---

## 📘 Exemplo de fluxo

```bash
# Você está em develop e quer enviar para produção

git add .
git commit -m "Finalizei a feature"

gitmenu  # Escolhe Switch → main
gitmenu  # Escolhe Merge → develop
git push origin main
```

---

## 📂 Organização do código

```
.
├── gitmenu          # Script principal
├── README.md        # Documentação do projeto
```
