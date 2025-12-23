vim.o.number = true
vim.o.relativenumber = true
vim.g.mapleader = " "
vim.o.signcolumn = "yes"
vim.o.cursorline = true
vim.o.showmode = true vim.o.wrap = false
vim.o.winborder = "double"
vim.o.breakindent = false
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.guicursor = ""

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.scrolloff = 10
vim.o.confirm = true

vim.o.splitright = true
vim.o.splitbelow = true

-- Transparent background
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
vim.api.nvim_set_hl(0, "Pmenu", { bg = "none" })
