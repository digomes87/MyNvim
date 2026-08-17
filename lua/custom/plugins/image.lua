-- Configuração do image.nvim (preview de imagens no Kitty)

return {
  {
    '3rd/image.nvim',
    cond = function() return vim.env.TERM == 'xterm-kitty' end,
    opts = {
      backend = 'kitty',
      max_width_window_percentage = 100,
      max_height_window_percentage = 100,
      integrations = {
        markdown = { enabled = false },
      },
    },
  },
}
