-- fix functionality to work better
return {
	-- highlight things like todo in comments
	{
		"folke/todo-comments.nvim",
		name = "todo-comments",
		requires = "nvim-lua/plenary.nvim",
	},
	-- open files over ssh
	{ "lambdalisue/vim-protocol" },
	-- highlight yanks
	{ "machakann/vim-highlightedyank" },
	-- support . for more things
	{ "tpope/vim-repeat" },
	-- work on delims
	{ "kylechui/nvim-surround" },
	-- advanced qflist
	{
		"kevinhwang91/nvim-bqf",
		requires = {
			{ 
			  "junegunn/fzf", 
			  dir = "~/.fzf", 
			  build = "./install --all" 
			},
			"junegunn/fzf.vim",
		},
		ft = "qf",
	},

}
