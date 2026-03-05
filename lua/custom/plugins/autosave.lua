return {
  'Pocco81/auto-save.nvim',
  config = function()
    require('auto-save').setup {
      enabled = true, -- Começa ativado
      trigger_events = { 'InsertLeave', 'TextChanged' }, -- Salva ao sair do modo insert ou mudar texto
      execution_message = {
        message = function() -- Mensagem discreta ao salvar
          return ('AutoSave: saved at ' .. vim.fn.strftime '%H:%M:%S')
        end,
        dim = 0.18, -- Opacidade da mensagem
        cleaning_interval = 1250, -- Tempo até a mensagem sumir (ms)
      },
      debounce_delay = 1000, -- Espera 1 segundo após parar de digitar para salvar (evita salvar a cada letra)
    }
  end,
}
