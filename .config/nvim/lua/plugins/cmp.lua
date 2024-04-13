local get_opts = function()
  local cmp = require("cmp")
  return {
    mapping = cmp.mapping.preset.insert({
      ["<C-j>"] = cmp.mapping.select_next_item({behavior = cmp.SelectBehavior.Insert}),
      ["<C-k>"] = cmp.mapping.select_prev_item({behavior = cmp.SelectBehavior.Insert}),
      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      -- ["<ESC>"] = function(fallback) if cmp.visible() then cmp.abort() else fallback() end end,
      ["<C-e>"] = cmp.mapping.abort(),
      -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      ["<C-i>"] = cmp.mapping.confirm({select = true, behavior = cmp.ConfirmBehavior.Replace}),
      ["<CR>"] = cmp.mapping.confirm({behavior = cmp.ConfirmBehavior.Replace}),
      -- ["<CR>"] = cmp.mapping.confirm(),
    }),
    -- REQUIRED - you must specify a snippet engine
    snippet = {
      expand = function(args)
        require('snippy').expand_snippet(args.body) -- Lightest snippet engine
      end,
    },
    sources = cmp.config.sources({
      { name = "nvim_lsp" },
      { name = "buffer" },
      { name = "path" },
    }),
    experimental = {ghost_text = {hl_group = "LspCodeLens"}},
  }
end

return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    'hrsh7th/cmp-cmdline',
    "dcampos/nvim-snippy",
    "dcampos/cmp-snippy",
  },
  opts = get_opts,
}
