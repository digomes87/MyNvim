-- Autocommands pessoais

-- Recarrega arquivos alterados externamente (ex.: edições feitas no VSCode)
vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter', 'CursorHold', 'CursorHoldI' }, {
  group = vim.api.nvim_create_augroup('auto-reload', { clear = true }),
  pattern = '*',
  callback = function()
    if vim.fn.mode() ~= 'c' then vim.cmd 'checktime' end
  end,
})

-- Highlights customizados para Python, calibrados por tema (os hex eram
-- do tokyonight; no catppuccin usam a paleta equivalente). Temas fora da
-- lista ficam com a paleta própria do colorscheme.
local python_hl = {
  tokyonight = { var = '#569CD6', punct = '#e0af68' },
  catppuccin = { var = '#89b4fa', punct = '#f9e2af' },
}

vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = '*',
  callback = function()
    local name = vim.g.colors_name or ''
    local palette
    for prefix, colors in pairs(python_hl) do
      if name:sub(1, #prefix) == prefix then
        palette = colors
        break
      end
    end
    if not palette then return end
    vim.api.nvim_set_hl(0, '@punctuation.special.python', { fg = palette.punct, bold = true })
    vim.api.nvim_set_hl(0, '@variable.python', { fg = palette.var, bold = true })
  end,
})

-- Configuração específica para C/C++
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'c', 'cpp' },
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.expandtab = true
    vim.opt_local.cindent = true
    vim.opt_local.cinoptions = ':0,l1,g0,t0,(0'

    -- Desativa o guess-indent para C/C++
    vim.b.guessindent_disable = true
  end,
})

-- Desativar treesitter no markdown
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'markdown' },
  callback = function(ev)
    if vim.api.nvim_buf_is_valid(ev.buf) then pcall(vim.treesitter.stop, ev.buf) end
  end,
})

-- Preview de imagens no Kitty
vim.api.nvim_create_autocmd('BufEnter', {
  group = vim.api.nvim_create_augroup('image-preview', { clear = true }),
  pattern = { '*.png', '*.jpg', '*.jpeg', '*.gif', '*.webp', '*.bmp' },
  callback = function()
    if vim.env.TERM ~= 'xterm-kitty' then return end
    local ok, image = pcall(require, 'image')
    if not ok then return end
    vim.schedule(function()
      local path = vim.api.nvim_buf_get_name(0)
      local img = image.from_file(path, {
        buffer = vim.api.nvim_get_current_buf(),
        window = vim.api.nvim_get_current_win(),
        with_virtual_padding = true,
      })
      if img then img:render() end
    end)
  end,
})

-- Destaca o texto copiado por um instante
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})
