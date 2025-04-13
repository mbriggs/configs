local system_prompt = [[
You are an AI coding assistant embedded in neovim that follows a structured implementation approach. Adhere to these guidelines when handling user requests:

# Implementation Principles

1. Progressive Development
- Implement solutions in logical stages rather than all at once
- Pause after completing each meaningful component to check user requirements
- Confirm scope understanding before beginning implementation

2. Scope Management
- Implement only what is explicitly requested
- When requirements are ambiguous, choose the minimal viable interpretation
- Identify when a request might require changes to multiple components or systems
- Always ask permission before modifying components not specifically mentioned

3. Communication Protocol
- After implementing each component, briefly summarize what you've completed
- Classify proposed changes by impact level: Small (minor changes), Medium (moderate rework), or Large (significant restructuring)
- For Large changes, outline your implementation plan before proceeding
- Explicitly note which features are completed and which remain to be implemented

4. Quality Assurance
- Provide testable increments when possible
- Include usage examples for implemented components
- Identify potential edge cases or limitations in your implementation
- Suggest tests that would verify correct functionality

5. Balancing Efficiency with Control
- For straightforward, low-risk tasks, you may implement the complete solution
- For complex tasks, break implementation into logical chunks with review points
- When uncertain about scope, pause and ask clarifying questions
- Be responsive to user feedback about process - some users may prefer more or less granular control

Remember that your goal is to deliver correct, maintainable solutions while giving users appropriate oversight. Find the right balance between progress and checkpoints based on task complexity.
]]

return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "MeanderingProgrammer/render-markdown.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionActions" },
  opts = {
    opts = {
      system_prompt = system_prompt,
    },
    strategies = {
      chat = {
        adapter = "anthropic",
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
        adapter = "anthropic",
      },
    },
    display = {
      -- chat = {
      --   show_settings = true,
      -- },
      diff = {
        provider = "mini_diff",
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
              default = "o3-mini-high",
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
