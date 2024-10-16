return {
	"saghen/blink.cmp",
	lazy = false,
	version = "v0.*",

	opts = {
		highlight = {
			-- sets the fallback highlight groups to nvim-cmp's highlight groups
			-- useful for when your theme doesn't support blink.cmp
			-- will be removed in a future release, assuming themes add support
			use_nvim_cmp_as_default = true,
		},
		keymap = {
			show = "<C-space>",
			hide = "<C-e>",
			accept = "<Tab>",
			select_prev = { "<Up>", "<C-p>" },
			select_next = { "<Down>", "<C-n>" },

			show_documentation = {},
			hide_documentation = {},
			scroll_documentation_up = "<C-b>",
			scroll_documentation_down = "<C-f>",

			snippet_forward = "<Tab>",
			snippet_backward = "<S-Tab>",
		},
		-- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
		-- adjusts spacing to ensure icons are aligned
		nerd_font_variant = "normal",

		-- experimental auto-brackets support
		accept = { auto_brackets = { enabled = false } },

		-- experimental signature help support
		trigger = { signature_help = { enabled = true } },
	},
}
