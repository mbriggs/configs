-- generate links to github
return {
	"ruifm/gitlinker.nvim",
	name = "gitlinker",
	event = "BufRead",
	requires = "nvim-lua/plenary.nvim",
	opts = {
		opts = {
			-- adds current line nr in the url for normal mode
			add_current_line_on_normal_mode = true,
			-- print the url after performing the action
			print_url = false,
			-- mapping to call url generation
			mappings = "<leader>gy",
		}
	}
}
