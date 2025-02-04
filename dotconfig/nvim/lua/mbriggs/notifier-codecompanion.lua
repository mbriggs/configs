local M = {}

-- Simple spinner frames:
local spinner_frames = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }

-- Store active request states:
--   M.active[id] = {
--       msg = string,         -- short status text (like "In progress...")
--       done = boolean,       -- whether request is finished
--       strategy = string,    -- codecompanion strategy
--       adapter = string,     -- codecompanion adapter name
--   }
M.active = {}

------------------------------------------------------------------------------
-- We'll use a single function to "refresh" the spinner notification
-- for *all* active requests. This is called periodically on a timer.
------------------------------------------------------------------------------
local function refresh_notifications()
	-- If there are no active requests, we can skip.
	if vim.tbl_isempty(M.active) then
		return
	end

	-- Build lines for each active request
	local lines = {}
	for id, entry in pairs(M.active) do
		table.insert(lines, string.format("%-16s %s", id, entry.msg))
	end

	-- Calculate spinner frame
	local frame_idx = math.floor(vim.loop.hrtime() / (1e6 * 80)) % #spinner_frames + 1
	local icon = spinner_frames[frame_idx]

	-- Show them all in a single notification, or do them individually if you prefer.
	-- We'll do one single aggregated notification here for simplicity.
	vim.notify(table.concat(lines, "\n"), "info", {
		-- We'll use the same ID for all requests, so we have *one*
		-- spinner notification that updates. If you prefer separate
		-- notifications, use unique IDs (like "cc_progress_" .. id).
		id = "cc_progress",
		title = "CodeCompanion",
		opts = function(notif)
			notif.icon = icon
		end,
	})
end

------------------------------------------------------------------------------
-- Timer to keep the spinner "spinning" in the background
------------------------------------------------------------------------------
M.timer = nil

-- Start the timer if it’s not already running
local function ensure_timer_running()
	if M.timer then
		return
	end
	M.timer = vim.loop.new_timer()
	M.timer:start(
		0,
		150, -- update every 150 ms
		vim.schedule_wrap(refresh_notifications)
	)
end

-- Stop the timer if no active requests remain
local function maybe_stop_timer()
	if M.timer and vim.tbl_isempty(M.active) then
		M.timer:stop()
		M.timer:close()
		M.timer = nil
	end
end

------------------------------------------------------------------------------
-- Utility: build a stable ID from CodeCompanion data (adapter + request ID)
------------------------------------------------------------------------------
local function request_key(data)
	-- Example: "openai-GPT-1" plus the request's ID
	local adapter = data.adapter or {}
	local name = adapter.formatted_name or adapter.name or "UnknownAdapter"
	return (name .. ":" .. (data.id or "??"))
end

------------------------------------------------------------------------------
-- Autocmd Setup
------------------------------------------------------------------------------
function M.setup()
	local group = vim.api.nvim_create_augroup("CodeCompanionSnacks", { clear = true })

	----------------------------------------------------------------------------
	-- On CodeCompanionRequestStarted:
	----------------------------------------------------------------------------
	vim.api.nvim_create_autocmd("User", {
		pattern = "CodeCompanionRequestStarted",
		group = group,
		callback = function(ev)
			local data = ev.data or {}
			local key = request_key(data)

			M.active[key] = {
				msg = string.format("[   ] Starting (strategy: %s)", data.strategy or "N/A"),
				done = false,
				adapter = data.adapter and data.adapter.name or "???",
				strategy = data.strategy or "???",
			}

			-- Make sure the spinner is running
			ensure_timer_running()
			refresh_notifications()
		end,
	})

	----------------------------------------------------------------------------
	-- On CodeCompanionRequestFinished:
	----------------------------------------------------------------------------
	vim.api.nvim_create_autocmd("User", {
		pattern = "CodeCompanionRequestFinished",
		group = group,
		callback = function(ev)
			local data = ev.data or {}
			local key = request_key(data)
			local req = M.active[key]
			if not req then
				return
			end

			-- Mark as done and show a final message
			req.done = true

			if data.status == "success" then
				req.msg = "[100%] Completed"
			elseif data.status == "error" then
				req.msg = "[XXX] Error"
			else
				req.msg = "[ - ] Cancelled"
			end

			-- We'll do one more refresh so the user can see the final message
			refresh_notifications()

			-- Then remove it from the table
			M.active[key] = nil
			-- That might leave others still running, so only stop timer if empty
			maybe_stop_timer()
		end,
	})
end

return M
