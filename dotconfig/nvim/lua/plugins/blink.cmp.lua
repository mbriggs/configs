return {
	"saghen/blink.cmp",
	lazy = false,
	version = "v0.*",
	dependencies = {
		"saghen/blink.compat",
		version = "*",
		lazy = true,
		opts = {
			impersonate_nvim_cmp = false,
		},
	},
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
			default = {
				"codecompanion",
				"lazydev",
				"lsp",
				"path",
				"snippets",
				"buffer",
				-- "avante_commands",
				-- "avante_mentions",
				-- "avante_files",
			},
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
				-- avante_commands = {
				-- 	name = "avante_commands",
				-- 	module = "blink.compat.source",
				-- 	score_offset = 90, -- show at a higher priority than lsp
				-- 	opts = {},
				-- },
				-- avante_files = {
				-- 	name = "avante_commands",
				-- 	module = "blink.compat.source",
				-- 	score_offset = 100, -- show at a higher priority than lsp
				-- 	opts = {},
				-- },
				-- avante_mentions = {
				-- 	name = "avante_mentions",
				-- 	module = "blink.compat.source",
				-- 	score_offset = 1000, -- show at a higher priority than lsp
				-- 	opts = {},
				-- },
			},
		},
	},
}
