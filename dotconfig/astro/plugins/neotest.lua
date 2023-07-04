-- test running
return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-neotest/neotest-go",
		"olimorris/neotest-rspec",
		"zidhuss/neotest-minitest",
		"haydenmeade/neotest-jest",
	},
	config = function()
		require("neotest").setup({
			adapters = {
				require("neotest-go"),
				require("neotest-rspec"),
				require("neotest-minitest"),
				require("neotest-jest")({
					jestCommand = "jest --watch ",
				}),
			},
		})
	end,
}
