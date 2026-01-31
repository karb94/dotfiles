return {
  {"numToStr/Comment.nvim", config = true},
  -- {"karb94/neoscroll.nvim", opts = {stop_eof = false}},
  {"lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {indent = {char = '┊'}}},
  {"norcalli/nvim-colorizer.lua", config = true},
  {"lewis6991/gitsigns.nvim", config = true},
  {"chaoren/vim-wordmotion", init=function ()
    vim.g.wordmotion_uppercase_spaces = {
      '(', ')', '[', ']' , '{', '}',
      '.', ',', ';', ':', '"', "'",
      '+', '*', '/', '=',
    }
  end},
  {
    "ggandor/flit.nvim",
    opts={labeled_modes = "nv"},
    dependencies={url="https://codeberg.org/andyg/leap.nvim"},
  },
  {"nvim-lua/plenary.nvim", lazy = false},
  {"romainl/vim-cool"},
  { 'windwp/nvim-autopairs', event = "InsertEnter", config = true },
  { "j-hui/fidget.nvim", config = true },
  "gregorias/coop.nvim",
  "neovim/nvim-lspconfig",
}
