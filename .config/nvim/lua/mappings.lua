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
    ['U']                 = ':redo<CR>',
    ['[t']                = ':tabp<CR>',
    [']t']                = ':tabn<CR>',
    ['[c']                = ':cnext<CR>',
    [']c']                = ':cprevious<CR>',
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
    ['<localleader>m']    = ':w<CR>:Neomake! make<CR>',
    ['<localleader>d']    = ':w<CR>:Neomake! debug<CR>',
    ['<leader><leader>p'] = '"0p',
    ['<leader><leader>P'] = '"*p',
}

for keymap, value in pairs(normal_mode_maps) do
    mappings.nmap(keymap, value)
end

return mappings
