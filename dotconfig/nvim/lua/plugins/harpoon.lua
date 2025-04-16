return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  opts = {
    settings = {
      save_on_toggle = true,
    },
  },
  keys = {
    { "<leader>ha", "<cmd>lua require('harpoon'):list():add()<cr>",     silent = true,              desc = "Add to Harpoon" },
    {
      "<leader>hh",
      function() require('harpoon').ui:toggle_quick_menu(require('harpoon'):list()) end,
      silent = true,
      desc = "Toggle Harpoon",
    },
    { "<C-h>",      "<cmd>lua require('harpoon'):list():select(1)<cr>", desc = "Harpoon to file 1", silent = true,          mode = { "n", "t" } },
    { "<C-j>",      "<cmd>lua require('harpoon'):list():select(2)<cr>", desc = "Harpoon to file 2", silent = true,          mode = { "n", "t" } },
    { "<C-k>",      "<cmd>lua require('harpoon'):list():select(3)<cr>", desc = "Harpoon to file 3", silent = true,          mode = { "n", "t" } },
    { "<C-l>",      "<cmd>lua require('harpoon'):list():select(4)<cr>", desc = "Harpoon to file 4", silent = true,          mode = { "n", "t" } },
    { "<C-;>",      "<cmd>lua require('harpoon'):list():select(5)<cr>", desc = "Harpoon to file 5", silent = true,          mode = { "n", "t" } },
    { "<C-'>",      "<cmd>lua require('harpoon'):list():select(6)<cr>", desc = "Harpoon to file 6", silent = true,          mode = { "n", "t" } },
  },
}
