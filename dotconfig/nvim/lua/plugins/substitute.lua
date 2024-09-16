-- Substitute operator to replace text with whatever is in the unnamed register

return {
	"gbprod/substitute.nvim",
	lazy = false,
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
	},
	config = function(opts)
		require("substitute").setup(opts)

		vim.keymap.set("n", "s", require("substitute").operator, { noremap = true })
		vim.keymap.set("n", "ss", require("substitute").line, { noremap = true })
		vim.keymap.set("n", "S", require("substitute").eol, { noremap = true })
		vim.keymap.set("x", "s", require("substitute").visual, { noremap = true })
	end,
}
