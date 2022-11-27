local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local setup = {
  plugins = {
    marks = true, -- shows a list of your marks on ' and `

    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode

    spelling = {
      enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },

    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = true, -- adds help for motions
      text_objects = true, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
  },

  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  -- operators = { gc = "Comments" },
  key_labels = {
    -- override the label used to display some keys. It doesn't effect WK in any other way.
    -- For example:
    -- ["<space>"] = "SPC",
    -- ["<cr>"] = "RET",
    -- ["<tab>"] = "TAB",
  },

  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },

  popup_mappings = {
    scroll_down = "<c-d>", -- binding to scroll down inside the popup
    scroll_up = "<c-u>", -- binding to scroll up inside the popup
  },

  window = {
    border = "rounded", -- none, single, double, shadow
    position = "bottom", -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    winblend = 5,
  },

  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
    align = "center", -- align columns left, center or right
  },

  ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
  show_help = true, -- show help message on the command line when the popup is visible
  triggers = "auto", -- automatically setup triggers
  --triggers = {"<Space>"}, -- or specify a list manually
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = { "j", "k" },
    v = { "j", "k" },
  },
}

local opts = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
  ["a"] = { "<cmd>Alpha<cr>", "Alpha" },
  ["c"] = { "<cmd>e ~/.config/nvim/<cr>", "Configs" },
  ["d"] = { "<cmd>Bdelete!<CR>", "Delete Buffer" },
  ["e"] = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
  ["h"] = { "<cmd>nohlsearch<CR>", "nohlsearch" },
  ["n"] = { "<cmd>Notifications<cr>", "Notifications" },
  -- ["P"] = { "<cmd>lua require('telescope').extensions.projects.projects()<cr>", "Projects" },
  ["q"] = { "<cmd>silent quit<CR>", "Quit" },
  ["Q"] = { "<cmd>q!<CR>", "Force Quit" },
  ["w"] = { "<cmd>w!<CR>", "Save" },
  ["W"] = { '<cmd>MatchupWhereAmI??<cr>', ':WhereAmI' },

  D = {
    name = "Debug",
    b = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Breakpoint" },
    c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
    i = { "<cmd>lua require'dap'.step_into()<cr>", "Into" },
    o = { "<cmd>lua require'dap'.step_over()<cr>", "Over" },
    O = { "<cmd>lua require'dap'.step_out()<cr>", "Out" },
    r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Repl" },
    l = { "<cmd>lua require'dap'.run_last()<cr>", "Last" },
    u = { "<cmd>lua require'dapui'.toggle()<cr>", "UI" },
    x = { "<cmd>lua require'dap'.terminate()<cr>", "Exit" },
    -- nnoremap <silent> <leader>B :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
    -- nnoremap <silent> <leader>lp :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
    -- require("dapui").open()
    -- require("dapui").close()
    -- require("dapui").toggle()
  },

  f = {
    name = "Find",
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    C = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
    f = { "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>",
      "Find files",
    },
    F = { "<cmd>Telescope live_grep theme=ivy<cr>", "Find Text" },
    h = { "<cmd>Telescope help_tags<cr>", "Help" },
    H = { "<cmd>Telescope highlights<cr>", "Find highlights" },
    l = { "<cmd>Telescope resume<cr>", "Last Search" },
    M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
    r = { "<cmd>Telescope oldfiles<cr>", "Recent File" },
    k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
    c = { "<cmd>Telescope commands<cr>", "Commands" },
    ['\\'] = { "<cmd>Telescope file_browser<cr>", "File Browser" },
  },

  g = {
    name = "Git",
    g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
    j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
    k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
    l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
    p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
    r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
    R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
    s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
    u = {
      "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
      "Undo Stage Hunk",
    },
    o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
    d = {
      "<cmd>Gitsigns diffthis HEAD<cr>",
      "Diff",
    },
    P = {
      name = "Projects",
      l = { "<cmd>lua require('telescope').extensions.projects.projects()<cr>", "Projects" },
    }
  },

  i = {
    name = "Info",
    I = { "<cmd>Mason<cr>", "Installer Info" },
    l = { "<cmd>LspInfo<cr>", "LSP Status" },
    n = { "<cmd>NullLsInfo<CR>", "NullLS Info" },
    p = { "<cmd>PackerStatus<cr>", "Packer Status" },
    t = { "<cmd>TSModuleInfo<cr>", "Treesitter Modules" },
  },

  l = {
    name = "LSP",
    a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
    d = { "<cmd>TroubleToggle<cr>", "Diagnostics", },
    -- f = { "<cmd>lua vim.lsp.buf.format({ async = true})<cr>", "Format" }, NEOVIM 0.8
    f = { "<cmd>lua vim.lsp.buf.format()<CR>", "Format" },
    j = { "<cmd>lua vim.diagnostic.goto_next()<CR>", "Next Diagnostic", },
    k = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Prev Diagnostic", },
    l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
    o = { "Outline" },
    q = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "Quickfix" },
    r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "LSP Rename" },
    R = { "<cmd>lua vim.lsp.buf.references()<CR>", "References" },
    s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
    S = { "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Workspace Symbols", },
    t = { '<cmd>lua require("user.lsp.handlers").toggle_diagnostics()<cr>', "Toggle Diagnostics" },
    w = { "<cmd>LspToggleAutoFormat<CR>", "Toggle Autoformat" },
    g = {
      name = "goto",
      d = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "Declaration" },
      D = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Definition" },
      i = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Implementation" },
      n = { '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', "Next Diagnostic" },
      p = { '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', "Prev Diagnostic" },
      s = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature Help" },
      t = { "<cmd>lua vim.lsp.buf.type_definition()<CR>", "Goto Type Definition" },
    },
    u = {
      name = "UI Saga",
      a = { "<cmd>Lspsaga code_action<CR>", "code_action" },
      f = { "<Cmd>Lspsaga lsp_finder<CR>", "lsp_finder" },
      K = { "<Cmd>Lspsaga hover_doc<CR>", "hover_doc" },
      k = { "<Cmd>Lspsaga signature_help<CR>", "signature_help" },
      l = { "<Cmd>Lspsaga show_line_diagnostics", "show_line_diagnostics" },
      n = { "<CMD>Lspsaga diagnostic_jump_next<CR>", "diagnostic_jump_next" },
      o = { "<cmd>LSoutlineToggle<CR>", "LSoutlineToggle" },
      p = { "<CMD>Lspsaga diagnostic_jump_prev<CR>", "diagnostic_jump_prev" },
      P = { "<Cmd>Lspsaga preview_definition<CR>", "preview_definition" },
      r = { "<Cmd>Lspsaga rename<CR>", "rename" },
    },
  },

  m = {
    name = "more...",
    v = { "<cmd>vsplit<CR>", "VSplit" },
    h = { "<cmd>split<CR>", "HSplit" },
    b = {
      name = "Buffer Actions",
      p = { "<cmd>BufferLineTogglePin<CR>", "Pin Current Buffer" },
      a = { "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
        "Active Buffers", },
      t = { "<cmd>TodoTelescope<CR>", "Search TODOs" },
      l = { "<cmd>BufferLineMoveNext<CR>", "Move Forward" },
      h = { "<cmd>BufferLineMovePrev<CR>", "Move Backward" },
    },
    D = {
      name = "Docstring",
      f = { "<cmd>Neogen func<cr>", "Function" },
      c = { "<cmd>Neogen class<cr>", "Class" },
      t = { "<cmd>Neogen type<cr>", "Type" },
      F = { "<cmd>Neogen file<cr>", "File" },
    },
    m = {
      name = 'Move',
      w = { '<cmd>HopWord<cr>', ":HopWord" },
      l = { '<cmd>HopLine<cr>', ':HopLine' },
      c = { '<cmd>HopChar2<cr>', ':HopChar2' },
      p = { '<cmd>HopPattern<cr>', ':HopPattern' },
    },
    o = {
      name = 'Options'
    },
    r = {
      name = "SnipRun",
      c = { "<cmd>SnipClose<cr>", "Close" },
      f = { "<cmd>%SnipRun<cr>", "Run File" },
      l = { "<cmd>SnipRun<cr>", "Run Line" },
      m = { "<cmd>SnipReplMemoryClean<cr>", "Mem Clean" },
      r = { "<cmd>SnipReset<cr>", "Reset" },
      t = { "<cmd>SnipRunToggle<cr>", "Toggle" },
      x = { "<cmd>SnipTerminate<cr>", "Terminate" },
    },
    t = {
      name = "Tab Actions",
      e = { "<cmd>:tabedit<CR>", ":tabedit" }
    },
    T = {
      name = "Treesitter",
      h = { "<cmd>TSHighlightCapturesUnderCursor<cr>", "Highlight" },
      p = { "<cmd>TSPlaygroundToggle<cr>", "Playground" },
    },
    y = {
      name = "Yode",
      d = { "<cmd>YodeBufferDelete<CR>", "Delete Yode Buffer" },
      b = { "<cmd>YodeCreateSeditorReplace<CR>", "New Buffer Focus" },
      f = { "<cmd>YodeCreateSeditorFloating<CR>", "Float Focus" },
      c = { "<cmd>YodeCloneCurrentIntoFloat<CR>", "Yode Buffer to Float" },
      C = { "<cmd>YodeFloatToMainWindow<CR>", "Yode Float to Buffer" },
      r = { "<cmd>YodeRunInFile<CR>", "Yode cmdline" }
    }
  },

  p = {
    name = "Packer",
    c = { "<cmd>PackerCompile<cr>", "Compile" },
    i = { "<cmd>PackerInstall<cr>", "Install" },
    S = { "<cmd>PackerSync<cr>", "Sync" },
    s = { "<cmd>PackerStatus<cr>", "Status" },
    u = { "<cmd>PackerUpdate<cr>", "Update" },
  },

  -- r = {
  --     name = "Replace",
  --     r = { "<cmd>lua require('spectre').open()<cr>", "Replace" },
  --     w = { "<cmd>lua require('spectre').open_visual({select_word=true})<cr>", "Replace Word" },
  --     f = { "<cmd>lua require('spectre').open_file_search()<cr>", "Replace Buffer" },
  -- },

  r = {
    name = "Run",
    c = { "<cmd>RunCode<CR>", "Run Code" },
    r = { "<cmd>RunFile toggleterm<CR>", "Run File" },
    p = { "<cmd>RunProject<CR>", "Run Project" },
    j = {
      name = "JSON",
      s = { "Suported Files JSON" },
      p = { "List of Projects JSON" }
    }
  },

  s = {
    name = "Sessions",
    t = { "<cmd>lua require('user.session').toggle_session()<cr>", "Toggle Workspace Saving" },
    w = { "<cmd>lua require('user.session').save_session()<cr>", "Save New Workspace" },
    d = { "<cmd>lua require('user.session').delete_session()<cr>", "Delete Workspace" },
    l = { "<cmd>lua require('user.session').list_session()<cr>", "List Workspaces" },
  },

  t = {
    name = "Terminal",
    ["1"] = { ":1ToggleTerm<cr>", "1" },
    ["2"] = { ":2ToggleTerm<cr>", "2" },
    ["3"] = { ":3ToggleTerm<cr>", "3" },
    ["4"] = { ":4ToggleTerm<cr>", "4" },
    n = { "<cmd>lua _NODE_TOGGLE()<cr>", "Node" },
    u = { "<cmd>lua _NCDU_TOGGLE()<cr>", "NCDU" },
    m = { "<cmd>lua _HTOP_TOGGLE()<cr>", "Htop Monitor" },
    l = { "LazyGit" },
    p = { "<cmd>lua _PYTHON_TOGGLE()<cr>", "Python" },
    f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
    h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
    v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
    t = { "<cmd>ToggleTerm direction=tab<CR>", "Tab" }
  },
}

local vopts = {
  mode = "v", -- VISUAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local vmappings = {
  s = { "<esc><cmd>'<,'>SnipRun<cr>", "Snip Run Range" },
}

which_key.setup(setup)
which_key.register(mappings, opts)
which_key.register(vmappings, vopts)
