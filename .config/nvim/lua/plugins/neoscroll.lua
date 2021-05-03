require('neoscroll').setup({
    mappings = {'<C-u>', '<C-d>', '<C-b>', '<C-f>', '<C-y>', '<C-e>', 'zt', 'zz', 'zb'},
    -- mappings = {},
    -- Set any other options as needed
    stop_eof = false,
    respect_scrolloff = true,
    cursor_scrolls_alone = false
})

local config = require('neoscroll.config')
local t = config.key_to_function
-- easing1: f(x) = x^2
local easing1 = [[function(x) return math.pow(x, 2) end]]
-- easing2: f(x) = x^4
local easing2 = [[function(x) return math.pow(x, 4) end]]

-- Syntax: t[keys] = {function, {function arguments}}
-- Use easing1 function from 5 ms to 20 ms time-step
t['<C-u>'] = {'scroll', {'-vim.wo.scroll', 'true', easing1, '7', '15'}}
t['<C-d>'] = {'scroll', { 'vim.wo.scroll', 'true', easing1, '7', '15'}}
-- Use easing2 function from 7 ms to 15 ms time-step
t['<C-b>'] = {'scroll', {'-vim.api.nvim_win_get_height(0)', 'true', easing2, '5', '20'}}
t['<C-f>'] = {'scroll', { 'vim.api.nvim_win_get_height(0)', 'true', easing2, '5', '20'}}
-- Use a constant time-step of 20 ms
t['<C-y>'] = {'scroll', {'-0.10', 'false', '20'}}
t['<C-e>'] = {'scroll', { '0.10', 'false', '20'}}
-- Use a constant time-step of 7 ms
t['zt']    = {'zt', {'7'}}
t['zz']    = {'zz', {'7'}}
t['zb']    = {'zb', {'7'}}

config.set_mappings()


-- require('neoscroll').setup({
--     mappings = {'<C-u>', '<C-d>', '<C-b>', '<C-f>', '<C-y>', '<C-e>', 'zt', 'zz', 'zb'},
--     -- mappings = {},
--     stop_eof = false,
--     respect_scrolloff = true,
--     cursor_scrolls_alone = false
-- })

-- local config = require('neoscroll.config')
-- local t = config.key_to_function

-- local easing = [[function(x) return math.pow(x, 2) end]]

-- t['<C-u>'] = {'scroll', {'-vim.wo.scroll', 'true', easing, '5', '20'          }}
-- t['<C-d>'] = {'scroll', { 'vim.wo.scroll', 'true', easing, '5', '20'          }}
-- -- t['<C-u>'] = {'scroll', {'-vim.wo.scroll', 'true', '3'                 }}
-- -- t['<C-d>'] = {'scroll', { 'vim.wo.scroll', 'true', '3'                 }}
-- t['<C-b>'] = {'scroll', {'-vim.api.nvim_win_get_height(0)', 'true', '7'}}
-- t['<C-f>'] = {'scroll', { 'vim.api.nvim_win_get_height(0)', 'true', '7'}}
-- t['<C-y>'] = {'scroll', {'-0.10', 'false', '15'                        }}
-- t['<C-e>'] = {'scroll', { '0.10', 'false', '15'                        }}
-- t['zt']    = {'zt',     {'7'                                           }}
-- t['zz']    = {'zz',     {'7'                                           }}
-- t['zb']    = {'zb',     {'7'                                           }}

-- config.set_mappings()


vim.api.nvim_set_keymap('n', 'K', '<C-y>', {silent=true})
vim.api.nvim_set_keymap('n', 'J', '<C-e>', {silent=true})
vim.api.nvim_set_keymap('x', 'K', '<C-y>', {silent=true})
vim.api.nvim_set_keymap('x', 'J', '<C-e>', {silent=true})
