return {
	"hashino/doing.nvim",
	event = { "BufReadPost", "BufNewFile" },
	opts = {
		winbar = {
			enabled = false,
			-- ignores buffers that match filetype
			ignored_buffers = { "NvimTree" },
		},

		doing_prefix = "Current Task: ",
		store = {
			-- automatically create a .tasks when calling :Do
			auto_create_file = true,
			file_name = ".tasks",
		},
	},

	keys = {
		{ "<leader>dd", [[<cmd>Do<cr>]], desc = "Do something", silent = true },
		{ "<leader>dD", [[<cmd>Do!<cr>]], desc = "Do something later", silent = true },
		{ "<leader>dn", [[<cmd>Done<cr>]], desc = "Done", silent = true },
		{ "<leader>de", [[<cmd>DoEdit<cr>]], desc = "Doing", silent = true },
	},
}
