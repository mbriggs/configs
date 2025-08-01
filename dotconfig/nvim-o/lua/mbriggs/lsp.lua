local capabilities = vim.lsp.protocol.make_client_capabilities()

local has_blink, blink = pcall(require, "blink.cmp")
if has_blink then
	capabilities = blink.get_lsp_capabilities(capabilities)
end

vim.lsp.config("*", {
	capabilities = capabilities,
	on_attach = function(client, bufnr)
		local opts = { buffer = bufnr, silent = true }

		-- Navigation
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
		vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

		-- Documentation
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
		vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, opts)

		-- Code actions
		vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "<leader>cn", vim.lsp.buf.rename, opts)
		vim.keymap.set("n", "<leader>cm", function()
			vim.lsp.buf.format({ async = true })
		end, opts)

		-- Diagnostics
		vim.keymap.set("n", "[d", function()
			vim.diagnostic.jump({ count = -1 })
		end, opts)
		vim.keymap.set("n", "]d", function()
			vim.diagnostic.jump({ count = 1 })
		end, opts)
		vim.keymap.set("n", "<leader>ce", vim.diagnostic.open_float, opts)
		vim.keymap.set("n", "<leader>cq", vim.diagnostic.setloclist, opts)

		-- Workspace
		vim.keymap.set("n", "<leader>cwa", vim.lsp.buf.add_workspace_folder, opts)
		vim.keymap.set("n", "<leader>cwr", vim.lsp.buf.remove_workspace_folder, opts)
		vim.keymap.set("n", "<leader>cwl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts)
	end,
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
