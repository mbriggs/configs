return {
	"knubie/vim-kitty-navigator",
	event = "VeryLazy",
	build = "cp ./*.py ~/.config/kitty/",
	init = function()
		vim.g.kitty_navigator_no_mappings = 1
	end,
	config = function()
		local map = vim.keymap.set
		local modes = { "n", "v" }

		map(modes, "<D-h>", ":KittyNavigateLeft<cr>", { desc = "kitty navigate left", silent = true })
		map(modes, "<D-j>", ":KittyNavigateDown<cr>", { desc = "kitty navigate down", silent = true })
		map(modes, "<D-k>", ":KittyNavigateUp<cr>", { desc = "kitty navigate up", silent = true })
		map(modes, "<D-l>", ":KittyNavigateRight<cr>", { desc = "kitty navigate right", silent = true })

		map("i", "<D-h>", "<c-o>:KittyNavigateLeft<cr>", { desc = "kitty navigate left", silent = true })
		map("i", "<D-j>", "<c-o>:KittyNavigateDown<cr>", { desc = "kitty navigate down", silent = true })
		map("i", "<D-k>", "<c-o>:KittyNavigateUp<cr>", { desc = "kitty navigate up", silent = true })
		map("i", "<D-l>", "<c-o>:KittyNavigateRight<cr>", { desc = "kitty navigate right", silent = true })
	end,
}
