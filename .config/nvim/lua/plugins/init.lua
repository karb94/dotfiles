-- INSTALL PACKER IF NOT PRESENT
local function file_exists(path)
    return vim.fn.empty(vim.fn.glob(path)) == 0
end
local install_path = '.local/share/nvim/site/pack/packer/start/packer.nvim'
local home_dir = os.getenv('HOME')
local abs_install_path = home_dir ..  '/' .. install_path
local repo = 'https://github.com/wbthomason/packer.nvim'
local git_clone_cmd = '!git clone ' .. repo .. ' ' .. abs_install_path
-- If Packer directory does not exist clone repo and initialize Packer
if not file_exists(abs_install_path) then
    vim.api.nvim_command(git_clone_cmd)
    vim.api.nvim_command('packadd packer.nvim')
end


-- PLUGINS
return require('packer').startup(function()

    local plugins = {
        {'wbthomason/packer.nvim'},
        {'lukas-reineke/indent-blankline.nvim', branch='lua'},
        {'~/projects/neoscroll.nvim'},
        {'machakann/vim-highlightedyank'},
        {'machakann/vim-sandwich'},
        {'tpope/vim-commentary'},
        {'tpope/vim-fugitive'},
        {'norcalli/nvim-colorizer.lua'},
        {'wellle/targets.vim'},
        {'romainl/vim-cool'},
        {'Vimjas/vim-python-pep8-indent', ft={'py'}},
        {'neomake/neomake', ft={'cpp'}},
        {'junegunn/vim-easy-align'},
        {'lervag/vimtex'},
        {'karb94/gruvbox.nvim', requires='rktjmp/lush.nvim'},
        {'neovim/nvim-lspconfig', ft={'py', 'cpp', 'sh', 'tex'}},
        {'nvim-treesitter/nvim-treesitter', run=':TSUpdate'},
        {'nvim-treesitter/playground'},
        {'hrsh7th/nvim-compe'},
        {'nvim-telescope/telescope.nvim',
            requires={'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim'},
        }
    }

    local lua_dir = home_dir .. '/.config/nvim/lua/'
    for _, plugin in ipairs(plugins) do
        local plugin_repo = plugin[1]
        local plugin_name = plugin_repo:gmatch('[/^]([^/%.]+)[^/]*$')()
        local plugin_config_name = 'plugins/' .. plugin_name
        local plugin_config_path = lua_dir .. plugin_config_name .. '.lua'
        if file_exists(plugin_config_path) then
            plugin.config = [[require(']] .. plugin_config_name .. [[')]]
        end
        use(plugin)
    end

end)
