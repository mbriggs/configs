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
			{
				"Theo-Steiner/togglescope",
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
			opts.defaults.file_ignore_patterns = { "^git/" }

			opts.extensions = opts.extensions or {}

			opts.extensions.togglescope = {
				find_files = {
					["<C-h>"] = {
						--- search through hidden files/directories
						hidden = true,
						--- search through ignored directories/files
						--- (I occasionally want to look into node_modules)
						no_ignore = true,
						--- when this config is active, set the title to this
						togglescope_title = "Find Files (hidden)",
					},
				},

				--- configure find_files as a togglescope picker
				live_grep = {
					--- on alternate file hotkey <C-^> toggle to the below config
					["<C-^>"] = {
						--- flags are passed to ripgrep using "additional_args"
						additional_args = {
							--- search through hidden files/directories
							"--hidden",
							--- search through ignored directories/files
							"--no-ignore",
							--- specify a glob for the search
							"-g",
							--- ignore the glob of "package-lock.json"
							"!package-lock.json",
						},
						--- when this config is active, set the title to this
						togglescope_title = "Live Grep (hidden)",
					},
				},
			}

			return opts
		end,
	},
}
