-- Paste already indented
vim.keymap.set("n", "p", "]p")

-- Paste but don't put what was just replaced to register
vim.keymap.set("v", "<leader>p", '"_dP')

-- Keep cursor on the same place while searching
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Esc -> disable search highlighting
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Clipboard copy/paste
vim.keymap.set({ "n", "v" }, "<leader>cy", '"+y')
vim.keymap.set({ "n", "v" }, "<leader>cp", '"+p')

-- No colon anymore
vim.keymap.set('n', "<leader>w",  "<cmd>write<CR>")
vim.keymap.set('n', "<leader>q", "<cmd>quit<CR>")

-- File Explorer
vim.keymap.set('n', "-", "<cmd>Ex<CR>")

-- Move the word to the next line in the insert mode
vim.keymap.set('i', '<C-n>', 'Bi\n$a i')

