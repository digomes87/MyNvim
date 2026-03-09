# Guia Rápido de Comandos Neovim

Este documento resume os principais atalhos e comandos configurados no seu ambiente.

## Tecla Mestra (Leader Key)

- **Leader:** `Space` (Barra de Espaço)

##Explorador de Arquivos (Neo-tree)

- **Alternar (Abrir/Fechar):** `Cmd+B` ou `Ctrl+B`
- **Revelar arquivo atual:** `\`
- **Abrir arquivo em Split Horizontal:** `H` (dentro do explorador)
- **Abrir arquivo em Split Vertical:** `V` (dentro do explorador)
- **Fechar janela do explorador:** `q`
- **Criar/Deletar/Renomear:** Pressione `a` (add), `d` (delete) ou `r` (rename) sobre um arquivo/pasta.

##Terminal Integrado

- **Abrir/Fechar Terminal (Horizontal):** `<leader>tt` ou `<leader>th` (Space + t + t)
- **Abrir/Fechar Terminal (Vertical):** `<leader>tv` (Space + t + v)
- **Abrir Múltiplos Terminais:** Digite o número antes do comando.
    - Ex: `2<leader>tv` abre o terminal #2 ao lado do atual.
    - Ex: `3<leader>tt` abre o terminal #3 horizontalmente.
- **Navegar entre terminais:** Use `Ctrl + h/j/k/l` para mover o foco entre os terminais abertos.
- **Sair do modo terminal (para Normal mode):** `Esc` (ou `Esc` + `Esc`)

##Edição e Comentários

- **Comentar/Descomentar linha:** `gcc`
- **Comentar/Descomentar seleção:** Selecione com `v` e digite `gc`
- **Salvar arquivo:** `:w`
- **Sair:** `:q`

##Navegação e Busca

- **Navegar entre janelas (splits):** `Ctrl` + `h` (esquerda), `j` (baixo), `k` (cima), `l` (direita)
- **Ir para Definição:** `gd` (Go to Definition)
- **Voltar:** `Ctrl+o`
- **Buscar Arquivos:** `<leader>sf` (Search Files)
- **Buscar Texto (Grep):** `<leader>sg` (Search Grep)
- **Buscar Buffers abertos:** `<leader><space>`

##Autocomplete e Formatação

- **Aceitar sugestão:** `Tab` ou `Enter`
- **Navegar na lista:** `Ctrl+n` (próximo), `Ctrl+p` (anterior)
- **Mostrar documentação:** `Ctrl+Space`
- **Formatar arquivo:** `<leader>f` (Space + f)

##Python (Especificidades)

- **Organizar Imports:** Ocorre automaticamente ao salvar (via Ruff)
- **Formatação PEP8:** Automática ao salvar (via Ruff)
- **Signature Help:** Aparece automaticamente ao digitar argumentos de função.
