return {
	"folke/trouble.nvim",
	cmd = "Trouble",
	config = true,
	keys = {
		{ "<leader>xa", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
		{ "<leader>xx", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
	},
}
