-- qf list
local del_qf_item = function()
	local items = vim.fn.getqflist()
	local line = vim.fn.line(".")
	table.remove(items, line)
	vim.fn.setqflist(items, "r")
	if line > #items then
		line = #items
	end
	vim.api.nvim_win_set_cursor(0, { line, 0 })
end

vim.api.nvim_create_autocmd("FileType", {
	desc = "remove items from quickfix list",
	group = "userft",
	callback = function(opts)
		local ft = vim.bo[opts.buf].filetype

		if ft == "qf" then
			vim.keymap.set("n", "dd", del_qf_item, { silent = true, buffer = true, desc = "Remove entry from QF" })
		end
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "qf",
	callback = function(event)
		local opts = { buffer = event.buf, silent = true }
		vim.keymap.set("n", "<C-n>", "<cmd>cn | wincmd p<CR>", opts)
		vim.keymap.set("n", "<C-p>", "<cmd>cN | wincmd p<CR>", opts)
	end,
})
