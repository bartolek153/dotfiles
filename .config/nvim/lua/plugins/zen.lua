local st_zen, zen = pcall(require, "zen-mode")
if (not st_zen) then
  vim.notify("zen.nvim error")
else
  zen.setup({
    window = {
      backdrop = 1,
      height = 120, -- height of the Zen window
      width = 0.7,
      options = {
        signcolumn = "yes", -- disable signcolumn
        number = true, -- disable number column
        relativenumber = false, -- disable relative numbers
        -- cursorline = false, -- disable cursorline
        -- cursorcolumn = false, -- disable cursor column
        -- foldcolumn = "0", -- disable fold column
        -- list = false, -- disable whitespace characters
      },
    },
    plugins = {
      gitsigns = { enabled = false }, -- disables git signs
      tmux = { enabled = true },
      twilight = { enabled = true },
    },
    on_open = function()
      --   vim.diagnostic.disable()
      vim.cmd [[ hi Normal guibg=#282a36 ]]
    end,
    on_close = function()
      --   vim.diagnostic.enable()
      vim.cmd [[ hi Normal guibg=NONE ]]
    end,
  })
end

vim.keymap.set({ "i", "n" }, "<C-z>", "<cmd>ZenMode<cr>")



local st_twi, twilight = pcall(require, "twilight")
if (not st_twi) then
  vim.notify('twilight.nvim error')
else
  twilight.setup {
    dimming = {
      alpha = 0.25, -- amount of dimming
      -- we try to get the foreground from the highlight groups or fallback color
      color = { "Normal", "black" },
      inactive = false, -- when true, other windows will be fully dimmed (unless they contain the same buffer)
    },
    context = 0, -- amount of lines we will try to show around the current line
    treesitter = true, -- use treesitter when available for the filetype
    -- treesitter is used to automatically expand the visible text,
    -- but you can further control the types of nodes that should always be fully expanded
    expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
      -- Lua
      "function",
      "method",
      "table",
      "field",
      "if_statement",
      "function_call",

      -- python
      "function_definition"
    },
    exclude = {}, -- exclude these filetypes
  }
end
