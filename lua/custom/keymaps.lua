-- Atalhos pessoais que não fazem parte do kickstart padrão

-- Navegação entre buffers via bufferline
vim.keymap.set('n', '<Tab>', '<cmd>BufferLineCycleNext<CR>', { desc = 'Next buffer' })
vim.keymap.set('n', '<S-Tab>', '<cmd>BufferLineCyclePrev<CR>', { desc = 'Previous buffer' })
vim.keymap.set('n', '<leader>x', '<cmd>bdelete<CR>', { desc = 'Close buffer' })

-- Limpa o destaque da busca
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Navegação entre janelas
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Clipboard
vim.keymap.set('x', 'p', '"_dP', { desc = 'Paste without overwriting register' })
vim.keymap.set('n', '<leader>y', '"+y', { desc = 'Copy to clipboard' })
vim.keymap.set('v', '<leader>y', '"+y', { desc = 'Copy to clipboard' })

-- Explorador de arquivos e temas
vim.keymap.set('n', '<leader>e', '<cmd>Neotree toggle<CR>', { desc = '[E]xplorador de arquivos' })
vim.keymap.set('n', '<leader>ct', function() require('custom.theme').cycle(1) end, { desc = 'Próximo tema' })
vim.keymap.set('n', '<leader>cs', function() require('custom.theme').picker() end, { desc = 'Selecionar tema (preview)' })

-- Abre o guia de atalhos (COMANDOS.md) em split lateral; q fecha
vim.keymap.set('n', '<leader>?', function()
  vim.cmd.vsplit(vim.fn.stdpath 'config' .. '/COMANDOS.md')
  vim.bo.buflisted = false -- não polui a lista de buffers do bufferline
  vim.keymap.set('n', 'q', '<cmd>close<CR>', { buffer = 0, desc = 'Fechar guia' })
end, { desc = 'Guia de atalhos' })
