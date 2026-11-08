-- Troca rápida de tema em cima da prateleira de lua/custom/plugins/style.lua.
--
-- O tema escolhido persiste entre sessões: o autocmd abaixo salva cada
-- colorscheme aplicado em stdpath('state')/theme, e o spec ATIVO de
-- plugins/style.lua restaura o último no startup (sem tema salvo, aplica o
-- padrão dele). Os temas INSTALADOS ficam com lazy = true: o lazy.nvim
-- só carrega o plugin quando o colorscheme é invocado (handler de
-- ColorSchemePre), então não pesam no startup.

local M = {}

-- Último tema aplicado (restaurado no próximo startup).
local state_file = vim.fn.stdpath 'state' .. '/theme'

-- Persiste o tema aplicado para a próxima sessão.
vim.api.nvim_create_autocmd('ColorScheme', {
  group = vim.api.nvim_create_augroup('theme-persist', { clear = true }),
  callback = function()
    local name = vim.g.colors_name
    if not name then return end
    local f = io.open(state_file, 'w')
    if f then
      f:write(name)
      f:close()
    end
  end,
})

-- Colorschemes que entram no ciclo do <leader>ct.
-- Para incluir outro, torne-o INSTALADO em plugins/style.lua e some aqui.
M.list = {
  'kanagawa',
  'catppuccin',
  'tokyonight-moon',
  'cyberdream',
}

function M.apply(name)
  vim.cmd.colorscheme(name)
  vim.notify('Tema: ' .. name, vim.log.levels.INFO)
end

--- Restaura o último tema salvo. Retorna false quando não há tema salvo
--- ou quando ele não existe mais (aí o chamador aplica o padrão dele).
function M.restore()
  local f = io.open(state_file, 'r')
  if not f then return false end
  local name = f:read '*l'
  f:close()
  if not name or name == '' then return false end
  if vim.g.colors_name == name then return true end
  return pcall(vim.cmd.colorscheme, name)
end

--- Cicla para o próximo tema da lista (step = 1) ou o anterior (step = -1).
--- Se o tema atual não está na lista, começa do primeiro.
function M.cycle(step)
  step = step or 1
  local current = vim.g.colors_name or ''
  local index = 0
  -- match tolerante: o colors_name real pode ter sufixo de variante
  -- ('catppuccin-mocha') ou ser o nome-base ('kanagawa' para kanagawa-wave)
  for i, name in ipairs(M.list) do
    if current:sub(1, #name) == name or name:sub(1, #current) == current then
      index = i
      break
    end
  end
  M.apply(M.list[(index + step - 1) % #M.list + 1])
end

--- Abre o seletor do Telescope com preview do buffer atual.
--- Navegar já aplica o preview; <Esc> desfaz e <CR> mantém.
function M.picker()
  local ok, builtin = pcall(require, 'telescope.builtin')
  if not ok then
    M.cycle(1)
    return
  end
  builtin.colorscheme { enable_preview = true, ignore_builtins = true }
end

return M
