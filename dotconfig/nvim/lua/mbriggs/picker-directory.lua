return {
	finder = function(opts, filter)
		local items = {}

		local ok, dirs = pcall(vim.fn.systemlist, "fd --type d --hidden --exclude .git")
		if not ok then
			vim.notify("Failed to list directories: " .. dirs, vim.log.levels.ERROR)
			return {}
		end

		local cwd = vim.fn.getcwd()
		for idx, dir in ipairs(dirs) do
			local item = {
				idx = idx,
				text = dir,
				dir = dir,
				score = 1,
				file = vim.fn.fnamemodify(cwd .. "/" .. dir, ":p"),
				icon = "󰉋 ", -- folder icon
				highlights = {
					{
						{ "󰉋 ", "Directory" }, -- highlight folder icon
						{ dir, "Normal" }, -- highlight path
					},
				},
			}

			if filter:match(item) then
				table.insert(items, item)
			end
		end

		return items
	end,

	format = "file",
	-- format = function(item)
	--   return {
	--     { item.icon .. " ", "Directory" },
	--     { item.text,        "Normal" },
	--   }
	-- end,

	preview = "directory",
	layout = {
		preset = "vertical",
		height = 0.4,
		width = 0.6,
	},

	prompt = "❯ ",
	actions = {
		["<c-x>"] = { "edit_split", mode = { "i", "n" } },
		["<c-v>"] = { "edit_vsplit", mode = { "i", "n" } },
	},
	confirm = function(picker, item)
		picker:close()
		if item and item.dir then
			require("neo-tree.command").execute({
				position = "current",
				dir = vim.fn.getcwd() .. "/" .. item.dir,
			})
		end
	end,
}
