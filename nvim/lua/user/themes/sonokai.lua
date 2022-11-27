vim.cmd [[
let g:sonokai_style = 'andromeda'  " espresso , andromeda ...
let g:sonokai_enable_italic = 1
let g:sonokai_disable_italic_comment = 0
let g:sonokai_diagnostic_line_highlight = 1
let g:sonokai_diagnostic_text_highlight = 0
let g:sonokai_diagnostic_virtual_text = 'colored'
let g:sonokai_current_word = 'bold'
colorscheme sonokai
]]

pcall(require, "'lualine'.setup {options = {theme = 'sonokai'}}")
