vim.lsp.enable({
  'bashls',
  'lua_ls',
  'nixd',
  'vimls',
  'basedpyright',
  --texlab,
})

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(event)
    local opts = { buffer = event.buf }
    vim.keymap.set('n', '<leader>r', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<leader>n', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>d', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', '<leader>h', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<leader>i', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<leader>a', vim.lsp.buf.code_action, opts)
    vim.keymap.set('i', '<C-s>', vim.lsp.buf.signature_help, opts)
  end,
})
