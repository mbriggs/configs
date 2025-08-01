-- Substitute operator to replace text with whatever is in the unnamed register
return {
  "gbprod/substitute.nvim",
  config = true,
  keys = {
    { "S", "<cmd>lua require('substitute').operator()<cr>", desc = "substitute" },
    { "S", "<cmd>lua require('substitute').visual()<cr>",   desc = "substitute", mode = { "v", "x" } },
  },
}
