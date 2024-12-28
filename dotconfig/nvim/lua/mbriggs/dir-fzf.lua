-- Function to open netrw/neo-tree in the selected directory
local function open_netrw(selected)
  -- Close the fzf window and open neo-tree at the selected directory
  local dir = selected[1]
  require("neo-tree.command").execute({
    position = "current",
    dir = vim.fn.getcwd() .. "/" .. dir,
  })
end

-- Custom function to search directories using fzf-lua
local function search_directories(opts)
  opts = opts or {}

  -- Configure the fzf-lua picker
  require("fzf-lua").fzf_exec(
  -- Command to list directories
    "fd --type d --hidden --exclude .git",
    {
      prompt = "Search Directories> ",
      actions = {
        ["default"] = function(selected)
          open_netrw(selected)
        end,
      },
      previewer = false,
      -- Additional fzf options
      fzf_opts = {
        ["--layout"] = "reverse",
        ["--info"] = "inline",
      },
    }
  )
end

-- Create a vim command to call the function
vim.api.nvim_create_user_command("DirectoryFzf", function()
  search_directories()
end, {})

return {
  search_directories = search_directories,
}
