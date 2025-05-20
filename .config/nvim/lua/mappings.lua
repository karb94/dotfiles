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
  ['gqip']              = 'm`gqip``',
  ['U']                 = ':redo<CR>',
  ['[t']                = ':tabp<CR>',
  [']t']                = ':tabn<CR>',
  ['<C-j>']             = ':cnext<CR>',
  ['<C-k>']             = ':cprevious<CR>',
  ['<C-h>']             = '^',
  ['<C-l>']             = 'g_',
  ['<space>']           = '<NOP>',
  ['<leader>j']         = 'J',
  ['<leader>B']         = ':b#<CR>',
  ['<leader>e']         = ':cc<CR>',
  ['<leader>w']         = '<C-w>',
  ['<leader>q']         = ':q!<CR>',
  ['<leader>Q']         = ':qa!<CR>',
  ['<leader>s']         = ':w<CR>',
  ['<leader>x']         = ':x<CR>',
  ['<leader>X']         = ':xa!<CR>',
  ['<leader>p']         = ':put<CR>=`[',
  ['<leader>P']         = ':put!<CR>=`[',
  ['<leader>o']         = ':set paste<CR>m`o<Esc>``:set nopaste<CR>',
  ['<leader>O']         = ':set paste<CR>m`O<Esc>``:set nopaste<CR>',
  ['<leader>d']         = ':lua vim.diagnostic.open_float()<CR>',
  ['<leader><leader>p'] = '"0p',
  ['<leader><leader>P'] = '"*p',
}
for keymap, command in pairs(normal_mode_maps) do
    local opts = { noremap = true, silent = true }
    vim.api.nvim_set_keymap( 'n', keymap, command, opts)
end


local loclist_exists = function ()
  return vim.fn.getloclist(0, { winid = 0 }).winid ~= 0
end

local qflist_exists = function ()
  return next(vim.fn.getqflist()) ~= nil
end

local multi_next = function ()
  if loclist_exists() then
    local success, _ = pcall(vim.cmd, 'lnext')
    if not success then
      vim.cmd('1ll')
    end
  elseif qflist_exists() then
    local success, _ = pcall(vim.cmd, 'cnext')
    if not success then
      vim.cmd('1cc')
    end
  else
    vim.diagnostic.goto_next({float=false})
  end
end

local multi_previous = function ()
  if loclist_exists() then
    local success, _ = pcall(vim.cmd, 'lprevious')
    if not success then
      vim.cmd('$ll')
    end
  elseif qflist_exists() then
    local success, _ = pcall(vim.cmd, 'cprevious')
    if not success then
      vim.cmd('$cc')
    end
  else
    vim.diagnostic.goto_prev({float=false})
  end
end

vim.keymap.set('n', '<C-j>', multi_next, { desc = 'Got to next loclist/qflist/diagnostic' })
vim.keymap.set('n', '<C-k>', multi_previous, { desc = 'Got to previous loclist/qflist/diagnostic' })
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { desc = 'Exit terminal mode' })
vim.keymap.set({'i', 'c'}, '<C-j>', '<C-n>')
vim.keymap.set({'i', 'c'}, '<C-k>', '<C-p>')
vim.keymap.set({'n', 'x'}, 'K', '<C-y>', { silent = true, remap = true })
vim.keymap.set({'n', 'x'}, 'J', '<C-e>', { silent = true, remap = true })
vim.keymap.set({'v'}, 'p', 'P', { silent = true, remap = false })
vim.keymap.set({'v'}, 'P', 'p', { silent = true, remap = false })
-- Reselect the text that was previously pasted
vim.keymap.set({'n'}, 'gp', [['`[' . getregtype()[0] . '`]']], { expr = true, silent = true, remap = false })

return mappings
