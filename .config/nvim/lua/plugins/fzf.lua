local get_dropdown_opts = function()
  return {
    prompt = " ",
    previewer = false,
    winopts = {
      width = 0.5,
      height = 15,
    },
  }
end

local find_files = function()
  require("fzf-lua").files(get_dropdown_opts())
end

local find_nvim_files = function()
  local nvim_path = vim.env.HOME .. "/.config/nvim/lua"
  local opts = get_dropdown_opts()
  opts.cwd = nvim_path
  require("fzf-lua").files(opts)
end

local find_git_files = function()
  vim.fn.system("git rev-parse --is-inside-work-tree")
  if vim.v.shell_error == 0 then
    require("fzf-lua").git_files(get_dropdown_opts())
  else
    require("fzf-lua").files(get_dropdown_opts())
  end
end

return {
  "ibhagwan/fzf-lua",
  cmd = "FzfLua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  -- dependencies = {
  --   { "junegunn/fzf", run = "./install --bin" },
  -- },
  -- opts = {
  --   defaults = {
  --     fzf_opts = {
  --       ["--layout"] = "default",
  --     },
  --     winopts = {
  --       preview = {
  --         default = "bat",
  --       },
  --     },
  --   },
  --   buffers = {
  --     actions = {
  --       ["ctrl-r"] = {
  --         -- fn = require("fzf-lua").actions.buf_del,
  --         desc = "delete buffer",
  --       },
  --     },
  --   },
  -- },
  -- config = function(_, opts)
  --   require("fzf-lua").setup(opts)
  -- end,
  config = true,
  keys = {
    { "<leader>ff", find_files, desc = "Switch files" },
    { "<leader>fl", find_nvim_files, desc = "Switch files" },
    { "<leader>fg", find_git_files },
    { "<leader>b", [[<cmd>FzfLua buffers<CR>]] },
    { "<leader>fh", [[<cmd>FzfLua help_tags<CR>]] },
    { "<leader>fH", [[<cmd>FzfLua command_history<CR>]] },
    { "<leader>fG", [[<cmd>FzfLua live_grep<CR>]] },
    { "<leader>fs", [[<cmd>FzfLua lsp_document_symbols<CR>]] },
  },
}
