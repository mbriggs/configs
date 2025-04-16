local function create_file_or_dir()
  vim.ui.input({ prompt = "New File (or dir): " }, function(name)
    if name == "" then
      return
    end

    -- Get current directory from netrw
    local current_dir = vim.b.netrw_curdir
    local full_path = vim.fn.fnamemodify(current_dir .. "/" .. name, ":p")

    if name:sub(-1) == "/" then
      -- Remove trailing slash and create directory
      full_path = full_path:sub(1, -2)
      vim.fn.mkdir(full_path, "p")
    else
      -- Create parent directories if they don't exist
      local parent_dir = vim.fn.fnamemodify(full_path, ":h")
      vim.fn.mkdir(parent_dir, "p")

      -- Create file
      local file = io.open(full_path, "w")
      if file then
        file:close()
      end
    end

    -- Refresh netrw
    vim.cmd("edit " .. vim.fn.fnameescape(current_dir))
  end)
end

-- Store target highlight matches per buffer
local target_matches = {}

local function toggle_target()
  local bufnr = vim.api.nvim_get_current_buf()

  -- Clear existing target highlight for this buffer
  if target_matches[bufnr] then
    pcall(vim.fn.matchdelete, target_matches[bufnr])
    target_matches[bufnr] = nil
    vim.cmd("normal mT") -- Clear netrw target
    return
  end

  -- Get current line content and number
  local line = vim.fn.getline(".")
  local linenr = vim.fn.line(".")

  -- Only highlight the filename part, not the whole line
  local filename = vim.fn.getline("."):match("[%w%p ]+$")
  if not filename then
    return
  end

  -- Set netrw target mark using netrw's command
  vim.cmd("normal mt")

  -- Create highlight group if it doesn't exist
  vim.cmd([[highlight default NetrwTarget guibg=#2d2a2e guifg=#e0af68 gui=bold]])

  -- Add highlight for the current line
  target_matches[bufnr] = vim.fn.matchadd("NetrwTarget", "\\%" .. linenr .. "l" .. vim.fn.escape(filename, ".[]*"))
end

-- Clean up highlights when leaving netrw buffer
vim.api.nvim_create_autocmd("BufLeave", {
  pattern = "*",
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    if target_matches[bufnr] then
      pcall(vim.fn.matchdelete, target_matches[bufnr])
      target_matches[bufnr] = nil
    end
  end,
})

-- Keybindings

local map = vim.keymap.set

map("n", "-", ":Explore<CR>", {
  noremap = true,
  silent = true,
  desc = "Explore current dir",
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "netrw",
  callback = function()
    local opts = { buffer = true, silent = true, remap = true }
    map("n", "<Tab>", "mf", opts)                            -- Toggle mark on file
    map("n", "<S-Tab>", "mF", opts)                          -- Unmark all files
    -- map('n', '-', '-^', opts)                   -- Go up directory
    map("n", "%", create_file_or_dir, { buffer = true })     -- Create file/dir
    map("n", "<D-f>", create_file_or_dir, { buffer = true }) -- Create file/dir
    map("n", "d", "D", opts)                                 -- Delete file/directory
    map("n", "r", "R", opts)                                 -- Rename file/directory
    map("n", "=", toggle_target, opts)                       -- Toggle visual mark target
  end,
})

-- hide header
vim.g.netrw_banner = 0

-- Show directories first (sorting)
vim.g.netrw_sort_sequence = [[[\/]$,*]]

-- start hidden
vim.g.netrw_list_hide = [[^\..*]]

-- Human-readable files sizes
vim.g.netrw_sizestyle = "H"

-- Setup file operations commands (enable recursive copy and remove)
vim.g.netrw_localcopydircmd = "cp -r"
vim.g.netrw_localmkdir = "mkdir -p"
vim.g.netrw_localrmdir = "rm -r"

-- split to the right instead of the left
vim.g.netrw_altv = 1

-- Highlight marked files in the same way search matches are
vim.cmd("hi! link netrwMarkFile Search")
