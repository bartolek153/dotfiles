--DOCS CMD:   :help :map   :help :noremap   :help recursive_mapping   :help :map-modes   :help {key}^D

-- ':map' syntax (Vimscript): [mode][nore]map [arg] {lhs} {rhs}
--                             (1)   (2)       (3)   (4)   (5)
--
-- 1: represent the mode that the keymap will apply
--    normal_mode = "n"
--    insert_mode = "i"
--    visual_mode = "v"
--    visual_block_mode = "x"
--    term_mode = "t"
--    command_mode = "c"
--
-- 2: enables 'Non-Recursive' mapping
--    This option disallow mapping of {rhs}, to avoid nested and recursive mappings.
--    It is often used to redefine a command.
--    Briefly, if this is off, it is like using 'variables' for already existing mapping
--
-- 3: special arguments are optionals, but provide extra setts. (ex.: <silent> <buffer>)
--
-- 4: {lhs} means the desired key combo (or single key) for the new remap
--
-- 5: {rhs} means the key combo (or single key) that will be substituted by new remap or a vim.cmd


local keymap = vim.api.nvim_set_keymap
local noremap = { noremap = true, silent = true }
-- local map = { noremap = false, silent = false }

keymap("n", "tt", ":NvimTreeToggle<CR>", noremap)

-- Remap <Space> to null (<Nop>) in all modes but INSERT
keymap("", "<Space>", "<Nop>", noremap) -- same as 'noremap <Space> <Nop>'

-- <Leader> key to <Space> (default '\')
vim.g.mapleader = " " -- global
vim.g.localmapleader = " " -- local





-- NORMAL --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", noremap)
keymap("n", "<C-j>", "<C-w>j", noremap)
keymap("n", "<C-k>", "<C-w>k", noremap)
keymap("n", "<C-l>", "<C-w>l", noremap)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", noremap)
keymap("n", "<C-Down>", ":resize -2<CR>", noremap)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", noremap)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", noremap)

-- Tabs
keymap('n', 'te', ':tabedit %<Return>', noremap)
keymap('n', 'th', ':split<Return><C-w>W', noremap)
keymap('n', 'tv', ':vsplit<Return><C-w>W', noremap)

-- Navigate tabs
keymap("n", "<A-l>", "gt", noremap)
keymap("n", "<A-h>", "gT", noremap)
keymap('n', '<Tab>', 'gt', noremap)
keymap('n', '<S-Tab>', 'gT', noremap)

-- Navigate buffers
keymap("n", "<S-l>", ":BufferLineCycleNext<CR>", noremap)
keymap("n", "<S-h>", ":BufferLineCyclePrev<CR>", noremap)

-- Increment / Decrement
keymap("n", '+', '<C-a>', noremap)
keymap("n", '-', '<C-x>', noremap)

-- Delete a word backwards
keymap("n", 'dw', 'vb"_d', noremap)

-- Select all
keymap('v', '<c-a>', '<ESC>gg<S-v>G', noremap)



-- INSERT --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", noremap)

--- Gets out of pair with <TAB>
-- vim.cmd [[ inoremap <expr> <Tab> getline('.')[col('.')-1] =~? '[]>)}''\"`]' ? '<Right>' : '<Tab>' ]]

keymap("i", "<M-l>", "<Right>", noremap)
keymap("i", "<M-h>", "<Left>", noremap)

-- VISUAL --
-- Stay in indent mode
keymap("v", ">", ">gv", noremap)
keymap("v", "<", "<gv", noremap)

-- Move text up and down
keymap("v", "p", '"_dP', noremap)
keymap("v", "<A-j>", ":m .+1<CR>==", noremap)
keymap("v", "<A-k>", ":m .-2<CR>==", noremap)



-- VISUAL BLOCK --
keymap("x", "J", ":move '>+1<CR>gv-gv", noremap)
keymap("x", "K", ":move '<-2<CR>gv-gv", noremap)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", noremap)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", noremap)



-- TERMINAL --



-- CUSTOM --
keymap("n", "<C-s>", "<cmd>vsplit<cr>", noremap)
keymap("n", "<C-z>", "<cmd>ZenMode<cr>", noremap)
keymap("i", "<C-F>", '<esc><cmd>:HopChar2<CR>', noremap)
keymap("n", "<C-F>", '<esc><cmd>:HopChar2<CR>', noremap)
keymap("n", "\\",
  "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<CR>",
  noremap)
-- keymap("n", "qn", ":e ~/Notes/<cr>", noremap)




-- vim.cmd [[
--  " start terminal in insert mode
-- au BufEnter * if &buftype == 'terminal' | :startinsert | endif
--
-- " open terminal on ctrl+n
-- function! OpenTerminal()
--   split term://bash
--   resize 10
-- endfunction
-- nnoremap <Leader>T :call OpenTerminal()<CR>
-- ]]

-- keybiding suggestions:
--[[
    * Function keys (<F2>, <F3>, etc..)  *F1 = help
    * Shifted function keys (<S-F2>, etc)
    * Meta-keys (ALT)
    * '_' + ','
    * Key that is a synonym for another command.
    * Use an extra character to allow more mappings.
    * <Leader>
    *
  ]]
