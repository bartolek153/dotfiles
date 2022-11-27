local st_trouble, trouble = pcall(require, "trouble")
if (not st_trouble) then
  vim.notify("trouble.nvim error")
else
  trouble.setup {
    position = "bottom", -- position of the list can be: bottom, top, left, right
    height = 10, -- height of the trouble list when position is top or bottom
    width = 50, -- width of the list when position is left or right
    icons = true, -- use devicons for filenames
    mode = "workspace_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
    fold_open = "", -- icon used for open folds
    fold_closed = "", -- icon used for closed folds
    group = true, -- group results by file
    padding = true, -- add an extra new line on top of the list
    action_keys = { -- key mappings for actions in the trouble list
      -- map to {} to remove a mapping, for example:
      -- close = {},
      close = "q", -- close the list
      cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
      refresh = "r", -- manually refresh
      jump = { "<cr>", "<tab>" }, -- jump to the diagnostic or open / close folds
      open_split = { "<c-x>" }, -- open buffer in new split
      open_vsplit = { "<c-v>" }, -- open buffer in new vsplit
      open_tab = { "<c-t>" }, -- open buffer in new tab
      jump_close = { "o" }, -- jump to the diagnostic and close the list
      toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
      toggle_preview = "P", -- toggle auto_preview
      hover = "K", -- opens a small popup with the full multiline message
      preview = "p", -- preview the diagnostic location
      close_folds = { "zM", "zm" }, -- close all folds
      open_folds = { "zR", "zr" }, -- open all folds
      toggle_fold = { "zA", "za" }, -- toggle fold of current file
      previous = "k", -- preview item
      next = "j" -- next item
    },
    indent_lines = true, -- add an indent guide below the fold icons
    auto_open = false, -- automatically open the list when you have diagnostics
    auto_close = false, -- automatically close the list when you have no diagnostics
    auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
    auto_fold = false, -- automatically fold a file trouble list at creation
    auto_jump = { "lsp_definitions" }, -- for the given modes, automatically jump if there is only a single result
    signs = {
      -- icons / text used for a diagnostic
      error = "",
      warning = "",
      hint = "",
      information = "",
      other = "﫠"
    },
    use_diagnostic_signs = true -- enabling this will use the signs defined in your lsp client
  }
end





local st_todo, todo = pcall(require, "todo-comments")
if (not st_todo) then
  vim.notify("todo-comments.nvim error")
else
  -- TODO: do something
  -- FIX: needs fixing
  -- HACK: weird code warning
  -- WARN: ???
  -- PERF: fully optmised
  -- NOTE: adding a note

  local error_red = "#F44747"
  local warning_orange = "#ff8800"
  local info_yellow = "#FFCC66"
  local hint_blue = "#4FC1FF"
  local perf_purple = "#7C3AED"
  local note_green = '#10B981'

  todo.setup({
    signs = true, -- show icons in the signs column
    sign_priority = 8, -- sign priority
    -- keywords recognized as todo comments
    keywords = {
      FIX = {
        icon = " ", -- icon used for the sign, and in search results
        color = error_red, -- can be a hex color, or a named color (see below)
        alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
        -- signs = false, -- configure signs for some keywords individually
      },
      TODO = { icon = " ", color = hint_blue },
      HACK = { icon = " ", color = warning_orange },
      WARN = { icon = " ", color = info_yellow, alt = { "WARNING", "XXX" } },
      PERF = { icon = " ", color = perf_purple, alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
      NOTE = { icon = " ", color = note_green, alt = { "INFO" } },
    },
    merge_keywords = true, -- when true, custom keywords will be merged with the defaults
    -- highlighting of the line containing the todo comment
    -- * before: highlights before the keyword (typically comment characters)
    -- * keyword: highlights of the keyword
    -- * after: highlights after the keyword (todo text)
    highlight = {
      before = "empty", -- "fg" or "bg" or empty
      keyword = "wide", -- "fg", "bg", "wide" or empty. (wide is the same as bg, but will also highlight surrounding characters)
      after = "empty", -- "fg" or "bg" or empty
      pattern = [[.*<(KEYWORDS)\s*]], -- pattern or table of patterns, used for highlightng (vim regex)
      comments_only = true, -- uses treesitter to match keywords in comments only
      max_line_len = 400, -- ignore lines longer than this
      exclude = {}, -- list of file types to exclude highlighting
    },
    -- list of named colors where we try to extract the guifg from the
    -- list of hilight groups or use the hex color if hl not found as a fallback
    -- colors = {
    --   error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
    --   warning = { "DiagnosticWarning", "WarningMsg", "#FBBF24" },
    --   info = { "DiagnosticInfo", "#2563EB" },
    --   hint = { "DiagnosticHint", "#10B981" },
    --   default = { "Identifier", "#7C3AED" },
    -- },
    search = {
      command = "rg",
      args = {
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
      },
      -- regex that will be used to match keywords.
      -- don't replace the (KEYWORDS) placeholder
      pattern = [[\b(KEYWORDS):]], -- ripgrep regex
      -- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
    },
  })
end





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
      vim.diagnostic.disable()
      vim.cmd [[
          hi Normal guibg=#282a36
          hi! link Twilight Comment
          " IndentBlanklineDisable
          ]]
    end,
    on_close = function()
      vim.diagnostic.enable()
      vim.cmd [[
          hi Normal guibg=NONE
          " IndentBlanklineEnable
          ]]
    end,
  })
end





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
