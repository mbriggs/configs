-- file explorer
return {
	"stevearc/oil.nvim",
	cmd = "Oil",
	lazy = false,
	opts = {
		win_options = { number = false },
		prompt_save_on_select_new_entry = true,
		skip_confirm_for_simple_edits = true,
		use_default_keymaps = false,
		keymaps = {
			["g?"] = "actions.show_help",
			["<CR>"] = "actions.select",
			["<leader>'"] = "actions.select_vsplit",
			['<leader>"'] = "actions.select_split",
			["<tab>"] = "actions.preview",
			["q"] = "actions.close",
			["<C-l>"] = "actions.refresh",
			["-"] = "actions.parent",
			["_"] = "actions.open_cwd",
			["g."] = "actions.toggle_hidden",
		},
	},
	-- Optional dependencies
	dependencies = { "nvim-tree/nvim-web-devicons" },
}
