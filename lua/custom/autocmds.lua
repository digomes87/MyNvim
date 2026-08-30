-- Autocommands pessoais

-- Recarrega arquivos alterados externamente (ex.: edições feitas no VSCode)
vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter', 'CursorHold', 'CursorHoldI' }, {
  group = vim.api.nvim_create_augroup('auto-reload', { clear = true }),
  pattern = '*',
  callback = function()
    if vim.fn.mode() ~= 'c' then vim.cmd 'checktime' end
  end,
})

-- Highlights customizados para Python
vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = '*',
  callback = function()
    vim.api.nvim_set_hl(0, '@punctuation.special.python', { fg = '#e0af68', bold = true })
    vim.api.nvim_set_hl(0, '@variable.python', { fg = '#569CD6', bold = true })
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
    if vim.api.nvim_buf_is_valid(ev.buf) then
      pcall(vim.treesitter.stop, ev.buf)
    end
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
