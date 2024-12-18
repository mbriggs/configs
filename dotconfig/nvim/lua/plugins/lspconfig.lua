local map = require("map")
return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "folke/snacks.nvim",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    { "Bilal2453/luvit-meta", lazy = true },
  },
  event = { "BufReadPost", "BufNewFile" },
  cmd = { "LspInfo", "LspInstall", "LspUninstall", "Mason" },

  config = function()
    vim.filetype.add({ extension = { templ = "templ" } })
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls",
        "ts_ls",
        "gopls",
        "golangci_lint_ls",
        "templ",
        "html",
        "htmx",
        "tailwindcss",
      },
      handlers = {
        function(server_name) -- default handler (optional)
          require("lspconfig")[server_name].setup({
          })
        end,

        ["lua_ls"] = function()
          local lspconfig = require("lspconfig")
          lspconfig.lua_ls.setup({
            settings = {
              Lua = {
                diagnostics = {
                  globals = { "vim", "it", "describe", "before_each", "after_each" },
                },
              },
            },
          })
        end,

        -- required for templ
        ["html"] = function()
          local lspconfig = require("lspconfig")
          lspconfig.html.setup({
            filetypes = { "html", "templ" },
          })
        end,

        ["htmx"] = function()
          local lspconfig = require("lspconfig")
          lspconfig.html.setup({
            filetypes = { "html", "templ" },
          })
        end,

        ["tailwindcss"] = function()
          local lspconfig = require("lspconfig")
          lspconfig.html.setup({
            filetypes = { "templ", "astro", "javascript", "typescript", "react" },
            init_options = { userLanguages = { templ = "html" } },
          })
        end,
      },
    })

    vim.diagnostic.config({
      underline = true,
      update_in_insert = false,
      float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "if_many",
        header = "",
        prefix = "",
      },
      signs = {
        [vim.diagnostic.severity.ERROR] = " ",
        [vim.diagnostic.severity.WARN] = " ",
        [vim.diagnostic.severity.HINT] = " ",
        [vim.diagnostic.severity.INFO] = " ",
      },
      virtual_text = {
        spacing = 4,
        source = "if_many",
        prefix = " ●",
      },
    })

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }
        local desc = map.desc(opts)

        vim.keymap.set("n", "gD", vim.lsp.buf.type_definition, desc("Go to type definition"))
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, desc("Go to definition"))
        vim.keymap.set("n", "<leader>.", vim.lsp.buf.definition, desc("Go to definition"))

        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

        vim.keymap.set("n", "<leader>cD", vim.lsp.buf.type_definition, desc("Go to type definition"))
        vim.keymap.set("n", "<leader>cd", vim.lsp.buf.definition, desc("Go to definition"))
        vim.keymap.set("n", "<leader>ci", vim.lsp.buf.implementation, desc("Go to implementation"))
        vim.keymap.set("n", "<leader>cn", vim.lsp.buf.rename, desc("Rename symbol"))
        vim.keymap.set("n", "<leader>cr", vim.lsp.buf.references, desc("Go to references"))
      end,
    })

    -- lsp notification with snacks notifier
    local progress = vim.defaulttable()
    vim.api.nvim_create_autocmd("LspProgress", {
      callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        local value = ev.data.params
        .value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
        if not client or type(value) ~= "table" then
          return
        end
        local p = progress[client.id]

        for i = 1, #p + 1 do
          if i == #p + 1 or p[i].token == ev.data.params.token then
            p[i] = {
              token = ev.data.params.token,
              msg = ("[%3d%%] %s%s"):format(
                value.kind == "end" and 100 or value.percentage or 100,
                value.title or "",
                value.message and (" **%s**"):format(value.message) or ""
              ),
              done = value.kind == "end",
            }
            break
          end
        end

        local msg = {} ---@type string[]
        progress[client.id] = vim.tbl_filter(function(v)
          return table.insert(msg, v.msg) or not v.done
        end, p)

        local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
        vim.notify(table.concat(msg, "\n"), "info", {
          id = "lsp_progress",
          title = client.name,
          opts = function(notif)
            notif.icon = #progress[client.id] == 0 and " "
                or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
          end,
        })
      end,
    })
  end,
  keys = {
    { "<leader>m", "<cmd>Mason<cr>", desc = "Mason" },
  },
}
