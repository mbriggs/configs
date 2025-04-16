return {
  "joshuavial/aider.nvim",
  opts = {
    auto_manage_context = true,
    default_bindings = false,
    debug = false
  },
  keys = {
    { "<leader>aa", "<cmd>AiderOpen<cr>",             desc = "Open Aider" },
    { "<leader>am", "<cmd>AiderAddModifiedFiles<cr>", desc = "Add all git modified files" },
  }
}
