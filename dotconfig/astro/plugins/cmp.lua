return {
	"hrsh7th/nvim-cmp",
	opts = function(_, opts)
		local cmp = require("cmp")

		opts.mapping["<CR>"] = cmp.mapping.confirm({ select = true })
		opts.mapping["<Tab>"] = cmp.config.disable
		opts.mapping["<S-Tab>"] = cmp.config.disable
		opts.mapping["<ESC>"] = function(fallback)
			if cmp.visible() then
				cmp.abort()
			else
				fallback()
			end
		end

		cmp.event:on("menu_opened", function()
			vim.b.copilot_suggestion_hidden = true
		end)

		cmp.event:on("menu_closed", function()
			vim.b.copilot_suggestion_hidden = false
		end)

		return opts
	end,
}
