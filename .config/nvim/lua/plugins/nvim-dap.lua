local dap = require('dap')
local variables_ui = require('dap.ui.variables')

dap.adapters.cpp = {
    type = 'executable',
    attach = {
        pidProperty = "pid",
        pidSelect = "ask"
    },
    command = 'lldb-vscode', -- my binary was called 'lldb-vscode-11'
    env = {
        LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = "YES"
    },
    name = "lldb"
}

-- in your init.lua (or copy the lines with command! in your init.vim)
vim.cmd [[
command! -complete=file -nargs=* DebugCpp lua require("plugins/cpp_debugger").start_c_debugger({<f-args>}, "lldb-vscode")
]]

local map = function(mode, keymap, command, opts)
    opts = opts or { noremap = true, silent = true }
    vim.api.nvim_set_keymap(mode, keymap, command, opts)
end
map('n', '<localleader>c', [[:lua require('dap').continue()<CR>]])
map('n', '<localleader>n', [[:lua require('dap').step_over()<CR>]])
map('n', '<localleader>s', [[:lua require('dap').step_into()<CR>]])
map('n', '<localleader>o', [[:lua require('dap').step_out()<CR>]])
map('n', '<localleader>b', [[:lua require('dap').toggle_breakpoint()<CR>]])
map('n', '<localleader>B', [[:lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>]])
map('n', '<localleader>r', [[:lua require('dap').run_last()<CR>]])
map('n', '<localleader>e', [[:lua require('dap.ui.variables').hover()<CR>]])
map('n', '<localleader>E', [[:lua require('dap.ui.variables').scopes()<CR>]])
