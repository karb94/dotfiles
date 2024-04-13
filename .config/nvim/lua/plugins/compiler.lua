return { -- This plugin
  "Zeioth/compiler.nvim",
  cmd = {"CompilerOpen", "CompilerToggleResults", "CompilerRedo"},
  dependencies = {
    "stevearc/overseer.nvim",
    commit = "400e762648b70397d0d315e5acaf0ff3597f2d8b",
    cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
    opts = {
      task_list = {
        direction = "bottom",
        min_height = 25,
        max_height = 25,
        default_detail = 1
      },
    },
  },
  opts = {},
  keys = {
    { "<leader>co", "<cmd>CompilerOpen<CR>", desc = "CompilerOpen"},
    { "<leader>cc", "<cmd>CompilerRedo<CR>", desc = "CompilerRedo"},
  },
}
