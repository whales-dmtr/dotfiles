-- Paste already indented
vim.keymap.set("n", "p", "]p")

-- Paste but don't put what was just replaced to register
vim.keymap.set("v", "<leader>p", '"_dP')

-- Keep cursor centered while searching
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Keep cursor centered while jumping up and down
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Esc -> disable search highlighting
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Clipboard copy/paste
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y')
vim.keymap.set({ "n", "v" }, "<leader>d", '"+d')
vim.keymap.set({ "n", "v" }, "<leader>cp", '"+p')
vim.keymap.set({ "n", "v" }, "<leader>cP", '"+P')

-- No colon anymore
vim.keymap.set("n", "<leader>w", "<cmd>write<CR>")
vim.keymap.set("n", "<leader>q", "<cmd>quit<CR>")
vim.keymap.set("n", "<leader>r", "<cmd>restart<CR>")

-- Move selection
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- File Explorer
vim.keymap.set("n", "-", "<cmd>Ex<CR>")

-- Move the word to the next line in the insert mode
vim.keymap.set("i", "<C-n>", "Bi\n$a i")

-- Make a checkbox
vim.keymap.set("i", "<C-x>", "-  [ ]  ")
vim.keymap.set("i", "<C-z>", "*  [ ]  ")

-- Terminal commands
vim.keymap.set("n", "<leader>t", "<cmd>ToggleTerminal<CR>") -- See plugin/terminal.lua
vim.keymap.set("t", "<Esc><Esc>", "<C-n><C-\\>") -- Exit insert mode in terminal mode

-- vim.keymap.set("n", "<leader>e", function() -- [E]xecute
-- 	vim.cmd("ToggleTerminal")
--     if not job_id then
--         print("global variable job_id is not defined")
--     end
-- 	vim.fn.chansend(job_id, { "./build\r\n" })
-- end)
