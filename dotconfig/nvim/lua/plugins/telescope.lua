-- Function to open netrw in the selected directory
local function open_netrw(prompt_bufnr)
	local actions = require("telescope.actions")
	local action_state = require("telescope.actions.state")

	local selected_entry = action_state.get_selected_entry()
	local dir = selected_entry.value

	actions.close(prompt_bufnr)
	-- vim.cmd("Explore " .. dir)
	require("neo-tree.command").execute({ position = "current", dir = vim.fn.getcwd() .. "/" .. dir })
end

-- Custom picker to list all directories in the project
local search_directories = function(opts)
	local finders = require("telescope.finders")
	local pickers = require("telescope.pickers")
	local previewers = require("telescope.previewers")

	opts = opts or {}

	local cmd = { "fd", "--type", "d", "--hidden", "--exclude", ".git" }

	pickers
		.new(opts, {
			prompt_title = "Search Directories",
			finder = finders.new_oneshot_job(cmd, opts),
			sorter = require("telescope.config").values.generic_sorter(opts),
			previewer = previewers.new_termopen_previewer({
				title = "Directory",

				get_command = function(entry)
					return { "gls", "-al", "--color", entry.value }
				end,
			}),
			attach_mappings = function(_, map)
				map("i", "<CR>", open_netrw)
				map("n", "<CR>", open_netrw)
				return true
			end,
		})
		:find()
end

return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"joaomsa/telescope-orgmode.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
		},
		{
			"fdschmidt93/telescope-egrepify.nvim",
			dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
		},
		{
			"stevearc/aerial.nvim",
			name = "aerial",
			dependencies = {
				"nvim-treesitter/nvim-treesitter",
				"nvim-tree/nvim-web-devicons",
			},
			config = true,
		},
	},
	cmd = { "Telescope" },
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local egrep_actions = require("telescope._extensions.egrepify.actions")

		telescope.setup({
			defaults = {
				mappings = {
					i = {
						["<esc>"] = actions.close,
					},
				},
			},
			extensions = {
				egrepify = {
					-- intersect tokens in prompt ala "str1.*str2" that ONLY matches
					-- if str1 and str2 are consecutively in line with anything in between (wildcard)
					AND = true, -- default
					permutations = false, -- opt-in to imply AND & match all permutations of prompt tokens
					lnum = true, -- default, not required
					lnum_hl = "EgrepifyLnum", -- default, not required, links to `Constant`
					col = false, -- default, not required
					col_hl = "EgrepifyCol", -- default, not required, links to `Constant`
					title = true, -- default, not required, show filename as title rather than inline
					filename_hl = "EgrepifyFile", -- default, not required, links to `Title`
					results_ts_hl = true, -- set to false if you experience latency issues!
					-- suffix = long line, see screenshot
					-- EXAMPLE ON HOW TO ADD PREFIX!
					prefixes = {
						-- ADDED ! to invert matches
						-- example prompt: ! sorter
						-- matches all lines that do not comprise sorter
						-- rg --invert-match -- sorter
						["!"] = {
							flag = "invert-match",
						},
					},
					-- default mappings
					mappings = {
						i = {
							-- toggle prefixes, prefixes is default
							["<C-z>"] = egrep_actions.toggle_prefixes,
							-- toggle AND, AND is default, AND matches tokens and any chars in between
							["<C-a>"] = egrep_actions.toggle_and,
							-- toggle permutations, permutations of tokens is opt-in
							["<C-r>"] = egrep_actions.toggle_permutations,
						},
					},
				},
			},
		})

		telescope.load_extension("fzf")
		telescope.load_extension("aerial")
		telescope.load_extension("egrepify")

		-- telescope.load_extension("orgmode")

		-- vim.keymap.set("n", "<leader>;", telescope.find_files, { desc = "Find files" })
		-- vim.keymap.set("n", "<leader>ff", telescope.find_files, { desc = "Find files" })
		-- vim.keymap.set("n", "<leader>fw", function()
		--     local word = vim.fn.expand("<cword>")
		--     telescope.grep_string({ search = word })
		-- end, { desc = "Find word" })
		-- vim.keymap.set("n", "<leader>fW", function()
		--     local word = vim.fn.expand("<cWORD>")
		--     telescope.grep_string({ search = word })
		-- end, { desc = "Find WORD" })
		-- vim.keymap.set("n", "<leader>fg", function()
		--     telescope.grep_string({ search = vim.fn.input("Grep > ") })
		-- end, { desc = "Grep" })
		-- vim.keymap.set("n", "<leader>fh", telescope.help_tags, { desc = "Find help tag" })
		--
		-- vim.keymap.set("n", "<leader>=", telescope.lsp_document_symbols, { desc = "Document symbols" })
	end,
	keys = {
		{
			"<leader>f;",
			":Telescope resume<CR>",
			noremap = true,
			silent = true,
			desc = "Resume last telescope session",
		},

		-- search directories
		{
			"<leader>fd",
			function()
				search_directories()
			end,
			noremap = true,
			silent = true,
			desc = "Search directories",
		},
		-- find files
		{
			"<leader>;",
			":Telescope find_files<CR>",
			noremap = true,
			silent = true,
			desc = "Find files",
		},
		{
			"<leader>ff",
			":Telescope find_files<CR>",
			noremap = true,
			silent = true,
			desc = "Find files",
		},

		-- grep
		{
			"<leader>fg",
			"<cmd>Telescope egrepify<cr>",
			noremap = true,
			silent = true,
			desc = "Grep",
		},

		-- vim
		{
			"<leader>fh",
			":Telescope help_tags<CR>",
			noremap = true,
			silent = true,
			desc = "Find help tag",
		},

		-- symbol jump
		{
			"<leader>=",
			":Telescope aerial<CR>",
			noremap = true,
			silent = true,
			desc = "Document symbols",
		},
		-- -- lsp
		-- {
		-- 	"<leader>=",
		-- 	":Telescope lsp_document_symbols<CR>",
		-- 	noremap = true,
		-- 	silent = true,
		-- 	desc = "Document symbols",
		-- },
	},
}
