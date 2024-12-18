local snippets_dir = vim.fn.stdpath("config") .. "/snippets"

return {
  "saghen/blink.cmp",
  lazy = "VeryLazy",
  version = "v0.*",

  dependencies = {
    {
      "chrisgrieser/nvim-scissors",
      lazy = false,
      dependencies = {
        "ibhagwan/fzf-lua",
        "stevearc/dressing.nvim"
      },
      opts = {
        snippetDir = snippets_dir,
      },
      keys = {
        {
          "<leader>Sa",
          [[<cmd>ScissorsAddNewSnippet<cr>]],
          mode = { "v", "n" },
          silent = true,
          desc = "Add Snippet",
        },
        { "<leader>Se", [[<cmd>ScissorsEditSnippet<cr>]], silent = true, desc = "Add Snippet" },
      },
    },
  },

  opts = {
    -- experimental signature help support
    trigger = { signature_help = { enabled = false } },
    highlight = { use_nvim_cmp_as_default = true },
    keymap = {
      ["<D-space>"] = { "show" },
      ["<S-CR>"] = { "hide" },
      ["<C-y>"] = { "accept" },
      ["<C-n>"] = { "select_next" },
      ["<C-p>"] = { "select_prev" },
      ["<PageDown>"] = { "scroll_documentation_down" },
      ["<PageUp>"] = { "scroll_documentation_up" },
    },
    nerd_font_variant = "mono",
    sources = {
      providers = {
        snippets = {
          opts = {
            search_paths = { snippets_dir },
          },
        },
      },
    },
  },
}
