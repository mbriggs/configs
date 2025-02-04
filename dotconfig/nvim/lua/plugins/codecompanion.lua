return {
	"olimorris/codecompanion.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		-- { "MeanderingProgrammer/render-markdown.nvim", ft = { "markdown", "codecompanion" } },
	},
	cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionActions" },
	opts = {
		strategies = {
			chat = {
				adapter = "anthropic",
			},
			inline = {
				adapter = "anthropic",
			},
		},
		adapters = {
			openai = function()
				return require("codecompanion.adapters").extend("openai", {
					env = {
						api_key = "cmd:op read op://Private/OpenAI/code-companion --no-newline",
					},
					schema = {
						model = {
							default = "o3-mini-high",
						},
					},
				})
			end,
			anthropic = function()
				return require("codecompanion.adapters").extend("anthropic", {
					env = {
						api_key = "cmd:op read op://Private/Anthropic/credential --no-newline",
					},
				})
			end,
		},
	},
	config = function(_, opts)
		require("mbriggs.notifier-codecompanion").setup()
		require("codecompanion").setup(opts)
	end,
	keys = {
		{ "<leader>cc", "<cmd>CodeCompanionChat toggle<cr>", desc = "Code Chat", mode = { "v", "n" } },
		{
			"<C-a>",
			"<cmd>CodeCompanionActions<cr>",
			silent = true,
			desc = "Code Companion Actions",
			mode = { "v", "n" },
		},
		{
			"ga",
			"<cmd>CodeCompanionChat Add<cr>",
			mode = { "v", "n" },
			desc = "Add to chat",
			noremap = true,
			silent = true,
		},
	},
}
