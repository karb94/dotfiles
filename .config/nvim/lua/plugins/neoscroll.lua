vim.g.neoscroll_stop_eof = false
vim.g.neoscroll_respect_scrolloff = true
vim.g.neoscroll_cursor_scrolls_alone = false

vim.api.nvim_set_keymap('n', 'K', '<C-y>', {silent=true})
vim.api.nvim_set_keymap('n', 'J', '<C-e>', {silent=true})
vim.api.nvim_set_keymap('x', 'K', '<C-y>', {silent=true})
vim.api.nvim_set_keymap('x', 'J', '<C-e>', {silent=true})
