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


--Custom finder
    -- local gen_new_finder = function(path)
    --     local path = vim.fn.getenv('HOME') .. '/.config/nvim/lua'
    --     local data = {}

    --     scan.scan_dir(path, {
    --         hidden = opts.hidden or false,
    --         add_dirs = true,
    --         depth = 1,
    --         on_insert = function(entry, typ)
    --             table.insert(data, typ == 'directory' and (entry .. os_sep) or entry)
    --         end
    --     })
    --     table.insert(data, 1, '../')

    --     return finders.new_table {
    --         results = data,
    --         entry_maker = (function()
    --             local tele_path = require'telescope.path'
    --             local gen = make_entry.gen_from_file(opts)
    --             return function(entry)
    --                 local tmp = gen(entry)
    --                 tmp.ordinal = tele_path.make_relative(entry, opts.cwd)
    --                 return tmp
    --             end
    --         end)()
    --     }
    -- end


-- Themes
local center_list = require('telescope.themes').get_dropdown({
    winblend = 10,
    width = 0.5,
    prompt = " ",
    results_height = 15,
    previewer = false
})
function telescope_config.find_nvim_files()
    local opts = vim.deepcopy(center_list)
    local path = vim.fn.getenv('HOME') .. '/.config/nvim/lua'
    opts.search_dirs = {path}
    require('telescope.builtin').find_files(opts)
end
function telescope_config.find_files()
    local opts = vim.deepcopy(center_list)
    require('telescope.builtin').find_files(opts)
end
function telescope_config.find_git_files()
    local opts = vim.deepcopy(center_list)
    require('telescope.builtin').git_files(opts)
end
function telescope_config.find_buffers()
    local opts = vim.deepcopy(center_list)
    require('telescope.builtin').buffers(opts)
end

-- Mappings
local map = function(mode, keymap, command, opts)
    opts = opts or { noremap = true, silent = true }
    vim.api.nvim_set_keymap(mode, keymap, command, opts)
end

map('n', '<leader>ff', [[:lua require('plugins/telescope').find_files()<CR>]])
map('n', '<leader>fv', [[:lua require('plugins/telescope').find_nvim_files()<CR>]])
map('n', '<leader>fg', [[:lua require('plugins/telescope').find_git_files()<CR>]])
map('n', '<leader>fG', [[:lua require('telescope.builtin').grep_string{}<CR>]])
map('n', '<leader>b', [[:lua require('plugins/telescope').find_buffers()<CR>]])
-- vim.api.nvim_set_keymap('n', '<leader>ff', [[:lua require('telescope.builtin').find_files{}<CR>]], {noremap=true})

return telescope_config
