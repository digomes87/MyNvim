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
    vim.api.nvim_set_hl(0, 'goBuiltinPrint', { fg = '#ff9e64', underline = true }) -- laranja: println/printf builtin em Go
  end,
})

-- Fallback caso o tema em uso não case com nenhum prefixo da lista acima
vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = '*',
  callback = function() vim.api.nvim_set_hl(0, 'goBuiltinPrint', { fg = '#ff9e64', underline = true }) end,
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

-- Apaga o buffer vazio [No Name] criado no startup (nvim sem arquivo) assim
-- que um arquivo real é aberto; sem isso ele fica preso na bufferline.
vim.api.nvim_create_autocmd('BufWinEnter', {
  group = vim.api.nvim_create_augroup('wipe-no-name', { clear = true }),
  callback = function(ev)
    if vim.api.nvim_buf_get_name(ev.buf) == '' then return end
    vim.schedule(function()
      for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if buf ~= ev.buf
            and vim.api.nvim_buf_is_valid(buf)
            and vim.api.nvim_buf_get_name(buf) == ''
            and vim.bo[buf].buftype == ''
            and not vim.bo[buf].modified
            and vim.bo[buf].buflisted
            and vim.api.nvim_buf_line_count(buf) == 1
            and vim.api.nvim_buf_get_lines(buf, 0, -1, false)[1] == ''
        then
          pcall(vim.api.nvim_buf_delete, buf, {})
        end
      end
    end)
  end,
})

-- Go: "autocorreção" e alerta para os builtins println/printf
-- 1) iabbrev: digitar println/printf + espaço vira fmt.Println/fmt.Printf
--    (o import é adicionado pelo goimports no save; Ctrl-] escapa da abrev)
-- 2) highlight: qualquer println(/printf( builtin restante no buffer (colado,
--    digitado com Ctrl-], etc.) fica sublinhado em laranja — o correto em Go
--    é fmt.Println (P maiúsculo); o builtin escreve no stderr e não é o que
--    você quer.
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('go-builtin-print', { clear = true }),
  pattern = 'go',
  callback = function(ev)
    vim.api.nvim_buf_call(ev.buf, function()
      vim.cmd [[iabbrev <buffer> println fmt.Println]]
      vim.cmd [[iabbrev <buffer> printf fmt.Printf]]
    end)

    vim.fn.matchadd('goBuiltinPrint', [[\v<prin(tln|tf)>\ze\s*\(]]) -- ignora fmt.Println (P maiúsculo não casa) e println sem (
  end,
})

-- Atualiza o destaque conforme o código muda (o matchadd sozinho cobre o
-- buffer inteiro; só revalidamos ao entrar no buffer/mudar texto)
vim.api.nvim_create_autocmd({ 'BufEnter', 'TextChanged', 'InsertLeave' }, {
  group = vim.api.nvim_create_augroup('go-builtin-print-refresh', { clear = true }),
  pattern = '*.go',
  callback = function()
    for _, m in ipairs(vim.fn.getmatches()) do
      if m.group == 'goBuiltinPrint' then vim.fn.matchdelete(m.id) end
    end
    vim.fn.matchadd('goBuiltinPrint', [[\v<prin(tln|tf)>\ze\s*\(]])
  end,
})

-- Destaca o texto copiado por um instante
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})
