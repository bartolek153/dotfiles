local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer. Close and reopen Neovim after..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

local status_ok, packer = pcall(require, 'packer')
if (not status_ok) then
  vim.notify("Packer Error")
  return
end



-- Have packer use a popup window
-- packer.init {
--   -- max_jobs = 10,
--   display = {
--     open_fn = function()
--       return require("packer.util").float { border = "rounded" }
--     end,
--   },
-- }

-- Install your plugins here
return packer.startup(function(use)

  --   ____  ____  ____  ____  _  _  ____  ____  _  _  ___  ____  ____  ___
  --  (  _ \( ___)(  _ \( ___)( \( )(  _ \( ___)( \( )/ __)(_  _)( ___)/ __)
  --   )(_) ))__)  )___/ )__)  )  (  )(_) ))__)  )  (( (__  _)(_  )__) \__ \
  --  (____/(____)(__)  (____)(_)\_)(____/(____)(_)\_)\___)(____)(____)(___/
  --
  use "wbthomason/packer.nvim" -- So that Packer manage itself
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used by lots of plugins
  use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" } -- Treesitter (syntax highlighting)
  use { "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" }

  --   __  __  ____
  --  (  )(  )(_  _)
  --   )(__)(  _)(_
  --  (______)(____)
  --
  use { 'dracula/vim' }
  use { 'sainnhe/sonokai' }
  use { 'morhetz/gruvbox' }
  -- use { 'arcticicestudio/nord-vim' }
  -- use { 'sainnhe/gruvbox-material' }
  -- use { 'sainnhe/everforest' }
  -- use { 'rebelot/kanagawa.nvim' }
  use "kyazdani42/nvim-web-devicons" -- Special development icons
  use "nvim-lualine/lualine.nvim" -- Status Line (Screen Bottom)
  use "akinsho/bufferline.nvim" -- TabLine / BufferLine (Screen Top)

  --   ____  ____  ____
  --  (_  _)(  _ \( ___)
  --   _)(_  )(_) ))__)
  --  (____)(____/(____)
  --
  use { "kylechui/nvim-surround", config = function() require("nvim-surround").setup() end }
  use { "nvim-telescope/telescope.nvim",
    -- Fuzzy Finder
    requires = {
      "nvim-telescope/telescope-file-browser.nvim",
      -- "ahmedkhalf/project.nvim",
      -- "nvim-telescope/telescope-project.nvim",
      -- "nvim-telescope/telescope-fzf-native.nvim",
      -- "cljoly/telescope-repo.nvim",
    },
  }
  use "akinsho/toggleterm.nvim" -- Terminal integrated to neovim
  use { "kyazdani42/nvim-tree.lua",
    -- File Explorer
    cmd = "NvimTreeToggle",
    config = function()
      require("lazyload.nvim-tree")
    end
  }
  use { 'numToStr/Comment.nvim', config = function() require('Comment').setup() end }

  --  __    ___  ____
  -- (  )  / __)(  _ \
  --  )(__ \__ \ )___/
  -- (____)(___/(__)
  --
  use { "neovim/nvim-lspconfig",
    -- Language Server Engine (built-in)
    requires = {
      -- "williamboman/nvim-lsp-installer", -- Language Server Installer
      "williamboman/mason.nvim", -- All-kind of tools installer
      "williamboman/mason-lspconfig.nvim", -- extension for mason.nvim
      "jose-elias-alvarez/null-ls.nvim", -- Language Server Formatter
      "glepnir/lspsaga.nvim", -- Lsp UIs
      "RRethy/vim-illuminate", -- Document Highlight
      -- "ray-x/lsp_signature.nvim", -- Signature Help Provider
      -- "j-hui/fidget.nvim", -- LSP Progress Show
    },
    config = function()
      require("user.lsp")
    end,
  }

  --   ___  _____  __  __  ____  __    ____  ____  ____  _____  _  _
  --  / __)(  _  )(  \/  )(  _ \(  )  ( ___)(_  _)(_  _)(  _  )( \( )
  -- ( (__  )(_)( )      ( )___/ )(__  )__)   )(   _)(_  )(_)( )   (
  --  \___)(_____)(_/\/\_)(__)  (____)(____) (__) (____)(_____)(_)\_)
  --
  use { "hrsh7th/nvim-cmp",
    -- The completion plugin
    disable = false,
    requires = {
      "hrsh7th/cmp-buffer", -- Buffer completions source
      "hrsh7th/cmp-path", -- Path completions source
      "hrsh7th/cmp-nvim-lsp", -- LSP completions source
      -- "hrsh7th/cmp-cmdline", -- Cmdline completions source
      -- "hrsh7th/cmp-nvim-lsp-signature-help", -- Signature Help completions source

      "onsails/lspkind.nvim", -- vscode-like pictograms

      "saadparwaiz1/cmp_luasnip", -- Snippet completions source
      "L3MON4D3/LuaSnip", -- Snippet Engine
      "rafamadriz/friendly-snippets", -- Colletion of snippets to use
      -- "honza/vim-snippets", -- Collection of snippets to use

      -- Pairs () [] {}
      "windwp/nvim-autopairs",
      "abecodes/tabout.nvim",
    },
  }

  --     ___  __  ____
  --    / __)(  )(_  _)
  --  _( (_ \ )(   )(
  -- (_)\___/(__) (__)
  --
  use { "lewis6991/gitsigns.nvim", config = function() require "gitsigns".setup() end }

  --  ____  _  _  ____  ____    __
  -- ( ___)( \/ )(_  _)(  _ \  /__\
  --  )__)  )  (   )(   )   / /(__)\
  -- (____)(_/\_) (__) (_)\_)(__)(__)
  --
  use 'lewis6991/impatient.nvim'
  use "nathom/filetype.nvim"
  use "dstein64/vim-startuptime"

  use "folke/which-key.nvim"
  use "folke/todo-comments.nvim" -- Special comment words highlighter
  use "folke/zen-mode.nvim"
  use "folke/twilight.nvim"
  use "folke/trouble.nvim"
  use "rcarriga/nvim-notify"
  use "moll/vim-bbye" -- Bdelete implementation
  -- use "goolord/alpha-nvim"
  -- use "karb94/neoscroll.nvim"
  -- use "filipdutescu/renamer.nvim"
  -- use 'michaelb/sniprun'
  -- use "mizlan/iswap.nvim"
  -- use "hoschi/yode-nvim"
  -- use "andymass/vim-matchup"
  -- use "lukas-reineke/indent-blankline.nvim"
  -- use "danymat/neogen"
  -- use "phaazon/hop.nvim"
  -- use "windwp/nvim-spectre"

  -- use { ,
  --   requires = "nvim-treesitter/nvim-treesitter",
  --   cmd =
  -- }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end

end)
