local mappings = require("mappings")

vim.g.vimtex_compiler_progname = 'nvr'
vim.g.tex_flavor = 'latex'
vim.g.tex_conceal=""
vim.g.vimtex_view_method = 'zathura'
vim.g.vimtex_syntax_enabled = 0
vim.g.vimtex_syntax_conceal_disable = 1
vim.g.vimtex_compiler_latexmk = {
  background = 1,
  build_dir = 'build',
  callback = 1,
  continuous = 0,
  executable = 'latexmk',
  hooks = {},
  options = {
    '-verbose',
    '-file-line-error',
    '-synctex=1',
    '-interaction=nonstopmode'
  }
}
vim.g.vimtex_quickfix_ignore_filters = {
  'LaTeX hooks'
}

local normal_mode_maps = {
  ['<leader>lc'] = ':w<CR>:VimtexCompile<CR>',
  ['<leader>lt'] = ':VimtexToggleMain<CR>',
  ['<leader>lr'] = ':VimtexReload<CR>',
  ['<leader>lk'] = ':VimtexStop<CR>',
}

for keymap, value in pairs(normal_mode_maps) do
  mappings.nmap(keymap, value)
end

-- " Prevents detecting 'latex' files as 'plain tex' files
-- let g:vimtex_compiler_progname = 'nvr'
-- let g:tex_flavor = 'latex'
-- let g:tex_conceal=""
-- let g:vimtex_compiler_latexmk = {
--     \ 'background' : 1,
--     \ 'build_dir' : 'build',
--     \ 'callback' : 1,
--     \ 'continuous' : 0,
--     \ 'executable' : 'latexmk',
--     \ 'hooks' : [],
--     \ 'options' : [
--     \   '-verbose',
--     \   '-file-line-error',
--     \   '-synctex=1',
--     \   '-interaction=nonstopmode',
--     \ ],
--     \}
--     " Disable overfull/underfull \hbox and all package warnings
--     " let g:vimtex_quickfix_latexlog = {
--         "             \ 'packages' : {
--             "             \   'default' : 0,
--             "             \ },
--             "             \}
--             let g:vimtex_view_method = 'zathura'
--             let g:vimtex_grammar_textidote = {
--                 "            \ 'jar': '/opt/textidote/textidote.jar',
--                 "            \ 'args': '',
--                 "            \}
