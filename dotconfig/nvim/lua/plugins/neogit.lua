return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  keys = {
    { "<leader>gg", function() require("neogit").open({ kind = "replace" }) end, desc = "Neogit" },
  },
}
