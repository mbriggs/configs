return {
	"nvim-neo-tree/neo-tree.nvim",
	opts = {
		popup_border_style = "rounded",
		source_selector = {
			winbar = false,
			content_layout = nil,
			tab_labels = nil,
		},
		default_component_configs = {
			indent = {
				padding = 1,
				indent_size = 3,
			},
		},
		window = {
			position = "float",
			width = 40,

			mappings = {
				["/"] = "none",
			},
		},
	}
}
