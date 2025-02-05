return {
	"trevorhauter/gitportal.nvim",
	config = true,
	cmd = { "GitPortal" },
	keys = {
		{
			"<leader>gp",
			function()
				require("gitportal").open_file_in_browser()
			end,
			desc = "Open file in browser",
			mode = { "v", "n" },
		},
		{
			"<leader>gy",
			function()
				require("gitportal").copy_link_to_clipboard()
			end,
			desc = "Copy link to clipboard",
			mode = { "v", "n" },
		},
		{
			"<leader>gv",
			function()
				require("gitportal").open_file_in_neovim()
			end,
			desc = "Visit file in neovim",
		},
	},
}
