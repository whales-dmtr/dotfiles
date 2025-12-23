-- Paste but don't put what was just replaced to register
vim.keymap.set("v", "<leader>p", '"_dP')

-- Keep cursor on the same place while searching
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Basic diagnostics keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Clipboard copy/cut/paste
vim.keymap.set({ "n", "v" }, "<leader>cy", '"+y')
vim.keymap.set({ "n", "v" }, "<leader>cd", '"+d')
vim.keymap.set({ "n", "v" }, "<leader>cp", '"+p')

vim.keymap.set("n", "<leader>lz", "<cmd>Lazy<CR>")
