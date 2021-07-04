local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local action_set = require('telescope.actions.set')
local finders = require('telescope.finders')
local make_entry = require('telescope.make_entry')
local pickers = require('telescope.pickers')
local previewers = require('telescope.previewers')
local utils = require('telescope.utils')
local conf = require('telescope.config').values

local scan = require('plenary.scandir')
local Path = require('plenary.path')
local os_sep = Path.path.sep

local flatten = vim.tbl_flatten
local filter = vim.tbl_filter

local function prepare_match(entry, kind)
    local entries = {}

    if entry.node then
        entry["kind"] = kind
        table.insert(entries, entry)
    else
        for name, item in pairs(entry) do
            vim.list_extend(entries, prepare_match(item, name))
        end
    end

    return entries
end

M = {}

M.treesitter = function(opts)
    opts.show_line = utils.get_default(opts.show_line, true)

    local has_nvim_treesitter, _ = pcall(require, 'nvim-treesitter')
    if not has_nvim_treesitter then
        print('You need to install nvim-treesitter')
        return
    end

    local parsers = require('nvim-treesitter.parsers')
    if not parsers.has_parser() then
        print('No parser for the current buffer')
        return
    end

    local ts_locals = require('nvim-treesitter.locals')
    local bufnr = opts.bufnr or vim.api.nvim_get_current_buf()

    local results = {}
    for _, definitions in ipairs(ts_locals.get_definitions(bufnr)) do
        local entries = prepare_match(definitions)
        for _, entry in ipairs(entries) do
            if entry.kind == 'method' then
                table.insert(results, entry)
            end
        end
    end

    if vim.tbl_isempty(results) then
        return
    end

    pickers.new(opts, {
        prompt_title = 'Treesitter Symbols',
        finder    = finders.new_table {
            results = results,
            entry_maker = opts.entry_maker or make_entry.gen_from_treesitter(opts)
        },
        previewer = conf.grep_previewer(opts),
        sorter = conf.prefilter_sorter{
            tag = "kind",
            sorter = conf.generic_sorter(opts)
        }
    }):find()
end

return M
