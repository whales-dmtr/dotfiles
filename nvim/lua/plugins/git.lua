return {
	-- Adds git related signs to the gutter, as well as utilities for managing changes
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		},
	},
	-- Git Diff
	{
		"axkirillov/unified.nvim",
		config = function()
			require("unified").setup({
				-- your configuration comes here
			})
			vim.keymap.set("n", "]h", function()
				require("unified.navigation").next_hunk()
			end)
			vim.keymap.set("n", "[h", function()
				require("unified.navigation").previous_hunk()
			end)

			vim.keymap.set("n", "<leader>gd", vim.cmd.Unified)
			vim.keymap.set("n", "<leader>gx", "<cmd>:Unified reset<CR>")
		end,
	},
}
