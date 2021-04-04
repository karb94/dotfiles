local on_attach = function(client, bufnr)
    require('completion').on_attach()

    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    local lsp_set_map = function(mode, key, lsp_func)
        func = "<cmd>lua vim.lsp." .. lsp_func .. "<CR>"
        opts = {noremap = true, silent = true}
        vim.api.nvim_buf_set_keymap(0, mode, key, func, opts)
    end
    -- Mappings.
    lsp_set_map('n', 'gD', 'buf.declaration()')
    lsp_set_map('n', 'gd', 'buf.definition()')
    lsp_set_map('n', '<C-k>', 'buf.signature_help()')
    lsp_set_map('n', '<leader>e', 'diagnostic.show_line_diagnostics()')
    lsp_set_map('n', '[d', 'diagnostic.goto_prev()')
    lsp_set_map('n', ']d', 'diagnostic.goto_next()')
    -- buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    -- buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    --buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    --buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    -- buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    --buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    --buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    --buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    --buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    --buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    --buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    -- buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    -- buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    -- buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    --buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

    -- Set some keybinds conditional on server capabilities
    --if client.resolved_capabilities.document_formatting then
    --    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    --elseif client.resolved_capabilities.document_range_formatting then
    --    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
    --end

    -- Set autocommands conditional on server_capabilities
    -- if client.resolved_capabilities.document_highlight then
    --     vim.api.nvim_exec([[
    --     augroup lsp_document_highlight
    --     autocmd! * <buffer>
    --     autocmd CursorMoved <buffer> lua vim.lsp.buf.document_highlight()
    --     autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
    --     augroup END
    --     ]], false)
    -- end
end

-- Use a loop to conveniently both setup defined servers 
-- and map buffer local keybindings when the language server attaches
local lsp = require('lspconfig')
local language_servers = { "pyright", "clangd", "bashls", "texlab", "vimls" }
for _, language_server in ipairs(language_servers) do
    lsp[language_server].setup({ on_attach = on_attach })
end