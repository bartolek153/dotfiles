vim.cmd [[
syntax enable

let g:dracula_bold = 0
let g:dracula_italic = 1
let g:dracula_underline = 0
let g:dracula_undercurl = 1
let g:dracula_full_special_attrs_support = 1
let g:dracula_inverse = 0
let g:dracula_colorterm = 1

colorscheme dracula

hi! NvimTreeNormal guibg=#21222C
hi! CursorLineNr guibg=#5F6A8E
]]

pcall(require, "'lualine'.setup {options = {theme = 'dracula'}}")
