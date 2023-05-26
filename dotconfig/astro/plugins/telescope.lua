return {
	{
		"nvim-telescope/telescope.nvim",
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
	{
		"smartpde/telescope-recent-files",
		after = "telescope.nvim",
		config = function()
			require("telescope").load_extension("recent_files")
		end
	},
	{
		"nvim-telescope/telescope-live-grep-args.nvim",
		after = "telescope.nvim",
		config = function()
			require("telescope").load_extension("live_grep_args")
		end
	},
	{
		"princejoogie/dir-telescope.nvim",
		after = "telescope.nvim",
		config = function()
			require("dir-telescope").setup({
				respect_gitignore = true,
				hidden = true,
			})

			require("telescope").load_extension("dir")
		end
	},
}
