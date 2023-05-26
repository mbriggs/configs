-- LSP --
-- language server tools
return {
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
		requires = { "kyazdani42/nvim-web-devicons", lazy = false },
		cmd = "TroubleToggle",
	},
	-- toggle diagnostic style
	{
		"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
		event = "LspAttach",
		config = function()
			require("lsp_lines").setup()
		end,
	},
	-- provide a single command for both references and definition
	{ "KostkaBrukowa/definition-or-references.nvim" },
}
