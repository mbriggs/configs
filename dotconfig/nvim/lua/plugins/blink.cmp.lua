return {
	"saghen/blink.cmp",
	lazy = false,
	version = "v0.*", -- REQUIRED release tag to download pre-built binaries

	opts = {
		-- experimental signature help support
		trigger = { signature_help = { enabled = true } },
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
	},
}
