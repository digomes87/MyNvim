-- Force Treesitter to start for Python files
vim.treesitter.start()

-- Ensure f-string highlight groups are available and correct
vim.api.nvim_set_hl(0, '@punctuation.special.python', { fg = '#e0af68', bold = true })
vim.api.nvim_set_hl(0, '@variable.python', { fg = '#569CD6', bold = true })
