-- Lazy.nvim kurulumu
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " " 
vim.opt.number = true 
vim.opt.relativenumber = true 
vim.opt.shiftwidth = 4 
vim.opt.tabstop = 4
vim.opt.expandtab = true 
vim.opt.termguicolors = true 

vim.keymap.set('n', '<A-j>', ':m .+1<CR>==', { desc = "Move line down" })
vim.keymap.set('n', '<A-k>', ':m .-2<CR>==', { desc = "Move line up" })


vim.keymap.set('v', '<A-j>', ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set('v', '<A-k>', ":m '<-2<CR>gv=gv", { desc = "Move selection up" })


require("lazy").setup("plugins")
