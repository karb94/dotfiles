return {
  "sbdchd/neoformat",
  cmd = "Neoformat",
  config = function()
    vim.g.shfmt_opt = '-ci -i 2'
  end,
  keys = {
    { "<leader><leader>f", "<cmd>Neoformat<cr>", desc = "NeoTree", mode= {'n'}},
    { "<leader><leader>f", ":Neoformat<cr>", desc = "NeoTree", mode= {'x'}},
  }
}
