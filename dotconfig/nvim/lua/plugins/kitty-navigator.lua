local map = vim.keymap.set

return {
	"knubie/vim-kitty-navigator",
	event = "VeryLazy",
	build = "cp ./*.py ~/.config/kitty/",
	init = function()
		vim.g.kitty_navigator_no_mappings = 1
	end,
	config = function()
		if vim.g.neovide then
			local modes = { "n", "v", "i" }
			map(modes, "<D-h>", "<c-w>h", { desc = "navigate left", silent = true })
			map(modes, "<D-j>", "<c-w>j", { desc = "navigate down", silent = true })
			map(modes, "<D-k>", "<c-w>k", { desc = "navigate up", silent = true })
			map(modes, "<D-l>", "<c-w>l", { desc = "navigate right", silent = true })

			map("t", "<D-h>", "<C-\\><C-n><c-w>h", { desc = "navigate left", silent = true })
			map("t", "<D-j>", "<C-\\><C-n><c-w>j", { desc = "navigate down", silent = true })
			map("t", "<D-k>", "<C-\\><C-n><c-w>k", { desc = "navigate up", silent = true })
			map("t", "<D-l>", "<C-\\><C-n><c-w>l", { desc = "navigate right", silent = true })
			return
		end

		local modes = { "n", "v", "t" }
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
