return {
  "saghen/blink.cmp",
  lazy = false,
  version = "v1.*",
  opts = {
    keymap = {
      ["<D-space>"] = { "show" },
      ["<S-CR>"] = { "hide" },
      ["<Tab>"] = { "accept" },
      ["<C-n>"] = { "select_next" },
      ["<C-p>"] = { "select_prev" },
      ["<PageDown>"] = { "scroll_documentation_down" },
      ["<PageUp>"] = { "scroll_documentation_up" },
    },
    sources = {
      default = {
        "lazydev",
        "lsp",
        "path",
        "snippets",
        "buffer",
      },

      providers = {
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          score_offset = 100,
        },
      },
    },
  },
}
