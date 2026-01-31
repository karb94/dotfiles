-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1
return {
  "stevearc/oil.nvim",
  opts={
    columns = {
      "icon",
      -- "permissions",
      -- "size",
      -- "mtime",
    },
    skip_confirm_for_simple_edits = true,
    constrain_cursor = "name",
  },
  keys = {
    {"-", "<CMD>Oil<CR>", { desc = "Open parent directory" }},
  },
  dependencies={"nvim-tree/nvim-web-devicons"},
  lazy = false,
}
