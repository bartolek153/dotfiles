local colorscheme = 'dracula'

vim.opt.background = 'dark'

-- Colors
vim.cmd [[ set termguicolors ]]

local status_ok = pcall(require, "user.themes." .. colorscheme)
if not status_ok then
  vim.notify("Colorscheme error")
end
