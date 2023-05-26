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

		opts.sources = cmp.config.sources({
			{ name = "nvim_lsp", priority = 1000 },
			{ name = "path", priority = 700 },
			{ name = "luasnip", priority = 500 },
			{ name = "nvim_lsp_signature_help" },
		})

		return opts
	end,

	dependencies = {
		{ "hrsh7th/cmp-nvim-lsp-signature-help" },
	},
}
