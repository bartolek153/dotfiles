local status_ok, signature = pcall(require, "lsp_signature")
if not status_ok then return end


signature.setup({
  bind = true, -- This is mandatory, otherwise border config won't get registered.
  handler_opts = {
    border = "rounded"
  },
  max_height = 12,
  max_width = 40,
  floating_window_above_cur_line = true,
  hint_enable = false
})


vim.keymap.set({ 'i' }, '<C-k>', function()
  -- local cmp = require("cmp")
  -- if cmp.visible() then
  --   cmp.mapping.close()
  -- end
  signature.toggle_float_win()
end, { silent = true, noremap = true, desc = 'toggle signature' })
