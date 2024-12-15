return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
		bigfile = {
			enabled = true,
		},
		dashboard = {
			enabled = true,
			sections = { { section = "header" }, { section = "startup", gap = 1, padding = 1 } },
		},
		input = { enabled = true },
		notifier = { enabled = true },
		quickfile = { enabled = true },
	},
	keys = {
		{
			"<leader>gb",
			[[<cmd>lua Snacks.git.blame_line()<cr>]],
			desc = "Blame",
		},
		{
			"<leader>gg",
			[[<cmd>lua Snacks.lazygit.open()<cr>]],
			desc = "LazyGit",
		},
		{
			"<leader>gl",
			[[<cmd>lua Snacks.lazygit.log()<cr>]],
			desc = "Git Log",
		},
		{
			"<leader>gf",
			[[<cmd>lua Snacks.lazygit.log_file()<cr>]],
			desc = "Git Log (file)",
		},
		{
			"<leader>H",
			[[<cmd>lua Snacks.notifier.show_history()<cr>]],
			desc = "Notifier History",
		},
		{
			"<leader>k",
			[[<cmd>lua Snacks.scratch()<cr>]],
			desc = "Toggle Scratch Buffer",
		},
		{
			"<leader>K",
			[[<cmd>lua Snacks.scratch.select()<cr>]],
			desc = "Select Scratch Buffer",
		},
		{
			"<leader>Z",
			[[<cmd>lua Snacks.zen()<cr>]],
			desc = "Zen Mode",
		},
	},
}
