-- toggling quickfix
local function toggle_qf()
  local qf_open = false
  for _, win in pairs(vim.fn.getwininfo()) do
    if win.quickfix == 1 then
      qf_open = true
      break
    end
  end

  if qf_open then
    vim.cmd("cclose")
  else
    if not vim.tbl_isempty(vim.fn.getqflist()) then
      vim.cmd("copen")
    else
      print("Quickfix list is empty")
    end
  end
end

vim.keymap.set("n", "<leader>q", function()
  toggle_qf()
end, { desc = "toggle quickfix" })

-- removing items from quickfix
local del_qf_item = function()
  local items = vim.fn.getqflist()
  if #items == 0 then
    vim.notify("Quickfix list is empty", vim.log.levels.WARN)
    return
  end

  local line = vim.fn.line(".")
  if line <= #items then
    table.remove(items, line)
    vim.fn.setqflist(items, "r")
    if line > #items then
      line = #items
    end
    vim.api.nvim_win_set_cursor(0, { line, 0 })
  end
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  desc = "Setup quickfix list item removal",
  callback = function(opts)
    -- Normal mode mapping
    vim.keymap.set("n", "x", function()
      del_qf_item()
      vim.cmd("silent! call repeat#set('x', v:count)")
    end, {
      silent = true,
      buffer = opts.buf,
      desc = "Remove entry from quickfix list",
      nowait = true,
    })
  end,
})

-- navigate master/detail style
vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  callback = function(event)
    local opts = { buffer = event.buf, silent = true }
    vim.keymap.set("n", "<C-n>", "<cmd>cn | wincmd p<CR>", opts)
    vim.keymap.set("n", "<C-p>", "<cmd>cN | wincmd p<CR>", opts)
  end,
})
