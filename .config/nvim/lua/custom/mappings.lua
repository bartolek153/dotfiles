---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["tn"] = { ":tabnew<Return>", "edit in new tab"},
    ["th"] = { ":split<Return><C-w>W", "split in new tab"},
    ["tv"] = { ":vsplit<Return><C-w>W", "vsplit in new tab"},
    ["<leader>tt"] = {
      function()
        require("base46").toggle_transparency()
      end,
      "toggle transparency",
    },
  },
  v = {
    [">"] = { ">gv", "indent" },
  },
  t = {
    ["<c-h>"] = { "<C-\\><C-n><C-W>h", "move left"},
    ["<c-k>"] = { "<C-\\><C-n><C-W>k", "move up"},
    -- ["<c-j>"] = { "<C-\\><C-n><C-W>j", "move down"},
    -- ["<c-l>"] = { "<C-\\><C-n><C-W>l", "move right"}
  }
}

M.nvimtree = {
  n = {
    ["<C-b>"] = { "<cmd> NvimTreeToggle <CR>", "toggle nvimtree" },
  },
}

M.telescope = {
  n = {
    ["<C-p>"] = { "<cmd> Telescope find_files <CR>", "find files" },
  },
}

M.nvterm = {
  n = {
    ["<leader>gr"] = {

      function()
        local file = vim.fn.expand "%"

        local fts = {
          cpp = "clear && g++ " .. file .. " && ./a.out",
          -- python = "some command",
        }

        require("nvterm.terminal").send(fts[vim.bo.ft], "horizontal")
      end,

      "run commands based on current filetype",
    },
  },
}

return M
