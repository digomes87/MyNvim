-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  lazy = false,
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
    -- Adicionando Cmd+B (D-b) e Ctrl+B (C-b) para alternar o Neo-tree
    { '<D-b>', ':Neotree toggle<CR>', desc = 'Toggle NeoTree', silent = true },
    { '<C-b>', ':Neotree toggle<CR>', desc = 'Toggle NeoTree', silent = true },
  },
  opts = {
    filesystem = {
      window = {
        mappings = {
          ['\\'] = 'close_window',
          ['H'] = 'open_split',
          ['V'] = 'open_vsplit',
        },
      },
      filtered_items = {
        visible = true, -- Mostrar arquivos ocultos por padrão
        hide_dotfiles = false,
        hide_gitignored = false,
      },
      follow_current_file = {
        enabled = true, -- Seguir o arquivo que está sendo editado
        leave_dirs_open = true, -- Manter diretórios abertos
      },
      use_libuv_file_watcher = true, -- Atualizar automaticamente quando houver mudanças no sistema de arquivos
    },
  },
}
