return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "folke/snacks.nvim",
    "mason-org/mason.nvim",
    "mason-org/mason-lspconfig.nvim",
    { "Bilal2453/luvit-meta",    lazy = true },
    {
      "folke/lazydev.nvim",
      ft = "lua", -- only load on lua files
      opts = {
        library = {
          -- See the configuration section for more details
          -- Load luvit types when the `vim.uv` word is found
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
      },
    },
    {
      "dgagn/diagflow.nvim",
      event = { "BufReadPost", "BufNewFile" },
      opts = {
        text_align = "left",
        padding_right = 4,
        toggle_event = { "InsertEnter", "InsertLeave" },
        render_event = { "DiagnosticChanged", "CursorMoved" },
        scope = "line",
      },
    },
    { "saecki/live-rename.nvim", config = true },
  },
  event = { "BufReadPost", "BufNewFile" },
  cmd = { "LspInfo", "LspInstall", "LspUninstall", "Mason" },
  keys = {
    { "<leader>m", "<cmd>Mason<cr>", desc = "Mason" }
  },

  config = function()
    -- First set up mason
    require("mason").setup()

    -- Then set up mason-lspconfig with automatic enabling
    require("mason-lspconfig").setup {
      ensure_installed = {
        "lua_ls",
        "bashls",
        "gopls",
        "ruby_lsp",
        "golangci_lint_ls",
        "html",
        "cssls",
        "jsonls",
        "eslint",
        "cmake",
        "nginx_language_server",
        "sqlls",
        "dockerls",
        "tailwindcss",
        "templ",
        "ts_ls"
      },
      -- This will automatically enable all installed servers
      automatic_enable = true,
    }

    -- lsp notification with snacks notifier
    require("mbriggs.notifier-lspconfig").setup()

    vim.filetype.add({ extension = { templ = "templ" } })

    -- Instead of individually setting up each server,
    -- let's just configure the ones that need special settings
    local lspconfig = require("lspconfig")

    -- Configure lua_ls with custom settings
    lspconfig.lua_ls.setup({
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim", "it", "describe", "before_each", "after_each" },
          },
        },
      },
    })

    -- Configure tailwindcss with custom settings
    lspconfig.tailwindcss.setup({
      filetypes = { "templ", "astro", "javascript", "typescript", "react" },
      init_options = { userLanguages = { templ = "html" } },
    })

    vim.diagnostic.config({
      underline = true,
      update_in_insert = false,
      float = {
        focusable = false,
        style = "minimal",
        close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
        border = "rounded",
        source = true,
        header = "",
        prefix = "",
      },
      signs = {
        [vim.diagnostic.severity.ERROR] = " ",
        [vim.diagnostic.severity.WARN] = " ",
        [vim.diagnostic.severity.HINT] = " ",
        [vim.diagnostic.severity.INFO] = " ",
      },
      -- virtual_text = {
      -- 	spacing = 4,
      -- 	source = "if_many",
      -- 	prefix = " ●",
      -- },
    })

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        local map = require("map")

        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }
        local desc = map.desc(opts)

        local live_rename = require("live-rename")

        -- vim.keymap.set("n", "gd", vim.lsp.buf.definition, desc("Go to definition"))
        -- vim.keymap.set("n", "<leader>ci", vim.lsp.buf.implementation, desc("Go to implementation"))
        -- vim.keymap.set("n", "<leader>cn", vim.lsp.buf.rename, desc("Rename symbol"))
        -- vim.keymap.set("n", "<leader>cr", vim.lsp.buf.references, desc("Go to references"))

        vim.keymap.set("n", "gD", Snacks.picker.lsp_type_definitions, desc("Go to type definition"))
        vim.keymap.set("n", "gd", Snacks.picker.lsp_definitions, desc("Go to definition"))
        vim.keymap.set("n", "<leader>.", Snacks.picker.lsp_definitions, desc("Go to definition"))

        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

        vim.keymap.set("n", "<leader>cD", Snacks.picker.lsp_type_definitions, desc("Go to type definition"))
        vim.keymap.set("n", "<leader>cd", Snacks.picker.lsp_definitions, desc("Go to definition"))
        vim.keymap.set("n", "<leader>ci", Snacks.picker.lsp_implementations, desc("Go to implementation"))
        vim.keymap.set("n", "<leader>cn", live_rename.map(), desc("Rename symbol"))
        vim.keymap.set("n", "<leader>cN", live_rename.map({ text = "", insert = true }), desc("Rename symbol"))
        vim.keymap.set("n", "<leader>cr", Snacks.picker.lsp_references, desc("Go to references"))
      end,
    })
  end,
}
