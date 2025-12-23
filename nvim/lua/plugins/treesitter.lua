return {
	-- Beautiful highlighting with treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter").setup({
				-- Directory to install parsers and queries to (prepended to `runtimepath` to have priority)
				install_dir = vim.fn.stdpath("data") .. "/site",
			})
			require("nvim-treesitter")
				.install({
					"bash",
					"c",
					"diff",
					"html",
					"lua",
					"luadoc",
					"markdown",
					"markdown_inline",
					"query",
					"vim",
					"vimdoc",
					"python",
				})
				:wait(300000) -- wait max. 5 minutes

			local syntax_on = {
				elixir = true,
				php = true,
			}

			vim.api.nvim_create_autocmd("FileType", {
				callback = function(args)
					local bufnr = args.buf
					local ok, parser = pcall(vim.treesitter.get_parser, bufnr)
					if not ok or not parser then
						return
					end
					pcall(vim.treesitter.start)

					local ft = vim.bo[bufnr].filetype
					if syntax_on[ft] then
						vim.bo[bufnr].syntax = "on"
					end
				end,
			})
		end,
	},
}
