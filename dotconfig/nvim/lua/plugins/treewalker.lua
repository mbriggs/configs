return {
	"aaronik/treewalker.nvim",
	opts = {
		highlight = true, -- default is false
	},
	keys = {
		{ "<a-k>", "<cmd>Treewalker Up<CR>", silent = true },
		{ "<a-j>", "<cmd>Treewalker Down<CR>", silent = true },
		{ "<a-h>", "<cmd>Treewalker Left<CR>", silent = true },
		{ "<a-l>", "<cmd>Treewalker Right<CR>", silent = true },
	},
}
