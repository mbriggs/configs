local capabilities = vim.lsp.protocol.make_client_capabilities()

local has_blink, blink = pcall(require, "blink.cmp")
if has_blink then
	capabilities = blink.get_lsp_capabilities(capabilities)
end

vim.lsp.config("*", {
	capabilities = capabilities,
})

for _, name in ipairs({
	"bashls",
	"cssls",
	"dockerls",
	"herb_ls",
	"jsonls",
	"lua_ls",
	"marksman",
	"ruby_lsp",
	"sqlls",
	"tailwindcss",
	"ts_ls",
	"yamlls",
	"docker_compose_language_service",
	"html",
	"stimulus",
}) do
	vim.lsp.enable(name)
end

vim.diagnostic.config({
	underline = true,
	virtual_text = false,
	update_in_insert = false,
	signs = {
		text = { -- <- nested
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.HINT] = "",
			[vim.diagnostic.severity.INFO] = "",
		},
	},
	float = {
		focusable = false,
		style = "minimal",
		border = "rounded",
		source = true,
		header = "",
		prefix = "",
		close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
	},
})
