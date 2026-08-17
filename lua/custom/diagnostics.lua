-- Configuração personalizada de diagnostics

vim.diagnostic.config {
  update_in_insert = false,
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = { severity = { min = vim.diagnostic.severity.WARN } },
  virtual_text = false,
  virtual_lines = {
    -- Cria uma linha virtual abaixo do código com a mensagem completa
    only_current_line = true, -- Mostra apenas na linha atual
    highlight_whole_line = true, -- Destaca a linha inteira
  },
  jump = { float = true },
}
