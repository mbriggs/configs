-- core plugins

return {
	-- move splits around
	{ "sindrets/winshift.nvim", name = "winshift" },
	-- open file
	{ "justinmk/vim-gtfo" },
	-- correct typos on file open from cli
	{ "mong8se/actually.nvim" },
	-- casing aware search and replace
	{ "lambdalisue/reword.vim" },
	-- reload file with sudo
	{ "lambdalisue/suda.vim" },
	-- utility mappings
	{ "tpope/vim-unimpaired" },
	-- highlight unique chars
	{ "jinh0/eyeliner.nvim" },
	-- zoom pane with <C-w>m
	{ "dhruvasagar/vim-zoom" },
	-- shadowenv integration
	{ "Shopify/shadowenv.vim", lazy = false },
	-- copilot
	{
		"github/copilot.vim",
		event = "BufReadPost",
		config = function()
			vim.cmd([[:Copilot setup]])
		end,
	},
}
