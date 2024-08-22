return {
	"rachartier/tiny-code-action.nvim",
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
		{ "nvim-telescope/telescope.nvim" },
	},
	event = "LspAttach",
	config = function()
		require("tiny-code-action").setup()
	end,
	keys = {
		{ "<leader>ca", "<cmd>lua require('tiny-code-action').code_action()<CR>", desc = "Code action" },
	},
}