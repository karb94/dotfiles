return {
  'Wansmer/treesj',
  keys = {
    {'<space>S', '<cmd>TSJSplit<CR>', desc = 'Split TS node into multiple lines'},
    {'<space>J', '<cmd>TSJJoin<CR>', desc = 'Join TS node into a single line'},
  },
  dependencies = { 'nvim-treesitter/nvim-treesitter', branch = "main" },
  config = function()
    require('treesj').setup({
      use_default_keymaps = false,
    })
  end,
}
