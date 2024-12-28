return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = {
    options = {
      theme = "auto",
      globalstatus = true,
      disabled_filetypes = { statusline = { "dashboard", "alpha" } },
    },
    sections = {
      lualine_a = { "branch" },
      lualine_b = {},
      lualine_c = {
        { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
        { "filename", path = 1 },
        { "filesize" }
      },
      lualine_x = {
        {
          "diagnostics",
          symbols = {
            error = " ",
            warn = " ",
            info = " ",
            hint = " ",
          },
        },
        {
          "diff",
          symbols = {
            added = " ",
            modified = " ",
            removed = " ",
          },
        }
      },
      lualine_y = {},
      lualine_z = {
        { "progress", separator = " ",                  padding = { left = 1, right = 0 } },
        { "location", padding = { left = 0, right = 1 } },
      },
    },
    extensions = { "neo-tree", "lazy", "fzf" },
  },
}
