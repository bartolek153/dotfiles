-- Automatically install lazy-nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


vim.keymap.set("n", "<F5>", "<cmd>Lazy sync<cr>")


local status_ok, lazy = pcall(require, 'lazy')
if (not status_ok) then
  vim.notify("Lazy.nvim Error")
  return
end



local plugins = {

  --   ____  ____  ____  ____  _  _  ____  ____  _  _  ___  ____  ____  ___
  --  (  _ \( ___)(  _ \( ___)( \( )(  _ \( ___)( \( )/ __)(_  _)( ___)/ __)
  --   )(_) ))__)  )___/ )__)  )  (  )(_) ))__)  )  (( (__  _)(_  )__) \__ \
  --  (____/(____)(__)  (____)(_)\_)(____/(____)(_)\_)\___)(____)(____)(___/
  --
  { "nvim-lua/popup.nvim" },
  { "nvim-lua/plenary.nvim" },
  { "nvim-tree/nvim-web-devicons" },

  {
    "nvim-treesitter/nvim-treesitter", -- Treesitter (syntax highlighting)
    build = ":TSUpdate",
    config = function()
      require('plugins.treesitter')
    end
  },


  --   __  __  ____
  --  (  )(  )(_  _)
  --   )(__)(  _)(_
  --  (______)(____)
  --
  {
    'dracula/vim',
    lazy = false,
    config = function()
      vim.cmd([[
          syntax enable

          let g:dracula_bold = 0
          let g:dracula_italic = 1
          let g:dracula_underline = 0
          let g:dracula_undercurl = 1
          let g:dracula_full_special_attrs_support = 1
          let g:dracula_inverse = 0
          let g:dracula_colorterm = 1

          colorscheme dracula

          hi! NeoTreeNormal guibg=#21222C
          hi! CursorLineNr guibg=#5F6A8E
        ]])
    end
  },

  -- use { 'sainnhe/sonokai' }
  -- use { 'morhetz/gruvbox' }
  -- use { 'arcticicestudio/nord-vim' }
  -- use { 'sainnhe/gruvbox-material' }
  -- use { 'sainnhe/everforest' }
  -- use { 'rebelot/kanagawa.nvim' }
  -- use { 'folke/tokyonight' }

  {
    "akinsho/bufferline.nvim", -- TabLine / BufferLine (Screen Top)
    config = function()
      require("plugins.bufferline")
    end
  },

  {
    "nvim-lualine/lualine.nvim", -- Status Line (Screen Bottom)
    config = function()
      require("plugins.lualine")
    end
  },

  {
    "karb94/neoscroll.nvim",
    config = function()
      require('neoscroll').setup({
        mappings = { "<C-d>", "<C-u>", "zt", "zz", "zb", "<PageUp>", "<PageDown>" },
      })
    end,
    event = "VeryLazy"
  },

  {
    "rcarriga/nvim-notify",
    config = function()
      require("plugins.notify")
    end
  },

  -- {
  --   "lukas-reineke/indent-blankline.nvim",
  --     config = function()
  --       vim.opt.list = true
  --       vim.opt.listchars:append "space:⋅"
  --       vim.opt.listchars:append "eol:↴"
  --
  --       require("indent_blankline").setup {
  --           --space_char_blankline = " ",
  --           --show_current_context = true,
  --           --show_current_context_start = true,
  --       }
  --     end
  -- },

  {
    "NvChad/nvim-colorizer.lua", -- Color highlighter
    config = function()
      require("colorizer").setup()
    end,

    ft = {
      'html', 'javascript', 'typescript',
      'vue', 'tsx', 'jsx', 'xml', 'php', 'lua'
    },

    event = "VeryLazy"
  },


  --   ____  ____  ____
  --  (_  _)(  _ \( ___)
  --   _)(_  )(_) ))__)
  --  (____)(____/(____)
  --
  {
    "akinsho/toggleterm.nvim", -- Terminal integrated to neovim
    config = function()
      require("plugins.toggleterm")
    end,
    keys = { "<C-\\>" },
    cmd = { "ToggleTerm" }
  },

  {
    "petertriho/nvim-scrollbar",
    config = function()
      require("scrollbar").setup()
    end,
    event = "BufEnter"
  },

  -- Auto generates documentation
  -- { "danymat/neogen" },

  {
    "goolord/alpha-nvim", -- a lua powered greeter like vim-startify / dashboard-nvim
    config = function()
      require("plugins.alpha")
    end
  },

  {
    "nvim-neo-tree/neo-tree.nvim", -- File Explorer
    config = function()
      require("plugins.neo-tree")
    end,
    dependencies = { "MunifTanjim/nui.nvim" },
    keys = { "<C-B>" },
    cmd = { "NeoTree" }
  },

  {
    "nvim-telescope/telescope.nvim", -- Fuzzy Finder
    dependencies = {
      "nvim-telescope/telescope-file-browser.nvim",
      -- "ahmedkhalf/project.nvim",
      -- "nvim-telescope/telescope-project.nvim",
      -- "nvim-telescope/telescope-fzf-native.nvim",
      -- "cljoly/telescope-repo.nvim",
    },
    config = function()
      require("plugins.telescope")
    end
  },

  {
    "nvim-pack/nvim-spectre", -- Search & Replace
    config = function()
      require("plugins.spectre")
    end,
    event = "VeryLazy"
  },

  -- Toggle comments
  { 'numToStr/Comment.nvim',   config = function() require('Comment').setup() end },

  -- Insert {} [] () at some selection
  { "kylechui/nvim-surround",  config = true,                                     event = "VeryLazy" },

  -- Http requests
  -- {
  --   "aquach/vim-http-client",
  --   config = function() require("rest-nvim").setup() end,
  --   -- cmd = { "RestNvim" }
  -- },


  --     ___  __  ____
  --    / __)(  )(_  _)
  --  _( (_ \ )(   )(
  -- (_)\___/(__) (__)
  --
  { "lewis6991/gitsigns.nvim", config = function() require "gitsigns".setup() end },


  --   ___  _____  __  __  ____  __    ____  ____  ____  _____  _  _
  --  / __)(  _  )(  \/  )(  _ \(  )  ( ___)(_  _)(_  _)(  _  )( \( )
  -- ( (__  )(_)( )      ( )___/ )(__  )__)   )(   _)(_  )(_)( )   (
  --  \___)(_____)(_/\/\_)(__)  (____)(____) (__) (____)(_____)(_)\_)
  --
  {
    "hrsh7th/nvim-cmp", -- The completion plugin
    enabled = true,


    -- event = "InsertEnter",

    config = function()
      require("plugins.completion")
    end,

    dependencies = {
      "hrsh7th/cmp-buffer",           -- Buffer completions source
      "hrsh7th/cmp-path",             -- Path completions source
      "hrsh7th/cmp-nvim-lsp",         -- LSP completions source
      "saadparwaiz1/cmp_luasnip",     -- Snippet completions source

      "onsails/lspkind.nvim",         -- vscode-like pictograms

      "L3MON4D3/LuaSnip",             -- Snippet Engine
      "rafamadriz/friendly-snippets", -- Colletion of snippets to use
      -- "honza/vim-snippets", -- Collection of snippets to use

      "windwp/nvim-autopairs",
      "abecodes/tabout.nvim",
    }
  },

  {
    "windwp/nvim-ts-autotag", -- Automatic Tag Web completion
    ft = {
      'html', 'javascript', 'typescript',
      'vue', 'tsx', 'jsx', 'xml', 'php'
    }
  },


  --  __    ___  ____
  -- (  )  / __)(  _ \
  --  )(__ \__ \ )___/
  -- (____)(___/(__)
  --
  {
    "neovim/nvim-lspconfig", -- Language Server Engine (built-in)

    dependencies = {
      "williamboman/mason.nvim",           -- All-kind of tools installer
      "williamboman/mason-lspconfig.nvim", -- extension for mason.nvim
      "jose-elias-alvarez/null-ls.nvim",   -- Language Server Formatter
      "glepnir/lspsaga.nvim",              -- Lsp UIs
      "ray-x/lsp_signature.nvim",          -- Signature Help Provider
      -- "j-hui/fidget.nvim", -- LSP Progress Show
      "folke/trouble.nvim",                -- diagnostics window
      -- "RRethy/vim-illuminate", -- Document Highlight
    },
    config = function()
      require("plugins.lsp")
    end,
  },


  --  ____  _  _  ____  ____    __
  -- ( ___)( \/ )(_  _)(  _ \  /__\
  --  )__)  )  (   )(   )   / /(__)\
  -- (____)(_/\_) (__) (_)\_)(__)(__)
  --

  -- Bdelete implementation
  { "moll/vim-bbye",            event = "VeryLazy" },

  -- Measure time to start up neovim
  { "dstein64/vim-startuptime", cmd = "StartupTime" },

  -- Highlight matching characters
  -- {
  --   "andymass/vim-matchup",
  --   config = function()
  --     vim.cmd [[hi! link MatchParen CursorLineNr ]]
  --   end,
  -- },

  { "mizlan/iswap.nvim",        event = "VeryLazy" },

  {
    "folke/which-key.nvim",
    enabled = false,
    config = function()
      require("plugins.whichkey")
    end
  },

  {
    "folke/zen-mode.nvim",
    enabled = false,
    config = function()
      require("plugins.zen")
    end,
    dependencies = {
      "folke/twilight.nvim"
    }
  },
}

local opts = {
  defaults = {
    lazy = false
  }
}



lazy.setup(plugins, opts)
