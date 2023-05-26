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
}
