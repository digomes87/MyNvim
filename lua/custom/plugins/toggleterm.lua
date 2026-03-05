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

      -- Função para alternar terminal com <leader>tt
      -- Usamos count=1 para garantir que é sempre o terminal 1 (ou criar um novo se não houver)
      local Terminal = require('toggleterm.terminal').Terminal
      
      -- Mapeamento personalizado para <leader>tt
      vim.keymap.set('n', '<leader>tt', '<cmd>ToggleTerm direction=horizontal<CR>', { desc = '[T]oggle [T]erminal (Horizontal)' })
      
      -- Atalhos para facilitar a navegação dentro do terminal
      function _G.set_terminal_keymaps()
        local opts = {buffer = 0}
        vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
        vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
        vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
        vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
        vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
      end

      -- Aplica os atalhos apenas em buffers de terminal
      vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
    end
  }
}
