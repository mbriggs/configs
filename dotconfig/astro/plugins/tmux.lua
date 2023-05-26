-- tmux integration

return {
	"aserowy/tmux.nvim",
	name = "tmux",
	opts = {
		copy_sync = {
			enable = false,
		},
		navigation = {
			cycle_navigation = true,
			enable_default_keybindings = false,
			persist_zoom = true,
		},
		resize = {
			enable_default_keybindings = false,
		},
	}
}
