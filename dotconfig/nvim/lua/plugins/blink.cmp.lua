return {
  "saghen/blink.cmp",
  lazy = false,
  version = "v0.*",
  opts = {
    keymap = {
      ["<D-space>"] = { "show" },
      ["<S-CR>"] = { "hide" },
      ["<C-y>"] = { "accept" },
      ["<C-n>"] = { "select_next" },
      ["<C-p>"] = { "select_prev" },
      ["<PageDown>"] = { "scroll_documentation_down" },
      ["<PageUp>"] = { "scroll_documentation_up" },
    },
    sources = {
      default = { "codecompanion", "lazydev", "lsp", "path", "snippets", "buffer" },
      providers = {
        codecompanion = {
          name = "CodeCompanion",
          module = "codecompanion.providers.completion.blink",
          enabled = true,
        },
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          score_offset = 100,
        },
      },
    },
  },
}
