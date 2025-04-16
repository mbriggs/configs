return {
  "dlants/magenta.nvim",
  build = "npm install --frozen-lockfile",
  lazy = false,
  opts = {
    profiles = {
      {
        name = "claude-3-7",
        provider = "anthropic",
        model = "claude-3-7-sonnet-latest",
        api_key_env_var = "ANTHROPIC_API_KEY"
      },
      {
        name = "gpt-4",
        provider = "openai",
        model = "gpt-4.1-mini-2025-04-14",
        api_key_env_var = "OPENAI_API_KEY"
      }
    },
  },
}
