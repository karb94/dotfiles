-- Set scrolloff based on window height
vim.api.nvim_create_autocmd(
  {'VimEnter', 'WinResized'},
  {
    group = vim.api.nvim_create_augroup('UserScrolloff', {}),
    callback = function()
      local windows = vim.api.nvim_get_vvar('event').windows
      if not windows then
        windows = vim.api.nvim_list_wins()
      end
      for _, winid in ipairs(windows) do
        local height = vim.fn.winheight(winid)
        local scrolloff = vim.fn.float2nr(0.1 * height)
        local opts = { scope = 'local', win = winid }
        vim.api.nvim_set_option_value('scrolloff', scrolloff, opts)
      end
    end,
  }
)

-- Highlight yanked text
vim.api.nvim_create_autocmd(
  {'TextYankPost'},
  {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('TextYankPost', {}),
    callback = function ()
      vim.highlight.on_yank({higroup="IncSearch", timeout=150})
    end,
  }
)
