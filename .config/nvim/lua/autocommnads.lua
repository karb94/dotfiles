-- Set scrolloff based on window height
vim.api.nvim_create_autocmd(
  {'VimResized', 'WinNew', 'WinEnter'},
  {
    group = vim.api.nvim_create_augroup('UserScrolloff', {}),
    callback = function()
      local scrolloff = vim.fn.float2nr(0.1 * vim.fn.winheight(0))
      vim.wo.scrolloff = scrolloff
    end,
  }
)

-- Highlight yanked text
vim.api.nvim_create_autocmd(
  {'TextYankPost'},
  {
    group = vim.api.nvim_create_augroup('TextYankPost', {}),
    callback = function ()
      vim.highlight.on_yank({higroup="IncSearch", timeout=150})
    end,
  }
)
