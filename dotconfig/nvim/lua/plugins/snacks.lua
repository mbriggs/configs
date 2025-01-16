return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = function()
    return {
      bigfile = {
        enabled = true,
      },
      dashboard = {
        enabled = true,
        sections = { { section = "header" }, { section = "startup", gap = 1, padding = 1 } },
      },
      input = { enabled = true },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      picker = {
        ui_select = true,
        sources = {
          aerial = require("mbriggs.picker-aerial"),
          directory = require("mbriggs.picker-directory")
        },
        win = {
          input = {
            keys = {
              ["<Esc>"] = { "close", mode = { "n", "i" } }
            }
          }
        }
      }
    }
  end,
  keys = {
    --- Picker
    { "<leader>,",     function() Snacks.picker.buffers() end,                                                desc = "Buffers" },
    { "<leader>/",     function() Snacks.picker.grep() end,                                                   desc = "Grep" },
    { "<leader>:",     function() Snacks.picker.command_history() end,                                        desc = "Command History" },
    { "<leader>;",     function() Snacks.picker.files() end,                                                  desc = "Find Files" },
    { "<leader><tab>", function() Snacks.picker.resume() end,                                                 desc = "Resume Last Pick" },
    { "<leader>=",     function() Snacks.picker.pick("aerial") end,                                           desc = "Find Symbols (Aerial)" },

    -- find
    { "<leader>fn",    function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end,                desc = "Find Config File" },
    { "<leader>fj",    function() Snacks.picker.jumps() end,                                                  desc = "Jumps" },
    { "<leader>fd",    function() Snacks.picker.pick("directory") end,                                        desc = "Directory" },
    { "<leader>fc",    function() Snacks.picker.command_history() end,                                        desc = "Command History" },
    { "<leader>fC",    function() Snacks.picker.commands() end,                                               desc = "Commands" },
    { '<leader>f"',    function() Snacks.picker.registers() end,                                              desc = "Registers" },
    { "<leader>fh",    function() Snacks.picker.help() end,                                                   desc = "Help Pages" },
    { "<leader>fk",    function() Snacks.picker.keymaps() end,                                                desc = "Keymaps" },
    { "<leader>fp",    function() Snacks.picker.projects() end,                                               desc = "Projects" },

    -- search
    { "<leader>sb",    function() Snacks.picker.lines() end,                                                  desc = "Buffer Lines" },
    { "<leader>ss",    function() Snacks.picker.grep_buffers() end,                                           desc = "Grep Open Buffers" },
    { "<leader>sw",    function() Snacks.picker.grep_word() end,                                              desc = "Visual selection or word", mode = { "n", "x" } },
    { "<leader>sq",    function() Snacks.picker.qflist() end,                                                 desc = "Quickfix List" },

    -- diagnostics
    { "<leader>x;",    function() Snacks.picker.diagnostics() end,                                            desc = "Diagnostics" },
    { "<leader>xst",   function() Snacks.picker.todo_comments() end,                                          desc = "Search Todo" },
    { "<leader>xsT",   function() Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } }) end, desc = "Search Todo/Fix/Fixme" },

    --- End Picker
    {
      "<leader>gb",
      [[<cmd>lua Snacks.git.blame_line()<cr>]],
      desc = "Blame",
    },
    {
      "<leader>gb",
      [[<cmd>lua Snacks.git.blame_line()<cr>]],
      desc = "Blame",
    },
    {
      "<leader>gg",
      [[<cmd>lua Snacks.lazygit.open()<cr>]],
      desc = "LazyGit",
    },
    {
      "<leader>gl",
      [[<cmd>lua Snacks.lazygit.log()<cr>]],
      desc = "Git Log",
    },
    {
      "<leader>gf",
      [[<cmd>lua Snacks.lazygit.log_file()<cr>]],
      desc = "Git Log (file)",
    },
    {
      "<leader>H",
      [[<cmd>lua Snacks.notifier.show_history()<cr>]],
      desc = "Notifier History",
    },
    {
      "<leader>k",
      [[<cmd>lua Snacks.scratch()<cr>]],
      desc = "Toggle Scratch Buffer",
    },
    {
      "<leader>K",
      [[<cmd>lua Snacks.scratch.select()<cr>]],
      desc = "Select Scratch Buffer",
    },
    {
      "<leader>Z",
      [[<cmd>lua Snacks.zen()<cr>]],
      desc = "Zen Mode",
    },
  },
}
