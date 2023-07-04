-- movement
return {
	"folke/flash.nvim",
	event = "VeryLazy",
	---@type Flash.Config
	opts = {
		keys = {
			{
				"s",
				mode = { "n", "o", "x" },
				function()
					require("flash").treesitter()
				end,
			},
		},
		modes = {
			char = {
				enabled = false,
			},
		},
	},
}
