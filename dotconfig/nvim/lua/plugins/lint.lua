return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		require("lint").linters_by_ft = {
			ruby = { "ruby", "rubocop" },
			html = { "tidy" },
			javascript = { "eslint" },
			typescript = { "eslint" },
			lua = { "luacheck" },
			sh = { "shellcheck" },
			zsh = { "zsh", "shellcheck" },
			bash = { "bash", "shellcheck" },
			make = { "checkmake" },
		}

		vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
			callback = function()
				require("lint").try_lint()
			end,
		})
	end,
}
