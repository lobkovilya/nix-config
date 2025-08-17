-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- disable float when jumping diagnostics

-- Jump to next diagnostic without float
vim.keymap.set("n", "]d", function()
  vim.diagnostic.jump({ count = 1, float = false })
end, { desc = "Next diagnostic" })

-- Jump to previous diagnostic without float
vim.keymap.set("n", "[d", function()
  vim.diagnostic.jump({ count = -1, float = false })
end, { desc = "Previous diagnostic" })
