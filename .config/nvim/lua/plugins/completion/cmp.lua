local cmp_status_ok, cmp = pcall(require, "cmp")
if (not cmp_status_ok) then return end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then return end

local kind_status_ok, lspkind = pcall(require, "lspkind")
if not kind_status_ok then return end

-- Snippets folder
-- local snippets_folder = vim.fn.stdpath "config" .. "/lua/user/snippets/"
-- require("luasnip.loaders.from_snipmate").lazy_load({ paths = snippets_folder })

-- Plugin built-ins
require("luasnip/loaders/from_vscode").lazy_load()



cmp.setup {

  -- Snippet block
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body) -- For `luasnip` users.
    end,
  },

  -- Order in completion results
  sources = {
    { name = "path" },
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
  },

  -- Menu Apperance
  formatting = {
    format = lspkind.cmp_format({ maxwidth = 50 })
  },

  -- Keymapping block
  mapping = {

    ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["<C-j>"] = cmp.mapping.select_next_item(),
    ["<PageDown>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }), -- for big cmp descriptions
    ["<PageUp>"] = cmp.mapping(cmp.mapping.scroll_docs( -1), { "i", "c" }),
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }), -- show all cmp options avaiable
    ["<Escape>"] = cmp.mapping { i = cmp.mapping.abort(), c = cmp.mapping.close(), },
    ["<C-e>"] = cmp.mapping { -- close cmp menu
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    },

    -- Accept currently selected item. If none selected, `select` first item.
    -- Set `select` to `false` to only confirm explicitly selected items.
    ["<CR>"] = cmp.mapping.confirm { select = false },

    ["<Tab>"] = cmp.mapping(function(fallback)
      if luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s", }),

    --   ["<S-Tab>"] = cmp.mapping(function(fallback)
    --
    --     if luasnip.jumpable(-1) then
    --       luasnip.jump(-1)
    --     else
    --       fallback()
    --     end
    --   end, { "i", "s", }),
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
