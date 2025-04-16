local map = vim.keymap.set

vim.g.terminal_scrollback_buffer_size = 500000

map("t", "<Esc>", "<C-\\><C-n>", { silent = true })

map("t", "<D-h>", "<C-\\><C-n><C-w>h")
map("t", "<D-j>", "<C-\\><C-n><C-w>j")
map("t", "<D-k>", "<C-\\><C-n><C-w>k")
map("t", "<D-l>", "<C-\\><C-n><C-w>l")

vim.api.nvim_create_autocmd("TermOpen", {
  callback = function()
    -- Get the command that opened the terminal
    local cmd = vim.bo.channel
        and vim.fn.jobpid(vim.bo.channel)
        and vim.split(vim.fn.system(string.format("ps -p %d -o comm=", vim.fn.jobpid(vim.bo.channel))), "\n")[1]

    -- Only proceed if it's a regular shell
    if cmd and (cmd:match("sh$") or cmd:match("bash$") or cmd:match("zsh$")) then
      vim.cmd("startinsert") -- Start in insert mode

      map({ "t", "n" }, "<C-,>", function()
        vim.cmd("stopinsert")
        vim.cmd("TermRename")
      end, { buffer = true })
    end
  end,
})

vim.api.nvim_create_user_command("TermRename", function()
  vim.ui.input({
    prompt = "Terminal name: ",
  }, function(name)
    if name then
      -- Get current buffer number
      local bufnr = vim.api.nvim_get_current_buf()
      -- Set the buffer name
      vim.api.nvim_buf_set_name(bufnr, "*" .. name .. "*")
    end
  end)
end, {})
