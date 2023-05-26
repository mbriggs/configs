-- fix functionality to work better
return {
	-- highlight things like todo in comments
	{
		"folke/todo-comments.nvim",
		name = "todo-comments",
		requires = "nvim-lua/plenary.nvim",
		event = "BufRead",
	},
	-- open files over ssh
	{ "lambdalisue/vim-protocol", lazy = false },
	-- highlight yanks
	{ "machakann/vim-highlightedyank", event = "TextYankPost" },
	-- support . for more things
	{ "tpope/vim-repeat", event = "BufRead" },
	-- work on delims
	{
		"kylechui/nvim-surround",
		lazy = false,
		config = function()
			require("nvim-surround").setup({})
		end,
	},
	-- advanced qflist
	{
		"kevinhwang91/nvim-bqf",
		requires = {
			{
				"junegunn/fzf",
				dir = "~/.fzf",
				build = "./install --all",
			},
			"junegunn/fzf.vim",
		},
		ft = "qf",
		lazy = false,
	},
}
