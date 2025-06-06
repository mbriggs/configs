return {
  "coder/claudecode.nvim",
  config = true,
  keys = {
    { "<leader>cc", "<cmd>ClaudeCode<cr>",     desc = "Toggle Claude" },
    { "<leader>cs", "<cmd>ClaudeCodeSend<cr>", mode = "v",            desc = "Send to Claude" },
  },
}
