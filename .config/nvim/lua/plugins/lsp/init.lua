local import = function(file)
  require("plugins.lsp." .. file)
end

require "fidget".setup()

import("lspconfig")
import("mason")
import("lspsaga")
import("null-ls")
import("trouble")
