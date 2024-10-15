-- set up custom keymaps
require("mbriggs.keymaps")

-- load vim settings
require("mbriggs.set")

-- set up filetypes for certain extensions
require("mbriggs.ft")

-- set up qf maps
require("mbriggs.quickfix")

-- load and configure third party plugins
require("mbriggs.plugins")

-- statusline
require("mbriggs.statusline").setup()
