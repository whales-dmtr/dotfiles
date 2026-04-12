-- Options
vim.o.number = true
vim.o.relativenumber = true
vim.g.mapleader = " "
vim.o.wrap = false
vim.o.signcolumn = "yes"

vim.o.breakindent = false
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.scrolloff = 10

vim.o.winborder = "double"
vim.o.colorcolumn = "80"
vim.o.confirm = true
vim.o.guicursor = ""
vim.o.conceallevel = 2

vim.o.langmap =
"ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz"
vim.g.netrw_liststyle = 1
vim.g.netrw_banner = 0

-- Keymaps
vim.keymap.set("n", "<leader>w", "<cmd>w<CR>")
vim.keymap.set("n", "<leader>q", "<cmd>q<CR>")
vim.keymap.set("n", "<leader>r", "<cmd>restart<CR>")
vim.keymap.set("n", "-", "<cmd>Ex<CR>")

vim.keymap.set({ "n", "v" }, "<leader>cy", '"+y')
vim.keymap.set({ "n", "v" }, "<leader>cp", '"+p')
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("v", "<leader>p", '"_dP')
vim.keymap.set("n", "p", "]p")


-- Plugins
vim.pack.add({
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/ThePrimeagen/harpoon" },
    { src = "https://github.com/blazkowolf/gruber-darker.nvim" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/saghen/blink.cmp" },
    { src = "https://github.com/nvim-telescope/telescope.nvim" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
    { src = "https://github.com/stevearc/conform.nvim" },
    { src = "https://github.com/lewis6991/gitsigns.nvim" },
    { src = "https://github.com/axkirillov/unified.nvim" },
    { src = "https://github.com/mbbill/undotree" },
    { src = "https://github.com/ThePrimeagen/Vim-Be-Good" },
})

vim.keymap.set("n", "<leader>vg", "<cmd>Vim-Be-Good<CR>")

-- Harpoon
vim.keymap.set("n", "<C-e>", require("harpoon.ui").toggle_quick_menu)
vim.keymap.set("n", "<leader>a", require("harpoon.mark").add_file)

vim.keymap.set("n", "<C-h>", function()
    return require("harpoon.ui").nav_file(1)
end)
vim.keymap.set("n", "<C-j>", function()
    return require("harpoon.ui").nav_file(2)
end)
vim.keymap.set("n", "<C-k>", function()
    return require("harpoon.ui").nav_file(3)
end)
vim.keymap.set("n", "<C-l>", function()
    return require("harpoon.ui").nav_file(4)
end)

-- LSP
vim.lsp.enable('lua_ls')
vim.lsp.enable('pyright')

require("blink.cmp").setup({
    completion = {
        documentation = { auto_show = true, auto_show_delay_ms = 200 },
    },
    fuzzy = { implementation = "lua" },
})

require("conform").setup()
vim.keymap.set("n", "<leader>lf", function()
    require("conform").format({ async = true, lsp_format = "fallback" })
end)

-- Fuzzy finger (Telescope)
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>sf", builtin.find_files)
vim.keymap.set("n", "<leader>sg", builtin.live_grep)
vim.keymap.set("n", "<leader>sc", builtin.colorscheme)

-- Git
require("unified").setup()
vim.keymap.set("n", "]h", function()
    require("unified.navigation").next_hunk()
end)
vim.keymap.set("n", "[h", function()
    require("unified.navigation").previous_hunk()
end)

vim.keymap.set("n", "<leader>gd", vim.cmd.Unified)
vim.keymap.set("n", "<leader>gx", "<cmd>:Unified reset<CR>")

require("gitsigns").setup({
    signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
    },
})

-- Undotree
			vim.keymap.set("n", "<leader>u", function()
				vim.cmd.UndotreeToggle()
				vim.cmd.UndotreeFocus()
			end)

			-- Swap < Undotree
			vim.o.swapfile = false
			vim.o.backup = false
			vim.o.undodir = "/Users/dimaoleynik/.local/share/nvim/undotree"
			vim.o.undofile = true

-- Colorscheme
vim.cmd("colorscheme gruber-darker")

-- Proper highlighting with treesitter
require("nvim-treesitter").setup({
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
    :wait(300000)

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
    end
})

-- Autocommands
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})
