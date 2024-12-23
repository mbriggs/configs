local function toggle_find_in_dir(_, ctx)
	local bufname = vim.api.nvim_buf_get_name(ctx.__CTX.bufnr)
	if bufname == "" then
		return false
	end

	local o = vim.deepcopy(ctx.__call_opts)

	-- Get the current cwd setting
	local using_file_dir = o.cwd and o.cwd == vim.fn.fnamemodify(vim.api.nvim_buf_get_name(ctx.__CTX.bufnr), ":h")

	if using_file_dir then
		-- Switch back to cwd
		o.cwd = vim.fn.getcwd()
		o.prompt = "> "
	else
		-- Switch to file directory
		local current_file = vim.api.nvim_buf_get_name(ctx.__CTX.bufnr)
		o.cwd = vim.fn.fnamemodify(current_file, ":h")
		local prompt = o.cwd:gsub("^" .. vim.fn.getcwd() .. "/?", "")
		o.prompt = prompt .. "> "
	end
	-- Keep the buffer reference
	o.buf = ctx.__CTX.bufnr

	-- Call files with new options
	require("fzf-lua").files(o)
end

return {
	"ibhagwan/fzf-lua",
	dependencies = {
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

	cmd = "FzfLua",
	opts = function()
		local config = require("fzf-lua.config")
		local actions = require("fzf-lua.actions")

		-- Toggle root dir / cwd
		config.defaults.actions.files["ctrl-r"] = toggle_find_in_dir
		config.set_action_helpstr(config.defaults.actions.files["ctrl-r"], "toggle-root-dir")

		return {
			fzf_colors = true,
			fzf_opts = {
				["--no-scrollbar"] = true,
				["--info"] = "inline",
				["--tiebreak"] = "begin",
			},
			defaults = {
				formatter = "path.dirname_first",
				headers = false,
			},
			keymap = {
				fzf = {
					["ctrl-q"] = "select-all+accept",
				},
			},
			winopts = {
				width = 0.8,
				height = 0.8,
				row = 0.5,
				col = 0.5,
				preview = {
					scrollchars = { "┃", "" },
				},
			},
			files = {
				cwd_prompt = false,
				actions = {
					["alt-i"] = { actions.toggle_ignore },
					["alt-h"] = { actions.toggle_hidden },
				},
			},
			grep = {
				rg_glob = true, -- enable glob parsing
				glob_flag = "--iglob", -- case insensitive globs
				glob_separator = "%s%-%-", -- query separator pattern (lua): ' --'
				actions = {
					["alt-i"] = { actions.toggle_ignore },
					["alt-h"] = { actions.toggle_hidden },
				},
			},
			oldfiles = {
				include_current_session = true,
			},
			lsp = {
				symbols = {
					symbol_hl = function(s)
						return "TroubleIcon" .. s
					end,
					symbol_fmt = function(s)
						return s:lower() .. "\t"
					end,
					child_prefix = false,
				},
				code_actions = {
					previewer = vim.fn.executable("delta") == 1 and "codeaction_native" or nil,
				},
			},
		}
	end,

	config = function(_, opts)
		require("mbriggs.aerial-fzf") -- custom plugin for integrating with aerial
		require("mbriggs.dir-fzf") -- custom plugin for fuzzy searching directories

		local fzf = require("fzf-lua")

		fzf.setup(opts)
		fzf.register_ui_select()
	end,
	keys = {
		-- general
		{ "<leader>,", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", desc = "Switch Buffer" },
		{
			"<leader>/",
			"<cmd>FzfLua live_grep<cr>",
			desc = "Grep",
			mode = { "n" },
		},
		{
			"<leader>/",
			"<cmd>FzfLua grep_visual<cr>",
			desc = "Grep",
			mode = { "v" },
		},
		{ "<leader>:", "<cmd>FzfLua command_history<cr>", desc = "Command History" },
		{ "<leader>;", "<cmd>FzfLua files<cr>", desc = "Find Files" },
		{ "<leader>=", "<cmd>AerialFzf<cr>", desc = "Find Doc Symbols" },
		{ "<leader><tab>", "<cmd>FzfLua resume<cr>", desc = "FZF resume" },

		-- find
		{ "<leader>fd", "<cmd>DirectoryFzf<cr>", desc = "Search Directory" },
		{ "<leader>fq", "<cmd>FzfLua quickfix<cr>", desc = "Quickfix List" },
		{ "<leader>fj", "<cmd>FzfLua jumps<cr>", desc = "Jumplist" },
		{ "<leader>fc", "<cmd>FzfLua commands<cr>", desc = "Command Pallet" },
		{ "<leader>fk", "<cmd>FzfLua keymaps<cr>", desc = "Key Maps" },
		{ "<leader>fh", "<cmd>FzfLua help_tags<cr>", desc = "Help Pages" },
		{ "<leader>fm", "<cmd>FzfLua marks<cr>", desc = "Jump to Mark" },

		-- search
		{ "<leader>ss", "<cmd>FzfLua grep<cr>", desc = "Search" },
		{ "<leader>sb", "<cmd>FzfLua lgrep_curbuf<cr>", desc = "Search Current Buffer" },
		{ "<leader>sw", "<cmd>FzfLua grep_cword<cr>", desc = "Search word at cursor" },
		{ "<leader>sw", "<cmd>FzfLua grep_cWORD<cr>", desc = "Search WORD at cursor" },
		{ "<leader>sq", "<cmd>FzfLua lgrep_quickfix<cr>", desc = "Search quickfix" },

		-- diagnostics
		{ "<leader>x;", "<cmd>FzfLua diagnostics_document<cr>", desc = "Document Diagnostics" },
		{ "<leader>x:", "<cmd>FzfLua diagnostics_workspace<cr>", desc = "Workspace Diagnostics" },

		-- rails
		{
			"<leader>rm",
			[[<cmd>lua require("mbriggs.rails").find_models()<cr>]],
			silent = true,
			desc = "Find Model",
		},
		{
			"<leader>rc",
			[[<cmd>lua require("mbriggs.rails").find_controllers()<cr>]],
			silent = true,
			desc = "Find Controller",
		},
		{
			"<leader>rv",
			[[<cmd>lua require("mbriggs.rails").find_views()<cr>]],
			silent = true,
			desc = "Find View",
		},
		{
			"<leader>rh",
			[[<cmd>lua require("mbriggs.rails").find_helpers()<cr>]],
			silent = true,
			desc = "Find Helper",
		},
		{
			"<leader>rM",
			[[<cmd>lua require("mbriggs.rails").find_mailers()<cr>]],
			silent = true,
			desc = "Find Mailer",
		},
		{
			"<leader>rj",
			[[<cmd>lua require("mbriggs.rails").find_jobs()<cr>]],
			silent = true,
			desc = "Find Job",
		},
		{
			"<leader>rl",
			[[<cmd>lua require("mbriggs.rails").find_lib()<cr>]],
			silent = true,
			desc = "Find Lib",
		},
		{
			"<leader>rt",
			[[<cmd>lua require("mbriggs.rails").find_tests()<cr>]],
			silent = true,
			desc = "Find Test",
		},
		{
			"<leader>rs",
			[[<cmd>lua require("mbriggs.rails").find_specs()<cr>]],
			silent = true,
			desc = "Find Model",
		},
		{
			"<leader>rr",
			[[<cmd>lua require("mbriggs.rails").find_related()<cr>]],
			silent = true,
			desc = "Find Related",
		},
	},
}
