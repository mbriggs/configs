local prettierconf = { "prettier_d_slim", "prettierd", "prettier", stop_after_first = true }

return {
	"stevearc/conform.nvim",
	lazy = true,
	cmd = "ConformInfo",
	keys = {
		{
			"<leader>cM",
			function()
				require("conform").format({ formatters = { "injected" }, timeout_ms = 3000 })
			end,
			mode = { "n", "v" },
			desc = "Format Injected Langs",
		},
		{
			"<leader>cm",
			function()
				require("conform").format()
			end,
			mode = { "n", "v" },
			desc = "Format",
		},
	},
	opts = function()
		local opts = {
			default_format_opts = {
				timeout_ms = 3000,
				async = false,
				quiet = false,
				lsp_format = "fallback",
			},
			formatters_by_ft = {
				lua = { "stylua" },
				fish = { "fish_indent" },
				sh = { "shfmt" },
				go = { "goimports" },
				typescript = prettierconf,
				javascript = prettierconf,
				typescriptreact = prettierconf,
				markdown = prettierconf,
				html = prettierconf,
				json = prettierconf,
				css = prettierconf,
				templ = { "templ" },
				sql = { "sql-formatter" },
				-- ruby = { "rubocop" },
			},
			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = true,
				condition = function(bufnr)
					-- Skip files matching these patterns
					local filename = vim.api.nvim_buf_get_name(bufnr)
					return not (filename:match("%.min%.[jc]ss$"))
				end,
			},

			formatters = {
				injected = { options = { ignore_errors = true } },
			},
		}
		return opts
	end,
}
