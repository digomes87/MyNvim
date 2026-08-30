-- Tema do Neovim — ponto único de configuração.
--
-- Para trocar de tema, altere apenas a linha ACTIVE abaixo e reinicie o Neovim.
-- Para voltar ao tema anterior (tokyonight-moon opaco), use ACTIVE = 'moon'.
--
-- Backup do estado anterior: git tag theme-backup-tokyonight-moon

local ACTIVE = 'night-transparent'

-- Presets disponíveis: nome -> { scheme, transparent }
local PRESETS = {
  ['moon'] = { scheme = 'tokyonight-moon', transparent = false },
  ['moon-transparent'] = { scheme = 'tokyonight-moon', transparent = true },
  ['night-transparent'] = { scheme = 'tokyonight-night', transparent = true },
  ['storm-transparent'] = { scheme = 'tokyonight-storm', transparent = true },
  ['mocha-transparent'] = { scheme = 'catppuccin-mocha', transparent = true },
  ['macchiato'] = { scheme = 'catppuccin-macchiato', transparent = false },
}

local preset = PRESETS[ACTIVE] or PRESETS['moon']

-- Grupos que precisam ficar sem fundo para a transparência do terminal aparecer.
local CLEAR_GROUPS = {
  'Normal',
  'NormalNC',
  'NormalFloat',
  'FloatBorder',
  'FloatTitle',
  'SignColumn',
  'LineNr',
  'FoldColumn',
  'EndOfBuffer',
  'MsgArea',
  'TelescopeNormal',
  'TelescopeBorder',
  'TelescopePromptNormal',
  'TelescopeResultsNormal',
  'TelescopePreviewNormal',
  'NeoTreeNormal',
  'NeoTreeNormalNC',
  'NeoTreeEndOfBuffer',
  'WhichKeyFloat',
  'LazyNormal',
  'MasonNormal',
  'StatusLine',
  'StatusLineNC',
  'WinSeparator',
  'Pmenu',
  'DiagnosticVirtualTextError',
  'DiagnosticVirtualTextWarn',
  'DiagnosticVirtualTextInfo',
  'DiagnosticVirtualTextHint',
}

local function clear_backgrounds()
  for _, group in ipairs(CLEAR_GROUPS) do
    vim.api.nvim_set_hl(0, group, { bg = 'none', ctermbg = 'none' })
  end
end

if preset.transparent then
  vim.api.nvim_create_autocmd('ColorScheme', {
    group = vim.api.nvim_create_augroup('theme-transparency', { clear = true }),
    pattern = '*',
    callback = clear_backgrounds,
  })
end

local is_catppuccin = preset.scheme:match '^catppuccin'

local function apply()
  vim.cmd.colorscheme(preset.scheme)
  if preset.transparent then clear_backgrounds() end
end

return {
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    opts = {
      transparent = preset.transparent,
      styles = {
        comments = { italic = false },
        sidebars = preset.transparent and 'transparent' or 'dark',
        floats = preset.transparent and 'transparent' or 'dark',
      },
    },
    config = function(_, opts)
      require('tokyonight').setup(opts)
      if not is_catppuccin then apply() end
    end,
  },

  {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = false,
    priority = 1000,
    opts = {
      transparent_background = preset.transparent,
      integrations = {
        gitsigns = true,
        neotree = true,
        telescope = { enabled = true },
        treesitter = true,
        which_key = true,
      },
    },
    config = function(_, opts)
      require('catppuccin').setup(opts)
      if is_catppuccin then apply() end
    end,
  },
}
