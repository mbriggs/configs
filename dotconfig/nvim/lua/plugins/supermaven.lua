return {
	"supermaven-inc/supermaven-nvim",
	event = "BufReadPost",
	opts = {
		keymaps = {
			accept_suggestion = "<D-;>",
			accept_word = "<S-D-;>",
		},
	},
}
