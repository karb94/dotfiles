local nvim_lsp = require("lspconfig")

local M = {}

M.on_attach = function(client, bufnr)
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	local lsp_nmap = function(key, lsp_func)
		local func = "<cmd>lua vim.lsp.buf." .. lsp_func .. "<CR>"
		local opts = { noremap = true, silent = true }
		vim.api.nvim_buf_set_keymap(bufnr, "n", key, func, opts)
	end

	-- Mappings.
	lsp_nmap("gD", "declaration()")
	lsp_nmap("gd", "definition()")
  lsp_nmap("gm", "implementation()")
	lsp_nmap("gs", "signature_help()")
end

local servers = {
	"pyright",
	"clangd",
	"bashls",
	"texlab",
	"vimls",
}


for _, lsp in ipairs(servers) do
	nvim_lsp[lsp].setup({
		on_attach = M.on_attach,
		flags = {
			debounce_text_changes = 150,
		},
	})
end

return M
