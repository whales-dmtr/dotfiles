return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "v0.2.0",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local builtin = require("telescope.builtin")
			-- local themes = require("telescope.themes")

			vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
			vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
			vim.keymap.set("n", "<leader>sc", builtin.colorscheme, { desc = "[S]earch [C]olorscheme" })

			-- local tl_bg_colour = "#232135"
			-- vim.api.nvim_set_hl(0, "TelescopeMatching", { bg = tl_bg_colour })
			-- vim.api.nvim_set_hl(0, "TelescopeSelection", { bg = tl_bg_colour })
			--
			-- vim.api.nvim_set_hl(0, "TelescopePromptTitle", { bg = tl_bg_colour })
			-- vim.api.nvim_set_hl(0, "TelescopePromptPrefix", { bg = tl_bg_colour })
			-- vim.api.nvim_set_hl(0, "TelescopePromptCounter", { bg = tl_bg_colour })
			-- vim.api.nvim_set_hl(0, "TelescopePromptNormal", { bg = tl_bg_colour })
			-- vim.api.nvim_set_hl(0, "TelescopePromptBorder", { bg = tl_bg_colour })
			--
			-- vim.api.nvim_set_hl(0, "TelescopeResultsTitle", { bg = tl_bg_colour })
			-- vim.api.nvim_set_hl(0, "TelescopeResultsNormal", { bg = tl_bg_colour })
			-- vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { bg = tl_bg_colour })
			--
			-- vim.api.nvim_set_hl(0, "TelescopePreviewTitle", { bg = tl_bg_colour })
			-- vim.api.nvim_set_hl(0, "TelescopePreviewNormal", { bg = tl_bg_colour })
			-- vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { bg = tl_bg_colour })
		end,
	},
}
