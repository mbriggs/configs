return {
	"andrewferrier/debugprint.nvim",
	event = { "BufReadPost", "BufNewFile" },
	opts = {
		print_tag = "DBG",
		keymaps = {
			normal = {
				plain_below = "<leader>cp",
				plain_above = "<leader>cP",
				variable_below = "<leader>cv",
				variable_above = "<leader>cV",
				variable_below_alwaysprompt = nil,
				variable_above_alwaysprompt = nil,
				textobj_below = "<leader>co",
				textobj_above = "<leader>cO",
				toggle_comment_debug_prints = nil,
				delete_debug_prints = nil,
			},
			insert = {
				plain = "<C-G>p",
				variable = "<C-G>v",
			},
			visual = {
				variable_below = "<leader>cv",
				variable_above = "<leader>cV",
			},
		},
		commands = {
			toggle_comment_debug_prints = "ToggleCommentDebugPrints",
			delete_debug_prints = "DeleteDebugPrints",
		},
	},
	version = "*",
	keys = {
		{ "<leader>c/", "<cmd>ToggleCommentDebugPrints<cr>", desc = "Toggle Comment Debug Prints", silent = true },
		{ "<leader>cx", "<cmd>DeleteDebugPrints<cr>", desc = "Delete Debug Prints", silent = true },
	},
}
