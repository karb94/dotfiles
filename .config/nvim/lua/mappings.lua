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
  ['<leader>X']         = ':wa<CR>:qa<CR>',
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


local loclist_exists = function ()
  return vim.fn.getloclist(0, { winid = 0 }).winid ~= 0
end

local qflist_exists = function ()
  return next(vim.fn.getqflist()) ~= nil
end

local multi_next = function ()
  if loclist_exists() then
    local success, _ = pcall(vim.api.nvim_command, 'lnext')
    if not success then
      vim.cmd('1ll')
    end
  elseif qflist_exists() then
    local success, _ = pcall(vim.api.nvim_command, 'cnext')
    if not success then
      vim.cmd('1cc')
    end
  else
    vim.diagnostic.jump({ count = 1, float = false })
  end
end

local multi_previous = function ()
  if loclist_exists() then
    local success, _ = pcall(vim.api.nvim_command, 'lprevious')
    if not success then
      vim.cmd('$ll')
    end
  elseif qflist_exists() then
    local success, _ = pcall(vim.api.nvim_command, 'cprevious')
    if not success then
      vim.cmd('$cc')
    end
  else
    vim.diagnostic.jump({ count = -1, float = false })
  end
end

vim.keymap.set('n', 'gd', '<C-]>', {noremap=false})
vim.keymap.set('n', '<leader><leader>d', vim.diagnostic.setloclist, { desc = 'Send diagnostics to the location list' })
vim.keymap.set('n', '<leader><leader>D', vim.diagnostic.setqflist, { desc = 'Send diagnostics to the quickfix list' })
vim.keymap.set('n', '<C-j>', multi_next, { desc = 'Got to next loclist/qflist/diagnostic' })
vim.keymap.set('n', '<C-k>', multi_previous, { desc = 'Got to previous loclist/qflist/diagnostic' })
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { desc = 'Exit terminal mode' })
vim.keymap.set({ 'i', 'c' }, '<C-j>', '<C-n>', { remap = true })
vim.keymap.set({ 'i', 'c' }, '<C-k>', '<C-p>', { remap = true })
vim.keymap.set({'n', 'x'}, 'K', '<C-y>', { silent = true, remap = true })
vim.keymap.set({'n', 'x'}, 'J', '<C-e>', { silent = true, remap = true })
vim.keymap.set({'v'}, 'p', 'P', { silent = true, remap = false })
vim.keymap.set({'v'}, 'P', 'p', { silent = true, remap = false })
-- Reselect the text that was previously pasted
vim.keymap.set({'n'}, 'gp', [['`[' . getregtype()[0] . '`]']], { expr = true, silent = true, remap = false })

return mappings
