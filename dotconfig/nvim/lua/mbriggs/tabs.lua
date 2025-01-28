local map = vim.keymap.set
local modes = { "n", "v", "i", "t" }
opts = { silent = true }

map(modes, "<D-n>", "<cmd>tabnew<CR>", opts)
map(modes, "<D-w>", "<cmd>tabclose<CR>", opts)
map(modes, "<D-Left>", "<cmd>tabprevious<CR>", opts)
map(modes, "<D-Right>", "<cmd>tabnext<CR>", opts)
map(modes, "<D-S-Left>", "<cmd>tabmove -1<CR>", opts)
map(modes, "<D-S-Right>", "<cmd>tabmove +1<CR>", opts)

for i = 1, 9 do
	map(modes, string.format("<D-%d>", i), string.format("%dgt", i), opts)
end
