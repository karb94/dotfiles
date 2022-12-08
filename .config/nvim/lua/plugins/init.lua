-- INSTALL PACKER IF NOT PRESENT
local function file_exists(path)
	return vim.fn.empty(vim.fn.glob(path)) == 0
end

local packer_bootstrap = false
local packer_install_dir = "/site/pack/packer/start/packer.nvim"
local abs_install_path = vim.fn.stdpath('data') .. packer_install_dir
-- If Packer directory does not exist clone repo and initialize Packer
if not file_exists(abs_install_path) then
  local repo = "https://github.com/wbthomason/packer.nvim"
  local git_clone_cmd = {
    "git",
    "clone",
    "--depth",
    "1",
    repo,
    abs_install_path
  }
	vim.cmd(git_clone_cmd)
	vim.api.nvim_command("packadd packer.nvim")
  packer_bootstrap = true
end

-- PLUGINS
return require("packer").startup(function()
	local plugins = {
    { "wbthomason/packer.nvim" },
    { "lewis6991/impatient.nvim" },
    { "nvim-lua/plenary.nvim" },
    { "luukvbaal/stabilize.nvim" },
    { "tversteeg/registers.nvim" },
		{ "lukas-reineke/indent-blankline.nvim" },
		-- { "~/projects/neoscroll.nvim" },
		{ "karb94/neoscroll.nvim" },
		{ "kylechui/nvim-surround" },
		{ "b3nj5m1n/kommentary" },
		{ "TimUntersberger/neogit", requires = "nvim-lua/plenary.nvim" },
		{ "lewis6991/gitsigns.nvim", requires = "nvim-lua/plenary.nvim" },
		{ "norcalli/nvim-colorizer.lua" },
		{ "sbdchd/neoformat" },
		{ "wellle/targets.vim" },
		{ "romainl/vim-cool" },
		{ "Vimjas/vim-python-pep8-indent", ft = { "py" } },
		{ "neomake/neomake", ft = { "cpp" } },
		{ "junegunn/vim-easy-align" },
    { "lervag/vimtex"},--, ft = { "tex", "bib" } },
		{ "karb94/gruvbox.nvim", requires = "rktjmp/lush.nvim" },
		{ "mfussenegger/nvim-dap" },
    { "theHamsta/nvim-dap-virtual-text", requires = "mfussenegger/nvim-dap" },
    { "rcarriga/nvim-dap-ui", requires = "mfussenegger/nvim-dap" },
    { "akinsho/toggleterm.nvim" },
    -- Autocompletion
    { "hrsh7th/nvim-cmp" },
    { "hrsh7th/cmp-buffer"},
    { "hrsh7th/cmp-nvim-lsp"},
    { "hrsh7th/cmp-nvim-lua"},
    { "hrsh7th/cmp-path"},
    { "saadparwaiz1/cmp_luasnip"},
    
		-- LSP
		{ "neovim/nvim-lspconfig" },
    { "folke/neodev.nvim", requires = "neovim/nvim-lspconfig"},
		{ "glepnir/lspsaga.nvim", requires = "neovim/nvim-lspconfig" },
		{ "L3MON4D3/LuaSnip", requires = "neovim/nvim-lspconfig" },
		-- Treesitter
		{ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" },
		{ "nvim-treesitter/playground", requires = "nvim-treesitter/nvim-treesitter" },
		-- { "nvim-treesitter/nvim-treesitter-textobjects", requires = "nvim-treesitter/nvim-treesitter" },
		-- Telescope
		{ "nvim-telescope/telescope.nvim", requires = { "nvim-lua/popup.nvim", "nvim-lua/plenary.nvim" } },
    { "nvim-telescope/telescope-project.nvim", requires = { "nvim-telescope/telescope.nvim" } },
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			requires = { "nvim-telescope/telescope.nvim" },
			run = "make",
		},
	}

	local lua_dir = vim.env.HOME .. "/.config/nvim/lua/"
	for _, plugin in ipairs(plugins) do
		local plugin_repo = plugin[1]
		if plugin.config == nil then
			local filename = plugin_repo:gmatch("[/^]([^/%.]+)[^/]*$")()
			local plugins_folder = "plugins/"
			local config_abs_path = table.concat({
				lua_dir,
				plugins_folder,
				filename,
				".lua",
			})
			if file_exists(config_abs_path) then
				plugin.config = table.concat({
					"require('",
					plugins_folder,
					filename,
					"')",
				})
			end
		end
    use(plugin)
	end

  -- Automatically set up config
  if packer_bootstrap then
    require('packer').sync()
  end
end)
-- /home/carles/.local/share/nvim/site/pack/packer/start/vimtex
