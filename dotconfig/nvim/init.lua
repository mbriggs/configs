-- set up custom keymaps
require("mbriggs.keymaps")

-- configure term
require("mbriggs.term")

-- configure tabs
require("mbriggs.tabs")

-- load and configure third party plugins
require("mbriggs.plugins")

-- set up debugging tools
_G.dd = function(...)
  Snacks.debug.inspect(...)
end
_G.bt = function()
  Snacks.debug.backtrace()
end
vim.print = _G.dd

-- load vim settings
require("mbriggs.set")

-- set up filetypes for certain extensions
require("mbriggs.ft")

-- set up qf maps
require("mbriggs.quickfix")

if vim.g.neovide then
  require("mbriggs.neovide")
end

-- statusline
-- require("mbriggs.statusline").setup()
