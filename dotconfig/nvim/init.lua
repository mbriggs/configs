require("mbriggs.keymaps")
require("mbriggs.plugins")

_G.dd = function(...)
  Snacks.debug.inspect(...)
end
_G.bt = function()
  Snacks.debug.backtrace()
end
vim.print = _G.dd

require("mbriggs.term")
require("mbriggs.netrw")
require("mbriggs.tabs")
require("mbriggs.set")
require("mbriggs.ft")
require("mbriggs.quickfix")
if vim.g.neovide then
  require("mbriggs.neovide")
end
