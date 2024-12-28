return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("tokyonight").setup({
      style = "moon",
      dim_inactive = true,
      hide_inactive_statusline = true
    })

    vim.cmd.colorscheme("tokyonight")
  end,
}
