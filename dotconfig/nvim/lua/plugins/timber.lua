return {
  "Goose97/timber.nvim",
  version = "*",
  event = "VeryLazy",
  opts = {
    keymaps = {
      insert_log_below = "<leader>lj",
      insert_log_above = "<leader>lk",
      insert_plain_log_below = "<leader>lo",
      insert_plain_log_above = "<leader>l<S-o>",
      insert_batch_log = "<leader>lb",
      add_log_targets_to_batch = "<leader>la",
      insert_log_below_operator = "<leader><S-l>j",
      insert_log_above_operator = "<leader><S-l>k",
      insert_batch_log_operator = "<leader><S-l>b",
      add_log_targets_to_batch_operator = "<leader><S-l>a",
    }
  },
  config = true
}
