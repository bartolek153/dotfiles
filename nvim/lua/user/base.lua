-------------
-- General --
-------------

-- Backup
local backup_folder = vim.fn.stdpath "config" .. "/backup/"

vim.opt.backupdir = backup_folder .. "copies/"
vim.opt.directory = backup_folder .. "swap/"

--  *backup-table*
--'backup' 'writebackup'  action
--   off       off    no backup made
--   off       on     backup current file, deleted afterwards (default)
--   on        off    delete old backup, backup current file
--   on        on     delete old backup, backup current file

vim.opt.swapfile = true -- Use a swapfile for the buffer (a recovery file with the unsaved changes)
vim.opt.backup = true -- Turn on backup option
vim.opt.writebackup = true -- Make backup before overwriting the current buffer
vim.opt.backupcopy = "yes" -- Overwrite the original backup file
vim.cmd [[au BufWritePre * let &bex = '@' . strftime("%F.%H:%M")]] -- Meaningful backup name, ex: filename@2015-04-05.14:59

-- Backspace
vim.opt.backspace = 'start,eol,indent'

-- Clipboard
vim.opt.clipboard = "unnamedplus" -- Uses clipboard register '+' for operations (normally, to unnamed register)

-- Encoding
vim.scriptencoding = 'utf-8'
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'

-- Mouse
vim.opt.mouse = "a" -- Allow use of mouse in all modes
vim.opt.mousehide = true -- Mouse pointer is hidden when characters are typed
vim.opt.mousefocus = true -- The window that the mouse pointer is on is automatically activated

-- Searching
vim.opt.hlsearch = true -- Highlight all matches on previous search pattern
vim.opt.ignorecase = true -- Ignore case in search patterns
vim.opt.smartcase = true -- Override 'ignorecase' if search pattern contains upper case chars
vim.opt.incsearch = true -- Incremental search

-- Sessions
vim.opt.sessionoptions = "buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"

-- <TAB> and Indentation
vim.opt.autoindent = true -- Copy indent from current line when starting a new line
vim.opt.smartindent = true -- Smart autoindenting when starting a new line (some cases)
vim.opt.expandtab = true -- Convert tabs to spaces
vim.opt.smarttab = true -- insert tabs on the start of a line according to shiftwidth
vim.opt.shiftwidth = 2 -- Number of spaces to use for each step of (auto)indent ('>')
vim.opt.shiftround = true -- Round indent to multiple of 'shiftwidth'
vim.opt.tabstop = 2 -- Number of spaces that a <Tab> in the file counts for
vim.opt.softtabstop = 2 -- Number of spaces that a <Tab> counts for while performing editing operations
vim.opt.breakindent = true -- Every wrapped line will continue visually indented

-- Time Beahavior
vim.opt.timeoutlen = 1000 -- Time to wait for a mapped sequence to complete (ms)
vim.opt.updatetime = 200

-- Undo
vim.opt.undofile = true -- Saves and restores undo history in a file

-- Virtual Editing
vim.opt.virtualedit = "none" -- Cursor can be positioned where there is no actual character in visual mode





-------------
---- UI -----
-------------


-- Blend
vim.opt.winblend = 0
vim.opt.pumblend = 5

-- CMD
vim.opt.cmdheight = 1 -- Number of screen lines to use for the command-line

-- Completion Menu
vim.opt.completeopt = { "menu", "menuone", "noselect" } -- Completion options
vim.opt.pumheight = 10 -- Maximum number of items to show in the popup menu

-- Fold (:h usr_28.txt)
-- vim.o.foldcolumn = '1'
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = -1
vim.o.foldenable = true
vim.o.fillchars = [[fold: ,foldopen:,foldsep: ,foldclose:]]

-- Lines
vim.opt.wrap = false -- When off lines will not wrap and only part of long lines will be displayed
vim.opt.cursorline = true -- Highlight the current line
-- vim.opt.cursorlineopt = "number" -- Highlight only current line number
vim.opt.scrolloff = 8 -- Minimal number of screen lines to keep above and below the cursor
vim.opt.sidescrolloff = 8 -- Minimal number of screen columns to keep to the left and to the right of the cursor
-- vim.opt.ruler = false -- Line and Column count when there is no statusline

-- Mode
vim.opt.showmode = false -- If in Insert, Replace or Visual mode put a message on the last line

-- Number Columns
vim.opt.number = true -- Set numbered lines
vim.opt.relativenumber = false -- Set relative numbered lines
-- vim.opt.numberwidth = 2 -- Minimal number of columns to use for the line number
vim.opt.signcolumn = "yes" -- When and how to draw the signcolumn (number column)

-- Split Screen
vim.opt.splitbelow = true -- Force all horizontal splits to go below current window
vim.opt.splitright = true -- Force all vertical splits to go to the right of current window

-- Status Line
vim.opt.laststatus = 3

-- Tabs
vim.opt.showtabline = 1 -- Where the line with tab page labels will be displayed





------------
-- Others --
------------


vim.opt.conceallevel = 0 -- so that `` is visible in markdown files
vim.opt.hidden = true
vim.opt.shortmess:append "c" -- don't give |ins-completion-menu| messages´
vim.cmd [[
set iskeyword+=- "'abcd-edfg' is just one word
filetype plugin on "load the plugin file for the file type, if any
filetype indent on "load the indent file for the file type, if any
"let &t_Cs = "\e[4:3m" 
"let &t_Ce = "\e[4:0m" 
set formatoptions-=o
set formatoptions+=r
]]





------------
-- AutoCMD's --
------------


vim.cmd [[
augroup LargeFile
let g:large_file = 10485760 " 10MB
" Set options:
"   eventignore+=FileType (no syntax highlighting etc
"   assumes FileType always on)
"   noswapfile (save copy of file)
"   bufhidden=unload (save memory when other file is viewed)
"   buftype=nowritefile (is read-only)
"   undolevels=-1 (no undo possible)
 
    au BufReadPre *
    \ let f=expand("<afile>") |
    \ if getfsize(f) > g:large_file |
    \ set eventignore+=FileType |
    \ setlocal noswapfile bufhidden=unload buftype=nowrite undolevels=-1 |
    \ else |
    \ set eventignore-=FileType |
    \ endif
augroup END
]]

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "qf", "help", "man", "lspinfo", "spectre_panel", "lir", "startuptime" },
  callback = function()
    vim.cmd [[
      nnoremap <silent> <buffer> q :close<CR> 
      set nobuflisted 
    ]]
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "gitcommit", "markdown", "txt" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

vim.cmd "autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif"

vim.api.nvim_create_autocmd(
  "BufReadPost",
  { command = [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif]] }
)





-- Disable some builtin vim plugins
local g = vim.g

g.loaded_gzip = 1
g.loaded_zip = 1
g.loaded_zipPlugin = 1
g.loaded_tar = 1
g.loaded_tarPlugin = 1

g.loaded_getscript = 1
g.loaded_getscriptPlugin = 1
g.loaded_vimball = 1
g.loaded_vimballPlugin = 1
g.loaded_2html_plugin = 1

g.loaded_matchit = 1
g.loaded_matchparen = 1
g.loaded_logiPat = 1
g.loaded_rrhelper = 1

g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
g.loaded_netrwSettings = 1
g.loaded_netrwFileHandlers = 1
