-- vim:ts=4:sw=4:ai:foldmethod=marker:foldlevel=0:

-- {{{ Startup
local start_time = vim.uv.hrtime()
-- }}}

-- {{{ Settings
vim.opt.formatoptions = "jqlnt"
-- j: remove comment leader when joining
-- q: allow formatting of comments with gq
-- l: don't break long lines in insert mode
-- n: recognize numbered lists
-- t: auto-wrap text using textwidth

-- 2 spaces by default
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- 80 chars for hard wrapping
vim.opt.textwidth = 80

-- more sophisticated indentation
vim.opt.smartindent = true

-- search settings
vim.opt.smartcase = true
vim.opt.ignorecase = true

-- do not conceal
vim.opt.conceallevel = 0
vim.opt.concealcursor = ""

-- soft wrapping long lines
vim.opt.wrap = true

-- show line numbers by default
vim.opt.number = false

-- make extra files less irritating
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

-- folding
vim.opt.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99

-- more gui colors
vim.opt.termguicolors = true

vim.opt.scrolloff = 8 -- lines to keep above / below the cursor
vim.opt.signcolumn = "yes" -- show signs

vim.opt.isfname:append("@-@") -- allow @ in file names

vim.opt.updatetime = 50 -- speed up ui

vim.o.grepprg = "rg --vimgrep --no-heading --smart-case"
-- }}}

