local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
  vim.notify("BufferLine Error")
  return
end

bufferline.setup {
  options = {
    mode = "buffers", -- set to "tabs" to only show tabpages instead
    numbers = "none", -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
    close_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
    right_mouse_command = "vert sbuffer %d", -- can be a string | function, see "Mouse actions"
    left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
    middle_mouse_command = nil, -- can be a string | function, see "Mouse actions"
    -- indicator = {
    --     icon = '▎', -- this should be omitted if indicator style is not 'icon'
    --     style = 'icon' -- | 'underline' | 'none',
    -- },
    buffer_close_icon = '',
    modified_icon = '●',
    close_icon = '',
    left_trunc_marker = '',
    right_trunc_marker = '',


    --- name_formatter can be used to change the buffer's label in the bufferline.
    --- Please note some names can/will break the
    --- bufferline so use this at your discretion knowing that it has
    --- some limitations that will *NOT* be fixed.
    -- name_formatter = function(buf)  -- buf contains a "name", "path" and "bufnr"
    --     -- remove extension from markdown files for example
    --     if buf.name:match('%.md') then
    --         return vim.fn.fnamemodify(buf.name, ':t:r')
    --     end
    -- end,


    max_name_length = 18,
    max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
    tab_size = 18,


    diagnostics = "nvim_lsp", --false | "nvim_lsp" | "coc",
    diagnostics_update_in_insert = true,
    -- The diagnostics indicator can be set to nil to keep the buffer name highlight but delete the highlighting
    diagnostics_indicator = function(_, _, diagnostics)
      -- local symbols = { error = ' ', warning = ' ', hint = ' ', info = ' ' }
      local symbols = { error = ' ', warning = ' ' }
      local result = {}
      for name, count in pairs(diagnostics) do
        if symbols[name] and count > 0 then
          table.insert(result, symbols[name] .. count)
        end
      end
      result = table.concat(result, ' ')
      return #result > 0 and result or ''
    end,


    -- NOTE: this will be called a lot so don't do any heavy processing here
    -- custom_filter = function(buf_number, buf_numbers)
    --     -- filter out filetypes you don't want to see
    --     if vim.bo[buf_number].filetype ~= "<i-dont-want-to-see-this>" then
    --         return true
    --     end
    --     -- filter out by buffer name
    --     if vim.fn.bufname(buf_number) ~= "<buffer-name-I-dont-want>" then
    --         return true
    --     end
    --     -- filter out based on arbitrary rules
    --     -- e.g. filter out vim wiki buffer from tabline in your work repo
    --     if vim.fn.getcwd() == "<work-repo>" and vim.bo[buf_number].filetype ~= "wiki" then
    --         return true
    --     end
    --     -- filter out by it's index number in list (don't show first buffer)
    --     if buf_numbers[1] ~= buf_number then
    --         return true
    --     end
    -- end,


    offsets = {
      {
        filetype = "NvimTree",
        text = "Explorer", -- | function ,
        text_align = "center", -- "left" | "center" | "right"
        separator = true
      },
      {
        filetype = 'toggleterm',
        text = 'Terminal',
        highlight = 'PanelHeading'
      },
      {
        filetype = 'Outline',
        text = 'Outline',
        highlight = 'PanelHeading',
      },
      {
        filetype = 'packer',
        text = 'Packer',
        highlight = 'PanelHeading',
      },
    },


    color_icons = true, -- whether or not to add the filetype icon highlights
    show_buffer_icons = true, -- disable filetype icons for buffers
    show_buffer_close_icons = true,
    show_buffer_default_icon = true, -- whether or not an unrecognised filetype should show a default icon
    show_close_icon = true,
    show_tab_indicators = true,
    persist_buffer_sort = false, -- whether or not custom sorted buffers should persist


    -- can also be a table containing 2 custom separators
    -- [focused and unfocused]. eg: { '|', '|' }
    separator_style = 'slant', -- "slant" | "thick" | "thin" | { 'any', 'any' },
    enforce_regular_tabs = true,
    always_show_bufferline = false,


    -- sort_by = 'insert_after_current' | 'insert_at_end' | 'id' | 'extension' | 'relative_directory' | 'directory' | 'tabs'
    --     | function(buffer_a, buffer_b)
    --       -- add custom logic
    --       return buffer_a.modified > buffer_b.modified
    --     end
  },
  highlights = {
    fill = {
      fg = { attribute = "fg", highlight = "TabLine" },
      bg = { attribute = "bg", highlight = "TabLine" },
    },
    buffer_selected = {
      bold = true
    },
    tab_selected = {
      fg = { attribute = "fg", highlight = "Normal" },
      bg = { attribute = "bg", highlight = "Normal" },
    },
    -- tab = {
    --   guifg = { attribute = "fg", highlight = "TabLine" },
    --   guibg = { attribute = "bg", highlight = "TabLine" },
    -- },
    tab_close = {
      fg = { attribute = "fg", highlight = "Normal" },
      bg = { attribute = "bg", highlight = "Normal" },
    },
    separator = {
      fg = { attribute = "bg", highlight = "TabLine" },
    },
    separator_selected = {
      fg = { attribute = "bg", highlight = "TabLine" },
    },
    separator_visible = {
      fg = { attribute = 'bg', highlight = 'TabLine' },
    },
  },

  -- groups = {
  --   options = {
  --     toggle_hidden_on_enter = false,
  --   },
  --   items = {
  --     -- groups.builtin.ungrouped,
  --     {
  --       name = 'Terraform',
  --       matcher = function(buf)
  --         return buf.name:match('%.tf') ~= nil
  --       end,
  --     },
  --     {
  --       highlight = { guisp = '#51AFEF', gui = 'underline' },
  --       name = 'tests',
  --       icon = '',
  --       matcher = function(buf)
  --         return buf.filename:match('_spec') or buf.filename:match('_test')
  --       end,
  --     },
  --     {
  --       name = 'docs',
  --       icon = '',
  --       matcher = function(buf)
  --         for _, ext in ipairs({ 'md', 'txt', 'org', 'norg', 'wiki' }) do
  --           if ext == vim.fn.fnamemodify(buf.path, ':e') then
  --             return true
  --           end
  --         end
  --       end,
  --     },
  --   },
  -- },
}
