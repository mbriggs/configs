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
					"jsdoc",
					"bash",
					"sql",
					"ruby",
					"go",
					"gomod",
					"gowork",
					"gosum",
				},

				-- Install parsers synchronously (only applied to `ensure_installed`)
				sync_install = false,

				-- Automatically install missing parsers when entering buffer
				-- Recommendation: set to false if you don"t have `tree-sitter` CLI installed locally
				auto_install = true,

				indent = {
					enable = true,
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

			vim.g.ruby_indent_assignment_style = "hanging"
			vim.g.ruby_indent_block_style = "do"
			vim.g.ruby_indent_access_modifier_style = "indent" -- Properly indents private/protected
			vim.g.ruby_indent_hanging_elements = 1 -- Better handling of hanging elements
			vim.g.ruby_operators = 1 -- Better operator highlighting

			require("nvim-treesitter.install").compilers = { "gcc-14" }
		end,
	},
}
