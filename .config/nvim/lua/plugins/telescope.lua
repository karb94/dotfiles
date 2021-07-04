local telescope_config= {}

local telescope = require('telescope')
local actions = require('telescope.actions')
local themes = require('telescope.themes')
local builtin_pickers = require('telescope.builtin')

-- Default global config
local defaults = {
    mappings = {
        i = {
            ["<Esc>"] = actions.close,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous
        },
    },
    vimgrep_arguments = {
        'rg',
        '--color=never',
        '--no-heading',
        '--with-filename',
        '--line-number',
        '--column',
        '--smart-case'
    },
    prompt_position = "bottom",
    prompt_prefix = "> ",
    selection_caret = "> ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "descending",
    layout_strategy = "horizontal",
    layout_defaults = {
        horizontal = {
            mirror = false,
        },
        vertical = {
            mirror = true,
        },
    },
    file_sorter =  require'telescope.sorters'.get_fuzzy_file,
    file_ignore_patterns = {},
    generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
    shorten_path = true,
    winblend = 0,
    width = 0.75,
    preview_cutoff = 120,
    results_height = 1,
    results_width = 0.8,
    color_devicons = true,
    use_less = true,
    set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
    file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new
}

telescope.setup({defaults = defaults})

-- Mappings
local map = function(mode, keymap, command, opts)
    opts = opts or { noremap = true, silent = true }
    vim.api.nvim_set_keymap(mode, keymap, command, opts)
end

theme_opts = {
    winblend = 10,
    width = 0.5,
    prompt = " ",
    results_height = 15,
    previewer = false
}

local theme_opts = {
    winblend = 10,
    width = 0.5,
    prompt = " ",
    results_height = 15,
    previewer = false
}

local dropdown_theme = themes.get_dropdown(theme_opts)

function telescope_config.find_files()
    builtin_pickers.find_files(dropdown_theme)
end

function telescope_config.find_nvim_files()
    local nvim_path = vim.env.HOME .. '/.config/nvim/lua'
    dropdown_theme.cwd = nvim_path
    builtin_pickers.find_files(dropdown_theme)
    dropdown_theme.cwd = nil
end

function telescope_config.find_git_files()
    builtin_pickers.git_files(dropdown_theme)
end

function telescope_config.find_buffers()
    builtin_pickers.buffers(dropdown_theme)
end

map('n', '<leader>ff', [[:lua require('plugins/telescope').find_files()<CR>]])
map('n', '<leader>fl', [[:lua require('plugins/telescope').find_nvim_files()<CR>]])
map('n', '<leader>fg', [[:lua require('plugins/telescope').find_git_files()<CR>]])
map('n', '<leader>b', [[:Telescope buffers<CR>]])
map('n', '<leader>fh', [[:Telescope help_tags<CR>]])
map('n', '<leader>h', [[:Telescope command_history<CR>]])
map('n', '<leader>G', [[:Telescope live_grep<CR>]])

return telescope_config
