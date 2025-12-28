vim.o.number = true
vim.o.relativenumber = true
vim.g.mapleader = " "
vim.o.signcolumn = "yes"
vim.o.cursorline = true
vim.o.showmode = true
vim.o.wrap = false
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

vim.o.makeprg = "python3 %"

local function escape(str)
	local escape_chars = [[;,."|\]]
	return vim.fn.escape(str, escape_chars)
end

local en_shift = [[~QWERTYUIOP{}ASDFGHJKL:"ZXCVBNM<>]]
local ru_shift = [[ËЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ]]
local en = [[`qwertyuiop[]asdfghjkl;'zxcvbnm]]
local ru = [[ёйцукенгшщзхъфывапролджэячсмить]]
vim.opt.langmap = vim.fn.join({
	escape(ru_shift)
		.. ";"
		.. escape(en_shift),
	escape(ru) .. ";" .. escape(en),
}, ",")

