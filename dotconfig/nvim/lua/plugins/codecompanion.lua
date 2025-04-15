return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "MeanderingProgrammer/render-markdown.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionActions" },
  opts = {
    strategies = {
      chat = {
        adapter = "openai",
        slash_commands = {
          opts = {
            provider = "snacks",
          },
          buffer = {
            opts = {
              provider = "snacks",
            },
          },
          file = {
            opts = {
              provider = "snacks",
            },
          },
        },
      },
      inline = {
        adapter = "openai",
      },
    },
    display = {
      diff = {
        enabled = false
      }
    },
    adapters = {
      opts = {
        show_defaults = false,
        extended_output = false,
        extended_thinking = false,
      },
      openai = function()
        return require("codecompanion.adapters").extend("openai", {
          env = {
            api_key = "cmd:op read op://Private/OpenAI/code-companion --no-newline",
          },
          schema = {
            model = {
              default = "gpt-4.1-mini-2025-04-14",
            },
            max_tokens = {
              default = 8192,
              -- default = 18000,
            },
            extended_output = {
              default = false,
            },
            extended_thinking = {
              default = false,
            },
          },
        })
      end,
      anthropic = function()
        return require("codecompanion.adapters").extend("anthropic", {
          env = {
            api_key = "cmd:op read op://Private/Anthropic/credential --no-newline",
          },
          schema = {
            -- model = {
            -- 	default = "claude-3-5-sonnet-20241022",
            -- },
            max_tokens = {
              -- default = 8192,
              default = 18000,
            },
            extended_output = {
              default = false,
            },
            extended_thinking = {
              default = false,
            },
          },
        })
      end,
      gemini = function()
        return require("codecompanion.adapters").extend("gemini", {
          env = {
            api_key = "cmd:op read op://Private/Gemini/credential --no-newline",
          },
          schema = {
            model = {
              default = "gemini-2.5-pro-exp-03-25",
            },
            extended_output = {
              default = false,
            },
            extended_thinking = {
              default = false,
            },
          },
        })
      end,
    },
  },
  config = function(_, opts)
    require("mbriggs.notifier-codecompanion").setup()
    require("codecompanion").setup(opts)
  end,
  keys = {
    { "<leader>cc", "<cmd>CodeCompanionChat toggle<cr>", desc = "Code Chat", mode = { "v", "n" } },
    {
      "<C-a>",
      "<cmd>CodeCompanionActions<cr>",
      silent = true,
      desc = "Code Companion Actions",
      mode = { "v", "n" },
    },
  },
}
