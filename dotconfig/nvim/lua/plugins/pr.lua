return {
	{
		"fredrikaverpil/pr.nvim",
		lazy = true,
		version = "*",
		opts = {},
		keys = {
			{
				"<leader>gv",
				function()
					require("pr").view()
				end,
				desc = "View PR in browser",
			},
		},
		cmd = { "PRView" },
	},
}
