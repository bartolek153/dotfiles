    local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
    return
end

-- column icon suggestion = ' :'
-- line icon suggestion = ' :'

local hide_in_width = function()
    return vim.fn.winwidth(0) > 100
end

local fileformat = {
    "fileformat",
    separator = { right = '' },
    padding = 1,
}

local mode = {
    "mode",
    fmt = function(str)
        return "" .. str .. " "
    end,
    padding = 0
}

local diagnostics = {
    "diagnostics",
    sources = { "nvim_diagnostic" },
    sections = { "error", "warn" },
    symbols = { error = " ", warn = " " },
    --sections = { "error", "warn", "info" },
    --symbols = { error = " ", warn = " ", info = " " },

    colored = false,
    update_in_insert = false,
    always_visible = true,
}

local filename = {
    'filename',
    file_status = true, -- Displays file status (readonly status, modified status)
    path = 1, -- 0: Just the filename
    -- 1: Relative path
    -- 2: Absolute path
    -- 3: Absolute path, with tilde as the home directory

    shorting_target = 40, -- Shortens path to leave 40 spaces in the window
    -- for other components. (terrible name, any suggestions?)
    symbols = {
        modified = '[+]', -- Text to show when the file is modified.
        readonly = '[-]', -- Text to show when the file is non-modifiable or readonly.
        unnamed = '--', -- Text to show for unnamed buffers.
    },
}

local branch = {
    "branch",
    icons_enabled = false,
    separator = { left = '', right = '' },
    padding = 0,
    fmt = function(str)
        if str == '' then
            return ""
        end
        return "%#TermCursor#" .. " " .. str .. "%*"
    end,
    cond = hide_in_width
}

local diff = {
    "diff",
    colored = false,
    symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
    cond = hide_in_width,
    padding = 1
}

local spaces = function()
    return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

local encoding = {
    "encoding",
    separator = { left = ' ', right = '' },
    padding = 1,
    cond = hide_in_width
}

local Available
local lsp = function()
    local buf_ftype = vim.api.nvim_buf_get_option(0, 'filetype')
    local clients = vim.lsp.get_active_clients()
    if next(clients) == nil then
        Available = false
        return "no lsp" 
    end
    for _, client in ipairs(clients) do
        local filetypes = client.config.filetypes
        if filetypes and vim.fn.index(filetypes, buf_ftype) ~= -1 then
            Available = true
            return client.name .. " "
        end
    end
    Available = false
    return "no lsp"
end

local lsp_is_available = function()
    return Available
end

local filetype = {
    "filetype",
    icon_only = true,
    separator = { left = ' ' --[[ , right = ' ' ]] },
    padding = 1,
    cond = lsp_is_available
}

local progress = function()
    local current_line = vim.fn.line(".")
    local total_lines = vim.fn.line("$")
    local chars = { "  ", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
    local line_ratio = current_line / total_lines
    local index = math.ceil(line_ratio * #chars)
    return chars[index]
end

local help_custom = {
    sections = {
        lualine_b = { {
            'filename',
            path = 0,
        } },
        lualine_z = { {
            'filetype',
            icon_only = true,
            padding = 1
        } }
    },
    filetypes = { 'help' }
}

local telescope = {
    sections = {
        lualine_a = { {
            function ()
                return "Telescope"
            end
        } },
        lualine_z = { {
            function ()
                return ""
            end
        } },
    },
    filetypes = { 'TelescopePrompt' }
}

lualine.setup({
    options = {
        icons_enabled = true,
        --theme = "auto",
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = { "alpha", "dashboard", },
    },
    sections = {
        lualine_a = { fileformat, mode },
        lualine_b = { diagnostics },
        lualine_c = { filename, branch, },
        lualine_x = { diff, { spaces, cond = hide_in_width, padding = 1 }, encoding, filetype,
            { lsp, separator = { left = ' ', right = nil }, padding = 1, cond = hide_in_width }, },
        lualine_y = { progress, {"progress", cond = hide_in_width} },
        lualine_z = { "location" },
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename", "branch" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
    },
      tabline = {},
    extensions = { help_custom, telescope, "toggleterm", "neo-tree", "symbols-outline", "man", "aerial", }, })
