-- Objects --
-- custom text objects
return {
  -- space = operate on segment
  { "chaoren/vim-wordmotion", setup = [[vim.g.wordmotion_prefix = '<space>']] },
  -- gs = sort
  { "ralismark/opsort.vim" },
  -- many things
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    requires = "nvim-treesitter/nvim-treesitter",
  },
}
