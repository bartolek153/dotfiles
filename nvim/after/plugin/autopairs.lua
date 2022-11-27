local status_ok, npairs = pcall(require, "nvim-autopairs")
if not status_ok then
  return
end

npairs.setup {
  break_undo = true, -- switch for basic rule break undo sequence
  map_cr = true,
  map_bs = true, -- map the <BS> key
  map_c_h = false, -- Map the <C-h> key to delete a pair
  map_c_w = false, -- map <c-w> to delete a pair if possible

  check_ts = false,
  ts_config = {
    --[[ lua = { 'string' }, -- it will not add a pair on that treesitter node
        javascript = { "string", "template_string" }, -- disable these features
        java = false, ]]
  },
  disable_filetype = { "TelescopePrompt", "spectre_panel" },
  fast_wrap = {
    map = "<M-e>",
    chars = { "{", "[", "(", '"', "'" },
    pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
    offset = 0, -- Offset from pattern match
    end_key = "$",
    keys = "qwertyuiopzxcvbnmasdfghjkl",
    check_comma = true,
    highlight = "PmenuSel",
    highlight_grey = "LineNr",
  },
}

------- Custom Rules

-- Vim-Way
--
-- add <!-- --> pair and remove '{' for html file
-- vim.cmd[[au FileType html let b:AutoPairs = AutoPairsDefine({'<!--' : '-->'}, ['{'])]]

vim.cmd [[ au FileType py let b:AutoPairs = AutoPairsDefine({'"""' : '"""'}) ]]


-- Neovim-Way
--
local Rule = require('nvim-autopairs.rule')
npairs.add_rules {

  Rule("'''", "'''"), -- third argument = FileType

  --Rule("a","a","-vim") -- disable for .vim files, but it work for another filetype

  Rule(' ', ' ')
      :with_pair(function(opts)
        local pair = opts.line:sub(opts.col - 1, opts.col)
        return vim.tbl_contains({ '()', '[]', '{}' }, pair)
      end),

  Rule('( ', ' )')
      :with_pair(function() return false end)
      :with_move(function(opts)
        return opts.prev_char:match('.%)') ~= nil
      end)
      :use_key(')'),

  Rule('{ ', ' }')
      :with_pair(function() return false end)
      :with_move(function(opts)
        return opts.prev_char:match('.%}') ~= nil
      end)
      :use_key('}'),

  Rule('[ ', ' ]')
      :with_pair(function() return false end)
      :with_move(function(opts)
        return opts.prev_char:match('.%]') ~= nil
      end)
      :use_key(']')
}
