---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
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
}

M.nvimtree = {
  n = {
    ["<C-b>"] = { "<cmd> NvimTreeToggle <CR>", "Toggle nvimtree" },
  },
}

M.telescope = {
  n = {
    ["<C-p>"] = { "<cmd> Telescope find_files <CR>", "Find files" },
  },
}

M.nvterm = {
  n = {
    ["<leader>gc"] = {

      function()
        local file = vim.fn.expand "%"

        local fts = {
          cpp = "clear && g++ -o out " .. file .. " && ./out",
          -- python = "some command",
        }

        require("nvterm.terminal").send(fts[vim.bo.ft], "horizontal")
      end,

      "run commands based on current filetype",
    },
  },
}

return M
