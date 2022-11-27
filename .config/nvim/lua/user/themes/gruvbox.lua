vim.cmd [[

let g:gruvbox_bold = 1
let g:gruvbox_italic = 1
let g:gruvbox_transparent_bg = 1
"let g:gruvbox_underline = 0
let g:gruvbox_undercurl = 1
let g:gruvbox_contrast_dark = "soft"
let g:gruvbox_hls_cursor = "yellow"
let g:gruvbox_vert_split = "bg1"
let g:gruvbox_italicize_comments = 1
let g:gruvbox_italicize_strings = 1
"let g:gruvbox_improved_strings = 1 
"let g:gruvbox_improved_warnings = 1 
colorscheme gruvbox 

hi Visual gui=NONE cterm=NONE
hi! link SignColumn Normal
]]


require 'lualine'.setup { options = { theme = "gruvbox-material" } }
