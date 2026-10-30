# MyNvim

Minha configuração pessoal de [Neovim](https://neovim.io), baseada no
[kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) com uma camada
própria em `lua/custom/` — um arquivo por plugin, documentada e fácil de
reverter. Voltada para **Python, Rust, Go, C/C++, LaTeX e Lua**, com tema
escuro confortável para longas sessões de madrugada.

> Guia completo de atalhos: [`COMANDOS.md`](COMANDOS.md) — ou, de dentro do
> nvim, `Space ?`.

## Requisitos

- **Neovim 0.12+** (testado com build from source `v0.12.3`; ver
  [Manutenção do ambiente](#manutenção-do-ambiente))
- Uma **Nerd Font** no terminal
- `git`, `make` e um compilador C (compila o `telescope-fzf-native`)
- `ripgrep` (busca com `Space g`) — `fd` é bem-vindo, mas opcional
- Opcionais: terminal [kitty](https://sw.kovidgoyal.net/) (preview de
  imagens), `latexmk` (vimtex), `poppler` (`pdftoppm`/`pdfinfo`, visualizador
  de PDF embutido)

## Instalação

```bash
# backup da config atual, se houver
mv ~/.config/nvim ~/.config/nvim.bak

git clone https://github.com/digomes87/MyNvim.git ~/.config/nvim
nvim   # o lazy.nvim baixa e instala tudo na primeira abertura
```

Os LSPs e ferramentas (pyright, ruff, stylua, delve...) são instalados
automaticamente pelo Mason — é só abrir um arquivo da linguagem e esperar.

## Destaques

- **Tema com troca a quente** — catppuccin-mocha ativo; `Space ct` cicla entre
  tokyonight-moon, kanagawa e cyberdream; `Space cs` abre um seletor com
  preview ao vivo (regras da "prateleira" no topo de
  [`lua/custom/plugins/style.lua`](lua/custom/plugins/style.lua))
- **Busca sem cerimônia** — `Space p/g/o/r` para arquivos, grep, buffers e
  recentes; apertar `Space` mostra todos os grupos no which-key
- **Autosave esperto** — salva ao sair do modo de inserção, com debounce de
  1s (não briga com o organize-imports do Ruff)
- **Diagnósticos limpos** — sem `virtual_text` poluindo tudo; a mensagem
  completa aparece numa linha virtual só na linha atual
- **Formatação ao salvar** (conform.nvim): Ruff no Python, stylua no Lua,
  rustfmt, goimports+gofumpt no Go; formatação manual com `Space f`
- **Preview de imagens no kitty** e **visualizador de PDF embutido**
  (`lua/custom/pdf.lua`, navegação com `j/k/gg/G`)
- **undo, swap e shada centralizados** dentro de `~/.config/nvim/`

## Estrutura

```
init.lua                    # bootstrap: leader, options, lazy.nvim
lua/custom/
  options.lua               # opções gerais e paths de estado
  keymaps.lua               # atalhos pessoais (guia em COMANDOS.md)
  autocmds.lua              # reload automático, highlights por tema, C/C++
  diagnostics.lua           # como os diagnósticos aparecem
  theme.lua                 # ciclo e seletor de temas (Space ct/cs)
  pdf.lua                   # visualizador de PDF caseiro
  plugins/                  # um arquivo por plugin
lua/kickstart/plugins/      # specs do upstream mantidos (dap, neo-tree, ...)
after/                      # ftplugin e queries do treesitter (Python)
COMANDOS.md                 # guia completo de atalhos
```

## Plugins (os principais)

| Área | Plugins |
|---|---|
| Busca | telescope.nvim (+ fzf-native, ui-select) |
| Explorador | neo-tree.nvim |
| LSP | nvim-lspconfig, mason.nvim, fidget.nvim, none-ls |
| Autocomplete | blink.cmp + LuaSnip |
| Formatação | conform.nvim |
| Lint | nvim-lint |
| Git | gitsigns.nvim |
| Debug | nvim-dap (+ dap-ui, dap-go, dap-python) |
| UI | bufferline.nvim, mini.statusline, which-key, indent-blankline |
| Edição | mini.ai/surround/comment, nvim-autopairs, nvim-ts-autotag, guess-indent |
| Terminal | toggleterm.nvim |
| Syntax | nvim-treesitter, todo-comments |
| Mídia | image.nvim, vimtex |
| Tema | catppuccin (ativo), tokyonight, kanagawa, cyberdream (lazy) |

## Atalhos que você mais vai usar

| Atalho | Ação |
|---|---|
| `Space p` / `Space g` | procurar arquivos / grep no projeto |
| `Space o` / `Space r` | buffers abertos / recentes |
| `Space e` | explorador de arquivos |
| `Space x` / `Tab` | fechar buffer / alternar buffers |
| `Space f` | formatar o arquivo |
| `Space ct` / `Space cs` | trocar tema / escolher tema com preview |
| `Space ?` | abrir o guia completo (`q` fecha) |

## Atualizar a partir do kickstart (upstream)

O remote `upstream` segue apontando para o kickstart oficial. A camada
`lua/custom/` é minha e não conflita; o que veio do upstream vive em
`init.lua` (kickstart) e `lua/kickstart/`. Para puxar mudanças:

```bash
git fetch upstream
git merge upstream/master   # ou rebase, preferência sua
```

## Manutenção do ambiente

Histórico de manutenção do binário Neovim e do ambiente, para facilitar
restore/contexto.

### 2026-06-18 — Build Neovim v0.12.3 from source

- **O quê:** Atualizei o binário do Neovim de `v0.12.2` (Homebrew) para `v0.12.3` (build estável from source).
- **Por quê:** Preferência por build oficial from source em vez de Homebrew. `v0.12.3` é tag estável (só fixes sobre 0.12.2).
- **Como (passos executados):**
  ```sh
  git clone --depth 1 --branch v0.12.3 https://github.com/neovim/neovim.git ~/neovim
  cd ~/neovim
  make CMAKE_BUILD_TYPE=Release CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=/usr/local"
  sudo make install            # instala em /usr/local/bin/nvim
  brew unlink neovim           # remove symlink brew p/ source ganhar no PATH
  ```
- **Estado resultante:**
  - `nvim` ativo: `/usr/local/bin/nvim` → `NVIM v0.12.3` (Release).
  - Homebrew neovim: ainda **instalado**, apenas **unlinked** (fallback disponível).
  - Config (`~/.config/nvim`) e plugins (`lazy-lock.json`) **não alterados**.
  - PATH: `/opt/homebrew/bin` vem antes de `/usr/local/bin`; o `brew unlink` é o que faz a versão source vencer.
- **Como reverter (voltar ao brew):**
  ```sh
  brew link neovim             # restaura symlink do brew
  sudo rm -f /usr/local/bin/nvim   # opcional: remove o binário source
  hash -r                      # limpa cache de PATH do shell
  ```
- **Notas v0.12 (breaking changes relevantes p/ config):** `vim.diagnostic.disable()`/`is_disabled()` removidos; `vim.diff` → `vim.text.diff`; LSP JSON null vira `vim.NIL`; `i_CTRL-R` insere registrador literal; `'shelltemp'` default `false`. Novidades: `vim.pack` (gerenciador nativo), `:Undotree`, `:DiffTool`, LSP inline completion / code lens.

## Créditos

- [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) — a base e o
  esqueleto de tudo; o upstream continua configurado como remote
- Cada spec em `lua/custom/plugins/` carrega um comentário de cabeçalho
  explicando o que faz
