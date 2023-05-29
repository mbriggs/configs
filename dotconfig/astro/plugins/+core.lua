-- core plugins

return {
	-- move splits around
	{ "sindrets/winshift.nvim", cmd = "WinShift", name = "winshift" },
	-- open file
	{ "justinmk/vim-gtfo", event = "BufReadPost" },
	-- correct typos on file open from cli
	{ "mong8se/actually.nvim", event = "BufReadPost" },
	-- casing aware search and replace
	{ "lambdalisue/reword.vim", cmd = "Reword" },
	-- reload file with sudo
	{ "lambdalisue/suda.vim", event = "BufReadPost" },
	-- utility mappings
	{ "tpope/vim-unimpaired", event = "BufReadPost" },
	-- highlight unique chars
	{ "jinh0/eyeliner.nvim", event = "BufReadPost" },
	-- zoom pane with <C-w>m
	{ "dhruvasagar/vim-zoom", event = "BufReadPost" },
	-- shadowenv integration
	{ "Shopify/shadowenv.vim", event = "BufReadPost" },
	{
		"chrisgrieser/nvim-spider",
		lazy = false,
		config = function()
			vim.keymap.set({ "n", "o", "x" }, "w", "<cmd>lua require('spider').motion('w')<CR>", { desc = "Spider-w" })
			vim.keymap.set({ "n", "o", "x" }, "e", "<cmd>lua require('spider').motion('e')<CR>", { desc = "Spider-e" })
			vim.keymap.set({ "n", "o", "x" }, "b", "<cmd>lua require('spider').motion('b')<CR>", { desc = "Spider-b" })
			vim.keymap.set(
				{ "n", "o", "x" },
				"ge",
				"<cmd>lua require('spider').motion('ge')<CR>",
				{ desc = "Spider-ge" }
			)
		end,
	},
	-- editorconfig
	{
		"gpanders/editorconfig.nvim",
		event = "BufReadPost",
		config = function()
			vim.g.editorconfig = false
		end,
	},
}
