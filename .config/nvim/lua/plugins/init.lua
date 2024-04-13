return {
  {"numToStr/Comment.nvim", config = true},
  -- {"karb94/neoscroll.nvim", opts = {stop_eof = false}},
  -- {dir = "~/projects/neoscroll.nvim", opts = {}},
  {dir = "~/projects/neoscroll.nvim", opts = {stop_eof = true}},
  -- {dir = "~/projects/neoscroll.nvim", config = function()
  --   require('neoscroll').setup {}
  --   local t = {}
  --   t['zz']    = {'zz', {'250'}}
  --   require('neoscroll.config').set_mappings(t)
  -- end},
  {"lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {indent = {char = '┊'}}},
  {"norcalli/nvim-colorizer.lua", config = true},
  {"lewis6991/gitsigns.nvim", config = true},
  {"chaoren/vim-wordmotion", init=function ()
    vim.g.wordmotion_uppercase_spaces = {
      '(', ')', '[', ']' , '{', '}',
      '.', ',', ';', '"', "'",
      '+', '-', '*', '/', '=',
    }
  end},
  {"stevearc/oil.nvim", opts={}, dependencies={"nvim-tree/nvim-web-devicons"}},
  {"ggandor/flit.nvim", opts={labeled_modes = "nv"}, dependencies={"ggandor/leap.nvim"}},
  {"nvim-lua/plenary.nvim"},
  {"romainl/vim-cool"},
  {"https://git.sr.ht/~whynothugo/lsp_lines.nvim"},
  { "folke/trouble.nvim", dependencies = { "nvim-tree/nvim-web-devicons" }, opts = {}},
}
