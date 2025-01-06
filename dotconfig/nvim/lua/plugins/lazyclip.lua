return {
	{
		"atiladefreitas/lazyclip",
		config = true,
		keys = {
			{
				"<leader>P",
				":lua require('lazyclip').show_clipboard()<CR>",
				desc = "Open Clipboard Manager",
				silent = true,
			},
		},
	},
}
