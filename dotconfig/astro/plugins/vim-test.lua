-- run tests
return {
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
}
