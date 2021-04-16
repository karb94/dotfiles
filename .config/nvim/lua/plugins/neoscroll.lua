require('neoscroll').setup({
    -- mappings = {'<C-u>', '<C-d>', '<C-b>', '<C-f>', '<C-y>', '<C-e>', 'zt', 'zz', 'zb'},
    -- mappings = {},
    stop_eof = false,
    respect_scrolloff = true,
    cursor_scrolls_alone = false
})

local config = require('neoscroll.config')
local t = config.key_to_function
t['<C-u>'] = {'scroll', {'-vim.wo.scroll', 'true', '8'                 }}
t['<C-d>'] = {'scroll', { 'vim.wo.scroll', 'true', '8'                 }}
t['<C-b>'] = {'scroll', {'-vim.api.nvim_win_get_height(0)', 'true', '7'}}
t['<C-f>'] = {'scroll', { 'vim.api.nvim_win_get_height(0)', 'true', '7'}}
t['<C-y>'] = {'scroll', {'-0.10', 'false', '15'                        }}
t['<C-e>'] = {'scroll', { '0.10', 'false', '15'                        }}
t['zt']    = {'zt',     {'7'                                           }}
t['zz']    = {'zz',     {'7'                                           }}
t['zb']    = {'zb',     {'7'                                           }}

config.set_mappings()


vim.api.nvim_set_keymap('n', 'K', '<C-y>', {silent=true})
vim.api.nvim_set_keymap('n', 'J', '<C-e>', {silent=true})
vim.api.nvim_set_keymap('x', 'K', '<C-y>', {silent=true})
vim.api.nvim_set_keymap('x', 'J', '<C-e>', {silent=true})
