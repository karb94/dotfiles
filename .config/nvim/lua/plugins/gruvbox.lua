--vim.g.gruvbox_contrast_dark = 'hard'
--vim.g.gruvbox_contrast_light = 'soft'
--vim.g.gruvbox_sign_column = 'bg0'
--vim.cmd('colorscheme gruvbox')

return {
  "ellisonleao/gruvbox.nvim",
  priority=1000,
  opts = function()
    local colors = require("gruvbox.palette").colors
    local dark0_hard_bg = {bg = colors.dark0_hard}
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
        CursorLine = {bg = colors.dark0},
        CursorLineNr = {bg = colors.dark0_hard, bold = true}
      },
    }
  end,
  config = function(_, opts)
    require("gruvbox").setup(opts)
    vim.cmd([[colorscheme gruvbox]])
  end,
}
