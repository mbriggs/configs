return {
  {
    "fredrikaverpil/pr.nvim",
    lazy = true,
    version = "*",
    opts = {
      github_token = function()
        local cmd = { "op", "read", "op://Private/g27xw2tie5a2vmmsnkh5cnjgr4/API/pat", "--no-newline" }
        local obj = vim.system(cmd, { text = true }):wait()
        if obj.code ~= 0 then
          vim.notify("Failed to get token from 1Password", vim.log.levels.ERROR)
          return nil
        end
        return obj.stdout
      end,
    },
    keys = {
      {
        "<leader>gv",
        function()
          require("pr").view()
        end,
        desc = "View PR in browser",
      },
    },
    cmd = { "PRView" },
  },
}
