return {
  settings = {

    Lua = {
      diagnostics = {
        globals = { "vim", },
        -- DIAG_LINE_ONLY_SPACE = false,
        -- DIAG_LINE_POST_SPACE = false,
        disable = { "trailing-space" }

      },
      -- workspace = {
      --     library = {
      --         [vim.fn.expand("$VIMRUNTIME/lua")] = true,
      --         [vim.fn.stdpath("config") .. "/lua"] = true,
      -- },
      -- },
    },
  },
}
