local servers = {
  "bashls",
  "lua_ls",
  "nixd",
  "vimls",
  --"clangd",
  "pyright",
  --"texlab",
}

-- Remove annoying popup
-- See https://github.com/neovim/nvim-lspconfig/pull/2536
-- local lua_ls_settings = {
--   Lua = {
--     workspace = {
--       checkThirdParty = false,
--     },
--   },
-- }

local config = function()
  local lspconfig = require("lspconfig")
  for _, lsp in ipairs(servers) do
    if lsp == "lua_ls"
    then
      -- lspconfig[lsp].setup({settings = lua_ls_settings})
      lspconfig[lsp].setup({})
    else
      lspconfig[lsp].setup({})
    end
  end
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
      -- Enable completion triggered by <c-x><c-o>
      vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
      local opts = { buffer = ev.buf }
      vim.keymap.set('n', '<space>r', vim.lsp.buf.rename, opts)
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
      vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
      vim.keymap.set('n', 'gr', vim.lsp.buf.hover, opts)
      -- vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
      -- Disable virtual_text from diagnostics
      vim.diagnostic.config({ virtual_text = false })

    end,
  })
end


local override = function(_, library)
  library.enabled = true
  library.runtime = true
  library.types = true
  library.plugins = true
end

-- neodev doesn't work for symlinked config under lua/*
-- see https://github.com/folke/neodev.nvim/issues/158
-- Tried to apply fix but didn't work
return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "folke/neodev.nvim", opts = {override = function(_, library)
        library.enabled = true
        -- library.runtime = true
        -- library.types = true
        library.plugins = true
      end
    }
    },
  },
  event = { "BufReadPre", "BufNewFile" },
  opts = {},
  config = config,
}
