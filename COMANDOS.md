# Guia de Atalhos e Comandos Neovim

Leader = `Space`. **Dica nº 1:** aperte `Space` e espere 1 segundo — o which-key
mostra na tela todos os atalhos do prefixo que você digitou.
**Dica nº 2:** `Space ?` abre este arquivo (num split lateral; `q` fecha).

⭐ = atalho novo (out/2026). Os demais são da sua config original.

## Dia a dia — os 8 essenciais

| Atalho | Ação |
|---|---|
| `Space p` ⭐ | Procurar arquivos no projeto |
| `Space g` ⭐ | Buscar texto no projeto (grep) |
| `Space o` ⭐ | Lista de buffers abertos |
| `Space r` ⭐ | Arquivos recentes |
| `Space e` ⭐ | Explorador de arquivos (Neo-tree) |
| `Space x` | Fechar buffer atual |
| `Tab` / `Shift+Tab` | Buffer seguinte / anterior |
| `Space f` | Formatar o arquivo |

Alternativas com Ctrl: `Ctrl+f` = procurar arquivos, `Ctrl+b` = Neo-tree.

## Busca (Telescope)

Apelidos rápidos: `Space p`, `Space g`, `Space o`, `Space r` (acima) e `Space /` (busca no buffer atual).

Os mnemônicos `[S]earch` continuam valendo:

| Atalho | Ação |
|---|---|
| `Space sf` | Arquivos |
| `Space sg` | Grep no projeto |
| `Space sw` | Buscar a palavra sob o cursor |
| `Space sh` | Ajuda do Neovim |
| `Space sk` | Lista TODOS os atalhos |
| `Space ss` | Todos os pickers do Telescope |
| `Space sd` | Diagnósticos (LSP) |
| `Space sr` | Reabrir a última busca |
| `Space s.` | Arquivos recentes |
| `Space sc` | Comandos (`:`) |
| `Space s/` | Grep só nos arquivos abertos |
| `Space sn` | Arquivos da config do nvim |
| `Space Space` | Buffers abertos |
| `Ctrl+Shift+f` | Grep no projeto |

**Dentro do Telescope:** digite para filtrar · `Enter` abre · `Esc` fecha · `Ctrl+n`/`Ctrl+p` navega.

## Explorador (Neo-tree)

| Atalho | Ação |
|---|---|
| `Space e` ⭐ / `Ctrl+b` / `Cmd+b` | Abrir/fechar o explorador |
| `\` | Revelar o arquivo atual no explorador |

Dentro do explorador: `a` cria, `d` deleta, `r` renomeia, `H` abre em split
horizontal, `V` em vertical, `q` fecha.

## Edição

| Atalho | Ação |
|---|---|
| `gcc` | Comentar/descomentar a linha |
| `gc` (seleção) | Comentar/descomentar a seleção |
| `Space y` | Copiar para a área de transferência do sistema |
| `p` (no visual) | Colar sem sobrescrever o registro |
| `Esc` | Limpar o destaque da busca |
| `saiw)` | Surround: adiciona `(` ao redor da palavra |
| `sd'` / `sr)'` | Surround: deleta `'` / troca `)` por `'` |

## Navegação e janelas

| Atalho | Ação |
|---|---|
| `Ctrl+h/j/k/l` | Foco para janela à esquerda/baixo/cima/direita |
| `Space q` | Diagnósticos na quickfix |
| `Ctrl+o` | Voltar na pilha de navegação |

## LSP (com um arquivo de código aberto)

| Atalho | Ação |
|---|---|
| `K` | Documentação (hover) |
| `gd` | Ir para a definição |
| `grr` | Referências |
| `gri` | Implementações |
| `grt` | Definição de tipo |
| `grD` | Declaração |
| `grn` | Renomear símbolo |
| `gra` | Code action |
| `gO` | Símbolos do arquivo atual |
| `gW` | Símbolos do workspace |
| `Space th` | Ligar/desligar inlay hints |

## Git

| Atalho | Ação |
|---|---|
| `]c` / `[c` | Próxima / anterior alteração (hunk) |
| `Space hs` | Stage do hunk (com seleção: do trecho) |
| `Space hr` | Reset do hunk |
| `Space hS` / `Space hR` | Stage / reset do buffer inteiro |
| `Space hp` | Preview do hunk |
| `Space hb` | Blame da linha |
| `Space hd` / `Space hD` | Diff contra o index / último commit |
| `Space tb` | Blame virtual no fim da linha (on/off) |
| `Space tw` | Word diff intra-linha (on/off) |
| `vih` | Selecionar o hunk (textobj) |

## Terminal

| Atalho | Ação |
|---|---|
| `Ctrl+\` | Alternar terminal |
| `Space tt` | Terminal horizontal |
| `Esc Esc` | Sair do modo terminal (para o Normal) |

## Debug (DAP)

| Atalho | Ação |
|---|---|
| `F5` | Iniciar/continuar |
| `F1` / `F2` / `F3` | Step into / over / out |
| `F7` | Abrir/fechar a UI de debug |
| `Space b` | Breakpoint |
| `Space B` | Breakpoint condicional |

## Temas ⭐

| Atalho | Ação |
|---|---|
| `Space ct` | Ciclar: catppuccin → tokyonight-moon → kanagawa → cyberdream |
| `Space cs` | Seletor com preview (navegar já aplica; `Esc` desfaz, `Enter` mantém) |

A troca vale só para a sessão. Para fixar um tema como padrão, inverta os
flags `enabled`/`lazy` em `lua/custom/plugins/style.lua` (regra comentada no
topo do arquivo) e rode `:Lazy sync`.

## Autocomplete (blink.cmp)

| Atalho | Ação |
|---|---|
| `Tab` / `Enter` | Aceitar sugestão |
| `Shift+Tab` | Item anterior |
| `Ctrl+n` / `Ctrl+p` | Navegar na lista |

## Onde os atalhos vivem

- `lua/custom/keymaps.lua` — pessoais (inclui os ⭐)
- `lua/custom/plugins/telescope.lua` — buscas
- `lua/kickstart/plugins/neo-tree.lua` — explorador
- `lua/custom/plugins/lsp.lua` e `telescope.lua` — LSP
- `lua/kickstart/plugins/gitsigns.lua` — git
- `lua/custom/plugins/toggleterm.lua` — terminal
- `lua/kickstart/plugins/debug.lua` — DAP
- `lua/custom/theme.lua` — temas
