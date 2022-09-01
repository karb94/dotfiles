-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/carles/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/carles/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/carles/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/carles/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/carles/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  LuaSnip = {
    loaded = true,
    path = "/home/carles/.local/share/nvim/site/pack/packer/start/LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/home/carles/.local/share/nvim/site/pack/packer/start/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/home/carles/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-nvim-lua"] = {
    loaded = true,
    path = "/home/carles/.local/share/nvim/site/pack/packer/start/cmp-nvim-lua",
    url = "https://github.com/hrsh7th/cmp-nvim-lua"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/home/carles/.local/share/nvim/site/pack/packer/start/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  cmp_luasnip = {
    loaded = true,
    path = "/home/carles/.local/share/nvim/site/pack/packer/start/cmp_luasnip",
    url = "https://github.com/saadparwaiz1/cmp_luasnip"
  },
  ["gitsigns.nvim"] = {
    config = { "require('plugins/gitsigns')" },
    loaded = true,
    path = "/home/carles/.local/share/nvim/site/pack/packer/start/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  ["gruvbox.nvim"] = {
    config = { "require('plugins/gruvbox')" },
    loaded = true,
    path = "/home/carles/.local/share/nvim/site/pack/packer/start/gruvbox.nvim",
    url = "https://github.com/karb94/gruvbox.nvim"
  },
  ["impatient.nvim"] = {
    loaded = true,
    path = "/home/carles/.local/share/nvim/site/pack/packer/start/impatient.nvim",
    url = "https://github.com/lewis6991/impatient.nvim"
  },
  ["indent-blankline.nvim"] = {
    config = { "require('plugins/indent-blankline')" },
    loaded = true,
    path = "/home/carles/.local/share/nvim/site/pack/packer/start/indent-blankline.nvim",
    url = "https://github.com/lukas-reineke/indent-blankline.nvim"
  },
  kommentary = {
    config = { "require('plugins/kommentary')" },
    loaded = true,
    path = "/home/carles/.local/share/nvim/site/pack/packer/start/kommentary",
    url = "https://github.com/b3nj5m1n/kommentary"
  },
  ["lua-dev.nvim"] = {
    config = { "require('plugins/lua-dev')" },
    loaded = true,
    path = "/home/carles/.local/share/nvim/site/pack/packer/start/lua-dev.nvim",
    url = "https://github.com/folke/lua-dev.nvim"
  },
  ["lush.nvim"] = {
    loaded = true,
    path = "/home/carles/.local/share/nvim/site/pack/packer/start/lush.nvim",
    url = "https://github.com/rktjmp/lush.nvim"
  },
  neoformat = {
    config = { "require('plugins/neoformat')" },
    loaded = true,
    path = "/home/carles/.local/share/nvim/site/pack/packer/start/neoformat",
    url = "https://github.com/sbdchd/neoformat"
  },
  neomake = {
    config = { "require('plugins/neomake')" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/carles/.local/share/nvim/site/pack/packer/opt/neomake",
    url = "https://github.com/neomake/neomake"
  },
  ["neoscroll.nvim"] = {
    config = { "require('plugins/neoscroll')" },
    loaded = true,
    path = "/home/carles/.local/share/nvim/site/pack/packer/start/neoscroll.nvim",
    url = "https://github.com/karb94/neoscroll.nvim"
  },
  ["nvim-cmp"] = {
    config = { "require('plugins/nvim-cmp')" },
    loaded = true,
    path = "/home/carles/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-colorizer.lua"] = {
    config = { "require('plugins/nvim-colorizer')" },
    loaded = true,
    path = "/home/carles/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua",
    url = "https://github.com/norcalli/nvim-colorizer.lua"
  },
  ["nvim-dap"] = {
    config = { "require('plugins/nvim-dap')" },
    loaded = true,
    path = "/home/carles/.local/share/nvim/site/pack/packer/start/nvim-dap",
    url = "https://github.com/mfussenegger/nvim-dap"
  },
  ["nvim-dap-ui"] = {
    config = { "require('plugins/nvim-dap-ui')" },
    loaded = true,
    path = "/home/carles/.local/share/nvim/site/pack/packer/start/nvim-dap-ui",
    url = "https://github.com/rcarriga/nvim-dap-ui"
  },
  ["nvim-dap-virtual-text"] = {
    config = { "require('plugins/nvim-dap-virtual-text')" },
    loaded = true,
    path = "/home/carles/.local/share/nvim/site/pack/packer/start/nvim-dap-virtual-text",
    url = "https://github.com/theHamsta/nvim-dap-virtual-text"
  },
  ["nvim-lspconfig"] = {
    config = { "require('plugins/nvim-lspconfig')" },
    loaded = true,
    path = "/home/carles/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-treesitter"] = {
    config = { "require('plugins/nvim-treesitter')" },
    loaded = true,
    path = "/home/carles/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/carles/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  playground = {
    config = { "require('plugins/playground')" },
    loaded = true,
    path = "/home/carles/.local/share/nvim/site/pack/packer/start/playground",
    url = "https://github.com/nvim-treesitter/playground"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/carles/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/home/carles/.local/share/nvim/site/pack/packer/start/popup.nvim",
    url = "https://github.com/nvim-lua/popup.nvim"
  },
  ["registers.nvim"] = {
    loaded = true,
    path = "/home/carles/.local/share/nvim/site/pack/packer/start/registers.nvim",
    url = "https://github.com/tversteeg/registers.nvim"
  },
  ["stabilize.nvim"] = {
    config = { "require('plugins/stabilize')" },
    loaded = true,
    path = "/home/carles/.local/share/nvim/site/pack/packer/start/stabilize.nvim",
    url = "https://github.com/luukvbaal/stabilize.nvim"
  },
  ["targets.vim"] = {
    loaded = true,
    path = "/home/carles/.local/share/nvim/site/pack/packer/start/targets.vim",
    url = "https://github.com/wellle/targets.vim"
  },
  ["telescope-fzf-native.nvim"] = {
    config = { "require('plugins/telescope-fzf-native')" },
    loaded = true,
    path = "/home/carles/.local/share/nvim/site/pack/packer/start/telescope-fzf-native.nvim",
    url = "https://github.com/nvim-telescope/telescope-fzf-native.nvim"
  },
  ["telescope-project.nvim"] = {
    config = { "require('plugins/telescope-project')" },
    loaded = true,
    path = "/home/carles/.local/share/nvim/site/pack/packer/start/telescope-project.nvim",
    url = "https://github.com/nvim-telescope/telescope-project.nvim"
  },
  ["telescope.nvim"] = {
    config = { "require('plugins/telescope')" },
    loaded = true,
    path = "/home/carles/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["toggleterm.nvim"] = {
    config = { "require('plugins/toggleterm')" },
    loaded = true,
    path = "/home/carles/.local/share/nvim/site/pack/packer/start/toggleterm.nvim",
    url = "https://github.com/akinsho/toggleterm.nvim"
  },
  ["vim-cool"] = {
    loaded = true,
    path = "/home/carles/.local/share/nvim/site/pack/packer/start/vim-cool",
    url = "https://github.com/romainl/vim-cool"
  },
  ["vim-easy-align"] = {
    config = { "require('plugins/vim-easy-align')" },
    loaded = true,
    path = "/home/carles/.local/share/nvim/site/pack/packer/start/vim-easy-align",
    url = "https://github.com/junegunn/vim-easy-align"
  },
  ["vim-python-pep8-indent"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/carles/.local/share/nvim/site/pack/packer/opt/vim-python-pep8-indent",
    url = "https://github.com/Vimjas/vim-python-pep8-indent"
  },
  ["vim-sandwich"] = {
    loaded = true,
    path = "/home/carles/.local/share/nvim/site/pack/packer/start/vim-sandwich",
    url = "https://github.com/machakann/vim-sandwich"
  },
  vimtex = {
    config = { "require('plugins/vimtex')" },
    loaded = true,
    path = "/home/carles/.local/share/nvim/site/pack/packer/start/vimtex",
    url = "https://github.com/lervag/vimtex"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: telescope-fzf-native.nvim
time([[Config for telescope-fzf-native.nvim]], true)
require('plugins/telescope-fzf-native')
time([[Config for telescope-fzf-native.nvim]], false)
-- Config for: vim-easy-align
time([[Config for vim-easy-align]], true)
require('plugins/vim-easy-align')
time([[Config for vim-easy-align]], false)
-- Config for: lua-dev.nvim
time([[Config for lua-dev.nvim]], true)
require('plugins/lua-dev')
time([[Config for lua-dev.nvim]], false)
-- Config for: nvim-lspconfig
time([[Config for nvim-lspconfig]], true)
require('plugins/nvim-lspconfig')
time([[Config for nvim-lspconfig]], false)
-- Config for: vimtex
time([[Config for vimtex]], true)
require('plugins/vimtex')
time([[Config for vimtex]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
require('plugins/telescope')
time([[Config for telescope.nvim]], false)
-- Config for: toggleterm.nvim
time([[Config for toggleterm.nvim]], true)
require('plugins/toggleterm')
time([[Config for toggleterm.nvim]], false)
-- Config for: nvim-dap
time([[Config for nvim-dap]], true)
require('plugins/nvim-dap')
time([[Config for nvim-dap]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
require('plugins/nvim-treesitter')
time([[Config for nvim-treesitter]], false)
-- Config for: kommentary
time([[Config for kommentary]], true)
require('plugins/kommentary')
time([[Config for kommentary]], false)
-- Config for: nvim-dap-virtual-text
time([[Config for nvim-dap-virtual-text]], true)
require('plugins/nvim-dap-virtual-text')
time([[Config for nvim-dap-virtual-text]], false)
-- Config for: neoscroll.nvim
time([[Config for neoscroll.nvim]], true)
require('plugins/neoscroll')
time([[Config for neoscroll.nvim]], false)
-- Config for: nvim-dap-ui
time([[Config for nvim-dap-ui]], true)
require('plugins/nvim-dap-ui')
time([[Config for nvim-dap-ui]], false)
-- Config for: playground
time([[Config for playground]], true)
require('plugins/playground')
time([[Config for playground]], false)
-- Config for: nvim-colorizer.lua
time([[Config for nvim-colorizer.lua]], true)
require('plugins/nvim-colorizer')
time([[Config for nvim-colorizer.lua]], false)
-- Config for: gitsigns.nvim
time([[Config for gitsigns.nvim]], true)
require('plugins/gitsigns')
time([[Config for gitsigns.nvim]], false)
-- Config for: neoformat
time([[Config for neoformat]], true)
require('plugins/neoformat')
time([[Config for neoformat]], false)
-- Config for: nvim-cmp
time([[Config for nvim-cmp]], true)
require('plugins/nvim-cmp')
time([[Config for nvim-cmp]], false)
-- Config for: gruvbox.nvim
time([[Config for gruvbox.nvim]], true)
require('plugins/gruvbox')
time([[Config for gruvbox.nvim]], false)
-- Config for: stabilize.nvim
time([[Config for stabilize.nvim]], true)
require('plugins/stabilize')
time([[Config for stabilize.nvim]], false)
-- Config for: indent-blankline.nvim
time([[Config for indent-blankline.nvim]], true)
require('plugins/indent-blankline')
time([[Config for indent-blankline.nvim]], false)
-- Config for: telescope-project.nvim
time([[Config for telescope-project.nvim]], true)
require('plugins/telescope-project')
time([[Config for telescope-project.nvim]], false)
vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType py ++once lua require("packer.load")({'vim-python-pep8-indent'}, { ft = "py" }, _G.packer_plugins)]]
vim.cmd [[au FileType cpp ++once lua require("packer.load")({'neomake'}, { ft = "cpp" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