-- {{{ Keymaps
vim.g.mapleader = " "
vim.g.maplocalleader = "  "
local map = vim.keymap.set

map("n", "<leader>#", "<cmd>set nu!<cr>", { desc = "Toggle Line Numbers" })
map(
	"n",
	"<leader>w",
	":nohlsearch<CR>:lua require('conform').format()<CR>:w<CR>",
	{ desc = "save->fmt->clear highlights" }
)

-- window resizing
-- Arrow keys with Alt for fine control
map("n", "<A-Up>", ":resize +2<CR>")
map("n", "<A-Down>", ":resize -2<CR>")
map("n", "<A-Left>", ":vertical resize -2<CR>")
map("n", "<A-Right>", ":vertical resize +2<CR>")

-- Ctrl+ for larger adjustments
map("n", "<C-Up>", ":resize +10<CR>")
map("n", "<C-Down>", ":resize -10<CR>")
map("n", "<C-Left>", ":vertical resize -10<CR>")
map("n", "<C-Right>", ":vertical resize +10<CR>")

-- Map Cmd+F to % (jump to matching bracket)
map({ "n", "v", "o", "i" }, "<D-f>", "%")
map("c", "<D-f>", '<C-r>="%"<CR>') -- Command mode for :%s/foo etc.

-- Cmd+hjkl to move between windows in every mode
map({ "n", "v", "o", "i" }, "<D-h>", "<C-w>h")
map({ "n", "v", "o", "i" }, "<D-j>", "<C-w>j")
map({ "n", "v", "o", "i" }, "<D-k>", "<C-w>k")
map({ "n", "v", "o", "i" }, "<D-l>", "<C-w>l")

map({ "n", "v", "o", "i" }, "<D-f>", "%")
-- dabbrev style completion
map("i", "<D-/>", "<C-n>", { desc = "next completion", noremap = "true" })
map("i", "<D-S-/>", "<C-x><C-n>", { desc = "next completion in current file", noremap = "true" })

-- nuke buffer
map("n", "<leader>bk", "<cmd>bd!<cr>", { desc = "nuke buffer" })

-- cmdwin
map("n", "<leader>:", "q:", { desc = "cmdwin", noremap = true, silent = true })
map("n", "q:", "<nop>")

-- go to alternate file
map("n", "<leader>-", "<C-^>", { desc = "go to alternate file" })

-- make file executable
map("n", "<leader>bx", "<cmd>!chmod +x %<CR>", { silent = true, desc = "make file executable" })

-- make it super easy to quit
map("n", "<leader><CR>", ":q<cr>", { desc = "quit" })

-- make it super easy to split
map("n", "<leader>'", ":vsp<cr>", { desc = "vertical split" })
map("n", '<leader>"', ":sp<cr>", { desc = "horizontal split" })

-- in visual mode, move lines around with J and K
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "move line(s) down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "move line(s) up" })

-- dont move the cursor when joining lines
map("n", "J", "mzJ`z", { desc = "join lines" })

-- keep cursor in middle of screen when scrolling
map("n", "<C-d>", "<C-d>zz", { desc = "scroll down" })
map("n", "<C-u>", "<C-u>zz", { desc = "scroll up" })

-- keep cursor in the middle of the screen when moving between search results
map("n", "n", "nzzzv", { desc = "next search result" })
map("n", "N", "Nzzzv", { desc = "previous search result" })

-- emacs style
-- map("n", "<leader>.", "<C-]>", { desc = "jump to definition" })
map("i", "<C-a>", "<Home>", { desc = "start of line" })
map("i", "<C-e>", "<esc>A", { desc = "end of line" })
map({ "i", "n", "c" }, "<C-n>", "<down>", { desc = "next line" })
map({ "i", "n", "c" }, "<C-p>", "<up>", { desc = "previous line" })
map("i", "<M-left>", "<C-left>", { desc = "previous word" })
map("i", "<M-right>", "<C-right>", { desc = "next word" })
map("i", "<M-backspace>", "<C-w>", { desc = "delete previous word" })

-- without yanking
map("x", "<leader>p", [["_dP]], { desc = "paste without yanking" })

-- yank to system
map({ "n", "v" }, "<leader>y", [["+y]], { desc = "yank to system clipboard" })
map("n", "<leader>Y", [["+Y]], { desc = "yank rest of line to system clipboard" })

-- replay macro
map("n", "Q", "@q", { desc = "replay macro" })

-- qf nav, keep cursor in the middle of the screen, go off of option
map("n", "<C-S-n>", "<cmd>cnext<CR>zz", { desc = "next quickfix" })
map("n", "<C-S-p>", "<cmd>cprev<CR>zz", { desc = "previous quickfix" })

-- substitute current word
map("n", "<leader>cs", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "substitute current word" })

-- H / L for start / end of line
map({ "n", "v" }, "<s-h>", "^", { desc = "start of line" })
map({ "n", "v" }, "<s-l>", "$", { desc = "end of line" })

-- put current dir into command
map("c", "%%", "<C-R>=expand('%:h').'/'<cr>", { desc = "put current dir into command" })

-- maps for diffs
vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
	pattern = "*",
	callback = function()
		if vim.wo.diff then
			local opts = { buffer = true, noremap = true, silent = true }
			map("n", "gf", "diffget //2", opts)
			map("n", "gj", "diffget //3", opts)
		end
	end,
})
-- }}}

-- {{{ Netrw
local function create_file_or_dir()
	vim.ui.input({ prompt = "New File (or dir): " }, function(name)
		if name == "" or name == nil then
			return
		end

		-- Get current directory from netrw
		local current_dir = vim.b.netrw_curdir
		local full_path = vim.fn.fnamemodify(current_dir .. "/" .. name, ":p")

		if name:sub(-1) == "/" then
			-- Remove trailing slash and create directory
			full_path = full_path:sub(1, -2)
			vim.fn.mkdir(full_path, "p")
		else
			-- Create parent directories if they don't exist
			local parent_dir = vim.fn.fnamemodify(full_path, ":h")
			vim.fn.mkdir(parent_dir, "p")

			-- Create file
			local file = io.open(full_path, "w")
			if file then
				file:close()
			end
		end

		-- Refresh netrw
		vim.cmd("edit " .. vim.fn.fnameescape(current_dir))
	end)
end

-- Keybindings

map("n", "-", ":Explore<CR>", {
	noremap = true,
	silent = true,
	desc = "Explore current dir",
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "netrw",
	callback = function()
		local opts = { buffer = true, silent = true, remap = true }
		map("n", "<Tab>", "mf", opts) -- Toggle mark on file
		map("n", "<S-Tab>", "mF", opts) -- Unmark all files
		-- map('n', '-', '-^', opts)                   -- Go up directory
		map("n", "%", create_file_or_dir, { buffer = true }) -- Create file/dir
		map("n", "<D-f>", create_file_or_dir, { buffer = true }) -- Create file/dir
		map("n", "d", "D", opts) -- Delete file/directory
		map("n", "r", "R", opts) -- Rename file/directory
	end,
})

-- hide header
vim.g.netrw_banner = 0

-- Show directories first (sorting)
vim.g.netrw_sort_sequence = [[[\/]$,*]]

-- start hidden
vim.g.netrw_list_hide = [[^\..*]]

-- Human-readable files sizes
vim.g.netrw_sizestyle = "H"

-- Setup file operations commands (enable recursive copy and remove)
vim.g.netrw_localcopydircmd = "cp -r"
vim.g.netrw_localmkdir = "mkdir -p"
vim.g.netrw_localrmdir = "rm -r"

-- split to the right instead of the left
vim.g.netrw_altv = 1

-- Highlight marked files in the same way search matches are
vim.cmd("hi! link netrwMarkFile Search")
--- }}}

-- {{{ Terminal

vim.g.terminal_scrollback_buffer_size = 500000

map("t", "<Esc>", "<C-\\><C-n>", { silent = true })

map("t", "<D-h>", "<C-\\><C-n><C-w>h")
map("t", "<D-j>", "<C-\\><C-n><C-w>j")
map("t", "<D-k>", "<C-\\><C-n><C-w>k")
map("t", "<D-l>", "<C-\\><C-n><C-w>l")

vim.api.nvim_create_autocmd("TermOpen", {
	callback = function()
		-- Get the command that opened the terminal
		local cmd = vim.bo.channel
			and vim.fn.jobpid(vim.bo.channel)
			and vim.split(vim.fn.system(string.format("ps -p %d -o comm=", vim.fn.jobpid(vim.bo.channel))), "\n")[1]

		-- Only proceed if it's a regular shell
		if cmd and (cmd:match("sh$") or cmd:match("bash$") or cmd:match("zsh$")) then
			vim.cmd("startinsert") -- Start in insert mode

			map({ "t", "n" }, "<leader>R", function()
				vim.cmd("stopinsert")
				vim.cmd("TermRename")
			end, { buffer = true })
		end
	end,
})

vim.api.nvim_create_user_command("TermRename", function()
	vim.ui.input({
		prompt = "Terminal name: ",
	}, function(name)
		if name then
			-- Get current buffer number
			local bufnr = vim.api.nvim_get_current_buf()
			-- Set the buffer name
			vim.api.nvim_buf_set_name(bufnr, "*" .. name .. "*")
		end
	end)
end, {})

-- }}}

-- {{{ Plugin Setup

-- Mini {{{

local function setup_mini_icons()
	local icons = require("mini.icons")
	icons.mock_nvim_web_devicons()
end

local function setup_mini_starter()
	local starter = require("mini.starter")
	starter.setup({
		items = { starter.sections.sessions(5, true) },
		footer = function()
			local ms = (vim.uv.hrtime() - start_time) / 1e6
			local t = ("󱐋 ready in %dms"):format(ms)
			return t
		end,
		header = [[
███████╗████████╗██████╗ ██╗██╗  ██╗███████╗
██╔════╝╚══██╔══╝██╔══██╗██║██║ ██╔╝██╔════╝
███████╗   ██║   ██████╔╝██║█████╔╝ █████╗
╚════██║   ██║   ██╔══██╗██║██╔═██╗ ██╔══╝
███████║   ██║   ██║  ██║██║██║  ██╗███████╗
╚══════╝   ╚═╝   ╚═╝  ╚═╝╚═╝╚═╝  ╚═╝╚══════╝
████████╗██╗  ██╗███████╗
╚══██╔══╝██║  ██║██╔════╝
   ██║   ███████║█████╗
   ██║   ██╔══██║██╔══╝
   ██║   ██║  ██║███████╗
   ╚═╝   ╚═╝  ╚═╝╚══════╝
███████╗ █████╗ ██████╗ ████████╗██╗  ██╗██╗
██╔════╝██╔══██╗██╔══██╗╚══██╔══╝██║  ██║██║
█████╗  ███████║██████╔╝   ██║   ███████║██║
██╔══╝  ██╔══██║██╔══██╗   ██║   ██╔══██║╚═╝
███████╗██║  ██║██║  ██║   ██║   ██║  ██║██╗
╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝╚═╝]],
	})
end

local function setup_mini_pick()
	local pick = require("mini.pick")
	pick.setup()

	vim.ui.select = pick.ui_select
end

local function setup_mini_sessions()
	require("mini.sessions").setup({
		force = {
			delete = true,
		},
		verbose = {
			write = false,
			delete = false,
		},
	})

	map("n", "<leader>vv", function()
		vim.cmd("wa")
		require("mini.sessions").write()
		require("mini.sessions").select()
		lsp_cleanup()
	end, { desc = "Switch Session" })

	map("n", "<leader>vw", function()
		local cwd = vim.fn.getcwd()
		local last_folder = cwd:match("([^/]+)$")
		require("mini.sessions").write(last_folder)
	end, { desc = "Save Session" })

	map("n", "<leader>ve", function()
		vim.cmd("wa")
		require("mini.sessions").select()
		lsp_cleanup()
	end, { desc = "Load Session" })

	map("n", "<leader>vd", function()
		require("mini.sessions").select("delete")
	end, { desc = "Delete Session" })
end

local function setup_mini_files()
	require("mini.files").setup({
		windows = {
			preview = true,
			width_focus = 30,
			width_preview = 30,
		},
		options = {
			-- Whether to use for editing directories (use `netrw`)
			use_as_default_explorer = false,
		},
	})

	map("n", "<leader>fm", function()
		require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
	end, {
		desc = "Open mini.files (Directory of Current File)",
	})

	map("n", "<leader>fM", function()
		require("mini.files").open(vim.uv.cwd(), true)
	end, {
		desc = "Open mini.files (cwd)",
	})

	local show_dotfiles = true
	local filter_show = function(fs_entry)
		return true
	end
	local filter_hide = function(fs_entry)
		return not vim.startswith(fs_entry.name, ".")
	end

	local toggle_dotfiles = function()
		show_dotfiles = not show_dotfiles
		local new_filter = show_dotfiles and filter_show or filter_hide
		require("mini.files").refresh({ content = { filter = new_filter } })
	end

	vim.api.nvim_create_autocmd("User", {
		pattern = "MiniFilesBufferCreate",
		callback = function(args)
			local buf_id = args.data.buf_id

			map("n", "g.", toggle_dotfiles, { buffer = buf_id, desc = "Toggle hidden files" })
		end,
	})

	vim.api.nvim_create_autocmd("User", {
		pattern = "MiniFilesActionRename",
		callback = function(event)
			Snacks.rename.on_rename_file(event.data.from, event.data.to)
		end,
	})
end

local function setup_mini_splitjoin()
	require("mini.splitjoin").setup({
		detect = {
			-- default () [] {} plus Ruby `do ... end` as a region
			brackets = {
				"%b()",
				"%b[]",
				"%b{}",
				-- 'do ... end' as standalone words (frontiers), minimal match
				"%f[%w]do%f[%W].-%f[%w]end%f[%W]",
			},
			-- split on commas AND semicolons (Ruby one-liners often use ;)
			separator = "[,;]",
			-- also treat `do ... end` as an excluded subregion to avoid false splits
			exclude_regions = { "%b()", "%b[]", "%b{}", '%b""', "%b''", "%f[%w]do%f[%W].-%f[%w]end%f[%W]" },
		},
	})
end

local function setup_mini_completion()
	require("mini.completion").setup()
end

local function setup_mini_clue()
	local miniclue = require("mini.clue")
	miniclue.setup({
		window = {
			delay = 300,
		},

		triggers = {
			-- Leader triggers
			{ mode = "n", keys = "<Leader>" },
			{ mode = "x", keys = "<Leader>" },

			-- Built-in completion
			{ mode = "i", keys = "<C-x>" },

			-- `g` key
			{ mode = "n", keys = "g" },
			{ mode = "x", keys = "g" },

			-- Marks
			{ mode = "n", keys = "'" },
			{ mode = "n", keys = "`" },
			{ mode = "x", keys = "'" },
			{ mode = "x", keys = "`" },

			-- Registers
			{ mode = "n", keys = '"' },
			{ mode = "x", keys = '"' },
			{ mode = "i", keys = "<C-r>" },
			{ mode = "c", keys = "<C-r>" },

			-- Window commands
			{ mode = "n", keys = "<C-w>" },

			-- `z` key
			{ mode = "n", keys = "z" },
			{ mode = "x", keys = "z" },
		},

		clues = {
			{ mode = "n", keys = "<leader>b", desc = "+buffer" },
			{ mode = "n", keys = "<leader>c", desc = "+code" },
			{ mode = "n", keys = "<leader>g", desc = "+git" },
			{ mode = "n", keys = "<leader>gd", desc = "+diff" },
			{ mode = "n", keys = "<leader>v", desc = "+sessions" },
			{ mode = "n", keys = "<leader>f", desc = "+find" },
			{ mode = "n", keys = "<leader>s", desc = "+search" },
			{ mode = "n", keys = "<leader>h", desc = "+harpoon" },
			{ mode = "n", keys = "<leader>t", desc = "+test" },

			miniclue.gen_clues.builtin_completion(),
			miniclue.gen_clues.g(),
			miniclue.gen_clues.marks(),
			miniclue.gen_clues.registers(),
			miniclue.gen_clues.windows(),
			miniclue.gen_clues.z(),
		},
	})
end

local function setup_mini_ai()
	local function indent(ai_type)
		local spaces = (" "):rep(vim.o.tabstop)
		local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
		local indents = {} ---@type {line: number, indent: number, text: string}[]

		for l, line in ipairs(lines) do
			if not line:find("^%s*$") then
				indents[#indents + 1] = { line = l, indent = #line:gsub("\t", spaces):match("^%s*"), text = line }
			end
		end

		local ret = {}

		for i = 1, #indents do
			if i == 1 or indents[i - 1].indent < indents[i].indent then
				local from, to = i, i
				for j = i + 1, #indents do
					if indents[j].indent < indents[i].indent then
						break
					end
					to = j
				end
				from = ai_type == "a" and from > 1 and from - 1 or from
				to = ai_type == "a" and to < #indents and to + 1 or to
				ret[#ret + 1] = {
					indent = indents[i].indent,
					from = { line = indents[from].line, col = ai_type == "a" and 1 or indents[from].indent + 1 },
					to = { line = indents[to].line, col = #indents[to].text },
				}
			end
		end

		return ret
	end

	local function buffer(ai_type)
		local start_line, end_line = 1, vim.fn.line("$")
		if ai_type == "i" then
			-- Skip first and last blank lines for `i` textobject
			local first_nonblank, last_nonblank = vim.fn.nextnonblank(start_line), vim.fn.prevnonblank(end_line)
			-- Do nothing for buffer with all blanks
			if first_nonblank == 0 or last_nonblank == 0 then
				return { from = { line = start_line, col = 1 } }
			end
			start_line, end_line = first_nonblank, last_nonblank
		end

		local to_col = math.max(vim.fn.getline(end_line):len(), 1)
		return { from = { line = start_line, col = 1 }, to = { line = end_line, col = to_col } }
	end

	local ai = require("mini.ai")
	ai.setup({
		n_lines = 500,
		custom_textobjects = {
			o = ai.gen_spec.treesitter({ -- code block
				a = { "@block.outer", "@conditional.outer", "@loop.outer" },
				i = { "@block.inner", "@conditional.inner", "@loop.inner" },
			}),
			f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }), -- function
			c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }), -- class
			t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" }, -- tags
			d = { "%f[%d]%d+" }, -- digits
			e = { -- Word with case
				{ "%u[%l%d]+%f[^%l%d]", "%f[%S][%l%d]+%f[^%l%d]", "%f[%P][%l%d]+%f[^%l%d]", "^[%l%d]+%f[^%l%d]" },
				"^().*()$",
			},
			i = indent,
			g = buffer,
			k = { "%b||", "^|().-()|$" },
			u = ai.gen_spec.function_call(), -- u for "Usage"
			U = ai.gen_spec.function_call({ name_pattern = "[%w_]" }), -- without dot in function name
			m = {
				-- Around markdown code block: includes the backticks
				a = function()
					local start_line = vim.fn.search("^```", "bnW")
					local end_line = vim.fn.search("^```", "nW")
					if start_line == 0 or end_line == 0 or start_line == end_line then
						return nil
					end
					return { from = { line = start_line, col = 1 }, to = { line = end_line, col = vim.fn.col("$") } }
				end,
				-- Inside markdown code block: excludes the backticks
				i = function()
					local start_line = vim.fn.search("^```", "bnW")
					local end_line = vim.fn.search("^```", "nW")
					if start_line == 0 or end_line == 0 or start_line == end_line or end_line - start_line <= 1 then
						return nil
					end
					return {
						from = { line = start_line + 1, col = 1 },
						to = { line = end_line - 1, col = vim.fn.col("$") },
					}
				end,
			},
		},
	})
end

local function setup_mini_diff()
	local bar = "│"
	local arrow = ""

	require("mini.diff").setup({
		view = {
			signs = {
				add = bar,
				change = bar,
				delete = arrow,
			},
		},
	})

	map("n", "<leader>_", "<cmd>lua MiniDiff.toggle()<CR>", { desc = "Toggle Diff" })
end

local function setup_mini_surround()
	require("mini.surround").setup({
		search_method = "cover_or_next", -- Cover or find next surrounding
		mappings = {
			add = "sa", -- Add surrounding in Normal and Visual modes
			delete = "sd", -- Delete surrounding
			find = "sf", -- Find surrounding (to the right)
			find_left = "sF", -- Find surrounding (to the left)
			highlight = "sh", -- Highlight surrounding
			replace = "sr", -- Replace surrounding
			update_n_lines = "sn", -- Update `n_lines`

			suffix_last = "l", -- Suffix to search with "prev" method
			suffix_next = "n", -- Suffix to search with "next" method
		},
	})
end

-- }}}

local function setup_fzf()
	local fzf = require("fzf-lua")
	local config = fzf.config
	local actions = fzf.actions

	config.defaults.keymap.fzf["ctrl-q"] = "select-all+accept"

	-- Toggle root dir / cwd
	config.defaults.actions.files["ctrl-r"] = function(_, ctx)
		local o = vim.deepcopy(ctx.__call_opts)
		o.root = o.root == false
		o.cwd = nil
		o.buf = ctx.__CTX.bufnr
	end
	config.defaults.actions.files["alt-c"] = config.defaults.actions.files["ctrl-r"]
	config.set_action_helpstr(config.defaults.actions.files["ctrl-r"], "toggle-root-dir")

	fzf.setup({
		fzf_colors = true,
		fzf_opts = {
			["--no-scrollbar"] = true,
		},
		defaults = {
			header = false,
			formatter = "path.dirname_first",
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
		buffers = {
			actions = {
				["alt-d"] = { fn = actions.buf_del, exec = false },
			},
		},
		grep = {
			actions = {
				["alt-i"] = { actions.toggle_ignore },
				["alt-h"] = { actions.toggle_hidden },
			},
		},
		lsp = {
			symbols = {
				symbol_style = 2, -- 2 = icon only
				symbol_fmt = function(s, opts)
					return s
				end, -- remove default "[" .. s .. "]"
			},
		},
	})

	map("n", "<leader>,", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", {
		desc = "Switch Buffer",
	})

	map("n", "<leader>/", "<cmd>FzfLua live_grep<cr>", {
		desc = "Search",
	})

	map("n", "<leader>:", "<cmd>FzfLua command_history<cr>", {
		desc = "Command History",
	})

	map("n", "<leader>;", "<cmd>FzfLua files<cr>", {
		desc = "Find files",
	})

	map("n", "<leader>f'", "<cmd>FzfLua resume<cr>", {
		desc = "Resume pick",
	})

	map("n", "<leader>d", "<cmd>FzfLua diagnostics_document<cr>", {
		desc = "Document Diagnostics",
	})

	map("n", "<leader>D", "<cmd>FzfLua diagnostics_workspace<cr>", {
		desc = "Workspace Diagnostics",
	})

	local kind_filter = {
		default = {
			"Class",
			"Constructor",
			"Enum",
			"Field",
			"Function",
			"Interface",
			"Method",
			"Module",
			"Namespace",
			"Package",
			"Property",
			"Struct",
			"Trait",
		},
		markdown = false,
		help = false,
		-- you can specify a different filter for each filetype
		lua = {
			"Class",
			"Constructor",
			"Enum",
			"Field",
			"Function",
			"Interface",
			"Method",
			"Module",
			"Namespace",
			-- "Package", -- remove package since luals uses it for control flow structures
			"Property",
			"Struct",
			"Trait",
		},
	}

	local function get_kind_filter(buf)
		buf = (buf == nil or buf == 0) and vim.api.nvim_get_current_buf() or buf
		local ft = vim.bo[buf].filetype
		if kind_filter[ft] == false then
			return
		end
		if type(kind_filter[ft]) == "table" then
			return kind_filter[ft]
		end
		---@diagnostic disable-next-line: return-type-mismatch
		return type(kind_filter) == "table" and type(kind_filter.default) == "table" and kind_filter.default or nil
	end

	local function symbols_filter(entry, ctx)
		if ctx.symbols_filter == nil then
			ctx.symbols_filter = get_kind_filter(ctx.bufnr) or false
		end
		if ctx.symbols_filter == false then
			return true
		end
		return vim.tbl_contains(ctx.symbols_filter, entry.kind)
	end

	map("n", "<leader>=", function()
		require("fzf-lua").lsp_document_symbols({
			regex_filter = symbols_filter,
		})
	end, { desc = "Goto Symbol (Document)" })

	-- find

	map("n", "<leader>fb", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", {
		desc = "Buffers",
	})

	map("n", "<leader>fd", function()
		require("fzf-lua").fzf_exec("fd --type d --hidden --exclude .git", {
			fzf_opts = {
				["--preview"] = "eza --color=always -lA '{}' 2>/dev/null",
				["--preview-window"] = "nohidden,down,50%",
				["--ansi"] = "",
				["--multi"] = "",
			},
			actions = {
				-- On enter, open netrw in that directory
				["default"] = function(selected)
					if not selected or #selected == 0 then
						return
					end

					if #selected == 1 then
						local d = selected[1]
						if d and d ~= "" then
							vim.cmd("Explore " .. vim.fn.fnameescape(d))
						end
					else
						local list = {}
						for _, d in ipairs(selected) do
							if type(d) == "string" and d ~= "" then
								table.insert(list, { filename = d, lnum = 1, col = 1, text = "[dir]" })
							end
						end
						if #list == 0 then
							return
						end

						vim.fn.setqflist(list, "r")
						vim.cmd("copen")

						-- Jump to the first entry directory in current buffer:
						local first = list[1].filename
						if first and vim.fn.isdirectory(first) == 1 then
							vim.cmd("cd " .. vim.fn.fnameescape(first))
						end
					end
				end,
			},
		})
	end, { desc = "Find Dir" })

	map("n", "<leader>ff", "<cmd>FzfLua files<cr>", {
		desc = "Find Files (Root Dir)",
	})

	map("n", "<leader>fg", "<cmd>FzfLua git_files<cr>", {
		desc = "Find Files (git-files)",
	})

	map("n", "<leader>fr", "<cmd>FzfLua oldfiles<cr>", {
		desc = "Recent",
	})

	-- git
	map("n", "<leader>gc", "<cmd>FzfLua git_commits<cr>", {
		desc = "Git Commits",
	})

	map("n", "<leader>gs", "<cmd>FzfLua git_status<cr>", {
		desc = "Git Status",
	})

	-- search

	map("n", "<leader>sb", "<cmd>FzfLua grep_curbuf<cr>", {
		desc = "Buffer",
	})

	map("n", "<leader>sc", "<cmd>FzfLua command_history<cr>", {
		desc = "Command History",
	})

	map("n", "<leader>sC", "<cmd>FzfLua commands<cr>", {
		desc = "Commands",
	})

	map("n", "<leader>sd", "<cmd>FzfLua diagnostics_document<cr>", {
		desc = "Document Diagnostics",
	})

	map("n", "<leader>sD", "<cmd>FzfLua diagnostics_workspace<cr>", {
		desc = "Workspace Diagnostics",
	})

	map("n", "<leader>sh", "<cmd>FzfLua help_tags<cr>", {
		desc = "Help Pages",
	})

	map("n", "<leader>sH", "<cmd>FzfLua highlights<cr>", {
		desc = "Search Highlight Groups",
	})

	map("n", "<leader>sj", "<cmd>FzfLua jumps<cr>", {
		desc = "Jumplist",
	})

	map("n", "<leader>sk", "<cmd>FzfLua keymaps<cr>", {
		desc = "Keymaps",
	})

	map("n", "<leader>sq", "<cmd>FzfLua quickfix<cr>", {
		desc = "Quickfix List",
	})
end

local function setup_diagflow()
	require("diagflow").setup({
		text_align = "left",
		padding_right = 4,
		toggle_event = { "InsertEnter", "InsertLeave" },
		render_event = { "DiagnosticChanged", "CursorMoved" },
		scope = "line",
	})
end

local function setup_substitute()
	require("substitute").setup()
	map("n", "S", "<cmd>lua require('substitute').operator()<cr>", {
		desc = "substitute",
	})
	map({ "v", "x" }, "S", "<cmd>lua require('substitute').visual()<cr>", {
		desc = "substitute",
	})
end

local function setup_gitsigns()
	local bar = "│"
	local arrow = ""

	require("gitsigns").setup({
		linehl = false,
		signs = {
			add = { text = bar },
			change = { text = bar },
			delete = { text = arrow },
			topdelete = { text = arrow },
			changedelete = { text = bar },
			untracked = { text = bar },
		},
		signs_staged = {
			add = { text = bar },
			change = { text = bar },
			delete = { text = arrow },
			topdelete = { text = arrow },
			changedelete = { text = bar },
		},
		on_attach = function(buffer)
			local gs = package.loaded.gitsigns
			local pick = require("mini.pick")

			map("n", "]h", function()
				if vim.wo.diff then
					vim.cmd.normal({ "]c", bang = true })
				else
					gs.nav_hunk("next")
				end
			end, { desc = "Next Hunk" })

			map("n", "[h", function()
				if vim.wo.diff then
					vim.cmd.normal({ "[c", bang = true })
				else
					gs.nav_hunk("prev")
				end
			end, { desc = "Prev Hunk" })

			map("n", "]H", function()
				gs.nav_hunk("last")
			end, { desc = "Last Hunk" })

			map("n", "[H", function()
				gs.nav_hunk("first")
			end, { desc = "First Hunk" })

			map({ "n", "v" }, "<leader>gs", ":Gitsigns stage_hunk<CR>", { desc = "Stage Hunk" })
			map({ "n", "v" }, "<leader>gr", ":Gitsigns reset_hunk<CR>", { desc = "Reset Hunk" })
			map("n", "<leader>gS", gs.stage_buffer, { desc = "Stage Buffer" })
			map("n", "<leader>gu", gs.undo_stage_hunk, { desc = "Undo Stage Hunk" })
			map("n", "<leader>gR", gs.reset_buffer, { desc = "Reset Buffer" })
			map("n", "<leader>gp", gs.preview_hunk_inline, { desc = "Preview Hunk Inline" })
			map("n", "<leader>gdd", gs.diffthis, { desc = "Diff This" })

			map("n", "<leader>gdp", function()
				gs.diffthis("~")
			end, { desc = "Diff This ~" })

			map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Select Hunk" })

			map("n", "<leader>gdb", function()
				local branches = vim.fn.systemlist("git branch --format='%(refname:short)'")
				vim.ui.select(branches, {
					prompt = "Diff branch> ",
				}, function(choice)
					if choice then
						require("gitsigns").diffthis(choice)
					end
				end)
			end, { desc = "Diff this against Branch" })

			map("n", "<leader>gdc", function()
				local log = vim.fn.systemlist("git log --pretty=format:'%h %s' -n 50")
				vim.ui.select(log, {
					prompt = "Diff commit> ",
				}, function(choice)
					if choice then
						local commit = choice:match("^(%w+)")
						if commit then
							require("gitsigns").diffthis(commit)
						end
					end
				end)
			end, { desc = "Diff this against commit" })
		end,
	})
end

local function setup_gitportal()
	map({ "v", "n" }, "<leader>gb", function()
		require("gitportal").open_file_in_browser()
	end, { desc = "Open file in browser" })

	map({ "v", "n" }, "<leader>gy", function()
		require("gitportal").copy_link_to_clipboard()
	end, { desc = "Copy link to clipboard" })

	map("n", "<leader>gv", function()
		require("gitportal").open_file_in_neovim()
	end, { desc = "Visit file in neovim" })
end

local function setup_undotree()
	map("n", "<leader>u", vim.cmd.UndotreeToggle, {
		desc = "Toggle undotree",
	})
end

local function setup_render_markdown()
	require("render-markdown").setup({
		heading = {
			icons = {},
		},
	})
end

local function setup_lualine()
	require("lualine").setup({
		options = {
			theme = "auto",
			globalstatus = false,
			component_separators = { left = " ", right = " " },
			section_separators = { left = "", right = "" },
			disabled_filetypes = { statusline = { "dashboard", "alpha", "ministarter" } },
		},
		sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = {
				{
					function()
						local modes = {
							["n"] = "NOR",
							["i"] = "INS",
							["v"] = "VIS",
							["V"] = "VIS",
							["s"] = "SEL",
							["S"] = "SEL",
							["c"] = "CMD",
							["R"] = "REP",
							["r"] = "REP",
							["!"] = "SHL",
							["t"] = "TER",
						}

						return modes[vim.fn.mode()] or "???"
					end,
					separator = { left = "", right = "" }, -- Powerline separators for box effect
					padding = 1,
					color = function()
						return {
							fg = "#7a88cf",
							bg = "#222436",
						}
					end,
				},
				{
					"filename",
					path = 1,
					separator = "",
					padding = { right = 0, left = 1 },
					fmt = function(str)
						if vim.fn.bufname() == "" then
							return ""
						end
						-- Split the path by directory separator and remove the first component
						local parts = vim.split(str, "/")
						table.remove(parts, #parts)
						-- Join the remaining parts back together
						return table.concat(parts, "/") .. "/"
					end,
					color = function()
						return {
							fg = "#7a88cf",
							bg = "#222436",
						}
					end,
				},
				{
					"filename",
					path = 0,
					padding = { left = 0 },
					symbols = {
						modified = "[+]",
						readonly = "[-]",
						unnamed = "[No Name]",
					},
					color = function()
						if vim.fn.bufname() == "" then
							return {
								fg = "#7a88cf",
								bg = "#222436",
							}
						end

						return {
							fg = "#e0af68",
							bg = "#222436",
							gui = "bold",
						}
					end,
				},
			},
			lualine_x = {
				{
					"diagnostics",
					symbols = {
						error = " ",
						warn = " ",
						info = " ",
						hint = " ",
					},
				},
				{ "filetype", icon_only = true, separator = "", padding = { left = 2, right = 0 } },
				{
					-- Lsp server name .
					function()
						local msg = ""
						local buf_ft = vim.api.nvim_get_option_value("filetype", { buf = 0 })
						local clients = vim.lsp.get_clients()
						if next(clients) == nil then
							return msg
						end
						for _, client in ipairs(clients) do
							local filetypes = client.config.filetypes
							if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
								return client.name
							end
						end
						return msg
					end,
					padding = { left = 0, right = 3 },
				},
				{ "location" },
			},
			lualine_y = {},
			lualine_z = {},
		},
		extensions = { "quickfix" },
	})
end

local function setup_treesitter()
	require("nvim-treesitter.configs").setup({
		-- A list of parser names, or "all"
		ensure_installed = {
			"vimdoc",
			"javascript",
			"typescript",
			"markdown",
			"markdown_inline",
			"html",
			"embedded_template",
			"c",
			"lua",
			"templ",
			"rust",
			"regex",
			"jsdoc",
			"bash",
			"sql",
			"ruby",
			"go",
			"gomod",
			"gowork",
			"gosum",
			"yaml",
		},

		-- Install parsers synchronously (only applied to `ensure_installed`)
		sync_install = false,

		-- Automatically install missing parsers when entering buffer
		-- Recommendation: set to false if you don"t have `tree-sitter` CLI installed locally
		auto_install = true,

		indent = {
			enable = true,
			disable = { "ruby" },
		},

		highlight = {
			-- `false` will disable the whole extension
			enable = true,
			additional_vim_regex_highlighting = { "markdown" },
		},

		autotag = {
			enable = true,
		},

		textobjects = {
			enable = true,
			lookahead = true,
		},
	})

	-- trying to get ts ruby stuff better
	-- vim.g.ruby_indent_assignment_style = "variable"
	-- vim.g.ruby_indent_block_style = "do"
	-- vim.g.ruby_indent_access_modifier_style = "indent"
	-- vim.g.ruby_indent_hanging_elements = 1
	-- vim.g.ruby_operators = 1
	-- vim.g.ruby_indent_dot_match_mark_style = 'lambda'
	-- vim.g.ruby_indent_continuations = 1

	-- use native ruby indentation
	vim.api.nvim_create_autocmd("FileType", {
		pattern = "ruby",
		callback = function()
			vim.opt_local.indentexpr = "GetRubyIndent()"
			vim.opt_local.autoindent = true
			vim.opt_local.smartindent = true
		end,
	})

	require("nvim-treesitter.install").compilers = { "gcc-14" }
end

local function setup_treesitter_context() end

local function setup_conform()
	local prettierconf = { "prettier_d_slim", "prettierd", "prettier", stop_after_first = true }

	require("conform").setup({
		default_format_opts = {
			timeout_ms = 3000,
			async = false,
			quiet = false,
			lsp_format = "fallback",
		},
		formatters_by_ft = {
			lua = { "stylua" },
			fish = { "fish_indent" },
			sh = { "shfmt" },
			go = { "goimports" },
			typescript = prettierconf,
			javascript = prettierconf,
			typescriptreact = prettierconf,
			markdown = prettierconf,
			html = prettierconf,
			json = prettierconf,
			css = prettierconf,
			templ = { "templ" },
			sql = { "sql-formatter" },
			-- ruby = { "rubocop" },
		},
		format_on_save = {
			timeout_ms = 500,
			lsp_fallback = true,
			condition = function(bufnr)
				-- Skip files matching these patterns
				local filename = vim.api.nvim_buf_get_name(bufnr)
				return not (filename:match("%.min%.[jc]ss$"))
			end,
		},

		formatters = {
			injected = { options = { ignore_errors = true } },
		},
	})
end

local function setup_vim_test()
	vim.g["test#strategy"] = "neovim_sticky"
	map("n", "<leader>tt", "<cmd>TestNearest<cr>", { desc = "Test Nearest" })
	map("n", "<leader>tf", "<cmd>TestFile<cr>", { desc = "Test Current File" })
	map("n", "<leader>ta", "<cmd>TestSuite<cr>", { desc = "Test Whole Suite" })
	map("n", "<leader>t;", "<cmd>TestLast<cr>", { desc = "Rerun last test" })
	map("n", "<leader>tg", "<cmd>TestVisit<cr>", { desc = "Visit last test" })
end

local function setup_copilot()
	require("copilot").setup({
		filetypes = {
			org = false,
			markdown = false,
		},
		suggestion = {
			auto_trigger = true,
			keymap = {
				accept = "<D-;>",
				accept_word = false,
				accept_line = false,
				next = "<D-]>",
				prev = "<D-[>",
				dismiss = "<C-]>",
			},
		},
		panel = {
			enabled = false,
		},
	})
	vim.cmd([[Copilot auth]])
end

local function setup_harpoon()
	require("harpoon").setup({
		settings = {
			save_on_toggle = true,
		},
	})

	map("n", "<leader>ha", "<cmd>lua require('harpoon'):list():add()<cr>", {
		silent = true,
		desc = "Add to Harpoon",
	})

	map("n", "<leader>hh", "<cmd>require('harpoon').ui:toggle_quick_menu(require('harpoon'):list())<cr>", {
		silent = true,
		desc = "Toggle Harpoon",
	})

	map({ "n", "t" }, "<C-h>", "<cmd>lua require('harpoon'):list():select(1)<cr>", {
		desc = "Harpoon to file 1",
		silent = true,
	})
	map({ "n", "t" }, "<C-j>", "<cmd>lua require('harpoon'):list():select(2)<cr>", {
		desc = "Harpoon to file 2",
		silent = true,
	})
	map({ "n", "t" }, "<C-k>", "<cmd>lua require('harpoon'):list():select(3)<cr>", {
		desc = "Harpoon to file 3",
		silent = true,
	})
	map({ "n", "t" }, "<C-l>", "<cmd>lua require('harpoon'):list():select(4)<cr>", {
		desc = "Harpoon to file 4",
		silent = true,
	})
	map({ "n", "t" }, "<C-;>", "<cmd>lua require('harpoon'):list():select(5)<cr>", {
		desc = "Harpoon to file 5",
		silent = true,
	})
	map({ "n", "t" }, "<C-'>", "<cmd>lua require('harpoon'):list():select(6)<cr>", {
		desc = "Harpoon to file 6",
		silent = true,
	})
end
-- }}}

-- {{{ Plugins
-- cmd to update treesitter parsers when nvim-treesitter is installed or updated
vim.api.nvim_create_autocmd("PackChanged", {
	group = vim.api.nvim_create_augroup("TSUpdateForTreesitter", {}),
	callback = function(event)
		local name = event.spec and event.spec.name
		local src = event.spec and event.spec.src or ""
		if
			(name == "nvim-treesitter" or src:match("nvim%-treesitter"))
			and (event.kind == "install" or event.kind == "update")
		then
			vim.schedule(function()
				vim.cmd("TSUpdate")
			end)
		end
	end,
})

vim.pack.add({
	"https://github.com/dgagn/diagflow.nvim",
	"https://github.com/echasnovski/mini.nvim",
	"https://github.com/folke/tokyonight.nvim",
	"https://github.com/gbprod/substitute.nvim",
	"https://github.com/ibhagwan/fzf-lua",
	"https://github.com/lewis6991/gitsigns.nvim",
	"https://github.com/mbbill/undotree",
	"https://github.com/meanderingprogrammer/render-markdown.nvim",
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/nvim-lualine/lualine.nvim",
	"https://github.com/nvim-treesitter/nvim-treesitter",
	"https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
	"https://github.com/stevearc/conform.nvim",
	"https://github.com/trevorhauter/gitportal.nvim",
	"https://github.com/vim-test/vim-test",
	"https://github.com/zbirenbaum/copilot.lua",
	{ src = "https://github.com/ThePrimeagen/harpoon", version = "harpoon2" },
})

vim.cmd([[colorscheme tokyonight-moon]])

setup_conform()
setup_copilot()
setup_diagflow()
setup_fzf()
setup_gitportal()
setup_gitsigns()
setup_harpoon()
setup_lualine()
setup_mini_ai()
setup_mini_clue()
setup_mini_completion()
setup_mini_diff()
setup_mini_files()
setup_mini_icons()
setup_mini_pick()
setup_mini_sessions()
setup_mini_splitjoin()
setup_mini_starter()
setup_mini_surround()
setup_render_markdown()
setup_substitute()
setup_treesitter()
setup_treesitter_context()
setup_undotree()
setup_vim_test()

-- }}}

-- {{{ LSP

function _G.lsp_cleanup()
	local new_root = vim.fs.root(0, {
		".git",
		"Gemfile",
		"go.mod",
		"package.json",
		"Cargo.toml",
	})

	for _, client in pairs(vim.lsp.get_clients()) do
		if client.config.root_dir and client.config.root_dir ~= new_root then
			client:stop()
		end
	end
end

vim.lsp.config("*", {
	on_attach = function(client, bufnr)
		local opts = { buffer = bufnr, silent = true }

		-- Navigation
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
		vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

		-- Documentation
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
		vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, opts)

		-- Code actions
		vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "<leader>cn", vim.lsp.buf.rename, opts)
		vim.keymap.set("n", "<leader>cm", function()
			vim.lsp.buf.format({ async = true })
		end, opts)

		-- Diagnostics
		vim.keymap.set("n", "[d", function()
			vim.diagnostic.jump({ count = -1 })
		end, opts)
		vim.keymap.set("n", "]d", function()
			vim.diagnostic.jump({ count = 1 })
		end, opts)
		vim.keymap.set("n", "<leader>ce", vim.diagnostic.open_float, opts)
		vim.keymap.set("n", "<leader>cq", vim.diagnostic.setloclist, opts)

		-- Workspace
		vim.keymap.set("n", "<leader>cwa", vim.lsp.buf.add_workspace_folder, opts)
		vim.keymap.set("n", "<leader>cwr", vim.lsp.buf.remove_workspace_folder, opts)
		vim.keymap.set("n", "<leader>cwl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts)
	end,
})

for _, name in ipairs({
	"bashls",
	"cssls",
	"dockerls",
	"herb_ls",
	"jsonls",
	"lua_ls",
	"marksman",
	"ruby_lsp",
	"sqlls",
	"tailwindcss",
	"ts_ls",
	"yamlls",
	"docker_compose_language_service",
	"html",
	"stimulus",
}) do
	vim.lsp.enable(name)
end

vim.diagnostic.config({
	underline = true,
	virtual_text = false,
	update_in_insert = false,
	signs = {
		text = { -- <- nested
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.HINT] = "",
			[vim.diagnostic.severity.INFO] = "",
		},
	},
	float = {
		focusable = false,
		style = "minimal",
		border = "rounded",
		source = true,
		header = "",
		prefix = "",
		close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
	},
})

-- }}}

-- {{{ Filetypes

vim.api.nvim_create_augroup("userft", {})

-- edn is clojure
vim.api.nvim_create_autocmd("BufRead", {
	desc = "set edn to clojure",
	group = "userft",
	pattern = "*.edn",
	command = "set ft=clojure",
})

-- gohtml is html
vim.api.nvim_create_autocmd("BufRead", {
	desc = "set gohtml to html",
	group = "userft",
	pattern = "*.gohtml",
	command = "set ft=html",
})

-- Brewfile is ruby
vim.api.nvim_create_autocmd("BufRead", {
	desc = "set Brewfile to ruby",
	group = "userft",
	pattern = "Brewfile",
	command = "set ft=ruby",
})

-- .envrc is bash
vim.api.nvim_create_autocmd("BufRead", {
	desc = "set envrc to bash",
	group = "userft",
	pattern = ".envrc*",
	command = "set ft=bash",
})

-- set golang formatting
vim.api.nvim_create_autocmd("BufRead", {
	desc = "golang formatting",
	group = "userft",
	pattern = "*.go",
	callback = function()
		vim.opt_local.expandtab = false -- noet: Don't expand tabs to spaces
		vim.opt_local.tabstop = 4 -- ts=4: Number of spaces that a <Tab> in the file counts for
		vim.opt_local.shiftwidth = 4 -- sw=4: Size of an indent
		vim.opt_local.softtabstop = 4 -- sts=4: Number of spaces that a Tab counts for while performing editing operations

		-- vim.keymap.set("n", "<leader>td", [[<cmd>lua require('dap-go').debug_test()<CR>]],
		--     { buffer = true, noremap = true, silent = true, desc = "Debug Nearest (go)" })
		--
		-- vim.keymap.set("n", "<leader>tD", [[<cmd>lua require('dap-go').debug_last_test()<CR>]],
		--     { buffer = true, noremap = true, silent = true, desc = "Debug Last (go)" })
	end,
})

vim.api.nvim_create_autocmd("BufRead", {
	desc = "golang mod file ft",
	group = "userft",
	pattern = "go.mod",
	command = "set ft=gomod",
})

vim.api.nvim_create_autocmd("BufRead", {
	desc = "golang sum file ft",
	group = "userft",
	pattern = "go.sum",
	command = "set ft=gosum",
})

vim.api.nvim_create_autocmd("BufRead", {
	desc = "golang workspace file ft",
	group = "userft",
	pattern = "go.work",
	command = "set ft=gowork",
})
-- }}}
