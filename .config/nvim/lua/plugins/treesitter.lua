local status_ok, ts = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

ts.setup {

  -- A list of parser names, or "all"
--  ensure_installed = {
--    "python",
--    "lua",
--    "c",
--    "c_sharp",
--  },

  -- install languages synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  auto_install = true,

  -- List of parsers to ignore installing (for 'all')
  -- ignore_install = { "markdown", "markdown_inline" },

  highlight = {
    enable = true, -- false will disable the whole extension

    disable = function(lang, buf)
      local max_filesize = 100 * 1024 -- 100 KB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
          return true
      end
    end,
  },
  

  indent = {
    enable = true,
    disable = {}
  },

  autopairs = {
    enable = true,
  },

  autotag = {
    enable = true,
    skip_tags = {
      'area', 'base', 'br', 'col', 'command', 'embed', 'hr', 'img', 'slot',
      'input', 'keygen', 'link', 'meta', 'param', 'source', 'track', 'wbr','menuitem'
    }
  },

  matchup = {
    enable = true, -- mandatory, false will disable the whole extension
    disable = {}, -- optional, list of language that will be disabled
  },

  playground = {
    enable = false,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
    },
  },
}
