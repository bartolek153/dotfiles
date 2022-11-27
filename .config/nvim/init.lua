-- Windows specific configs
--
-- local has = function(x)
--   return vim.fn.has(x) == 1
-- end

-- local is_win = has "win32"

-- if is_win then
-- require("user.windows")
-- end



-- Faster startups
--
require('impatient')
vim.g.did_load_filetypes = 1



-- Configs
--
require("user.base")
require("user.maps")
require("user.plugins")



-- Colorscheme
--
require("user.colorscheme")
-- vim.cmd [[colorscheme habamax]] -- Temporary purposes



-- Transparent Background
--
vim.cmd [[

highlight Normal guibg=NONE ctermbg=NONE
highlight EndOfBuffer guibg=NONE ctermbg=NONE

]]
