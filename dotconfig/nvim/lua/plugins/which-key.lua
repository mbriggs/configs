return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300

    local wk = require("which-key")

    wk.setup({
      preset = "classic",
      icons = {
        rules = false,
      },
      spec = {
        { "<leader>b",         group = "buffer" },
        { "<leader>c",         group = "code" },
        { "<leader>l",         group = "log" },
        { "<leader>f",         group = "find",         mode = { "v", "n" } },
        { "<leader>s",         group = "search" },
        { "<leader>f<leader>", group = "subdir" },
        { "<leader>g",         group = "git" },
        { "<leader>u",         group = "pull requests" },
        { "<leader>k",         group = "task" },
        { "<leader>r",         group = "rails" },
        { "<leader>o",         group = "org" },
        { "<leader>ob",        group = "babel" },
        { "<leader>oi",        group = "insert" },
        { "<leader>ol",        group = "link" },
        { "<leader>ox",        group = "task" },
        { "<leader>p",         group = "project" },
        { "<leader>h",         group = "harpoon" },
        { "<leader>a",         group = "aider" },
        { "<leader>t",         group = "test" },
        { "<leader>x",         group = "trouble" },
        { "<leader>S",         group = "snippets",     mode = { "v", "n" } },
      },
    })

    local function LocalKeybinds()
      local wkl = require("which-key")
      local fileTy = vim.api.nvim_buf_get_option(0, "filetype")
      local opts = { prefix = "<LocalLeader>", buffer = 0 }

      if fileTy == "norg" then
        wkl.add({
          { "ot", group = "task" },
          { "on", group = "note" },
          { "ol", group = "list" },
          { "oi", group = "insert" },
          { "om", group = "mode" },
        }, opts)
      end
    end
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "*",
      group = "userft",
      callback = LocalKeybinds,
    })
  end,
}
