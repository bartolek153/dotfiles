return {

  -- handlers = {
  --   ['textDocument/publishDiagnostics'] = function(...) end
  -- },


  ------------------------
  ---To enable third-party module completion:

  -- 1 cd ~/.local/share/nvim/mason/packages/python-lsp-server/venv/
  -- 2 include-system-site-packages = true in pyvenv.cfg
  ------------------------

  settings = {
    pylsp = {
      plugins = {
        autopep8 = { enabled = true },
        black = { enabled = true },
        flake8 = { 
          enabled = true,
          executable = vim.fn.expand"$VIM/mason/bin/flake8.cmd",
        },
        -- jedi = {},
        mccabe = { enabled = false },
        -- preload = { enabled = false, modules = { "numpy", "scipy" } },
        pycodestyle = { enabled = false },
        pydocstyle = { enabled = false },
        pyflakes = { enabled = false },
        -- jedi = {}
        
        --pyls_mypy = { enabled = false },
        pyls_flake8 = { enabled = false },
        --pyls_isort = { enabled = true, executable = vim.fn.expand"$VIM/mason/bin/isort.cmd" },
        --python_lsp_black = { enabled = true, executable = vim.fn.expand"$VIM/mason/bin/black.cmd" }

        pylint = { 
          enabled = false,
          executable = vim.fn.expand"$VIM/mason/bin/pylint.cmd",
        },
        rope_completion = { enabled = false, eager = false },
        yapf = { enabled = false },
      },
      -- rope = { },
      
    },
  },
}
