local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  vim.notify("LSP Config Error")
end

require("user.lsp.configs")
require("user.lsp.handlers").setup()
require("user.lsp.lspsaga")
require("user.lsp.illuminate")
-- require("user.lsp.nullls")

vim.cmd [[LspToggleAutoFormat]]
