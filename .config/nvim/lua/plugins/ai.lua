return {
  "olimorris/codecompanion.nvim",
  version = "^19.0.0",
  opts = {
    interactions = {
      chat = {
        adapter = {
          name = "opencode",
          -- model = "qwen3.6:35b-a3b-q4_K_M",
          model = "qwen3.6:35b-a3b-opt",
        },
      },
      inline = {
        adapter = {
          name = "opencode",
          -- model = "qwen3.6:35b-a3b-q4_K_M",
          model = "qwen3.6:35b-a3b-opt",
        },
      },
      -- background = {
      --   adapter = {
      --     name = "ollama",
      --     model = "qwen3.5:27b",
      --   },
      -- },
    }
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-treesitter/nvim-treesitter", branch = "main" },
  },
}
