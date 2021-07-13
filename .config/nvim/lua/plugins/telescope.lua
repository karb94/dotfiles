local telescope_config = {}

local telescope = require("telescope")
local actions = require("telescope.actions")
local themes = require("telescope.themes")
local builtin_pickers = require("telescope.builtin")

-- Default global config
local defaults = {
	mappings = {
		i = {
			["<Esc>"] = actions.close,
			["<C-j>"] = actions.move_selection_next,
			["<C-k>"] = actions.move_selection_previous,
		},
	},
	initial_mode = "insert",
	selection_strategy = "reset",
	layout_strategy = "horizontal",
	layout_config = {
		horizontal = {
			mirror = false,
		},
		vertical = {
			mirror = true,
		},
	},
}

telescope.setup({ defaults = defaults })

-- Mappings
local map = function(mode, keymap, command, opts)
	opts = opts or { noremap = true, silent = true }
	vim.api.nvim_set_keymap(mode, keymap, command, opts)
end

local theme_opts = {
	prompt = " ",
	previewer = false,
	layout_config = { width = 0.5, height = 15 },
}

local dropdown_theme = themes.get_dropdown(theme_opts)

function telescope_config.find_files()
	builtin_pickers.find_files(dropdown_theme)
end

function telescope_config.find_nvim_files()
	local nvim_path = vim.env.HOME .. "/.config/nvim/lua"
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

map("n", "<leader>ff", [[:lua require('plugins/telescope').find_files()<CR>]])
map("n", "<leader>fl", [[:lua require('plugins/telescope').find_nvim_files()<CR>]])
map("n", "<leader>fg", [[:lua require('plugins/telescope').find_git_files()<CR>]])
map("n", "<leader>b", [[:Telescope buffers<CR>]])
map("n", "<leader>fH", [[:Telescope help_tags<CR>]])
map("n", "<leader>fh", [[:Telescope command_history<CR>]])
map("n", "<leader>G", [[:Telescope live_grep<CR>]])

return telescope_config
