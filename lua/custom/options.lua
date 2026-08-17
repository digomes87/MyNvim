-- Configurações pessoais de opções e paths
-- Mantém swap/shada/undo dentro do diretório de configuração

local config_dir = vim.fn.stdpath 'config'

local swap_dir = config_dir .. '/.swap//'
vim.fn.mkdir(swap_dir, 'p')
vim.opt.directory = swap_dir

local shada_dir = config_dir .. '/.state/shada'
vim.fn.mkdir(shada_dir, 'p')
vim.opt.shadafile = shada_dir .. '/main.shada'

local undo_dir = config_dir .. '/.undo//'
vim.fn.mkdir(undo_dir, 'p')
vim.opt.undodir = undo_dir

-- Opções gerais
vim.o.number = true
vim.o.mouse = 'a'
vim.o.showmode = false
vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = 'yes'
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣', eol = '↲' }
vim.o.inccommand = 'split'
vim.o.cursorline = true
vim.o.scrolloff = 10
vim.o.confirm = true
vim.o.autoread = true -- Recarrega arquivos alterados externamente
