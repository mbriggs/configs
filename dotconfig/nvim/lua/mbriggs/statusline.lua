_G.StatusLine = {}
StatusLine = _G.StatusLine

-- Define the status line function
function StatusLine.active()
	-- Get the file path relative to the project root (cwd), without the filename
	local filepath = vim.fn.fnamemodify(vim.fn.expand("%:~:."), ":h")
	-- Get just the filename
	local filename = vim.fn.expand("%:t")
	-- If no file, show "[No Name]"
	local is_no_name = false
	if filename == "" then
		filename = "[No Name]"
		is_no_name = true
	end

	local is_file_buffer = (not is_no_name and filepath ~= "")

	-- Get the file icon and color using nvim-web-devicons
	local icon, _ = require("nvim-web-devicons").get_icon(filename, vim.fn.expand("%:e"), { default = true })

	-- Use a representational single-width symbol for indicating a modified file or the default '[+]'
	local modified = (vim.bo.modified and is_file_buffer) and " [+]" or ""

	-- Assemble the status line components
	local components = {
		"%#StatusLine#", -- Highlight group
		(icon and ("%#StatusLineIcon#" .. icon .. " ")) or "", -- Telescope or file type icon
		" ",
		is_file_buffer and ("%#StatusLinePath#" .. filepath .. "/") or "", -- File path with its own highlight
		is_file_buffer and ("%#StatusLineFile#" .. filename) or ("%#StatusLinePath#" .. filename), -- File name with white bold highlight
		"%#StatusLineModified#", -- Modified indicator highlight
		modified, -- Modified indicator
		"%#StatusLine#", -- Reset to default highlight
		" ",
		"%=%#StatusLineFT#", -- Align right
		vim.bo.filetype, -- File type
		" ",
		"%l:%c / %L", -- Line and column
	}

	-- Combine components with no additional space between filename and path
	return table.concat(components, "")
end

StatusLine.inactive = function()
	return "%#StatusLineNC#%f %m %r%h %w %y"
end

StatusLine.short = function()
	return "%#StatusLine#%f %m %r%h %w %y"
end

-- TokyoNight Moon
vim.cmd("highlight StatusLineIcon guifg=#9ece6a guibg=#222436") -- Light green for icons
vim.cmd("highlight StatusLinePath guifg=#7a88cf guibg=#222436") -- Muted blue for the file path
vim.cmd("highlight StatusLineFile guifg=#e0af68 guibg=#222436 gui=bold") -- Yellow for the filename
vim.cmd("highlight StatusLineFT guifg=#ff9e64 guibg=#222436") -- Orange for filetype
vim.cmd("highlight StatusLineModified guifg=#bb9af7 guibg=#222436") -- Purple for modified indicator
vim.cmd("highlight StatusLine guifg=#c8d3f5 guibg=#222436") -- Default statusline color
vim.cmd("highlight StatusLineNC guifg=#7a88cf guibg=#1e2030") -- Non-current window statusline
vim.cmd("highlight StatusLine guibg=#222436") -- Active statusline background
vim.cmd("highlight StatusLineNC guibg=#1e2030") -- Inactive statusline background

--- Frappe
-- vim.cmd("highlight StatusLineIcon guifg=#a6d189 guibg=#292c3c") -- Use a static greenish color for icons
-- vim.cmd("highlight StatusLinePath guifg=#9ca0a4 guibg=#292c3c") -- Dimmed color for the file path (Grayish)
-- vim.cmd("highlight StatusLineFile guifg=#ffffff guibg=#292c3c") -- White color for the filename, bold
-- vim.cmd("highlight StatusLineFT guifg=#f2d5cf guibg=#292c3c") -- Peach (text) on dark background
-- vim.cmd("highlight StatusLineModified guifg=#f4b8e4 guibg=#292c3c") -- Pink/purple for modified indicator

-- Latte
-- vim.cmd("highlight StatusLineIcon guifg=#40a02b guibg=#e6e9ef") -- Greenish color for icons (from Latte)
-- vim.cmd("highlight StatusLinePath guifg=#4c4f69 guibg=#e6e9ef") -- Dimmed color for the file path (Grayish from Latte)
-- vim.cmd("highlight StatusLineFile guifg=#1e1e2e guibg=#e6e9ef") -- Darker color for the filename, bold (from Latte)
-- vim.cmd("highlight StatusLineFT guifg=#dc8a78 guibg=#e6e9ef") -- Peach (text) on light background (from Latte)
-- vim.cmd("highlight StatusLineModified guifg=#ea76cb guibg=#e6e9ef") -- Pink/purple for modified indicator (from Latte)

local statusline_group = vim.api.nvim_create_augroup("StatusLine", { clear = true })

vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
	group = statusline_group,
	callback = function()
		vim.wo.statusline = "%!v:lua.StatusLine.active()"
	end,
})

vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
	group = statusline_group,
	callback = function()
		vim.wo.statusline = "%!v:lua.StatusLine.inactive()"
	end,
})

vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter", "FileType" }, {
	group = statusline_group,
	pattern = "NvimTree",
	callback = function()
		vim.wo.statusline = "%!v:lua.StatusLine.short()"
	end,
})
