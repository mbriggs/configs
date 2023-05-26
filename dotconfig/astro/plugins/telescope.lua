return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			{
				"princejoogie/dir-telescope.nvim",
				config = function()
					require("dir-telescope").setup({
						noignore = false,
						hidden = true,
					})

					require("telescope").load_extension("dir")
				end,
			},
			{
				"nvim-telescope/telescope-live-grep-args.nvim",
				config = function()
					require("telescope").load_extension("live_grep_args")
				end,
			},
			{
				"smartpde/telescope-recent-files",
				config = function()
					require("telescope").load_extension("recent_files")
				end,
			},
		},
		opts = function(_, opts)
			local actions = require("telescope.actions")
			opts.file_ignore_patterns = { "vendor" }

			opts.defaults.mappings.i["<C-n>"] = actions.move_selection_next
			opts.defaults.mappings.i["<C-p>"] = actions.move_selection_previous
			opts.defaults.mappings.i["<C-j>"] = actions.cycle_history_next
			opts.defaults.mappings.i["<C-k>"] = actions.cycle_history_prev
			opts.defaults.mappings.i["<ESC>"] = actions.close

			opts.defaults.mappings.n["<C-n>"] = actions.move_selection_next
			opts.defaults.mappings.n["<C-p>"] = actions.move_selection_previous

			return opts
		end,
	},
}
