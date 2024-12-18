local M = {}

-- Helper function to find the root of the Rails project
local function find_rails_root()
	local current_dir = vim.fn.getcwd()
	while current_dir ~= "/" do
		if vim.fn.filereadable(current_dir .. "/Gemfile") == 1 and vim.fn.isdirectory(current_dir .. "/app") == 1 then
			return current_dir
		end
		current_dir = vim.fn.fnamemodify(current_dir, ":h")
	end
	return nil
end

-- Helper function to create a finder
local function create_finder(prompt_title, directory)
	local rails_root = find_rails_root()
	if not rails_root then
		print("Not in a Rails project")
		return
	end

	require("fzf-lua").files({
		prompt = prompt_title .. "❯ ",
		cwd = rails_root .. directory,
		cmd = "fd --type f --hidden --follow --exclude .git",
	})
end

-- Custom finders for various Rails components
function M.find_models()
	create_finder("Rails Models", "/app/models")
end
function M.find_controllers()
	create_finder("Rails Controllers", "/app/controllers")
end
function M.find_views()
	create_finder("Rails Views", "/app/views")
end
function M.find_helpers()
	create_finder("Rails Helpers", "/app/helpers")
end
function M.find_mailers()
	create_finder("Rails Mailers", "/app/mailers")
end
function M.find_jobs()
	create_finder("Rails Jobs", "/app/jobs")
end
function M.find_lib()
	create_finder("Rails Lib", "/lib")
end
function M.find_tests()
	create_finder("Rails Tests", "/test")
end
function M.find_specs()
	create_finder("Rails Specs", "/spec")
end

-- Helper functions
local function get_singular_and_plural(word)
	local singular = word:gsub("s$", "")
	local plural = singular .. "s"
	return { singular, plural }
end

local function capitalize(str)
	return (str:gsub("^%l", string.upper):gsub(":%l", string.upper))
end

local function singularize(word)
	return word:gsub("s$", "")
end

local function is_view_file(file_parts)
	return file_parts[2] == "views"
end

-- context-aware finder
function M.find_related()
	local rails_root = find_rails_root()
	if not rails_root then
		print("Not in a Rails project")
		return
	end

	local current_file = vim.fn.expand("%:p")
	local relative_path = vim.fn.fnamemodify(current_file, ":~:.")
	local file_parts = vim.split(relative_path, "/")
	local file_name = file_parts[#file_parts]:gsub("%.rb$", "")

	-- Extract module name and base name
	local module_parts = {}
	local base_name = file_name

	if is_view_file(file_parts) then
		if #file_parts > 3 then
			local view_parts = vim.list_slice(file_parts, 3, #file_parts - 1)
			if #view_parts > 1 then
				module_parts = vim.list_slice(view_parts, 1, #view_parts - 1)
				base_name = view_parts[#view_parts]
			else
				base_name = view_parts[1]
			end
		end
	else
		if #file_parts > 3 then
			module_parts = vim.list_slice(file_parts, 3, #file_parts - 1)
			base_name = file_name:gsub("_controller$", ""):gsub("_helper$", ""):gsub("_mailer$", "")
		end
	end

	local module_name = table.concat(module_parts, "::")
	local full_name = module_name ~= "" and (module_name .. "::" .. base_name) or base_name
	local display_full_name = capitalize(singularize(full_name))
	local normalized_name = full_name:lower():gsub("::", "/")

	local search_patterns = {}
	for _, name in ipairs(get_singular_and_plural(normalized_name)) do
		table.insert(search_patterns, "app/models/" .. name .. ".rb")
		table.insert(search_patterns, "app/controllers/" .. name .. "_controller.rb")
		table.insert(search_patterns, "app/helpers/" .. name .. "_helper.rb")
		table.insert(search_patterns, "app/mailers/" .. name .. "_mailer.rb")
		table.insert(search_patterns, "app/jobs/" .. name .. "_job.rb")
		table.insert(search_patterns, "app/views/" .. name .. "/*")
		table.insert(search_patterns, "test/models/" .. name .. "_test.rb")
		table.insert(search_patterns, "test/controllers/" .. name .. "_controller_test.rb")
		table.insert(search_patterns, "test/helpers/" .. name .. "_helper_test.rb")
		table.insert(search_patterns, "test/mailers/" .. name .. "_mailer_test.rb")
		table.insert(search_patterns, "test/jobs/" .. name .. "_job_test.rb")
		table.insert(search_patterns, "spec/models/" .. name .. "_spec.rb")
		table.insert(search_patterns, "spec/controllers/" .. name .. "_controller_spec.rb")
		table.insert(search_patterns, "spec/helpers/" .. name .. "_helper_spec.rb")
		table.insert(search_patterns, "spec/mailers/" .. name .. "_mailer_spec.rb")
		table.insert(search_patterns, "spec/jobs/" .. name .. "_job_spec.rb")
	end

	-- Build rg command for fzf
	local rg_command = table.concat({
		"rg --files",
		table.concat(
			vim.tbl_map(function(pattern)
				return "--glob '" .. pattern .. "'"
			end, search_patterns),
			" "
		),
	}, " ")

	require("fzf-lua").files({
		prompt = "Related Files for " .. display_full_name .. "❯ ",
		cwd = rails_root,
		cmd = rg_command,
		actions = {
			["default"] = function(selected, opts)
				if selected[1] ~= current_file then
					vim.cmd("edit " .. selected[1])
				end
			end,
		},
	})
end

-- Check if current project is a Rails project
function M.is_rails_project()
	return find_rails_root() ~= nil
end

return M
