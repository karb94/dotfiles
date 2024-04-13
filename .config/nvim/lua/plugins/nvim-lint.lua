return {
  "mfussenegger/nvim-lint",
  config = function(_, opts)
    local lint = require('lint')

    -- local mypy = lint.linters.mypy
    -- mypy.args = {
    --   '--show-column-numbers',
    --   '--hide-error-codes',
    --   '--hide-error-context',
    --   '--no-color-output',
    --   '--no-error-summary',
    --   '--no-pretty',
    --   -- '--ignore-missing-imports',
    --   '--disallow-untyped-defs'
    -- }

    require('lint').linters_by_ft.python = { 'mypy', }

    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      callback = function()
        lint.try_lint()
      end,
    })
  end,
  keys = {
    {'<leader>l', function() require("lint").try_lint() end},
  };
  -- cmd = "Neomake";
}
