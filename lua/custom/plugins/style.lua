-- Prateleira de temas.
--
-- Cada tema tem três estados possíveis:
--   * ATIVO      — enabled = true, lazy = false: baixa e aplica no startup.
--   * INSTALADO  — enabled = true, lazy = true: baixa, mas só carrega quando
--                  o colorscheme é invocado. São os temas do ciclo <leader>ct
--                  e do seletor <leader>cs (custom/theme.lua). O config desses
--                  só faz o setup; quem aplica é o :colorscheme.
--   * PRATELEIRA — enabled = false: nem é baixado.
--
-- Para trocar o tema padrão de forma permanente, inverta os flags do ATIVO
-- com os de um INSTALADO e rode :Lazy sync. Para experimentar sem
-- compromisso, use <leader>ct (cicla) ou <leader>cs (seletor com preview).

return {
  -----------------------------------------------------------------------
  -- ATIVO
  -----------------------------------------------------------------------
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    enabled = true,
    lazy = false,
    priority = 1000,
    config = function()
      require('catppuccin').setup {
        flavour = 'mocha', -- latte, frappe, macchiato, mocha
        term_colors = true,
        styles = { comments = {} }, -- lista vazia = sem itálico
        integrations = {
          bufferline = true,
          gitsigns = true,
          indent_blankline = { enabled = true },
          mini = true,
          neotree = true,
          telescope = { enabled = true },
          toggleterm = true,
          treesitter = true,
          which_key = true,
        },
      }
      vim.cmd.colorscheme 'catppuccin'
    end,
  },

  -----------------------------------------------------------------------
  -- INSTALADOS — entram no ciclo <leader>ct / seletor <leader>cs
  -----------------------------------------------------------------------
  {
    'folke/tokyonight.nvim',
    enabled = true,
    lazy = true,
    config = function()
      require('tokyonight').setup {
        styles = {
          comments = { italic = false },
        },
      }
    end,
  },

  {
    'rebelot/kanagawa.nvim',
    enabled = true,
    lazy = true,
    config = function()
      require('kanagawa').setup {
        theme = 'wave', -- wave, dragon, lotus
        commentStyle = { italic = false },
      }
    end,
  },

  {
    'scottmckendry/cyberdream.nvim',
    enabled = true,
    lazy = true,
    config = function() require('cyberdream').setup { variant = 'dark' } end,
  },

  -----------------------------------------------------------------------
  -- PRATELEIRA — desligados
  -----------------------------------------------------------------------
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    enabled = false,
    priority = 1000,
    config = function()
      require('rose-pine').setup {
        variant = 'moon', -- auto, main, moon, dawn
        styles = { italic = false },
      }
      vim.cmd.colorscheme 'rose-pine'
    end,
  },

  {
    'EdenEast/nightfox.nvim',
    enabled = false,
    priority = 1000,
    config = function()
      require('nightfox').setup {
        options = { styles = { comments = 'NONE' } },
      }
      -- variantes: nightfox, duskfox, nordfox, terafox, carbonfox
      vim.cmd.colorscheme 'duskfox'
    end,
  },

  {
    'sainnhe/gruvbox-material',
    enabled = false,
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_background = 'hard' -- soft, medium, hard
      vim.g.gruvbox_material_foreground = 'material'
      vim.g.gruvbox_material_better_performance = 1
      vim.cmd.colorscheme 'gruvbox-material'
    end,
  },

  {
    'neanias/everforest-nvim',
    enabled = false,
    priority = 1000,
    config = function()
      require('everforest').setup { background = 'medium' }
      vim.cmd.colorscheme 'everforest'
    end,
  },

  {
    'Mofiqul/vscode.nvim',
    enabled = false,
    priority = 1000,
    config = function()
      require('vscode').setup { italic_comments = false }
      vim.cmd.colorscheme 'vscode'
    end,
  },
}
