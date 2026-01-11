return {
	"ThePrimeagen/Vim-Be-Good",
	-- Detect tabstop and shiftwidth automatically
	"NMAC427/guess-indent.nvim",
	-- Add vertical lines to show brackets scope
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		---@module "ibl"
		---@type ibl.config
		opts = {},
	},
	-- Add ) when you type (
	-- (work for all brackets)
	{
		"m4xshen/autoclose.nvim",
		opts = {},
	},

	-- Surround code with brackets
	{
		"echasnovski/mini.nvim",
		config = function()
			require("mini.surround").setup()
		end,
	},
}
