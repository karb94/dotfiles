local get_dropdown_theme = function()
  local theme_opts = {
    prompt = " ",
    previewer = false,
    layout_config = { width = 0.5, height = 15 },
  }
  return require("telescope.themes").get_dropdown(theme_opts)
end

local find_files = function()
  require("telescope.builtin").find_files(get_dropdown_theme())
end

local find_nvim_files = function()
  local nvim_path = vim.env.HOME .. "/.config/nvim/lua"
  local dropdown_theme = get_dropdown_theme()
  dropdown_theme.cwd = nvim_path
  require("telescope.builtin").find_files(dropdown_theme)
end

local find_git_files = function()
  vim.fn.system('git rev-parse --is-inside-work-tree')
  if vim.v.shell_error == 0 then
    require("telescope.builtin").git_files(get_dropdown_theme())
  else
    -- Revert to find_files() if not in git directory
    require"telescope.builtin".find_files(get_dropdown_theme())
  end
end

return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  dependencies = {
  "nvim-lua/plenary.nvim",
  {'nvim-telescope/telescope-fzf-native.nvim', build = 'make'}
  },
  opts = {
    defaults = {
      mappings = {
        i = {
          ["<Esc>"] = function(...) require("telescope.actions").close(...) end,
          ["<C-j>"] = function(...) require("telescope.actions").move_selection_next(...) end,
          ["<C-k>"] = function(...) require("telescope.actions").move_selection_previous(...) end,
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
    },
    extensions = {
      fzf = {
        fuzzy = true,                    -- false will only do exact matching
        override_generic_sorter = true,  -- override the generic sorter
        override_file_sorter = true,     -- override the file sorter
        case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
        -- the default case_mode is "smart_case"
      }
    }
  },
  config = function(_, opts)
    require('telescope').setup(opts)
    require('telescope').load_extension('fzf')
  end,
  keys = {
    {"<leader>ff", find_files, desc = "Switch files"},
    {"<leader>fl", find_nvim_files, desc = "Switch files"},
    {"<leader>fg", find_git_files},
    {"<leader>b", [[<cmd>Telescope buffers<CR>]]},
    {"<leader>fH", [[<cmd>Telescope help_tags<CR>]]},
    {"<leader>fh", [[<cmd>Telescope command_history<CR>]]},
    {"<leader>G", [[<cmd>Telescope live_grep<CR>]]},
  }
}
