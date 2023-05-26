-- LSP --
-- language server tools
return {
	-- popup documentation
	{
		"ray-x/lsp_signature.nvim",
		name = "lsp_signature",
		event = "BufRead",
	},
	-- refactoring tools
	{
		"ThePrimeagen/refactoring.nvim",
		requires = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-treesitter/nvim-treesitter" },
		},
	},
	-- generate debug statements
	{
		"andrewferrier/debugprint.nvim",
		name = "debugprint",
	},
	-- diagnostic window
	{
		"folke/lsp-trouble.nvim",
		name = "trouble",
		requires = "kyazdani42/nvim-web-devicons",
		cmd = "TroubleToggle",
	},
	{
		"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
		event = "LspAttach",
		config = function()
			require("lsp_lines").setup()
		end,
	},
}