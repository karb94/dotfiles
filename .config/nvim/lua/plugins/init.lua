return {
  {"numToStr/Comment.nvim", config = true},
  -- {"karb94/neoscroll.nvim", opts = {stop_eof = false}},
  -- {dir = "~/projects/neoscroll.nvim", opts = {}},
  {dir = "~/projects/neoscroll.nvim", opts = {stop_eof = true}},
  -- {dir = "~/projects/neoscroll.nvim", opts = {stop_eof = false}},
  {"lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {indent = {char = '┊'}}},
  {"norcalli/nvim-colorizer.lua", config = true},
  {"lewis6991/gitsigns.nvim", config = true},
  {"chaoren/vim-wordmotion", init=function ()
    vim.g.wordmotion_uppercase_spaces = {
      '(', ')', '[', ']' , '{', '}',
      '.', '-', ',', '/', '"', "'"
    }
  end},
  {"stevearc/oil.nvim", opts={}, dependencies={"nvim-tree/nvim-web-devicons"}},
  {"ggandor/flit.nvim", opts={}},
  {"nvim-lua/plenary.nvim"},
}
