return {
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = {
    multi_window = false,
    label = {
      uppercase = false,
      -- after = false,
      -- before = true,
      -- style = 'inline',
      -- min_pattern_length = 0,
    },
    modes = {
      search = {
        enabled = true,
        backdrop = true,
      },
      char = {
        highlight = { backdrop = false },
        jump_labels = true,
      },
    },
    highlight = {
      groups = {
        label = 'IncSearch',
      }
    },
  },
  keys = {
    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  },
}
