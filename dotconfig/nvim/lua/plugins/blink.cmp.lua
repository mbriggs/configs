local snippets_dir = vim.fn.stdpath("config") .. "/snippets"

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
