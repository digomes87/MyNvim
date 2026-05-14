return {
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    config = function()
      require('toggleterm').setup {
        size = 18, -- Tamanho do split (altura)
        open_mapping = [[<c-\>]], -- Atalho padrão para alternar (opcional)
        hide_numbers = true, -- Esconder números de linha no terminal
        shade_filetypes = {},
        shade_terminals = true,
        start_in_insert = true,
        insert_mappings = true, -- Permite usar o mapeamento de abertura no modo insert
        persist_size = true,
        direction = 'horizontal', -- O usuário pediu split horizontal
        close_on_exit = true, -- Fechar janela quando o processo sair
        shell = vim.o.shell, -- Usa o shell padrão
      }

      vim.keymap.set('n', '<leader>tt', '<cmd>ToggleTerm direction=horizontal<CR>', { desc = '[T]oggle [T]erminal (Horizontal)' })

      local function set_terminal_keymaps()
        local opts = { buffer = 0 }
        vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
        vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
        vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
        vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
        vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
      end

      vim.api.nvim_create_autocmd('TermOpen', {
        pattern = 'term://*',
        callback = set_terminal_keymaps,
      })
    end
  }
}
