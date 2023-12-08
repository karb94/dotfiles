return {
  "ellisonleao/gruvbox.nvim",
  priority=1000,
  opts = function()
    local palette = require("gruvbox").palette
    local dark0_hard_bg = {bg = palette.dark0_hard}
    return {
      inverse = false,
      contrast = "hard",
      overrides = {
        SignColumn = dark0_hard_bg,
        GruvboxGreenSign = dark0_hard_bg,
        GruvboxYellowSign = dark0_hard_bg,
        GruvboxBlueSign = dark0_hard_bg,
        GruvboxPurpleSign = dark0_hard_bg,
        GruvboxAquaSign = dark0_hard_bg,
        GruvboxOrangeSign = dark0_hard_bg,
        CursorLine = {bg = palette.dark0},
        CursorLineNr = {bg = palette.dark0_hard, bold = true}
      },
    }
  end,
  config = function(_, opts)
    require("gruvbox").setup(opts)
    vim.cmd([[colorscheme gruvbox]])
  end,
}
