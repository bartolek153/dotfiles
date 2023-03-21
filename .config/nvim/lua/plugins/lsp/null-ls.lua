local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then return end


local augroup = vim.api.nvim_create_augroup("LspFormatting", {})


local lsp_formatting = function(bufnr)
  vim.lsp.buf.format({
    filter = function(client)
      return client.name == "null-ls"
    end,
    bufnr = bufnr,
  })
end

vim.api.nvim_create_user_command('DisableFormatOnSave',
  function()
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = 0 })
  end,
  { nargs = 0 }
)






local with_diagnostics_code = function(builtin)
  return builtin.with {
    diagnostics_format = "#{m} [#{c}]"
  }
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics





null_ls.setup {
  sources = {
    -- .py
    -- with_diagnostics_code(null_ls.builtins.diagnostics.pylint), -- pip install pylint
    -- formatting.isort, -- pip install isort
    formatting.black, -- pip install black

    -- .js
    -- formatting.prettierd,
    -- with_diagnostics_code(diagnostics.eslint_d)

    -- .json
    formatting.fixjson,
  },

  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          lsp_formatting(bufnr)
        end,
      })
    end
  end
}
