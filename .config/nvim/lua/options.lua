vim.o.spelllang       = 'en_gb'                     -- Language for spell checking
vim.o.shortmess       = 'mwoOcIF'                   -- Notification area text options
vim.o.undofile        = true                        -- Persistent central location for undo files
vim.o.undodir         = '~/.config/nvim/undodir'    -- Undo files directory
vim.o.directory       = '~/.config/nvim/swp'        -- Use ~/.vim/swp to store swap files
vim.o.splitbelow      = true                        -- Split window below the current one
vim.o.splitright      = true                        -- Split window on the right of the current one
vim.o.iskeyword       = 'a-z,A-Z,48-57,_,-'         -- Definition of what a 'word' is
vim.o.hidden          = true                        -- change unsaved buffers
vim.o.backspace       = 'indent,eol,start'          -- Backspace behaves like everywhere else
vim.wo.number         = true                        -- Show line numbers
vim.wo.relativenumber = true                        -- Show relative line numbers
vim.o.completeopt     = 'menuone,noinsert,noselect' -- Better popup menu
vim.o.pumheight       = 7                           -- Popup menu height
vim.o.mouse           = 'n'                         -- Allow mouse interaction in normal mode
vim.o.signcolumn      = 'yes'                       -- Show signcolums
vim.wo.cursorline     = true                        -- Show cursorline
vim.o.foldmethod      = 'manual'                    -- Less laggy than syntax mode
vim.o.gdefault        = true                        -- Sets g flag on all substitutions by default
vim.o.incsearch       = true                        -- Incremental smart case highlight search
vim.o.ignorecase      = true                        -- Ignore case in search patterns (needed for smartcase)
vim.o.smartcase       = true                        -- Case-sensitive search if the search pattern contains uppercase letters
vim.o.inccommand      = 'split'                     -- Live substitution command
vim.o.clipboard       = 'unnamedplus'               -- To what register you yank to
scrolloff             = vim.fn.float2nr(0.15 * vim.fn.winheight(0))
vim.o.scrolloff       = scrolloff                   -- Top/bottom lines of margins
vim.o.wildignorecase  = true                        -- Greedy command line completion
vim.o.tabstop         = 4                           -- 4 whitespaces for <Tab>
vim.o.shiftwidth      = 4                           -- 4 whitespaces for (auto)indent
vim.o.expandtab       = true                        -- expands all tabs to tabstop whitespaces
vim.o.smartindent     = true                        -- Better autoindent
vim.o.laststatus      = 2                           -- Always show status bar
statusline            = [[\ %f\ %y\ %r\ %m%=Column:\ %c\ \ \|\ \ %P\ \ ]]
vim.o.statusline      = statusline                  -- Define status line
vim.o.ttimeoutlen     = 0                           -- Time waited for key codes

vim.cmd('autocmd InsertEnter * set timeoutlen=200') -- Time waited for mappings in insert mode
vim.cmd('autocmd InsertLeave * set timeoutlen=600') -- Time waited for mappings

-- To always have vertical splits in TermDebugger
vim.g.termdebug_wide = 1

-- Set python3 bin path
-- if g:os == "Darwin"
--     let g:python3_host_prog='$HOME/miniconda3/envs/neovim/bin/python'
-- endif
vim.g.python3_host_prog = '/usr/bin/python'
vim.g.mapleader       = ' '                         -- Set leader key
vim.b.maplocalleader  = ','                         -- Set local leader key
vim.g.vimsyn_embed    = 'l'                         -- Lua syntax highlighting inside vimscript
