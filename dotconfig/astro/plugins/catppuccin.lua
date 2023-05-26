-- color scheme
return {
	"catppuccin/nvim",
	lazy = false,
	name = "catppuccin",
	opts = {
		integrations = {
			nvimtree = false,
			ts_rainbow = false,
			aerial = true,
			dap = { enabled = true, enable_ui = true },
			headlines = true,
			mason = true,
			neotree = true,
			noice = true,
			notify = true,
			octo = true,
			sandwich = true,
			semantic_tokens = true,
			symbols_outline = true,
			telescope = true,
			which_key = true,
		},
	},
	build = ":CatppuccinCompile"
}
