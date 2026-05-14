local M = {}
local state = {} -- { [bufnr] = { page, total, path } }

local function get_page_count(path)
  if vim.fn.executable 'pdfinfo' == 0 then return 1 end
  local out = vim.fn.system { 'pdfinfo', path }
  return tonumber(out:match('Pages:%s*(%d+)')) or 1
end

local function render(bufnr, winid, page)
  local s = state[bufnr]
  if not s then return end
  local ok, image = pcall(require, 'image')
  if not ok then return end

  image.clear { buffer = bufnr }

  local tmp = vim.fn.tempname()
  vim.fn.system {
    'pdftoppm', '-r', '200',
    '-f', tostring(page), '-l', tostring(page),
    '-png', '-singlefile',
    s.path, tmp,
  }

  local png = tmp .. '.png'
  if vim.fn.filereadable(png) == 0 then return end

  local img = image.from_file(png, {
    buffer = bufnr,
    window = winid,
    with_virtual_padding = true,
  })
  if img then img:render() end

  s.page = page

  local ns = vim.api.nvim_create_namespace 'pdf-indicator'
  vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
  vim.api.nvim_buf_set_extmark(bufnr, ns, 0, 0, {
    virt_text = { { string.format('  página %d / %d ', page, s.total), 'Comment' } },
    virt_text_pos = 'right_align',
  })
end

function M.setup()
  vim.api.nvim_create_autocmd('BufEnter', {
    group = vim.api.nvim_create_augroup('pdf-viewer', { clear = true }),
    pattern = '*.pdf',
    callback = function()
      if vim.env.TERM ~= 'xterm-kitty' then return end
      if vim.fn.executable 'pdftoppm' == 0 then return end

      local bufnr = vim.api.nvim_get_current_buf()
      local winid = vim.api.nvim_get_current_win()
      local path = vim.api.nvim_buf_get_name(bufnr)

      if not state[bufnr] then
        state[bufnr] = { page = 1, total = get_page_count(path), path = path }
      end

      -- Limpa interface para modo leitura
      vim.wo[winid].number = false
      vim.wo[winid].relativenumber = false
      vim.wo[winid].signcolumn = 'no'

      vim.schedule(function() render(bufnr, winid, state[bufnr].page) end)

      local function map(lhs, fn)
        vim.keymap.set('n', lhs, fn, { buffer = bufnr, silent = true, nowait = true })
      end

      -- j / k → próxima / anterior página
      map('j', function()
        local s = state[bufnr]
        if s and s.page < s.total then render(bufnr, vim.api.nvim_get_current_win(), s.page + 1) end
      end)
      map('k', function()
        local s = state[bufnr]
        if s and s.page > 1 then render(bufnr, vim.api.nvim_get_current_win(), s.page - 1) end
      end)

      -- gg → primeira página (ou <n>gg → página n)
      map('gg', function()
        local s = state[bufnr]
        if not s then return end
        local target = vim.v.count > 0 and vim.v.count or 1
        render(bufnr, vim.api.nvim_get_current_win(), math.max(1, math.min(target, s.total)))
      end)

      -- G → última página (ou <n>G → página n)
      map('G', function()
        local s = state[bufnr]
        if not s then return end
        local target = vim.v.count > 0 and vim.v.count or s.total
        render(bufnr, vim.api.nvim_get_current_win(), math.max(1, math.min(target, s.total)))
      end)
    end,
  })

  vim.api.nvim_create_autocmd('BufDelete', {
    callback = function(ev) state[ev.buf] = nil end,
  })
end

return M
