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

		return opts
	end
}
