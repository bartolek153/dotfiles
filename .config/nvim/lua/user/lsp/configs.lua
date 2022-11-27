local status_ok, mason = pcall(require, "mason")
if not status_ok then
  return
end

local status_masonconfig, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_masonconfig then
  return
end

local lspconfig = require("lspconfig")

-- :lua print(vim.inspect(vim.lsp.buf_get_clients()[1].resolved_capabilities))

local servers = {
  -- "pyright",
  "clangd",
  "omnisharp",
  "sumneko_lua",
  "pylsp",
  -- "prosemd_lsp", -- MarkDown LSP
}

-- nvim-lsp-installer plugin setup
mason.setup({
  ui = {
    check_outdated_packages_on_open = true,

    border = "none",

    icons = {
      package_installed = "◍",
      package_pending = "◍",
      package_uninstalled = "◍",
    },

    keymaps = {
      toggle_package_expand = "<CR>",
      install_package = "i",
      update_package = "u",
      check_package_version = "c",
      update_all_packages = "U",
      check_outdated_packages = "C",
      uninstall_package = "X",
      cancel_installation = "<C-c>",
      apply_language_filter = "<C-f>",
    },
  },

  install_root_dir = vim.fn.stdpath("data") .. "/mason",

  pip = {
    install_args = {},
  },

  log_level = vim.log.levels.INFO,

  max_concurrent_installers = 4,

  github = {
    download_url_template = "https://github.com/%s/releases/download/%s/%s",
  },
})

mason_lspconfig.setup({
  -- A list of servers to automatically install if they're not already installed. Example: { "rust_analyzer@nightly", "sumneko_lua" }
  -- This setting has no relation with the `automatic_installation` setting.
  ensure_installed = servers,

  -- Whether servers that are set up (via lspconfig) should be automatically installed if they're not already installed.
  -- This setting has no relation with the `ensure_installed` setting.
  -- Can either be:
  --   - false: Servers are not automatically installed.
  --   - true: All servers set up via lspconfig are automatically installed.
  --   - { exclude: string[] }: All servers set up via lspconfig, except the ones provided in the list, are automatically installed.
  --       Example: automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }
  automatic_installation = true,
})

-- server iteration
for _, server in pairs(servers) do
  local opts = {
    on_attach = require("user.lsp.handlers").on_attach,
    capabilities = require("user.lsp.handlers").capabilities,
  }

  -- protected call to check if there is a file containing special server configurations
  local has_custom_opts, server_custom_opts = pcall(require, "user.lsp.settings." .. server)

  -- load custom settings file for some server if it exists
  if has_custom_opts then
    opts = vim.tbl_deep_extend("force", server_custom_opts, opts)
  end
  lspconfig[server].setup(opts) -- the same as, eg, require'lspconfig'.pyright.setup({})
end
