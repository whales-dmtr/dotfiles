return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "v0.2.0",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			vim.keymap.set("n", "<leader>sf", "<cmd>Telescope find_files<CR>", { desc = "[S]earch [F]iles" })
			vim.keymap.set("n", "<leader>sg", "<cmd>Telescope live_grep<CR:>", { desc = "[S]earch by [G]rep" })
			vim.keymap.set(
				"n",
				"<leader>sh",
				"<cmd>Telescope find_files find_command=rg,--hidden,--files<CR>",
				{ desc = "[S]earch [C]olorscheme" }
			)
		end,
	},
}
