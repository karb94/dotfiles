return {
  'RaafatTurki/corn.nvim',
  opts = {
    -- enables plugin auto commands
    auto_cmds = true,

    -- sorts diagnostics according to a criteria. must be one of `severity`, `severity_reverse`, `column`, `column_reverse`, `line_number` or `line_number_reverse`
    sort_method = 'severity',

    -- sets the scope to be searched for diagnostics, must be one of `line` or `file`
    scope = 'line',

    -- sets the style of the border, must be one of `single`, `double`, `rounded`, `solid`, `shadow` or `none`
    border_style = 'rounded',

    -- sets which vim modes corn isn't allowed to render in, should contain strings like 'n', 'i', 'v', 'V' .. etc
    blacklisted_modes = {},

    -- sets which severity corn isn't allowed to render in, should contain diagnostic severities like:
    -- vim.diagnostic.severity.HINT
    -- vim.diagnostic.severity.INFO
    -- vim.diagnostic.severity.WARN
    -- vim.diagnostic.severity.ERROR
    blacklisted_severities = {},

    -- Disable truncation
    -- set item_preprocess_func to return the item unmodified
    item_preprocess_func = function(item)
      return item
    end
  },
}
