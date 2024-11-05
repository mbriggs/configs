-- 2 spaces by default
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- more sophisticated indentation
vim.opt.smartindent = true

-- search settings
vim.opt.smartcase = true
vim.opt.ignorecase = true

-- conceal links in org mode
vim.opt.conceallevel = 2
vim.opt.concealcursor = "nc"

-- soft wrapping long lines
vim.opt.wrap = true

-- dont show line numbers by default
vim.opt.number = false

-- make extra files less irritating
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.config/nvim/undo"
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

--- netrw

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
