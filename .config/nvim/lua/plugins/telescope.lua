local telescope_config= {}

local actions = require('telescope.actions')

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
    layout_strategy = "vertical",
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
    border = {},
    borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
    color_devicons = true,
    use_less = true,
    set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
    file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new
}

require('telescope').setup({defaults=defaults})

-- Themes
-- local center_list = require('telescope.themes').get_dropdown({
-- })



local opts = {
    winblend = 10,
    width = 0.5,
    prompt = " ",
    results_height = 15,
    previewer = false
}
telescope_config.find_files = function()
    local center_list = require('telescope.themes').get_dropdown(opts)
    require('telescope.builtin').find_files(center_list)
end
telescope_config.find_git_files = function()
    local center_list = require('telescope.themes').get_dropdown(opts)
    require('telescope.builtin').git_files(center_list)
end
telescope_config.find_buffers = function()
    local center_list = require('telescope.themes').get_dropdown(opts)
    require('telescope.builtin').buffers(center_list)
end

-- Mappings
local map = function(mode, keymap, command, opts)
    opts = opts or { noremap = true, silent = true }
    vim.api.nvim_set_keymap(mode, keymap, command, opts)
end

map('n', '<leader>ff', [[:lua require('plugins/telescope').find_files()<CR>]])
map('n', '<leader>fg', [[:lua require('plugins/telescope').find_git_files()<CR>]])
map('n', '<leader>fG', [[:lua require('telescope.builtin').grep_string{}<CR>]])
map('n', '<leader>b', [[:lua require('plugins/telescope').find_buffers()<CR>]])
-- vim.api.nvim_set_keymap('n', '<leader>ff', [[:lua require('telescope.builtin').find_files{}<CR>]], {noremap=true})

return telescope_config
