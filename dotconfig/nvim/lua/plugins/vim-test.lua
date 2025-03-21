return {
	"vim-test/vim-test",
	lazy = true,

	init = function()
		vim.g["test#strategy"] = "neovim_sticky"
	end,

	keys = {
		{ "<leader>tt", "<cmd>TestNearest<cr>", desc = "Test Nearest" },
		{ "<leader>tf", "<cmd>TestFile<cr>", desc = "Test Current File" },
		{ "<leader>ta", "<cmd>TestSuite<cr>", desc = "Test Whole Suite" },
		{ "<leader>t;", "<cmd>TestLast<cr>", desc = "Rerun last test" },
		{ "<leader>tg", "<cmd>TestVisit<cr>", desc = "Visit last test" },
	},
}
