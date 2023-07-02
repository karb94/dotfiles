return {
  "sbdchd/neoformat",
  cmd = "Neoformat",
  config = function()
    vim.g.shfmt_opt = '-ci -i 2'
  end,
}
