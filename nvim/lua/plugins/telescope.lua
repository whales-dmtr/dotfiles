return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "v0.2.0",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local builtin = require("telescope.builtin")
            -- local themes = require("telescope.themes")

            vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "Search Files" })
            vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
        end,
    },
}
