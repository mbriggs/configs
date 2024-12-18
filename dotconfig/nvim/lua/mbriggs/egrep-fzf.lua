local fzf = require("fzf-lua")
local utils = require("fzf-lua.utils")

-- Built-in prefix handlers
local PREFIXES = {
	["#"] = { -- file extensions: #lua,md
		flag = "glob",
		cb = function(input)
			return string.format([[*.{%s}]], input)
		end,
	},
	[">"] = { -- folders: >src
		flag = "glob",
		cb = function(input)
			return string.format([[**/{%s}*/**]], input)
		end,
	},
	["&"] = { -- filenames: &test
		flag = "glob",
		cb = function(input)
			return string.format([[*{%s}*]], input)
		end,
	},
}

-- Parse prefixes from the input line
local function parse_prefixes(line, use_prefixes)
	if not use_prefixes then
		return line, {}
	end

	local args = {}
	local input = line

	for prefix, prefix_opts in pairs(PREFIXES) do
		local prefix_pattern = prefix .. "([^%s]+)"
		while true do
			local start, finish, capture = input:find(prefix_pattern)
			if not start then
				break
			end

			local flag_value = prefix_opts.cb and prefix_opts.cb(capture) or capture
			table.insert(args, string.format([[--%s=%s]], prefix_opts.flag, flag_value))

			-- Remove the matched prefix+value
			input = input:sub(1, start - 1) .. input:sub(finish + 1)
		end
	end

	return input, args
end

-- Process input line for special search modes
local function transform_search(search, state)
	if not search or search == "" then
		return search
	end

	local tokens = {}
	for token in search:gmatch("%S+") do
		table.insert(tokens, token)
	end

	if #tokens == 0 then
		return search
	end

	if state.use_permutations then
		local perms = {}
		for i = 1, #tokens do
			for j = i, #tokens do
				tokens[i], tokens[j] = tokens[j], tokens[i]
				table.insert(perms, table.concat(tokens, ".*"))
				tokens[i], tokens[j] = tokens[j], tokens[i]
			end
		end
		return "(" .. table.concat(perms, "|") .. ")"
	elseif state.use_and then
		return table.concat(tokens, ".*")
	else
		return search
	end
end

local function egrepify(opts)
	opts = opts or {}

	-- State for toggleable features
	local state = {
		use_prefixes = true,
		use_and = true,
		use_permutations = false,
	}

	-- Track last search for reloading
	local last_search = ""

	-- Setup grep options
	local grep_opts = vim.tbl_extend("force", {
		prompt = "Egrepify> ",
		fzf_opts = {
			["--history"] = vim.fn.stdpath("data") .. "/fzf-lua-egrepify-history",
		},
		no_esc = true, -- We're handling our own search transformations
		multiprocess = true,
		prompt_win = true,
		actions = {
			["ctrl-z"] = {
				function(_, _)
					state.use_prefixes = not state.use_prefixes
					utils.info(state.use_prefixes and "Prefixes enabled" or "Prefixes disabled")
				end,
				opts = { reload = true },
			},
			["ctrl-a"] = {
				function(_, _)
					state.use_and = not state.use_and
					utils.info(state.use_and and "AND enabled" or "AND disabled")
				end,
				opts = { reload = true },
			},
			["ctrl-r"] = {
				function(_, _)
					state.use_permutations = not state.use_permutations
					utils.info(state.use_permutations and "Permutations enabled" or "Permutations disabled")
				end,
				opts = { reload = true },
			},
		},
		fn_pre_fzf = function(_, _)
			-- Pass along the current search and state
			return last_search, state
		end,
		fn_transform = function(x)
			local search, prefix_args = parse_prefixes(x, state.use_prefixes)
			last_search = x

			if search and #search > 0 then
				return transform_search(search, state)
			else
				return search
			end
		end,
	}, opts)

	return fzf.live_grep(grep_opts)
end

return egrepify
