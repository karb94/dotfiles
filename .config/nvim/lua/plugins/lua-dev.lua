on_attach = function(client, bufnr)

  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local lsp_nmap = function(key, lsp_func)
    local func = "<cmd>lua vim.lsp." .. lsp_func .. "<CR>"
    local opts = {noremap = true, silent = true}
    vim.api.nvim_buf_set_keymap(bufnr, 'n', key, func, opts)
  end
  -- Mappings.
  lsp_nmap('gD', 'buf.declaration()')
  lsp_nmap('gd', 'buf.definition()')
  lsp_nmap('<C-k>', 'buf.signature_help()')
  lsp_nmap('<leader>e', 'diagnostic.show_line_diagnostics()')
  lsp_nmap('[d', 'diagnostic.goto_prev()')
  lsp_nmap(']d', 'diagnostic.goto_next()')
end

local luadev = require("lua-dev").setup({
  lspconfig = {
    cmd={"lua-language-server"},
    on_attach = on_attach,
  },
})
local lspconfig = require('lspconfig')
lspconfig.sumneko_lua.setup(luadev)
