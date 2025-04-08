local bar = "│"
local arrow = ""

return {
  'echasnovski/mini.diff',
  version = '*',
  event = { 'BufReadPost', 'BufNewFile' },
  opts = {
    view = {
      signs = {
        add = bar,
        change = bar,
        delete = arrow,
      },
    }
  }
}
