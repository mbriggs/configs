local function create_file_or_dir()
  vim.ui.input({ prompt = 'New File (or dir): ' }, function(name)
    if name == '' then return end

    -- Get current directory from netrw
    local current_dir = vim.b.netrw_curdir
    local full_path = vim.fn.fnamemodify(current_dir .. '/' .. name, ':p')

    if name:sub(-1) == '/' then
      -- Remove trailing slash and create directory
      full_path = full_path:sub(1, -2)
      vim.fn.mkdir(full_path, 'p')
    else
      -- Create file
      local file = io.open(full_path, 'w')
      if file then file:close() end
    end

    -- Refresh netrw
    vim.cmd('edit ' .. vim.fn.fnameescape(current_dir))
  end)
end

local current_target_match = nil
local function toggle_target()
  -- Clear existing target highlight
  if current_target_match then
    vim.fn.matchdelete(current_target_match)
    current_target_match = nil
  end

  -- Get current line
  local target = vim.fn.getline('.')

  -- Toggle if clicking same line, otherwise set new target
  if not vim.b.last_target or vim.b.last_target ~= target then
    vim.cmd('normal! mt') -- Set netrw target
    vim.cmd([[highlight NetrwTarget guibg=#2d2a2e guifg=#e0af68]])
    current_target_match = vim.fn.matchadd('NetrwTarget', target)
    vim.b.last_target = target
  else
    vim.cmd('normal! mT') -- Clear netrw target (capital T clears the target)
    vim.b.last_target = nil
  end
end

-- Keybindings

local map = vim.keymap.set

map('n', '-', ':Explore<CR>', {
  noremap = true, silent = true, desc = 'Explore current dir'
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'netrw',
  callback = function()
    local opts = { buffer = true, silent = true, remap = true }
    map('n', '<Tab>', 'mf', opts)                            -- Toggle mark on file
    map('n', '<S-Tab>', 'mF', opts)                          -- Unmark all files
    -- map('n', '-', '-^', opts)                   -- Go up directory
    map('n', '%', create_file_or_dir, { buffer = true })     -- Create file/dir
    map('n', '<D-f>', create_file_or_dir, { buffer = true }) -- Create file/dir
    map('n', 'd', 'D', opts)                                 -- Delete file/directory
    map('n', 'r', 'R', opts)                                 -- Rename file/directory
    map('n', 'c', 'mc', opts)                                -- Copy marked files
    map('n', 'm', 'mm', opts)                                -- Move marked files
    map('n', '=', 'mt`', opts)                               -- Set mark target
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
