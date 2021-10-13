-- Status line
statusline = [[ %f %y %r %m%=Column: %c  |  %P  ]]

-- Global options
local global_opts = {
    shortmess      = 'mwoOcIF',                   -- Notification area text options
    splitbelow     = true,                        -- Split window below the current one
    splitright     = true,                        -- Split window on the right of the current one
    hidden         = true,                        -- change unsaved buffers
    completeopt    = 'longest,menuone,noinsert,noselect', -- Better popup menu
    pumheight      = 7,                           -- Popup menu height
    mouse          = 'n',                         -- Allow mouse interaction in normal mode
    gdefault       = true,                        -- Sets g flag on all substitutions by default
    ignorecase     = true,                        -- Ignore case in search patterns (needed for smartcase)
    smartcase      = true,                        -- Case-sensitive search if the search pattern contains uppercase letters
    inccommand     = 'split',                     -- Live substitution command
    clipboard      = 'unnamedplus',               -- To what register you yank to
    joinspaces     = false,
    wildignorecase = true,                        -- Greedy command line completion
    ttimeout       = false,                       -- Don't wait for key code sequence
    termguicolors  = true
}

-- Window options
local window_opts = {
    signcolumn     = 'yes',                       -- Show signcolums
    statusline     = statusline,                  -- Define status line
    foldmethod     = 'manual',                    -- Less laggy than syntax mode
    number         = true,                        -- Show line numbers
    relativenumber = true,                        -- Show relative line numbers
    cursorline     = true,                        -- Show cursorline
    colorcolumn    = '80'                         -- Temporary fix for 
}

-- Buffer options
local buffer_opts = {
    spelllang      = 'en_gb',                     -- Language for spell checking
    formatoptions  = 'rqj',
    iskeyword      = 'a-z,A-Z,48-57,_,-',         -- Definition of what a 'word' is
    undofile       = true,                        -- Persistent central location for undo files
    tabstop        = 2,                           -- 4 whitespaces for <Tab>
    shiftwidth     = 2,                           -- 4 whitespaces for (auto)indent
    expandtab      = true,                        -- expands all tabs to tabstop whitespaces
    smartindent    = true                         -- Better autoindent
}

local set_options = function(opts)
    for option, value in pairs(opts) do
        vim.opt[option] = value
    end
end

set_options(global_opts)
set_options(window_opts)
set_options(buffer_opts)


-- GLOBAL VARIABLES
-- To always have vertical splits in TermDebugger
vim.g.python3_host_prog = '/usr/bin/python' -- Set python path to binary
vim.g.mapleader         = ' '               -- Set leader key
vim.g.maplocalleader    = ','               -- Set local leader key
vim.g.vimsyn_embed      = 'lP'              -- Lua syntax highlighting inside vimscript
vim.g.termdebug_wide    = 1                 -- Termdebug horizontal split

vim.cmd('autocmd InsertEnter * set timeoutlen=200') -- Time waited for mappings in insert mode
vim.cmd('autocmd InsertLeave * set timeoutlen=600') -- Time waited for mappings

-- To always have vertical splits in TermDebugger

-- compute_scrolloff = function()
-- end
-- scrolloff             = vim.fn.float2nr(0.15 * vim.fn.winheight(0))
-- vim.o.scrolloff       = scrolloff                   -- Top/bottom lines of margins
-- Directory variables

P = function(v)
    print(vim.inspect(v))
    return v
end

if pcall(require, 'plenary') then
    RELOAD = require('plenary.reload').reload_module

    R = function(name)
        RELOAD(name)
        return require(name)
    end
end
