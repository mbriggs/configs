local map = vim.keymap.set

-- Only applies in terminal mode
map("t", "<Esc>", "<C-\\><C-n>", { silent = true })

-- Alternative: map specific sequence for terminal escape
map("t", "<C-[>", "<C-\\><C-n>", { silent = true })

-- Disable line numbers in terminal
vim.api.nvim_create_autocmd("TermOpen", {
	callback = function()
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
		vim.cmd("startinsert") -- Start in insert mode

		map("t", "<D-,>", function()
			vim.cmd("stopinsert")
			vim.cmd("TermRename")
		end, { buffer = true })
	end,
})

vim.api.nvim_create_autocmd("TermEnter", {
	callback = function()
		vim.opt.guicursor = "a:ver25" -- Vertical bar in terminal mode
	end,
})

vim.api.nvim_create_autocmd("TermLeave", {
	callback = function()
		vim.opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20" -- Reset to normal cursor
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
			vim.api.nvim_buf_set_name(bufnr, name)
		end
	end)
end, {})
