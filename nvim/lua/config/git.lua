return {
	-- Adds git signs in the column line
	{
		"lewis6991/gitsigns.nvim",
        config = function ()
            vim.keymap.set("n", "<leader>gh", require("gitsigns").preview_hunk
        )
        end
	},
    {
        "tpope/vim-fugitive",
        config = function ()
            vim.keymap.set("n", "<leader>gs", "<cmd>Git<CR>")
            vim.keymap.set("n", "<leader>gl", "<cmd>Git log<CR>")
        end
    }
}
