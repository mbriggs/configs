local M = {}

local spinner = require("mbriggs.spinner")

-- Main Claude integration function using vim.system
-- @param prompt string The prompt to send to Claude
-- @param callback function|nil Optional callback to handle the response lines
-- @param opts table|nil Options table with:
--   - insert_at: "start" | number | nil - Where to insert the response
--   - notify_msg: string - Message to show while generating
--   - model: string - Model to use (e.g., "sonnet-4", "opus-3", etc.)
function M.run(prompt, callback, opts)
	opts = opts or {}
	local notify_msg = opts.notify_msg or "Generating with Claude..."
	local model = opts.model

	-- Capture cursor position and buffer BEFORE starting async operation
	local target_bufnr = vim.api.nvim_get_current_buf()
	local target_row

	-- Cleaner position calculation
	local insert_at = opts.insert_at
	if insert_at == "start" then
		target_row = 0
	elseif type(insert_at) == "number" then
		target_row = insert_at - 1 -- Convert to 0-indexed
	else
		target_row = vim.api.nvim_win_get_cursor(0)[1] - 1
	end

	-- Create and start spinner
	local spin = spinner.create(notify_msg)

	-- Build command
	local cmd = { "claude", "--print" }
	if model then
		table.insert(cmd, "--model")
		table.insert(cmd, model)
	end
	table.insert(cmd, prompt)

	vim.system(cmd, { text = true }, function(result)
		vim.schedule(function()
			spin.stop()

			if result.code == 0 then
				local output = result.stdout or ""
				local lines = vim.split(output, "\n")

				-- Remove empty last line if present
				if lines[#lines] == "" then
					table.remove(lines)
				end

				vim.notify("✓ Claude completed with " .. #lines .. " lines", vim.log.levels.INFO)

				if #lines > 0 then
					if callback then
						callback(lines)
					else
						-- Insert at the captured position in the captured buffer
						vim.api.nvim_buf_set_lines(target_bufnr, target_row, target_row, false, lines)
					end
				else
					vim.notify("No output from Claude", vim.log.levels.WARN)
				end
			else
				-- Better error handling
				local error_msg = result.stderr or ""
				if error_msg:match("command not found") or error_msg:match("No such file") then
					vim.notify(
						"✗ Claude CLI not found. Please install: npm install -g @anthropic-ai/claude-cli",
						vim.log.levels.ERROR
					)
				elseif error_msg:match("API key") or error_msg:match("authentication") then
					vim.notify("✗ Claude API key issue. Check your authentication setup", vim.log.levels.ERROR)
				elseif error_msg ~= "" then
					vim.notify("✗ Claude error: " .. error_msg, vim.log.levels.ERROR)
				else
					vim.notify("✗ Claude failed with exit code: " .. result.code, vim.log.levels.ERROR)
				end
			end
		end)
	end)
end

return M