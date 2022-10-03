return {
	n = {
		["<CR>"] = {
			":nohlsearch<cr>:w<cr>",
			desc = "clear highlights and save",
		},
		-- start / end of line
		["<S-h>"] = {
			"^",
			desc = "start of line",
		},
		["<S-l>"] = {
			"$",
			desc = "end of line",
		},
		-- toggle
		["-"] = {
			"<C-^>",
			desc = "go to previous buffer",
		},
		-- resize
		["<C-k>"] = {
			function()
				require("smart-splits").resize_up()
			end,
			desc = "resize current split up",
		},
		["<C-j>"] = {
			function()
				require("smart-splits").resize_down()
			end,
			desc = "resize current split down",
		},
		["<C-h>"] = {
			function()
				require("smart-splits").resize_left()
			end,
			desc = "resize current split left",
		},
		["<C-l>"] = {
			function()
				require("smart-splits").resize_right()
			end,
			desc = "resize current split right",
		},
		-- tmux
		["<C-w>h"] = {
			function()
				require("tmux").move_left()
			end,
			desc = "move left in vim or tmux",
		},
		["<C-w>j"] = {
			function()
				require("tmux").move_bottom()
			end,
			desc = "move down in vim or tmux",
		},
		["<C-w>k"] = {
			function()
				require("tmux").move_top()
			end,
			desc = "move up in vim or tmux",
		},
		["<C-w>l"] = {
			function()
				require("tmux").move_right()
			end,
			desc = "move right in vim or tmux",
		},
	},
	c = {
		["%%"] = {
			"<C-R>=expand('%:h').'/'<cr>",
			desc = "insert dir of current buffer into ex line",
		},
	},
}
