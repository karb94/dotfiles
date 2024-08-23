local servers = {
  "bashls",
  "lua_ls",
  "nixd",
  "vimls",
  --"clangd",
  "pyright",
  -- "ruff",
  --"texlab",
}

local override = function(_, library)
  library.enabled = true
  library.runtime = true
  library.types = true
  library.plugins = true
end

-- Remove annoying popup
-- See https://github.com/neovim/nvim-lspconfig/pull/2536
-- local lua_ls_settings = {
--   Lua = {
--     workspace = {
--       checkThirdParty = false,
--     },
--   },
-- }
local lua_ls_setup = {
  on_init = function(client)
    local path = client.workspace_folders[1].name
    if vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc') then
      return
    end

    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = {
        -- Tell the language server which version of Lua you're using
        -- (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT'
      },
      diagnostics = {
        globals = { "vim" },
      },
      -- Make the server aware of Neovim runtime files
      workspace = {
        checkThirdParty = false,
        -- library = {
        --   vim.env.VIMRUNTIME
        --   -- Depending on the usage, you might want to add additional paths here.
        --   -- "${3rd}/luv/library"
        --   -- "${3rd}/busted/library",
        -- }
        -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
        -- library = vim.api.nvim_get_runtime_file("", true)
        library = vim.env.VIMRUNTIME .. '/lua'
      }
    })
  end,
  settings = {
    Lua = {}
  }
}


local config = function()
  local lspconfig = require("lspconfig")
  for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup({})
  end
  -- lspconfig["lua_ls"].setup(lua_ls_setup)
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
      -- Enable completion triggered by <c-x><c-o>
      vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
      local opts = { buffer = ev.buf }
      vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, opts)
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
      vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
      vim.keymap.set('n', 'gr', vim.lsp.buf.hover, opts)
      vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
      -- vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)

    end,
  })
end

-- neodev doesn't work for symlinked config under lua/*
-- see https://github.com/folke/neodev.nvim/issues/158
-- Tried to apply fix but didn't work
return {
  "neovim/nvim-lspconfig",
  -- dependencies = {
  --   {
  --     "folke/neodev.nvim",
  --     -- opts = {},
  --     opts = {experimental = { pathStrict = true }},
  --     -- opts = {
  --     --   override = function(_, library)
  --     --     -- library.enabled = true
  --     --     -- library.runtime = true
  --     --     -- library.types = true
  --     --     -- library.plugins = true
  --     --   end
  --     -- },
  --     -- config = true,
  --     lazy = false,
  --   },
  -- },
  event = { "BufReadPre", "BufNewFile" },
  opts = {},
  config = config,
}
