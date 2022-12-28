local import = function(file)
  require("plugins.completion." .. file)
end

import("lspkind")
import("autopairs")
import("cmp")
import("tabout")

vim.cmd [[
  set completeopt=menuone,noinsert,noselect
  highlight! default link CmpItemKind CmpItemMenuDefault
]]
