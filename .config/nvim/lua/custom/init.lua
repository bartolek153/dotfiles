local opt = vim.opt
local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })

autocmd("BufEnter", {
  pattern = {"*.cpp"},
  command = "nnoremap <silent> <leader>gc :!g++ -Wall % && ./a.out<cr>"
})

opt.wrap = false
