-- set up custom keymaps
require("mbriggs.keymaps")

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

-- statusline
-- require("mbriggs.statusline").setup()
