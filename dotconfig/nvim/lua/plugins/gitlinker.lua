return {
	"ruifm/gitlinker.nvim",
	name = "gitlinker",
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {
		opts = {
			print_url = false,
		},
		mappings = "<nop>",
	},
	keys = {
		{
			"<leader>gy",
			function()
				require("gitlinker").get_buf_range_url("n")
			end,
			desc = "Generate github link to current line",
		},
		{
			"<leader>gy",
			function()
				require("gitlinker").get_buf_range_url("v")
			end,
			mode = "v",
			desc = "Generate github link to current line",
		},
	},
}
