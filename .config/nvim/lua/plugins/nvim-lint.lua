return {
  "mfussenegger/nvim-lint",
  config = function(_, opts)
    local lint = require('lint')
    require('lint').linters_by_ft = {
      python = {
        'mypy',
        -- 'ruff',
      }
    }

    vim.api.nvim_create_autocmd(
      { "BufWritePost" },
      {
        pattern = '*.py',
        callback = function()
          lint.try_lint('mypy')
        end,
      }
    )
    -- vim.api.nvim_create_autocmd(
    --   { "InsertLeave" },
    --   {
    --     pattern = '*.py',
    --     callback = function()
    --       lint.try_lint('ruff')
    --     end,
    --   }
    -- )
    
  end,
  -- keys = {
  --   {'<leader>l', function() require("lint").try_lint('mypy') end},
  -- };
  -- cmd = "Neomake";
}
