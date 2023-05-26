return {
	"nvim-treesitter/nvim-treesitter",
	opts = {
		sync_install = true,
		incremental_selection = {
			enable = true,
			keymap = {
				init_selection = "gnn",
				node_incremental = "grn",
				node_decremental = "grm",
			},
		},
		auto_install = true,
	}
}
