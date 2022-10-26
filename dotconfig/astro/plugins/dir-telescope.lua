return function()
	require("dir-telescope").setup({
		respect_gitignore = true,
		hidden = true,
	})

	require("telescope").load_extension("dir")
end
