return {
	{
		"ThePrimeagen/Vim-Be-Good",
		opts = {},
		config = function()
			-- vim game
			vim.keymap.set("n", "<leader>vg", "<cmd>VimBeGood<CR>")
		end,
	},
}
