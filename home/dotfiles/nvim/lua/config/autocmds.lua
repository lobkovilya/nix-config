-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
  pattern = { "*" },
  command = "silent! wall",
  nested = true,
})

local function hide_diagnostics()
  vim.diagnostic.config({ virtual_lines = false, virtual_text = false })
end

local function restore_diagnostics()
  vim.diagnostic.config({ virtual_lines = { current_line = true }, virtual_text = false })
end

-- Hide in Insert AND Select mode
vim.api.nvim_create_autocmd("ModeChanged", {
  pattern = { "*:i", "*:s" }, -- entering insert or select
  callback = hide_diagnostics,
})

-- Restore when leaving Insert/Select
vim.api.nvim_create_autocmd("ModeChanged", {
  pattern = { "i:*", "s:*" },
  callback = restore_diagnostics,
})
