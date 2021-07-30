local dap = require('dap')
local variables_ui = require('dap.ui.variables')

dap.adapters.lldb = {
  type = 'executable',
  command = '/usr/bin/lldb-vscode',
  name = "lldb"
}

dap.configurations.cpp = {
  {
    name = "Launch",
    type = "lldb",
    request = "launch",
    program = "/home/carles/phd/CSG_model/bin/csgm",
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = function()
      return {vim.fn.input('Arguments: ', vim.fn.getcwd(), 'file')}
    end,
    runInTerminal = false,
  },
}

-- in your init.lua (or copy the lines with command! in your init.vim)
vim.cmd [[
command! -complete=file -nargs=* DebugCpp lua require("plugins/cpp_debugger").start_c_debugger({<f-args>}, "lldb-vscode")
]]

local map = function(mode, keymap, command, opts)
    opts = opts or { noremap = true, silent = true }
    vim.api.nvim_set_keymap(mode, keymap, command, opts)
end
map('n', '<localleader>c', [[:lua require('dap').continue() require('dap').repl.open()<CR>]])
map('n', '<localleader>n', [[:lua require('dap').step_over()<CR>]])
map('n', '<localleader>s', [[:lua require('dap').step_into()<CR>]])
map('n', '<localleader>o', [[:lua require('dap').step_out()<CR>]])
map('n', '<localleader>b', [[:lua require('dap').toggle_breakpoint()<CR>]])
map('n', '<localleader>B', [[:lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>]])
map('n', '<localleader>r', [[:lua require('dap').run_last()<CR>]])
map('n', '<localleader>e', [[:lua require('dap.ui.variables').hover()<CR>]])
map('n', '<localleader>E', [[:lua require('dap.ui.variables').scopes()<CR>]])
