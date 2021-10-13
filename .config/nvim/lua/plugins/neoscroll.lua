require('neoscroll').setup {
  respect_scrolloff = false,
  use_local_scrolloff = true,
  hide_cursor = true,
  cursor_scrolls_alone = true,
  stop_eof = false,
  -- mappings = {},
  -- mappings = {'<C-u>', '<C-d>', '<C-b>', '<C-f>', '<C-y>', '<C-e>', 'zt', 'zz',
  --   'zb', 'gg', 'G'},
}
-- require("neoscroll").setup({})
--   mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt",
--                "zz", "zb"},
-- 	stop_eof = false,
-- 	respect_scrolloff = true,
-- 	cursor_scrolls_alone = false,
-- 	-- easing_function = "quadratic",
-- 	use_local_scrolloff = true,
-- })

-- require('neoscroll').setup()

-- local t = {}
-- t["G"] = { "G", { "100", "scroll" } }
-- t["gg"] = { "gg", { "100" } }
-- t['gg'] = {'scroll', {'-vim.api.nvim_buf_line_count(0)+20', 'true', '1500', [["cubic"]]}}
-- t['G']  = {'scroll', {'vim.api.nvim_buf_line_count(0)-20', 'true', '1500', [["cubic"]]}}
-- -- Syntax: t[keys] = {function, {function arguments}}
-- -- Use the "sine" easing function
-- t["<C-u>"] = { "scroll", { "-vim.wo.scroll", "true", "350", "sine", [['cursorline']] } }
-- t["<C-d>"] = { "scroll", { "vim.wo.scroll", "true", "350", "sine", [['cursorline']] } }
-- -- Use the "circular" easing function
-- t['<C-b>'] = {'scroll', {'-vim.api.nvim_win_get_height(0)', 'true', '500', 'circular'}}
-- t['<C-f>'] = {'scroll', { 'vim.api.nvim_win_get_height(0)', 'true', '500', 'circular'}}
-- -- Pass "nil" to disable the easing animation (constant scrolling speed)
-- t['<C-y>'] = {'scroll', {'-0.10', 'false', '100', nil}}
-- t['<C-e>'] = {'scroll', { '0.10', 'false', '100', nil}}
-- -- When no easing function is provided the default easing function (in this case "quadratic") will be used
-- t['zt']    = {'zt', {'300'}}
-- t['zz']    = {'zz', {'300'}}
-- t['zb']    = {'zb', {'300'}}

-- require("neoscroll.config").set_mappings(t)

-- local config = require('neoscroll.config')
-- -- easing1: f(x) = x^2
-- local easing1 = [[function(x) return math.pow(x, 2) end]]
-- -- easing2: f(x) = x^4
-- local easing2 = [[function(x) return math.pow(x, 4) end]]

-- local t = {}
-- Syntax: t[keys] = {function, {function arguments}}
-- Use easing1 function from 5 ms to 20 ms time-step
-- t['<C-u>'] = {'scroll', {'-vim.wo.scroll', 'true', '7', '15', easing1}}
-- t['<C-d>'] = {'scroll', { 'vim.wo.scroll', 'true', '7', '15', easing1}}
-- -- Use easing2 function from 7 ms to 15 ms time-step
-- t['<C-b>'] = {'scroll', {'-vim.api.nvim_win_get_height(0)', 'true', '5', '20', easing2}}
-- t['<C-f>'] = {'scroll', { 'vim.api.nvim_win_get_height(0)', 'true', '5', '20', easing2}}
-- -- Use a constant time-step of 20 ms
-- t['<C-y>'] = {'scroll', {'-0.10', 'false', '20'}}
-- t['<C-e>'] = {'scroll', { '0.10', 'false', '20'}}
-- -- Use a constant time-step of 7 ms
-- t['zt']    = {'zt', {'7', '15', easing1}}
-- t['zz']    = {'zz', {'7', '15', easing1}}
-- t['zb']    = {'zb', {'7', '15', easing1}}
-- -- t['zt']    = {'zt', {'7'}}
-- -- t['zz']    = {'zz', {'7'}}
-- -- t['zb']    = {'zb', {'7'}}

-- config.set_mappings(t)

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

vim.api.nvim_set_keymap("n", "K", "<C-y>", { silent = true })
vim.api.nvim_set_keymap("n", "J", "<C-e>", { silent = true })
vim.api.nvim_set_keymap("x", "K", "<C-y>", { silent = true })
vim.api.nvim_set_keymap("x", "J", "<C-e>", { silent = true })
