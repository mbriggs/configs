local null_ls = require("null-ls")

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

local lsp_formatting = function(bufnr)
	vim.lsp.buf.format({
		filter = function(client)
			-- apply whatever logic you want (in this example, we'll only use null-ls)
			return client.name == "null-ls"
		end,
		bufnr = bufnr,
	})
end

-- if you want to set up formatting on save, you can use this as a callback
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

return {
	debug = false,
	sources = {
		formatting.prettierd,
		formatting.cmake_format,
		formatting.shfmt,
		formatting.goimports,
		formatting.sqlformat,
		formatting.stylua,
		formatting.cljstyle,
		formatting.rubocop,
		formatting.mix,

		diagnostics.shellcheck,
		diagnostics.codespell,
		diagnostics.eslint_d,
		diagnostics.hadolint,
		diagnostics.proselint,
		diagnostics.golangci_lint,

		code_actions.eslint_d,
		code_actions.shellcheck,
		code_actions.refactoring,
	},

	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					lsp_formatting(bufnr)
				end,
			})
		end
	end,
}
