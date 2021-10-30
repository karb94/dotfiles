-- INSTALL PACKER IF NOT PRESENT
local function file_exists(path)
	return vim.fn.empty(vim.fn.glob(path)) == 0
end
local install_path = ".local/share/nvim/site/pack/packer/start/packer.nvim"
local abs_install_path = vim.env.HOME .. "/" .. install_path
local repo = "https://github.com/wbthomason/packer.nvim"
local git_clone_cmd = "!git clone " .. repo .. " " .. abs_install_path
-- If Packer directory does not exist clone repo and initialize Packer
if not file_exists(abs_install_path) then
	vim.api.nvim_command(git_clone_cmd)
	vim.api.nvim_command("packadd packer.nvim")
end

-- PLUGINS
return require("packer").startup(function()
	local plugins = {
		{ "wbthomason/packer.nvim" },
		{ "lukas-reineke/indent-blankline.nvim" },
		{ "~/projects/neoscroll.nvim" },
		-- {'karb94/neoscroll.nvim'},
		{ "machakann/vim-sandwich" },
		{ "b3nj5m1n/kommentary" },
		-- { "TimUntersberger/neogit", requires = "nvim-lua/plenary.nvim" },
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
    { "akinsho/toggleterm.nvim" },
    { "nvim-lua/plenary.nvim" },
    -- Autocompletion
    { "hrsh7th/nvim-cmp" },
    { "hrsh7th/cmp-buffer", requires = "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-nvim-lsp", requires = "hrsh7th/cmp-buffer"  },
    { "hrsh7th/cmp-nvim-lua", requires = "hrsh7th/cmp-buffer"  },
    { "hrsh7th/cmp-path", requires = "hrsh7th/cmp-buffer"  },
		-- LSP
		{ "neovim/nvim-lspconfig" },
    { "folke/lua-dev.nvim"},
		-- { "glepnir/lspsaga.nvim", requires = "neovim/nvim-lspconfig" },
		-- { "ray-x/lsp_signature.nvim", requires =
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
end)
