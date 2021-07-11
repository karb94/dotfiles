local map = function(mode, keymap, command, opts)
    opts = opts or { noremap = true, silent = true }
    vim.api.nvim_set_keymap(mode, keymap, command, opts)
end
local nmap = function(keymap, command)
    opts = { noremap = true, silent = true }
    vim.api.nvim_set_keymap( 'n', keymap, command, opts)
end

normal_mode_maps = {
    ['Y']              = 'yg_',
    ['p']              = 'pm`=`]``',
    ['P']              = 'Pm`=`]``',
    ['U']              = ':redo<CR>',
    ['[t']             = ':tabp<CR>',
    [']t']             = ':tabn<CR>',
    ['[c']             = ':cnext<CR>',
    [']c']             = ':cprevious<CR>',
    ['<leader>j']      = 'J',
    ['<leader>B']      = ':b#<CR>',
    ['<leader>e']      = ':cc<CR>',
    ['<leader>w']      = '<C-w>',
    ['<leader>q']      = ':q!<CR>',
    ['<leader>Q']      = ':qa!<CR>',
    ['<leader>s']      = ':w<CR>',
    ['<leader>x']      = ':x<CR>',
    ['<leader>X']      = ':xa<CR>',
    ['<leader>p']      = 'put<CR>=`[',
    ['<leader>P']      = 'put!<CR>=`[',
    ['<leader>o']      = ':set paste<CR>m`o<Esc>``:set nopaste<CR>',
    ['<leader>o']      = ':set paste<CR>m`O<Esc>``:set nopaste<CR>',
    ['<localleader>m'] = ':w<CR>:Neomake! make<CR>',
    ['<localleader>d'] = ':w<CR>:Neomake! debug<CR>',
    ['<leader><leader>p']      = '"0p',
    ['<leader><leader>P']      = '"*p',
}
for keymap, value in pairs(normal_mode_maps) do
    nmap(keymap, value)
end

-- end
-- ":inoremap lk <Esc>
-- " vnoremap lk <Esc>
-- inoremap <C-j> <C-n>
-- inoremap <C-k> <C-p>
-- cnoremap <C-j> <C-n>
-- cnoremap <C-k> <C-p>

-- set wildcharm=<C-z>
-- cnoremap <expr> <Tab>   getcmdtype() =~ '[\/?]' ? "<C-g>" : "<C-z>"
-- cnoremap <expr> <S-Tab> getcmdtype() =~ '[\/?]' ? "<C-t>" : "<S-Tab>"
-- " nnoremap <silent> <leader>m :silent make!\|redraw!\|cw<CR>
-- " Terminal mappings
-- tnoremap <C-]> <C-\><C-n>
-- " TermDebugger mappings
-- let s:fivep = float2nr(0.10*winheight(0))
-- -- exec "nnoremap J ".s:fivep."<C-e>"
-- -- exec "nnoremap K ".s:fivep."<C-y>"
-- exec "nnoremap L " . &l:scrolloff . "L"
-- exec "nnoremap H " . &l:scrolloff . "H"
