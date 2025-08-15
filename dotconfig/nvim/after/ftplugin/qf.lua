local map = vim.keymap.set
local opts = { buffer = true, silent = true }

local function is_loclist()
	local wininfo = vim.fn.getwininfo(vim.api.nvim_get_current_win())[1]
	return wininfo.loclist == 1
end

local function delete_lines(start_line, end_line)
	local current_line = vim.fn.line(".")
	vim.fn.winsaveview()

	local list
	if is_loclist() then
		list = vim.fn.getloclist(0)
	else
		list = vim.fn.getqflist()
	end

	-- Remove the specified lines (convert to 0-based indexing)
	for i = end_line, start_line, -1 do
		table.remove(list, i)
	end

	-- Update the list without reopening window
	if is_loclist() then
		vim.fn.setloclist(0, list, "r")
	else
		vim.fn.setqflist(list, "r")
	end

	-- Calculate new cursor position (Vim-like behavior)
	local new_line
	if current_line >= start_line and current_line <= end_line then
		-- Cursor was on a deleted line - stay at same position
		-- (next line moves up to fill the gap)
		new_line = start_line
		-- If we deleted the last lines, move to the new last line
		if new_line > #list then
			new_line = #list
		end
		-- Handle empty list
		if new_line == 0 then
			new_line = 1
		end
	elseif current_line > end_line then
		-- Cursor was after deleted lines - adjust position
		local deleted_count = end_line - start_line + 1
		new_line = current_line - deleted_count
	else
		-- Cursor was before deleted lines - no change needed
		new_line = current_line
	end

	-- Set cursor position
	if new_line > 0 and new_line <= #list then
		vim.fn.cursor(new_line, 0)
	elseif #list > 0 then
		vim.fn.cursor(#list, 0)
	end
end

-- Delete current line (d)
map("n", "d", function()
	local line = vim.fn.line(".")
	delete_lines(line, line)
end, vim.tbl_extend("force", opts, { desc = "Delete quickfix entry" }))

-- Delete visual selection (d in visual mode) - fixed to handle all selected lines
map("x", "d", function()
	-- Get the visual selection range while still in visual mode
	local start_line = vim.fn.line("v")
	local end_line = vim.fn.line(".")

	-- Ensure start_line is less than end_line
	if start_line > end_line then
		start_line, end_line = end_line, start_line
	end

	-- Exit visual mode
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)

	-- Delete the lines
	delete_lines(start_line, end_line)
end, vim.tbl_extend("force", opts, { desc = "Delete selected quickfix entries" }))

-- Close quickfix window (q) - with nowait to avoid delay from q: mapping
map("n", "q", "<cmd>close<CR>", vim.tbl_extend("force", opts, { desc = "Close quickfix window", nowait = true }))

-- Simple navigation that stays in quickfix window
local function navigate(direction)
	local current_line = vim.fn.line(".")

	local list
	if is_loclist() then
		list = vim.fn.getloclist(0)
	else
		list = vim.fn.getqflist()
	end

	local list_size = #list
	if list_size == 0 then
		return
	end

	local new_line
	if direction == "next" then
		if current_line < list_size then
			new_line = current_line + 1
		else
			new_line = current_line
		end
	else
		if current_line > 1 then
			new_line = current_line - 1
		else
			new_line = current_line
		end
	end

	-- Move cursor in quickfix window
	vim.fn.cursor(new_line, 0)

	-- Jump to the file/location without leaving quickfix
	local cmd
	if is_loclist() then
		cmd = "ll"
	else
		cmd = "cc"
	end
	local win_id = vim.api.nvim_get_current_win()

	-- Save the quickfix window ID before jumping
	vim.cmd("silent! " .. cmd .. " " .. new_line)

	-- Return focus to quickfix window
	vim.api.nvim_set_current_win(win_id)
end

-- Navigate entries (n/p) - stay in quickfix window
map("n", "n", function()
	navigate("next")
end, vim.tbl_extend("force", opts, { desc = "Next quickfix entry (stay in qf)" }))

map("n", "p", function()
	navigate("prev")
end, vim.tbl_extend("force", opts, { desc = "Previous quickfix entry (stay in qf)" }))

-- Additional useful keybindings

-- Open entry and keep quickfix window open (o or Enter)
map("n", "o", "<CR><C-w>p", vim.tbl_extend("force", opts, { desc = "Open entry, keep quickfix open" }))
map("n", "<CR>", "<CR><C-w>p", vim.tbl_extend("force", opts, { desc = "Open entry, keep quickfix open" }))

-- Preview entry without jumping (Tab)
map("n", "<Tab>", function()
	local line = vim.fn.line(".")
	local cmd = is_loclist() and "ll" or "cc"
	vim.cmd(cmd .. " " .. line)
	vim.cmd("wincmd p") -- Return to quickfix window
end, vim.tbl_extend("force", opts, { desc = "Preview entry" }))

-- Open in splits and tabs
map("n", "<C-v>", "<C-w><CR><C-w>L", vim.tbl_extend("force", opts, { desc = "Open in vertical split" }))
map("n", "<C-s>", "<C-w><CR>", vim.tbl_extend("force", opts, { desc = "Open in horizontal split" }))
map("n", "<C-t>", "<C-w><CR><C-w>T", vim.tbl_extend("force", opts, { desc = "Open in new tab" }))

-- Jump to first/last entry (H/L)
map("n", "H", function()
	local cmd = is_loclist() and "lfirst" or "cfirst"
	vim.cmd("silent! " .. cmd)
end, vim.tbl_extend("force", opts, { desc = "First quickfix entry" }))

map("n", "L", function()
	local cmd = is_loclist() and "llast" or "clast"
	vim.cmd("silent! " .. cmd)
end, vim.tbl_extend("force", opts, { desc = "Last quickfix entry" }))

-- Refresh quickfix list (R) - useful for grep/vimgrep results
map("n", "R", function()
	-- Trigger QuickFixCmdPost to refresh any dynamic lists
	vim.cmd("doautocmd QuickFixCmdPost")
	vim.notify("Quickfix list refreshed", vim.log.levels.INFO)
end, vim.tbl_extend("force", opts, { desc = "Refresh quickfix list" }))

-- Window settings for better visibility
vim.wo.number = false
vim.wo.relativenumber = false
vim.wo.wrap = false
vim.wo.spell = false
vim.wo.cursorline = true
