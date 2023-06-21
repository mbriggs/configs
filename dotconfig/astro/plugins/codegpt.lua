-- AI
return {
	"dpayne/CodeGPT.nvim",
	cmd = { "Chat" },
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		require("codegpt.config")
	end,
}
