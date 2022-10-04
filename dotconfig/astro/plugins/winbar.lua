return function()
	require("winbar").setup({
		enabled = true,

		show_file_path = true,
		show_symbols = true,

		exclude_filetype = {
			"help",
			"startify",
			"dashboard",
			"packer",
			"neogitstatus",
			"NvimTree",
			"neo-tree",
			"Trouble",
			"alpha",
			"lir",
			"Outline",
			"spectre_panel",
			"toggleterm",
			"qf",
		},
	})
end
