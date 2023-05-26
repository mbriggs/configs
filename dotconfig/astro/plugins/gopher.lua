-- go tooling
return {
	"olexsmir/gopher.nvim",
	name = "gopher",
	requires = { -- dependencies
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	opts = {
		commands = {
			go = "go",
			gomodifytags = "gomodifytags",
			gotests = "~/go/bin/gotests", -- also you can set custom command path
			impl = "impl",
			iferr = "iferr",
		},
	}
}
