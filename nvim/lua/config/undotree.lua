return {
	{
		"mbbill/undotree",
		opts = {},
		config = function()
			vim.keymap.set("n", "<leader>u", function()
				vim.cmd.UndotreeToggle()
				vim.cmd.UndotreeFocus()
			end)

			-- Swap < Undotree
			vim.o.swapfile = false
			vim.o.backup = false
			vim.o.undodir = "/Users/dimaoleynik/.local/share/nvim/undotree"
			vim.o.undofile = true
		end,
	},
}
