-- Configuração personalizada do treesitter

return {
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    opts = {
      ensure_installed = {
        'typescript',
        'javascript',
        'python',
        'bash',
        'c',
        'cpp',
        'diff',
        'html',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'query',
        'vim',
        'vimdoc',
        'latex',
        'rust',
        'go',
        'gomod',
        'gowork',
        'gosum',
      },
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { 'ruby' },
        disable = { 'markdown', 'markdown_inline' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
  },
}
