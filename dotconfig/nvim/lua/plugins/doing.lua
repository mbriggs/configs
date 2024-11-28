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
		{ "<leader>d", [[<cmd>DoEdit<cr>]], desc = "Doing", silent = true },
	},
}
