return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	opts = {
		settings = {
			save_on_toggle = true,
		},
	},
	keys = {
		{ "<leader>a", "<cmd>lua require('harpoon'):list():add()<cr>", silent = true, desc = "Add to Harpoon" },
		{
			"<leader>h",
			"<cmd>lua require('harpoon').ui:toggle_quick_menu(require('harpoon'):list())<cr>",
			silent = true,
			desc = "Toggle Harpoon",
		},
		{ "<C-h>", "<cmd>lua require('harpoon'):list():select(1)<cr>", desc = "Harpoon to file 1", silent = true },
		{ "<C-j>", "<cmd>lua require('harpoon'):list():select(2)<cr>", desc = "Harpoon to file 2", silent = true },
		{ "<C-k>", "<cmd>lua require('harpoon'):list():select(3)<cr>", desc = "Harpoon to file 3", silent = true },
		{ "<C-l>", "<cmd>lua require('harpoon'):list():select(4)<cr>", desc = "Harpoon to file 4", silent = true },
	},
}
