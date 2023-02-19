local import = function(file)
  require("plugins.lsp." .. file)
end

require "fidget".setup()

import("lspconfig")
import("mason")
import("lspsaga")
import("null-ls")
import("trouble")


--[[

    To install new LSP's, follow these steps:

      1) Install the LSP with Mason (:Mason)
      2) Go to plugins/lsp/lspconfig.lua and set
         its setup function (+optional settings)
      3) If any, add linters, formatters, etc.,
         in plugins/lsp/null-ls.lua
]]
