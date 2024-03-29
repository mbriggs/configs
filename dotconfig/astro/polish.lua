return function()
	-- snippets
	require("luasnip/loaders/from_snipmate").lazy_load({
		paths = { "./lua/user/snippets" },
	})

	-- Set autocommands
	vim.api.nvim_create_augroup("userft", {})
	vim.api.nvim_create_autocmd("BufRead", {
		desc = "set edn to clojure",
		group = "userft",
		pattern = "*.edn",
		command = "set ft=clojure",
	})
	vim.api.nvim_create_autocmd("BufRead", {
		desc = "set gohtml to html",
		group = "userft",
		pattern = "*.gohtml",
		command = "set ft=html",
	})
	vim.api.nvim_create_autocmd("BufRead", {
		desc = "set envrc to bash",
		group = "userft",
		pattern = ".envrc*",
		command = "set ft=bash",
	})
	vim.api.nvim_create_autocmd("BufRead", {
		desc = "golang formatting",
		group = "userft",
		pattern = "*.go",
		command = "setlocal noet ts=4 sw=4 sts=4",
	})
	vim.api.nvim_create_autocmd("BufRead", {
		desc = "markdown should wrap",
		group = "userft",
		pattern = "*.md",
		command = "set wrap",
	})
end
