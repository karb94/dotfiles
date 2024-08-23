return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    textobjects = {
      select = {
        enable = true,
        keymaps = {
          ["aa"] = "@parameter.outer",
          ["ia"] = "@parameter.inner",
        }
      }
    },
  },
  config = function(_, opts) require("nvim-treesitter.configs").setup(opts) end,
}
