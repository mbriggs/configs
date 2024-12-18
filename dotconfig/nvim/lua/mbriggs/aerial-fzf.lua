local function aerial_fzf()
	-- Ensure both plugins are available
	local ok_aerial, aerial = pcall(require, "aerial")
	local ok_fzf, fzf = pcall(require, "fzf-lua")

	if not (ok_aerial and ok_fzf) then
		vim.notify("aerial or fzf-lua not found", vim.log.levels.ERROR)
		return
	end

	-- Load aerial data
	aerial.sync_load()
	local backends = require("aerial.backends")
	local data = require("aerial.data")
	local util = require("aerial.util")
	local config = require("aerial.config")

	local backend = backends.get()
	if not backend then
		backends.log_support_err()
		return
	elseif not data.has_symbols(0) then
		backend.fetch_symbols_sync(0)
	end

	-- Get symbols
	local results = {}
	if data.has_symbols(0) then
		local bufdata = data.get_or_create(0)
		for _, item in bufdata:iter({ skip_hidden = false }) do
			table.insert(results, item)
		end
	end

	if #results == 0 then
		vim.notify("No symbols found", vim.log.levels.WARN)
		return
	end

	-- Reverse the symbols so they have the same top-to-bottom order as in the file
	util.tbl_reverse(results)

	-- Format symbols for fzf
	local entries = {}
	for _, symbol in ipairs(results) do
		-- Build symbol path
		local symbol_path = {}
		local cur = symbol
		while cur do
			table.insert(symbol_path, 1, cur.name)
			cur = cur.parent
		end

		-- Get icon
		local bufnr = vim.api.nvim_get_current_buf()
		local icon = config.get_icon(bufnr, symbol.kind)

		-- Get lnum and col from selection range if available
		local lnum = symbol.selection_range and symbol.selection_range.lnum or symbol.lnum
		local col = symbol.selection_range and symbol.selection_range.col or symbol.col

		-- Format display string
		local indent = string.rep("  ", #symbol_path - 1)
		local display = string.format("%s%s %s", indent, icon, symbol.name)

		table.insert(entries, {
			display,
			lnum,
			col + 1,
		})
	end

	-- Call fzf-lua with formatted entries
	fzf.fzf_exec(function(cb)
		for _, entry in ipairs(entries) do
			cb(entry[1])
		end
		cb(nil)
	end, {
		actions = {
			["default"] = function(selected)
				-- Get the selected entry
				for _, entry in ipairs(entries) do
					if entry[1] == selected[1] then
						-- Jump to the symbol location
						vim.api.nvim_win_set_cursor(0, { entry[2], entry[3] - 1 })
						break
					end
				end
			end,
		},
		prompt = "Symbols❯ ",
		winopts = {
			height = 0.5,
			width = 0.7,
		},
	})
end

vim.api.nvim_create_user_command("AerialFzf", aerial_fzf, {})
