local null_ls_status_ok, nullLS = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = nullLS.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = nullLS.builtins.diagnostics

local hover = nullLS.builtins.hover

local with_diagnostics_code = function(builtin)
  return builtin.with {
    diagnostics_format = "#{m} [#{c}]"
  }
end


-- https://github.com/prettier-solidity/prettier-plugin-solidity
-- npm install --save-dev prettier prettier-plugin-solidity
nullLS.setup {
  debug = false,
  save_after_format = false,
  sources = {

    -- Python
    -- with_diagnostics_code(diagnostics.flake8), -- pip install flake8
    with_diagnostics_code(diagnostics.pylint), -- pip install pylint
    formatting.black.with {
      -- pip install black
      extra_args = { "--fast" }
    },
    formatting.isort, -- pip install isort


    -- Lua
    -- formatting.stylua,
    -- diagnostics.selene,


    -- Web
    -- formatting.prettier.with {
    --     extra_filetypes = { "toml", "solidity" },
    --     extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
    -- },



    -- Markdown
    -- diagnostics.write_good, -- npm install write-good
    -- diagnostics.markdownlint,
    -- formatting.mdformat,
    -- hover.dictionary,


    -- diagnostics.cspell.with {
    --     filetypes = { "python", "rust", "typescript" },
    -- },
  },
}
