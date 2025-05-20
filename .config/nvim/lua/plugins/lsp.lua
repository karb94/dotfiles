local servers = {
  bashls = {},
  lua_ls = {},
  nixd = {},
  vimls = {},
  --clangd = {},
  -- https://www.reddit.com/r/neovim/comments/11k5but/how_to_disable_pyright_diagnostics/
  -- ruff = {
  --   on_attach = function(client, _) client.server_capabilities.hoverProvider = false end,
  -- },
  basedpyright = {},
  --texlab = {},
}

local config = function()
  local lspconfig = require("lspconfig")
  for server, config in pairs(servers) do
    lspconfig[server].setup(config)
  end
  -- lspconfig["lua_ls"].setup(lua_ls_setup)
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
      -- Enable completion triggered by <c-x><c-o>
      vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
      local opts = { buffer = ev.buf }
      vim.keymap.set('n', 'gr', vim.lsp.buf.hover, opts)

    end,
  })
end

-- neodev doesn't work for symlinked config under lua/*
-- see https://github.com/folke/neodev.nvim/issues/158
-- Tried to apply fix but didn't work
return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  opts = {},
  config = config,
}
