local nvim_lsp = require("lspconfig")

local M = {}

M.on_attach = function(client, bufnr)
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	local lsp_nmap = function(key, lsp_func)
		local func = "<cmd>lua vim.lsp." .. lsp_func .. "<CR>"
		local opts = { noremap = true, silent = true }
		vim.api.nvim_buf_set_keymap(bufnr, "n", key, func, opts)
	end

	-- Mappings.
	lsp_nmap("gD", "buf.declaration()")
	lsp_nmap("gd", "buf.definition()")
	lsp_nmap("gs", "buf.signature_help()")
	lsp_nmap("<leader>e", "diagnostic.show_line_diagnostics()")
	lsp_nmap("[d", "diagnostic.goto_prev()")
	lsp_nmap("]d", "diagnostic.goto_next()")
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
