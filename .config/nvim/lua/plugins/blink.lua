return {
  "saghen/blink.cmp",
  version = '1.*',
  event = "InsertEnter",
  opts = {
    keymap = {
      preset = 'super-tab',
      -- ['<C-j>'] = { 'select_next', 'fallback' },
      -- ['<C-k>'] = { 'select_prev', 'fallback' },
      ['<C-k>'] = {},
      ['<C-space>'] = { 'show_signature', 'hide_signature', 'fallback' },
      ["<CR>"] = { "accept", "fallback" },
    },
    documentation = { auto_show = true, auto_show_delay_ms = 2000 },
    sources = {
      default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
      providers = {
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          -- make lazydev completions top priority (see `:h blink.cmp`)
          score_offset = 100,
        },
      },
    },
    fuzzy = { implementation = "prefer_rust_with_warning" }
  },
  opts_extend = { "sources.default" },
}
