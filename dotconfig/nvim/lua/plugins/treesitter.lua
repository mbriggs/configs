return {
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		build = ":TSUpdate",
		event = { "VeryLazy" },
		config = function()
			require("nvim-treesitter.configs").setup({
				-- A list of parser names, or "all"
				ensure_installed = {
					"vimdoc",
					"javascript",
					"typescript",
					"markdown",
					"markdown_inline",
					"html",
					"embedded_template",
					"c",
					"lua",
					"templ",
					"rust",
					"regex",
					"jsdoc",
					"bash",
					"sql",
					"ruby",
					"go",
					"gomod",
					"gowork",
					"gosum",
					"yaml",
				},

				-- Install parsers synchronously (only applied to `ensure_installed`)
				sync_install = false,

				-- Automatically install missing parsers when entering buffer
				-- Recommendation: set to false if you don"t have `tree-sitter` CLI installed locally
				auto_install = true,

				indent = {
					enable = true,
					disable = { "ruby" },
				},

				highlight = {
					-- `false` will disable the whole extension
					enable = true,
					additional_vim_regex_highlighting = { "markdown" },
				},

				autotag = {
					enable = true,
				},

				textobjects = {
					enable = true,
					lookahead = true,
				},
			})

			-- trying to get ts ruby stuff better
			-- vim.g.ruby_indent_assignment_style = "variable"
			-- vim.g.ruby_indent_block_style = "do"
			-- vim.g.ruby_indent_access_modifier_style = "indent"
			-- vim.g.ruby_indent_hanging_elements = 1
			-- vim.g.ruby_operators = 1
			-- vim.g.ruby_indent_dot_match_mark_style = 'lambda'
			-- vim.g.ruby_indent_continuations = 1

			-- use native ruby indentation
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "ruby",
				callback = function()
					vim.opt_local.indentexpr = "GetRubyIndent()"
					vim.opt_local.autoindent = true
					vim.opt_local.smartindent = true
				end,
			})

			require("nvim-treesitter.install").compilers = { "gcc-14" }
		end,
	},
}
