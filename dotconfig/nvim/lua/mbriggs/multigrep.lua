-- Multi-grep implementation for Mini.Pick
-- Allows searching for pattern and filtering by file/directory patterns
-- Usage: Type your search, then :: followed by glob pattern
-- Example: "TODO::*.lua" searches for TODO only in Lua files

local M = {}

local function create_multigrep_picker()
	local pick = require("mini.pick")
	local separator = "::" -- Can be changed to any pattern

	return function()
		local process
		local set_items_opts = { do_match = false }
		local spawn_opts = { cwd = vim.uv.cwd() }

		local match = function(_, _, query)
			-- Kill previous process
			pcall(vim.loop.process_kill, process)

			-- For empty query, explicitly set empty items
			if #query == 0 then
				return pick.set_picker_items({}, set_items_opts)
			end

			-- Get the full query string and split on separator
			local full_query = table.concat(query)
			local pattern_start = full_query:find(separator, 1, true)

			local search_pattern, file_pattern
			if pattern_start then
				search_pattern = full_query:sub(1, pattern_start - 1)
				file_pattern = full_query:sub(pattern_start + #separator)
			else
				search_pattern = full_query
				file_pattern = ""
			end

			-- Don't search if pattern is empty
			if search_pattern == "" then
				return pick.set_picker_items({}, set_items_opts)
			end

			-- Build ripgrep command
			local command = {
				"rg",
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
				"--smart-case",
				"-e",
				search_pattern,
			}

			-- Add file/dir pattern if provided
			if file_pattern ~= "" then
				table.insert(command, "-g")
				table.insert(command, file_pattern)
			end

			process = pick.set_picker_items_from_cli(command, {
				postprocess = function(lines)
					local results = {}
					for _, line in ipairs(lines) do
						if line ~= "" then
							-- Parse ripgrep output: file:line:col:text
							local file, lnum, col, text = line:match("([^:]+):(%d+):(%d+):(.*)")
							if file then
								results[#results + 1] = {
									path = file,
									lnum = tonumber(lnum),
									col = tonumber(col),
									text = line,
								}
							end
						end
					end
					return results
				end,
				set_items_opts = set_items_opts,
				spawn_opts = spawn_opts,
			})
		end

		return pick.start({
			source = {
				items = {},
				name = string.format("Multi Grep (pattern%sglob)", separator),
				match = match,
				show = function(buf_id, items_to_show, query)
					pick.default_show(buf_id, items_to_show, query, { show_icons = true })
				end,
				choose = pick.default_choose,
			},
		})
	end
end

M.setup = function()
	local pick = require("mini.pick")
	-- Register in mini.pick registry
	pick.registry.multigrep = create_multigrep_picker()

	-- Optional: Create keymap
	vim.keymap.set("n", "<leader>sG", function()
		pick.registry.multigrep()
	end, { desc = "Multi grep (pattern::glob)" })
end

return M
