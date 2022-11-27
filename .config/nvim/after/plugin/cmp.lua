local cmp_status_ok, cmp = pcall(require, "cmp")
if (not cmp_status_ok) then return end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
  return
end

local kind_status_ok, lspkind = pcall(require, "lspkind")
if not kind_status_ok then
  return
end

-- Snippets folder
-- local snippets_folder = vim.fn.stdpath "config" .. "/lua/user/snippets/"
-- require("luasnip.loaders.from_snipmate").lazy_load({ paths = snippets_folder })

-- Plugin built-ins
require("luasnip/loaders/from_vscode").lazy_load()

-- local check_backspace = function()
--   local col = vim.fn.col "." - 1
--   return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
-- end

cmp.setup {

  -- Snippet block
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body) -- For `luasnip` users.
    end,
  },

  -- Order in completion results
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
    -- { name = "nvim_lsp_signature_help" },
  },

  -- Menu Apperance
  formatting = {
    format = lspkind.cmp_format({ maxwidth = 50 })
  },

  -- Keymapping block
  mapping = {

    -- Toggles the plugin on and off
    ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.

    ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["<C-j>"] = cmp.mapping.select_next_item(),
    ["<PageDown>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }), -- for big cmp descriptions
    ["<PageUp>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }), -- show all cmp options avaiable
    ["<Escape>"] = cmp.mapping { i = cmp.mapping.abort(), c = cmp.mapping.close(), },
    ["<C-e>"] = cmp.mapping { -- close cmp menu
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }, -- close cmp menu
    -- Accept currently selected item. If none selected, `select` first item.
    -- Set `select` to `false` to only confirm explicitly selected items.
    ["<CR>"] = cmp.mapping.confirm { select = false },

    ["<Tab>"] = cmp.mapping(function(fallback)
      -- if cmp.visible() then
      -- cmp.select_next_item()
      -- elseif luasnip.expandable() then
      -- luasnip.expand()
      -- elseif luasnip.expand_or_jumpable() then
      -- luasnip.expand_or_jump()
      -- elseif check_backspace() then
      -- fallback()

      if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s", }, { "i", "c" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      --   if cmp.visible() then
      --     cmp.select_prev_item()
      --   elseif luasnip.jumpable(-1) then
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }, { "i", "c" }),
  },


  confirm = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  },

  -- documentation = true,
  window = {
    -- documentation = "native",
    documentation = {
      border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
      winhighlight = "NormalFloat:Pmenu,NormalFloat:Pmenu,CursorLine:PmenuSel,Search:None",
    },
    completion = {
      border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
      winhighlight = "NormalFloat:Pmenu,NormalFloat:Pmenu,CursorLine:PmenuSel,Search:None",
    },
  },
  experimental = {
    ghost_text = false,
    -- native_menu = false,
  },
}

-- Use buffer source for `/`
cmp.setup.cmdline("/", {
  sources = {
    { name = "buffer" },
  },
})
