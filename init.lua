-- 1. Lazy.nvim Paket Yöneticisi Kurulumu
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- 2. Temel Editör Ayarları
vim.g.mapleader = " "          -- Leader tuşunu Space yapar
vim.opt.number = true          -- Satır numaralarını göster
vim.opt.relativenumber = true  -- Göreceli satır numaraları (Hızlı zıplamak için)
vim.opt.shiftwidth = 4         -- Tab genişliği
vim.opt.tabstop = 4
vim.opt.expandtab = true       -- Tab yerine boşluk kullan
vim.opt.termguicolors = true   -- 24-bit renk desteği

-- 3. Akıllı Satır Taşıma (Alt + j/k)
vim.keymap.set('n', '<A-j>', ':m .+1<CR>==', { desc = "Move line down" })
vim.keymap.set('n', '<A-k>', ':m .-2<CR>==', { desc = "Move line up" })
vim.keymap.set('v', '<A-j>', ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set('v', '<A-k>', ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- 4. Pencere Navigasyonu (Ctrl + h/j/k/l)
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')

-- Eklentileri Yükle
require("lazy").setup("plugins")
