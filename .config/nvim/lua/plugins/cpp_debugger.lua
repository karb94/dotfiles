local M = {}
local config


M.start_c_debugger = function(args, mi_mode, mi_debugger_path)
    local dap = require("dap")
    if args and #args > 0 then
        config = {
            type = "cpp",
            name = args[1],
            request = "launch",
            program = table.remove(args, 1),
            args = args,
            cwd = vim.fn.getcwd(),
            externalConsole = true,
            MIMode = mi_mode or "lldb-vscode",
            MIDebuggerPath = mi_debugger_path
        }
    end

    if not config then
        print('No binary to debug set! Use ":DebugC <binary> <args>" or ":DebugRust <binary> <args>"')
        return
    end

    dap.run(config)
    dap.repl.open({}, 'belowright vsplit')
end

return M
