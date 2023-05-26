-- Tools --
-- add tools to nvim
return {
  -- diff stuff
  { "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim" },

  -- run tests
  {
    "janko/vim-test",
    requires = "preservim/vimux",
    config = [[vim.g['test#strategy'] = 'vimux']],
  },
  -- with code coverage
  {
    "andythigpen/nvim-coverage",
    name = "coverage",
    requires = "nvim-lua/plenary.nvim",
  },
  -- search & replace panel
  {
    "windwp/nvim-spectre",
    name = "spectre",
    requires = "nvim-lua/plenary.nvim",
  },
}
