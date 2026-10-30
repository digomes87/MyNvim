-- Troca rápida de tema em cima da prateleira de lua/custom/plugins/style.lua.
--
-- O tema padrão é aplicado no startup pelo spec ATIVO (enabled = true,
-- lazy = false). Os temas INSTALADOS ficam com lazy = true: o lazy.nvim
-- só carrega o plugin quando o colorscheme é invocado (handler de
-- ColorSchemePre), então não pesam no startup.

local M = {}

-- Colorschemes que entram no ciclo do <leader>ct.
-- Para incluir outro, torne-o INSTALADO em plugins/style.lua e some aqui.
M.list = {
  'catppuccin',
  'tokyonight-moon',
  'kanagawa',
  'cyberdream',
}

function M.apply(name)
  vim.cmd.colorscheme(name)
  vim.notify('Tema: ' .. name, vim.log.levels.INFO)
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
