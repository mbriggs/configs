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
vim.opt.number = true

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

vim.opt.scrolloff = 8         -- lines to keep above / below the cursor
vim.opt.signcolumn = "yes"    -- show signs

vim.opt.isfname:append("@-@") -- allow @ in file names

vim.opt.updatetime = 50       -- speed up ui

vim.o.grepprg = "rg --vimgrep --no-heading --smart-case"
