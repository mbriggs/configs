-- go tooling
return {
	"olexsmir/gopher.nvim",
	ft = "go",
	name = "gopher",
	requires = { -- dependencies
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	config = true,
}
