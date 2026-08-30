-- Tema do Neovim — ponto único de configuração.
--
-- Para trocar de tema, altere apenas a linha ACTIVE abaixo e reinicie o Neovim.
-- Para voltar ao tema anterior (tokyonight-moon opaco), use ACTIVE = 'moon'.
--
-- Backup do estado anterior: git tag theme-backup-tokyonight-moon

local ACTIVE = 'rose-pine-transparent'

-- Presets disponíveis: nome -> { scheme, transparent }
local PRESETS = {
  ['moon'] = { scheme = 'tokyonight-moon', transparent = false },
  ['moon-transparent'] = { scheme = 'tokyonight-moon', transparent = true },
  ['night-transparent'] = { scheme = 'tokyonight-night', transparent = true },
  ['storm-transparent'] = { scheme = 'tokyonight-storm', transparent = true },
  ['mocha-transparent'] = { scheme = 'catppuccin-mocha', transparent = true },
  ['macchiato'] = { scheme = 'catppuccin-macchiato', transparent = false },
  ['rose-pine-transparent'] = { scheme = 'rose-pine-moon', transparent = true },
  ['rose-pine-main'] = { scheme = 'rose-pine', transparent = false },
}

local preset = PRESETS[ACTIVE] or PRESETS['moon']

-- Transparência em camadas.
--
-- Só o "chão" do editor fica sem fundo, para o blur do terminal aparecer.
-- Floats, menus e sidebar mantêm o fundo do tema de propósito: são superfícies
-- elevadas, e o contraste com o fundo borrado é o que dá profundidade.
-- Limpar tudo deixa a UI chapada e ilegível sobre o desktop.
local CLEAR_GROUPS = {
  'Normal',
  'NormalNC',
  'SignColumn',
  'LineNr',
  'LineNrAbove',
  'LineNrBelow',
  'FoldColumn',
  'EndOfBuffer',
  'MsgArea',
  'VertSplit',
  'WinSeparator',
  'StatusLine',
  'StatusLineNC',
  'DiagnosticVirtualTextError',
  'DiagnosticVirtualTextWarn',
  'DiagnosticVirtualTextInfo',
  'DiagnosticVirtualTextHint',
}

-- Painéis que o tema linka a Normal e que, por isso, herdariam a transparência.
-- Recebem o fundo de NormalFloat para continuarem lendo como superfície elevada.
local SURFACE_GROUPS = {
  'NeoTreeNormal',
  'NeoTreeNormalNC',
  'NeoTreeEndOfBuffer',
  'NeoTreeWinSeparator',
  'TelescopeNormal',
  'TelescopeBorder',
  'TelescopePromptNormal',
  'TelescopePromptBorder',
  'TelescopeResultsNormal',
  'TelescopeResultsBorder',
  'TelescopePreviewNormal',
  'TelescopePreviewBorder',
  'WhichKeyNormal',
  'LazyNormal',
  'MasonNormal',
}

local function apply_transparency()
  for _, group in ipairs(CLEAR_GROUPS) do
    vim.api.nvim_set_hl(0, group, { bg = 'none', ctermbg = 'none' })
  end

  local surface = vim.api.nvim_get_hl(0, { name = 'NormalFloat' }).bg
  if not surface then return end

  for _, group in ipairs(SURFACE_GROUPS) do
    local hl = vim.api.nvim_get_hl(0, { name = group })
    hl.bg = surface
    vim.api.nvim_set_hl(0, group, hl)
  end
end

if preset.transparent then
  vim.api.nvim_create_autocmd('ColorScheme', {
    group = vim.api.nvim_create_augroup('theme-transparency', { clear = true }),
    pattern = '*',
    callback = apply_transparency,
  })
end

local is_catppuccin = preset.scheme:match '^catppuccin' ~= nil
local is_rose_pine = preset.scheme:match '^rose%-pine' ~= nil
local is_tokyonight = not is_catppuccin and not is_rose_pine

local function apply()
  vim.cmd.colorscheme(preset.scheme)
  if preset.transparent then apply_transparency() end
end

return {
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    -- Os plugins ficam opacos de propósito: a transparência é aplicada
    -- seletivamente em CLEAR_GROUPS, para preservar as superfícies elevadas.
    opts = {
      transparent = false,
      styles = {
        comments = { italic = false },
        sidebars = 'dark',
        floats = 'dark',
      },
    },
    config = function(_, opts)
      require('tokyonight').setup(opts)
      if is_tokyonight then apply() end
    end,
  },

  {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = false,
    priority = 1000,
    opts = {
      transparent_background = false,
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

  {
    'rose-pine/neovim',
    name = 'rose-pine',
    lazy = false,
    priority = 1000,
    opts = {
      variant = 'moon',
      dark_variant = 'moon',
      styles = {
        italic = false,
        transparency = false,
      },
    },
    config = function(_, opts)
      require('rose-pine').setup(opts)
      if is_rose_pine then apply() end
    end,
  },
}
