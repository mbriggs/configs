local map = require("map")
return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"j-hui/fidget.nvim",
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		-- "hrsh7th/cmp-nvim-lsp",
		-- "hrsh7th/cmp-buffer",
		-- "hrsh7th/cmp-path",
		-- "hrsh7th/cmp-cmdline",
		-- "hrsh7th/nvim-cmp",
		-- { -- fork with a bunch of bugs fixed and better perf
		-- 	"iguanacucumber/magazine.nvim",
		-- 	name = "nvim-cmp",
		-- 	"j-hui/fidget.nvim",
		-- },
		-- {
		-- 	"folke/lazydev.nvim",
		-- 	ft = "lua",
		-- 	opts = {
		-- 		library = {
		-- 			{ path = "luvit-meta/library", words = { "vim%.uv" } },
		-- 		},
		-- 	},
		-- },
		{ "Bilal2453/luvit-meta", lazy = true },
	},
	event = { "BufReadPost", "BufNewFile" },
	cmd = { "LspInfo", "LspInstall", "LspUninstall", "Mason" },

	config = function()
		vim.filetype.add({ extension = { templ = "templ" } })
		--
		-- local cmp = require("cmp")
		-- local cmp_lsp = require("cmp_nvim_lsp")
		-- local capabilities = vim.tbl_deep_extend(
		-- 	"force",
		-- 	{},
		-- 	vim.lsp.protocol.make_client_capabilities(),
		-- 	cmp_lsp.default_capabilities()
		-- )
		--
		require("fidget").setup({})
		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls",
				"ts_ls",
				"gopls",
				"golangci_lint_ls",
				"templ",
				"html",
				"htmx",
				"tailwindcss",
			},
			handlers = {
				function(server_name) -- default handler (optional)
					require("lspconfig")[server_name].setup({
						capabilities = capabilities,
					})
				end,

				["lua_ls"] = function()
					local lspconfig = require("lspconfig")
					lspconfig.lua_ls.setup({
						capabilities = capabilities,
						settings = {
							Lua = {
								diagnostics = {
									globals = { "vim", "it", "describe", "before_each", "after_each" },
								},
							},
						},
					})
				end,

				-- required for templ
				["html"] = function()
					local lspconfig = require("lspconfig")
					lspconfig.html.setup({
						capabilities = capabilities,
						filetypes = { "html", "templ" },
					})
				end,

				["htmx"] = function()
					local lspconfig = require("lspconfig")
					lspconfig.html.setup({
						capabilities = capabilities,
						filetypes = { "html", "templ" },
					})
				end,

				["tailwindcss"] = function()
					local lspconfig = require("lspconfig")
					lspconfig.html.setup({
						capabilities = capabilities,
						filetypes = { "templ", "astro", "javascript", "typescript", "react" },
						init_options = { userLanguages = { templ = "html" } },
					})
				end,
				-- end templ
			},
		})

		-- local cmp_select = { behavior = cmp.SelectBehavior.Select }
		--
		-- cmp.setup({
		-- 	snippet = {
		-- 		expand = function(args)
		-- 			vim.snippet.expand(args.body)
		-- 		end,
		-- 	},
		-- 	mapping = cmp.mapping.preset.insert({
		-- 		["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
		-- 		["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
		-- 		["<C-Space>"] = cmp.mapping.complete(),
		-- 	}),
		-- 	sources = cmp.config.sources({
		-- 		{ name = "nvim_lsp", max_item_count = 25 },
		-- 		{ name = "lazydev", group_index = 0 },
		-- 	}),
		-- })

		vim.diagnostic.config({
			underline = true,
			update_in_insert = false,
			float = {
				focusable = false,
				style = "minimal",
				border = "rounded",
				source = "if_many",
				header = "",
				prefix = "",
			},
			signs = {
				[vim.diagnostic.severity.ERROR] = " ",
				[vim.diagnostic.severity.WARN] = " ",
				[vim.diagnostic.severity.HINT] = " ",
				[vim.diagnostic.severity.INFO] = " ",
			},
			virtual_text = {
				spacing = 4,
				source = "if_many",
				prefix = " ●",
			},
		})

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				-- Enable completion triggered by <c-x><c-o>
				vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

				-- Buffer local mappings.
				-- See `:help vim.lsp.*` for documentation on any of the below functions
				local opts = { buffer = ev.buf }
				local desc = map.desc(opts)

				vim.keymap.set("n", "gD", vim.lsp.buf.type_definition, desc("Go to type definition"))
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, desc("Go to definition"))
				vim.keymap.set("n", "<leader>.", vim.lsp.buf.definition, desc("Go to definition"))

				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

				vim.keymap.set("n", "<leader>cD", vim.lsp.buf.type_definition, desc("Go to type definition"))
				vim.keymap.set("n", "<leader>cd", vim.lsp.buf.definition, desc("Go to definition"))
				vim.keymap.set("n", "<leader>ci", vim.lsp.buf.implementation, desc("Go to implementation"))
				vim.keymap.set("n", "<leader>cn", vim.lsp.buf.rename, desc("Rename symbol"))
				vim.keymap.set("n", "<leader>cr", vim.lsp.buf.references, desc("Go to references"))
			end,
		})
	end,
}
