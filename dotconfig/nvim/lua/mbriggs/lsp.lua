local capabilities = vim.lsp.protocol.make_client_capabilities()

-- Enhance capabilities with blink.cmp if available
local has_blink, blink = pcall(require, "blink.cmp")
if has_blink then
	capabilities = blink.get_lsp_capabilities(capabilities)
end

-- Configure default settings for all servers
vim.lsp.config("*", {
	capabilities = capabilities,
})

-- Scan all 'lsp/*.lua' files in your runtimepath
vim.lsp.enable("bashls")
vim.lsp.enable("cssls")
vim.lsp.enable("dockerls")
vim.lsp.enable("herb_ls")
vim.lsp.enable("jsonls")
vim.lsp.enable("lua_ls")
vim.lsp.enable("ruby_lsp")
vim.lsp.enable("sqlls")
vim.lsp.enable("tailwindcss")
vim.lsp.enable("ts_ls")

vim.diagnostic.config({
	underline = true,
	update_in_insert = false,
	virtual_text = false,
	signs = {
		[vim.diagnostic.severity.ERROR] = " ",
		[vim.diagnostic.severity.WARN] = " ",
		[vim.diagnostic.severity.HINT] = " ",
		[vim.diagnostic.severity.INFO] = " ",
	},
	float = {
		focusable = false,
		style = "minimal",
		close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
		border = "rounded",
		source = true,
		header = "",
		prefix = "",
	},
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		local map = require("map")

		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf }
		local desc = map.desc(opts)

		local live_rename = require("live-rename")

		vim.keymap.set("n", "gD", Snacks.picker.lsp_type_definitions, desc("Go to type definition"))
		vim.keymap.set("n", "gd", Snacks.picker.lsp_definitions, desc("Go to definition"))
		vim.keymap.set("n", "<leader>.", Snacks.picker.lsp_definitions, desc("Go to definition"))

		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

		vim.keymap.set("n", "<leader>cD", Snacks.picker.lsp_type_definitions, desc("Go to type definition"))
		vim.keymap.set("n", "<leader>cd", Snacks.picker.lsp_definitions, desc("Go to definition"))
		vim.keymap.set("n", "<leader>ci", Snacks.picker.lsp_implementations, desc("Go to implementation"))
		vim.keymap.set("n", "<leader>cn", live_rename.map(), desc("Rename symbol"))
		vim.keymap.set("n", "<leader>cN", live_rename.map({ text = "", insert = true }), desc("Rename symbol"))
		vim.keymap.set("n", "<leader>cr", Snacks.picker.lsp_references, desc("Go to references"))
	end,
})
