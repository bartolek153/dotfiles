local M = {}

M.capabilities = vim.lsp.protocol.make_client_capabilities()

M.setup = function()

  vim.lsp.protocol.CompletionItemKind = {
    '', -- Text
    '', -- Method
    '', -- Function
    '', -- Constructor
    '', -- Field
    '', -- Variable
    '', -- Class
    'ﰮ', -- Interface
    '', -- Module
    '', -- Property
    '', -- Unit
    '', -- Value
    '', -- Enum
    '', -- Keyword
    '﬌', -- Snippet
    '', -- Color
    '', -- File
    '', -- Reference
    '', -- Folder
    '', -- EnumMember
    '', -- Constant
    '', -- Struct
    '', -- Event
    'ﬦ', -- Operator
    '', -- TypeParameter
  }

  local signs = {
    { name = "DiagnosticSignError", text = "" },
    -- { name = "DiagnosticSignError", text = ""},
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    -- { name = "DiagnosticSignInfo", text = ""},
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  local config = {
    -- disable virtual text
    virtual_text = true,
    -- show signs
    signs = {
      active = signs,
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  vim.diagnostic.config(config)

  -- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  --   border = "rounded",
  -- })
  --
  -- vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  --   border = "rounded",
  -- })
end

local function lsp_highlight_document(client)
  -- Set autocommands conditional on server_capabilities
  local status_ok, illuminate = pcall(require, "illuminate")
  if not status_ok then
    vim.notify("'vim-illuminate' not available")
    return
  end
  vim.api.nvim_set_hl(0, "CurrentWord", { bold = true })
  vim.cmd [[
    hi! clear LspReferenceRead
    highlight! link LspReferenceRead CurrentWord
    hi! clear LspReferenceWrite
    highlight! link LspReferenceWrite CurrentWord
    hi! clear LspReferenceText
    highlight! link LspReferenceText CurrentWord
    ]]
  illuminate.on_attach(client)
end

local function lsp_keymaps(bufnr)
  -- local opts = { noremap = true, silent = true }
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>k", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  -- -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  -- -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  -- -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>f", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gl", '<cmd>lua vim.diagnostic.open_float({ border = "rounded" })<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gQ", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.format()' ]]
  -- Neovim 0.8:
  -- vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting_seq_sync()' ]]
end

M.on_attach = function(client, bufnr)
  vim.notify(client.name .. " starting...")

  lsp_keymaps(bufnr)
  lsp_highlight_document(client)

  -- if client.name == "tsserver" then -- for specific servers, do custom functions
  --   client.server_capabilities.document_formatting = false
  --   M.capabilities.textDocument.completion.completionItem.snippetSupport = false
  --   -- vim.lsp.codelens.refresh()
  -- else
    if client.server_capabilities.documentFormattingProvider then
      vim.cmd [[
          augroup Format
            autocmd! * <buffer>
            autocmd BufWritePre <buffer> lua vim.lsp.buf.format()
            " Neovim 0.8: 
            "autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()
          augroup END
        ]]
    end

    local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
    if (not status_ok) then vim.notify('cmp_nvim_lsp Error') return end
    M.capabilities.textDocument.completion.completionItem.snippetSupport = true
    M.capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)
  end

-- end


function M.enable_format_on_save()
  --vim.cmd [[
  --augroup format_on_save
  --  autocmd!
  --  autocmd BufWritePre * lua vim.lsp.buf.format({ async = true })
  --augroup end
  --]]
  vim.notify("Enabled format on save", vim.log.levels.WARN)
  vim.cmd [[
      augroup Format
        autocmd! * <buffer>
        autocmd BufWritePre <buffer> lua vim.lsp.buf.format()
        " Neovim 0.8: and also check whichkey.lua
        "autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_synq()
      augroup END
    ]]
end

function M.disable_format_on_save()
  M.remove_augroup "Format"
  vim.notify("Disabled format on save", vim.log.levels.WARN)
end

function M.toggle_format_on_save()
  if vim.fn.exists "#Format#BufWritePre" == 0 then
    M.enable_format_on_save()
  else
    M.disable_format_on_save()
  end
end

function M.remove_augroup(name)
  if vim.fn.exists("#" .. name) == 1 then
    vim.cmd("au! " .. name)
  end
end

vim.cmd [[ command! LspToggleAutoFormat execute 'lua require("user.lsp.handlers").toggle_format_on_save()' ]]


local diagnostics_active = true
function M.toggle_diagnostics()
  diagnostics_active = not diagnostics_active
  if diagnostics_active then
    vim.diagnostic.enable()
  else
    vim.diagnostic.disable()
  end
end

return M
