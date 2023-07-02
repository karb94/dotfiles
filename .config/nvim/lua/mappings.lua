local mappings = {}

mappings.map = function(mode, keymap, command, opts)
    opts = opts or { noremap = true, silent = true }
    vim.api.nvim_set_keymap(mode, keymap, command, opts)
end

mappings.nmap = function(keymap, command)
    local opts = { noremap = true, silent = true }
    vim.api.nvim_set_keymap( 'n', keymap, command, opts)
end

local normal_mode_maps = {
    ['Y']                 = 'yg_',
    ['p']                 = 'pm`=`]``',
    ['P']                 = 'Pm`=`]``',
    -- ['L']                 = ':execute "normal! " . &l:scrolloff . "L"<CR>',
    -- ['H']                 = ':execute "normal! " . &l:scrolloff . "H"<CR>',
    ['gqip']              = 'm`gqip``',
    ['U']                 = ':redo<CR>',
    ['[t']                = ':tabp<CR>',
    [']t']                = ':tabn<CR>',
    ['[d']                = ':lua vim.diagnostic.goto_next()<CR>',
    [']d']                = ':lua vim.diagnostic.goto_previous()<CR>',
    ['<C-j>']             = ':cnext<CR>',
    ['<C-k>']             = ':cprevious<CR>',
    ['<C-h>']             = '^',
    ['<C-l>']             = 'g_',
    ['<leader>j']         = 'J',
    ['<leader>B']         = ':b#<CR>',
    ['<leader>e']         = ':cc<CR>',
    ['<leader>w']         = '<C-w>',
    ['<leader>q']         = ':q!<CR>',
    ['<leader>Q']         = ':qa!<CR>',
    ['<leader>s']         = ':w<CR>',
    ['<leader>x']         = ':x<CR>',
    ['<leader>X']         = ':xa<CR>',
    ['<leader>p']         = ':put<CR>=`[',
    ['<leader>P']         = ':put!<CR>=`[',
    ['<leader>o']         = ':set paste<CR>m`o<Esc>``:set nopaste<CR>',
    ['<leader>O']         = ':set paste<CR>m`O<Esc>``:set nopaste<CR>',
    ['<leader><leader>p'] = '"0p',
    ['<leader><leader>P'] = '"*p',
}

for keymap, command in pairs(normal_mode_maps) do
    local opts = { noremap = true, silent = true }
    vim.api.nvim_set_keymap( 'n', keymap, command, opts)
end

vim.keymap.set('t', '<C-]>', [[<C-\><C-n>]])
vim.keymap.set({'i', 'c'}, '<C-j>', '<C-n>')
vim.keymap.set({'i', 'c'}, '<C-k>', '<C-p>')
vim.keymap.set({'n', 'x'}, 'K', '<C-y>', { silent = true, remap = true })
vim.keymap.set({'n', 'x'}, 'J', '<C-e>', { silent = true, remap = true })

-- local function run_test()
--   local test_directory = require('plenary.test_harness').test_directory
--   local current_file_path = vim.fn.expand("%:p")
--   local minimal_init_path = vim.fn.expand("%:h") .. '/minimal_init.vim'
--   test_directory(current_file_path, {minimal_init = minimal_init_path})
-- end
-- vim.keymap.set('n', '<leader>t', run_test)

return mappings
