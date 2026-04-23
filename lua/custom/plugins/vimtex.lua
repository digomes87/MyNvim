return {
  'lervag/vimtex',
  lazy = false,
  config = function()
    vim.g.vimtex_view_method = 'general'
    vim.g.vimtex_compiler_method = 'latexmk'
  end,
}
