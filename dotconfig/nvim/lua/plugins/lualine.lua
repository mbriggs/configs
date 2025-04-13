return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = {
    options = {
      theme = "auto",
      globalstatus = false,
      component_separators = { left = ' ', right = ' ' },
      section_separators = { left = '', right = '' },
      disabled_filetypes = { statusline = { "dashboard", "alpha" } },
    },
    sections = {
      lualine_a = {},
      lualine_b = {
      },
      lualine_c = {
        {
          'filename',
          path = 1,
          separator = "",
          padding = { right = 0, left = 2 },
          fmt = function(str)
            if vim.fn.bufname() == "" then
              return ""
            end
            -- Split the path by directory separator and remove the first component
            local parts = vim.split(str, '/')
            table.remove(parts, #parts)
            -- Join the remaining parts back together
            return table.concat(parts, '/') .. "/"
          end,
          color = function()
            return {
              fg = '#7a88cf',
              bg = '#222436',
            }
          end
        },
        {
          'filename',
          path = 0,
          padding = { left = 0 },
          symbols = {
            modified = '[+]',
            readonly = '[-]',
            unnamed = '[No Name]',
          },
          color = function()
            if vim.fn.bufname() == "" then
              return {
                fg = '#7a88cf',
                bg = '#222436',
              }
            end

            return {
              fg = '#e0af68',
              bg = '#222436',
              gui = 'bold',
            }
          end
        },
      },
      lualine_x = {
        {
          "diagnostics",
          symbols = {
            error = " ",
            warn = " ",
            info = " ",
            hint = " ",
          },
        },
        { "filetype", icon_only = true, separator = "", padding = { left = 2, right = 0 } },
        {
          -- Lsp server name .
          function()
            local msg = ''
            local buf_ft = vim.api.nvim_get_option_value('filetype', { buf = 0 })
            local clients = vim.lsp.get_clients()
            if next(clients) == nil then
              return msg
            end
            for _, client in ipairs(clients) do
              local filetypes = client.config.filetypes
              if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                return client.name
              end
            end
            return msg
          end,
          padding = { left = 0, right = 3 }
        },
        { "location" }
      },
      lualine_y = {},
      lualine_z = {},
    },
    extensions = { "aerial", "mason", "quickfix", "trouble", "neo-tree", "lazy", "fzf" },
  },
}
