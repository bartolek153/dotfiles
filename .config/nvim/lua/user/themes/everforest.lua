vim.cmd [[
let g:everforest_background = 'medium' " hard, medium, soft
let g:everforest_transparent_background = 2
let g:everforest_ui_contrast = 'low'
let g:everforest_better_performance = 1
let g:everforest_enable_italic = 1
let g:everforest_disable_italic_comment = 0
let g:everforest_spell_foreground = 'none'
let g:everforest_show_eob = 1
let g:everforest_diagnostic_text_highlight = 0
let g:everforest_diagnostic_line_highlight = 1
let g:everforest_diagnostic_virtual_text = 'colored'
let g:everforest_current_word = 'bold'
let g:everforest_disable_terminal_colors = 0
"let g:everforest_colors_override = {}
colorscheme everforest
]]
require 'lualine'.setup { options = { theme = 'everforest', } }
