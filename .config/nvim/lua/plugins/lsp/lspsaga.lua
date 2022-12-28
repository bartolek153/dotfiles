local status_ok, saga = pcall(require, "lspsaga")
if not status_ok then return end

saga.setup({
  ui = {
    border = 'rounded',
    colors = {
      normal_bg = '#21222C'
    }
  },
  lightbulb = { enable = false, },
  request_timeout = 2000,
  diagnostic = {
    on_insert = false,
    on_insert_follow = false,
    show_code_action = false,
  },
  rename = { quit = "q", },
})

local opts = { noremap = true, silent = true }

vim.keymap.set('n', 'gf', '<Cmd>Lspsaga lsp_finder<CR>', opts)
vim.keymap.set('n', 'gca', '<Cmd>Lspsaga code_action<CR>', opts)
vim.keymap.set('n', 'gr', '<Cmd>Lspsaga rename<CR>', opts)
vim.keymap.set('n', 'gp', '<Cmd>Lspsaga peek_definition<CR>', opts)

vim.keymap.set('n', 'gl', "<Cmd>Lspsaga show_line_diagnostics<CR>", opts)
