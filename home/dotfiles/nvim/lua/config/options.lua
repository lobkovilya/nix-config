-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.cursorline = true
vim.opt.cursorcolumn = true

vim.opt.tabstop = 4 -- how wide a tab *looks*
vim.opt.softtabstop = 4 -- editing feels 4-wide
vim.opt.shiftwidth = 4 -- >> and << indent by 4

-- Disable conceal everywhere
vim.opt.conceallevel = 0
vim.opt.concealcursor = ""

vim.g.autoformat = false
