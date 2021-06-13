vim.g.indent_blankline_char = '┊'  -- '|', '¦', '┆', '┊'
vim.g.indent_blankline_use_treesitter = true
vim.g.indent_blankline_show_current_context = false
vim.g.indent_blankline_context_patterns = {
    'class', '^function', 'method', '^if', '^else', '^while', '^for', '^object', '^table'}
vim.g.indent_blankline_context_highlight_list = {
    'StorageClass', 'Function', 'Function', 'Conditional', 'Conditional', 'Repeat', 'Repeat', 'Structure', 'Structure'}
vim.g.indent_blankline_filetype_exclude = {'help'}
vim.g.indent_blankline_buftype_exclude = {'terminal'}
