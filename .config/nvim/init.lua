-- Configs
--
require("user.base")
require("user.maps")
require("user.plugins")



-- Transparent Background
--
vim.cmd [[

highlight Normal guibg=NONE ctermbg=NONE
highlight EndOfBuffer guibg=NONE ctermbg=NONE

]]
