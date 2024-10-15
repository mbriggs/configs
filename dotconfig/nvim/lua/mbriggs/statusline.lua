local M = {}

local devicons = require("nvim-web-devicons")

local function get_file_info()
	local filepath = vim.fn.fnamemodify(vim.fn.expand("%:~:."), ":h")
	local filename = vim.fn.expand("%:t")
	local is_no_name = filename == ""

	if is_no_name then
		filename = "[No Name]"
	end

	return {
		filepath = filepath,
		filename = filename,
		is_no_name = is_no_name,
		is_file_buffer = not is_no_name and filepath ~= "",
	}
end

local function get_icon(filename)
	local icon, _ = devicons.get_icon(filename, vim.fn.expand("%:e"), { default = true })
	return icon and ("%#StatusLineIcon#" .. icon .. " ") or ""
end

local function get_modified_indicator(is_modified, is_file_buffer)
	return (is_modified and is_file_buffer) and "%#StatusLineModified# [+]" or ""
end

function M.active()
	local file_info = get_file_info()
	local icon = get_icon(file_info.filename)
	local modified = get_modified_indicator(vim.bo.modified, file_info.is_file_buffer)

	local components = {
		"%#StatusLine#",
		icon,
		file_info.is_file_buffer and ("%#StatusLinePath#" .. file_info.filepath .. "/") or "",
		file_info.is_file_buffer and ("%#StatusLineFile#" .. file_info.filename)
			or ("%#StatusLinePath#" .. file_info.filename),
		modified,
		"%#StatusLine#",
		"%=%#StatusLineFT#",
		vim.bo.filetype,
		" ",
		"%l:%c / %L",
	}

	return table.concat(components, "")
end

function M.inactive()
	return "%#StatusLineNC#%f %m %r%h %w %y"
end

function M.short()
	return "%#StatusLine#%f %m %r%h %w %y"
end

local function set_highlights()
	local highlights = {
		StatusLineIcon = { fg = "#9ece6a", bg = "#222436" },
		StatusLinePath = { fg = "#7a88cf", bg = "#222436" },
		StatusLineFile = { fg = "#e0af68", bg = "#222436", bold = true },
		StatusLineFT = { fg = "#ff9e64", bg = "#222436" },
		StatusLineModified = { fg = "#bb9af7", bg = "#222436" },
		StatusLine = { fg = "#c8d3f5", bg = "#222436" },
		StatusLineNC = { fg = "#7a88cf", bg = "#1e2030" },
	}

	for group, colors in pairs(highlights) do
		vim.api.nvim_set_hl(0, group, colors)
	end
end

local function setup_autocommands()
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
end

function M.setup()
	set_highlights()
	setup_autocommands()
	_G.StatusLine = M
end

return M
