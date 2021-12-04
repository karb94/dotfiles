local luadev = require("lua-dev").setup({
  lspconfig = {
    cmd={"lua-language-server"},
    on_attach = require('plugins.nvim-lspconfig').on_attach,
  },
})

require('lspconfig').sumneko_lua.setup(luadev)
