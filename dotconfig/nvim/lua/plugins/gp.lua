return {
	"robitx/gp.nvim",
	name = "gp",
	cmd = { "GpChatNew", "GpChatToggle", "GpChatPaste" },
	config = function()
		local opts = {
			default_chat_agent = "Claude",
			default_command_agent = "Claude",
			chat_template = require("gp.defaults").short_chat_template,
			providers = {
				openai = {
					disable = true,
				},
				anthropic = {
					disable = false,
					endpoint = "https://api.anthropic.com/v1/messages",
					secret = { "op", "read", "op://Private/Anthropic/credential" },
				},
			},
			agents = {
				{
					provider = "anthropic",
					name = "Claude",
					chat = true,
					command = false,
					-- string with model name or table with model name and parameters
					model = { model = "claude-3-5-sonnet-20240620", temperature = 0.8, top_p = 1 },
					-- system prompt (use this to specify the persona/role of the AI)
					system_prompt = require("gp.defaults").chat_system_prompt,
				},
			},
		}

		require("gp").setup(opts)
	end,
	keys = {
		{ "<leader>cc", "<cmd>GpChatToggle vsplit<cr>", desc = "Toggle code chat" },
		{ "<leader>cC", "<cmd>GpChatNew<cr>", desc = "New Chat" },
		{ "<leader>cp", ":<C-u>'<,'>GpChatPaste<cr>", desc = "Paste into Chat", mode = { "v" } },
		{ "<leader>c<cr>", "<cmd>GpChatRespond<cr>", desc = "Code chat respond" },
		{ "<leader>c?", "<cmd>GpChatFinder<cr>", desc = "Find a stored chat" },
	},
}
