local null_ls = require("null-ls")

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

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
}
