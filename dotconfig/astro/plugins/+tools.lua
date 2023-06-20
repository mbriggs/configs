-- Tools --
-- add tools to nvim
return {
	-- diff stuff
	{ "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim" },

	-- AI
	{
		"dpayne/CodeGPT.nvim",
		cmd = { "Chat" },
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("codegpt.config")
		end,
	},

	-- run tests
	{
		"janko/vim-test",
		dependencies = {
			"christoomey/vim-tmux-runner",
		},
		config = function()
			vim.g["test#strategy"] = "vtr"
		end,
		cmd = { "TestFile", "TestNearest", "TestSuite", "TestLast" },
	},
	-- with code coverage
	{
		"andythigpen/nvim-coverage",
		name = "coverage",
		requires = "nvim-lua/plenary.nvim",
	},
	-- search & replace panel
	{
		"windwp/nvim-spectre",
		name = "spectre",
		requires = "nvim-lua/plenary.nvim",
	},
	-- file explorer
	{
		"stevearc/oil.nvim",
		cmd = "Oil",
		opts = {
			number = false,
			keymaps = {
				["g?"] = "actions.show_help",
				["<CR>"] = "actions.select",
				["<leader>'"] = "actions.select_vsplit",
				['<leader>"'] = "actions.select_split",
				["<C-p>"] = "actions.preview",
				["`"] = "actions.close",
				["<C-l>"] = "actions.refresh",
				["-"] = "actions.parent",
				["_"] = "actions.open_cwd",
				["g."] = "actions.toggle_hidden",
			},
		},
		-- Optional dependencies
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
}
