local M = {}

-- Spinner animation frames
local SPINNER_FRAMES = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }

-- Create and manage a spinner notification
-- @param message string The message to display with the spinner
-- @return table Object with stop() method to stop the spinner
function M.create(message)
	local spinner_idx = 1
	local notif_id = nil
	local timer = vim.uv.new_timer()
	local notify = require("mini.notify")

	local function update()
		local spinner = SPINNER_FRAMES[spinner_idx]
		spinner_idx = (spinner_idx % #SPINNER_FRAMES) + 1
		local msg = spinner .. " " .. message

		if notif_id then
			notify.update(notif_id, { msg = msg })
		else
			notif_id = notify.add(msg, "INFO", "DiagnosticInfo")
		end
		notify.refresh()
	end

	-- Start the spinner
	update()
	timer:start(100, 100, vim.schedule_wrap(update))

	return {
		stop = function()
			timer:stop()
			timer:close()
			if notif_id then
				notify.remove(notif_id)
			end
		end,
	}
end

return M