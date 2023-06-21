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

	{
		"SmiteshP/nvim-navbuddy",
		after = "neovim/nvim-lspconfig",
		event = "LspAttach",
		dependencies = {
			"SmiteshP/nvim-navic",
			"MunifTanjim/nui.nvim",
		},
		opts = { lsp = { auto_attach = true } },
	},
	{
		"ray-x/lsp_signature.nvim",
		event = "BufRead",
		config = function()
			require("lsp_signature").setup()
			vim.api.nvim_create_augroup("LspAttach_signature", {})
			vim.api.nvim_create_autocmd("LspAttach", {
				group = "LspAttach_signature",
				callback = function(args)
					if not (args.data and args.data.client_id) then
						return
					end

					local bufnr = args.buf
					require("lsp_signature").on_attach({}, bufnr)
				end,
			})
		end,
	},
}
