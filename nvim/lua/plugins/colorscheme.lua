return {
	{
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			require("rose-pine").setup({})
			-- vim.cmd("colorscheme rose-pine-main")
		end,
	},
	{
		"shaunsingh/nord.nvim",
		opts = {
			transparent = true,
		},
		config = function()
			-- vim.g.nord_italic = false
			-- vim.g.nord_bold = false
			vim.cmd([[colorscheme nord]])

			vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
			vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
			vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
			vim.api.nvim_set_hl(0, "Pmenu", { bg = "none" })

			vim.opt.colorcolumn = "80"
		end,
	},
}
