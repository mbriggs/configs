-- configure lua lsp for neovim
return {
	"folke/neodev.nvim",
	opts = {
		library = { plugins = { "neotest" }, types = true },
	},
}
