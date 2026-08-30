-- Prateleira de temas.
--
-- Regra: exatamente UM spec com `enabled = true`. Os demais ficam
-- `enabled = false` — o lazy nem chega a baixá-los, então não pesam no
-- startup nem entram no lazy-lock.json.
--
-- Para experimentar outro tema:
--   1. `enabled = false` no tema atual
--   2. `enabled = true`  no tema novo
--   3. reinicie o Neovim e rode `:Lazy sync`
--
-- Cada spec já traz a configuração testada do tema, então voltar atrás é
-- só inverter os dois booleanos de novo.

return {
  -----------------------------------------------------------------------
  -- ATIVO
  -----------------------------------------------------------------------
  {
    'folke/tokyonight.nvim',
    enabled = true,
    priority = 1000,
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require('tokyonight').setup {
        styles = {
          comments = { italic = false },
        },
      }
      vim.cmd.colorscheme 'tokyonight-moon'
    end,
  },

  -----------------------------------------------------------------------
  -- PRATELEIRA — todos desligados
  -----------------------------------------------------------------------
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    enabled = false,
    priority = 1000,
    config = function()
      require('catppuccin').setup {
        flavour = 'mocha', -- latte, frappe, macchiato, mocha
        integrations = {
          gitsigns = true,
          neotree = true,
          telescope = { enabled = true },
          treesitter = true,
          which_key = true,
        },
      }
      vim.cmd.colorscheme 'catppuccin'
    end,
  },

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
    'rebelot/kanagawa.nvim',
    enabled = false,
    priority = 1000,
    config = function()
      require('kanagawa').setup {
        theme = 'wave', -- wave, dragon, lotus
        commentStyle = { italic = false },
      }
      vim.cmd.colorscheme 'kanagawa'
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
    'scottmckendry/cyberdream.nvim',
    enabled = false,
    priority = 1000,
    config = function()
      require('cyberdream').setup { variant = 'dark' }
      vim.cmd.colorscheme 'cyberdream'
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
