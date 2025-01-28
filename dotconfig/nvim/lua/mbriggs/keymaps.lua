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
map('n', '<A-Up>', ':resize +2<CR>')
map('n', '<A-Down>', ':resize -2<CR>')
map('n', '<A-Left>', ':vertical resize -2<CR>')
map('n', '<A-Right>', ':vertical resize +2<CR>')

-- Ctrl+ for larger adjustments
map('n', '<C-Up>', ':resize +10<CR>')
map('n', '<C-Down>', ':resize -10<CR>')
map('n', '<C-Left>', ':vertical resize -10<CR>')
map('n', '<C-Right>', ':vertical resize +10<CR>')

-- Map Cmd+F to % (jump to matching bracket)
map({ "n", "v", "o", "i" }, "<D-f>", "%")
map("c", "<D-f>", '<C-r>="%"<CR>') -- Command mode for :%s/foo etc.

-- dabbrev style completion
map("i", "<D-/>", "<C-n>", { desc = "next completion", noremap = "true" })
map("i", "<D-S-/>", "<C-x><C-n>", { desc = "next completion in current file", noremap = "true" })

-- built in snippets
map({ "s", "i" }, "<Tab>", function()
  if vim.snippet.active({ direction = 1 }) then
    vim.snippet.jump(1)
  elseif next(vim.lsp.get_clients({ bufnr = 0 })) and vim.lsp.completion then
    vim.lsp.completion.trigger()
  end
end)

map("s", "<S-Tab>", function()
  if vim.snippet.active({ direction = -1 }) then
    vim.snippet.jump(-1)
  end
end)

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
    local map = vim.keymap.set
    if vim.wo.diff then
      local opts = { buffer = true, noremap = true, silent = true }
      map("n", "gf", "diffget //2", opts)
      map("n", "gj", "diffget //3", opts)
    end
  end,
})
