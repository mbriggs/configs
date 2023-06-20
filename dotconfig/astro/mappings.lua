local function toggleLines()
	local new_value = not vim.diagnostic.config().virtual_lines
	vim.diagnostic.config({
		virtual_lines = new_value,
		-- virtual_text = not new_value,
	})

	return new_value
end

function copyRelativePath()
	local path = vim.fn.expand("%")
	vim.fn.setreg("", path)
	vim.notify('Copied "' .. path .. '" to the default register')
end

-- spider movement
vim.keymap.set({ "n", "o", "x" }, ",w", "<cmd>lua require('spider').motion('w')<CR>", { desc = "Spider-w" })
vim.keymap.set({ "n", "o", "x" }, ",e", "<cmd>lua require('spider').motion('e')<CR>", { desc = "Spider-e" })
vim.keymap.set({ "n", "o", "x" }, ",b", "<cmd>lua require('spider').motion('b')<CR>", { desc = "Spider-b" })
vim.keymap.set({ "n", "o", "x" }, ",ge", "<cmd>lua require('spider').motion('ge')<CR>", { desc = "Spider-ge" })

return {
	n = {
		---- REMOVE ----
		--- buffers
		["<leader>b"] = false,
		["<leader>bs"] = false,
		["<leader>b\\"] = false,
		["<leader>b|"] = false,
		["<leader>bb"] = false,
		["<leader>bC"] = false,
		["<leader>bc"] = false,
		["<leader>bd"] = false,
		["<leader>bl"] = false,
		["<leader>br"] = false,
		["<leader>bse"] = false,
		["<leader>bsi"] = false,
		["<leader>bsm"] = false,
		["<leader>bsp"] = false,
		["<leader>bsr"] = false,

		-- explore
		["<leader>e"] = { [[<cmd>Oil<cr>]], desc = "explore current dir" },
		["<leader>o"] = { [[<cmd>Oil --float<cr>]], desc = "open explore float" },

		-- term
		["<leader>th"] = false,
		["<leader>tl"] = false,
		["<leader>tn"] = false,
		["<leader>tp"] = false,
		["<leader>tu"] = false,
		["<leader>tv"] = false,
		---- CORE ----
		["<leader>:"] = { [[<cmd>lua require("user.lsp_fixcurrent")()<cr>]], desc = "QuickFix" },
		["<leader>>"] = { [[<cmd>Navbuddy<cr>]], desc = "Navbuddy" },
		["<leader>;"] = { "<cmd>lua require('telescope').extensions.togglescope.find_files()<cr>", desc = "Files" },
		["<leader><cr>"] = { [[<cmd>q<cr>]], desc = "Close Window" },
		["<leader>-"] = { [[<cmd>only<cr>]], desc = "Close other splits" },
		["<leader>'"] = { [[<cmd>vs<cr>]], desc = "Split" },
		['<leader>"'] = { [[<cmd>sp<cr>]], desc = "Horizontal Split" },
		["<leader>."] = {
			function()
				require("definition-or-references").definition_or_references()
			end,
			desc = "Go to Definition or References",
		},
		["<leader>/"] = {
			toggleLines,
			desc = "Toggle Diagnostics",
		},
		["<CR>"] = {
			":nohlsearch<cr>:w<cr>",
			desc = "clear highlights and save",
		},

		["<leader>c"] = { [["0]], desc = "Last Yank Register" },
		["<leader>y"] = {
			[[<cmd>call setreg('+', @0) | echo "sent to clipboard"<cr>]],
			desc = "Send last yank to system clipboard",
		},

		-- find
		["<leader>fe"] = { [[<cmd>lua require('telescope').extensions.recent_files.pick()<cr>]], desc = "Recent Files" },
		["<leader>fR"] = { "<cmd>lua require('spectre').open()<CR>", desc = "Search and Replace" },
		["<leader>fg"] = { [[<cmd>Telescope git_bcommits<cr>]], desc = "Buffer Commits" },
		["<leader>fG"] = { [[<cmd>Telescope git_commits<cr>]], desc = "Git Commits" },

		["<leader>fw"] = {
			"<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
			desc = "Words",
		},
		["<leader>fd"] = { desc = " dir" },
		["<leader>fdf"] = { "<cmd>Telescope dir find_files<cr>", desc = "Find files in directory" },
		["<leader>fdw"] = { "<cmd>Telescope dir live_grep<cr>", desc = "Search files in directory" },

		-- git
		["<leader>gc"] = { [[<cmd>DiffviewFileHistory %<cr>]], desc = "File Commits" },
		["<leader>gC"] = { [[<cmd>DiffviewFileHistory<cr>]], desc = "Branch Commits" },
		["<leader>gd"] = { [[<cmd>DiffviewOpen<cr>]], desc = "View git diff" },

		-- editor
		["<leader>E"] = { desc = " Editor" },
		["<leader>Em"] = { [[<cmd>Telescope marks<cr>]], desc = "Marks" },
		["<leader>Eh"] = { [[<cmd>Telescope help_tags<cr>]], desc = "Help Tag" },
		["<leader>E;"] = { [[<cmd>Telescope commands<cr>]], desc = "Commands" },
		["<leader>Ec"] = { [[<cmd>Telescope command_history<cr>]], desc = "Previous Commands" },
		["<leader>Ek"] = { [[<cmd>Telescope keymaps<cr>]], desc = "Keymap" },
		["<leader>Ew"] = { "<cmd>WinShift<cr>", desc = "Move Window" },
		["<leader>Ea"] = { [[<cmd>AstroUpdate<cr>]], desc = "Astro Update" },
		["<leader>Eu"] = { desc = "Sudo" },
		["<leader>Eur"] = { "<cmd>SudaRead<cr>", desc = "Read file with sudo" },
		["<leader>Euw"] = { "<cmd>SudaWrite<cr>", desc = "Write file with sudo" },
		["<leader>Es"] = { "<cmd>Sort<cr>", desc = "Sort" },
		["<leader>Ey"] = { copyRelativePath, desc = "Copy Relative Path" },

		-- test
		["<leader>t"] = { desc = "󰙨 Test" },
		["<leader>tt"] = { "<cmd>TestNearest<cr>", desc = "Test Nearest" },
		["<leader>tf"] = { "<cmd>TestFile<cr>", desc = "Test File" },
		["<leader>ta"] = { "<cmd>TestSuite<cr>", desc = "Test Suite" },
		["<leader>t;"] = { "<cmd>TestLast<cr>", desc = "Rerun Last Test" },
		["<leader>t."] = { "<cmd>TestVisit<cr>", desc = "Visit Test" },

		-- trouble
		["<leader>x"] = { desc = " Trouble" },
		["<leader>xx"] = { "<cmd>TroubleClose<cr>", desc = "Close" },
		["<leader>xf"] = { "<cmd>TroubleToggle definitions<cr>", desc = "Definitions" },
		["<leader>xw"] = { "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics" },
		["<leader>xd"] = { "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics" },
		["<leader>xr"] = { "<cmd>TroubleToggle references<cr>", desc = "References" },
		["<leader>xq"] = { "<cmd>TroubleToggle quickfix<cr>", desc = "QuickFix" },
		["<leader>xl"] = { "<cmd>TroubleToggle loclist<cr>", desc = "Location List" },
		["<leader>xt"] = { "<cmd>TodoTrouble<cr>", desc = "TODOs" },

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

	i = {
		["<c-d>"] = {
			n = { "<c-r>=strftime('%Y-%m-%d')<cr>", desc = "Y-m-d" },
			x = { "<c-r>=strftime('%m/%d/%y')<cr>", desc = "m/d/y" },
			f = { "<c-r>=strftime('%B %d, %Y')<cr>", desc = "B d, Y" },
			X = { "<c-r>=strftime('%H:%M')<cr>", desc = "H:M" },
			F = { "<c-r>=strftime('%H:%M:%S')<cr>", desc = "H:M:S" },
			d = { "<c-r>=strftime('%Y/%m/%d %H:%M:%S -')<cr>", desc = "Y/m/d H:M:S -" },
		},
		["<c-p>"] = { [[<cmd>lua vim.lsp.buf.signature_help()<cr>]], desc = "Parameter Info" },
	},

	c = {
		["%%"] = {
			"<C-R>=expand('%:h').'/'<cr>",
			desc = "insert dir of current buffer into ex line",
		},
	},
}
