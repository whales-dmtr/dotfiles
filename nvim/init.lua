-- Options
vim.opt.number = true
vim.opt.relativenumber = true
vim.g.mapleader = " "
vim.opt.wrap = false
vim.opt.signcolumn = "yes"
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.list = true
vim.opt.scrolloff = 10
vim.opt.confirm = true
vim.opt.langmap = "ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz"
vim.g.netrw_banner = 0

-- Keymaps
vim.keymap.set("n", "-", "<cmd>Ex<CR>")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("v", "\\p", '"_dP')
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y')
vim.keymap.set({ "n", "v" }, "<leader>d", '"+d')
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p')

-- Colortheme
vim.pack.add({"https://github.com/EdenEast/nightfox.nvim" })
vim.cmd.colorscheme("carbonfox")

-- Telescope 
vim.pack.add({
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/nvim-telescope/telescope.nvim" }
})
require("telescope").setup({})

vim.keymap.set("n", "<leader>ff", require("telescope.builtin").find_files)
vim.keymap.set("n", "<leader>fg", require("telescope.builtin").live_grep)
vim.keymap.set("n", "<leader>fb", require("telescope.builtin").buffers)

-- Fugitive (git)
vim.pack.add({"https://github.com/tpope/vim-fugitive"})
vim.keymap.set("n", "<leader>gs", "<cmd>Git<CR>")

-- TreeSitter
do
    vim.pack.add({ "https://github.com/nvim-treesitter/nvim-treesitter" })

    ---@param buf integer
    ---@param language string
    local function treesitter_try_attach(buf, language)
        if not vim.treesitter.language.add(language) then return end
        vim.treesitter.start(buf, language)
        local has_indent_query = vim.treesitter.query.get(language, 'indents') ~= nil
        if has_indent_query then
            vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
    end

    ---@param buf integer
    local function attach_buffer(buf)
        local filetype = vim.bo[buf].filetype
        local language = vim.treesitter.language.get_lang(filetype)
        if not language then return end

        local ts = require('nvim-treesitter')
        local installed_parsers = ts.get_installed('parsers')
        local available_parsers = ts.get_available()

        if vim.tbl_contains(installed_parsers, language) then
            treesitter_try_attach(buf, language)
        elseif vim.tbl_contains(available_parsers, language) then
            ts.install(language):await(function() treesitter_try_attach(buf, language) end)
        else
            treesitter_try_attach(buf, language)
        end
    end

    local function setup_treesitter()
        require('nvim-treesitter').setup({
            install_dir = vim.fn.stdpath('data') .. '/site',
        })

        local parsers = { 'rust', 'javascript', 'python', 'c', 'bash' }
        require('nvim-treesitter').install(parsers)

        vim.api.nvim_create_autocmd('FileType', {
            callback = function(args) attach_buffer(args.buf) end,
        })

        -- Catch up on buffers whose FileType already fired before this
        -- autocmd existed (e.g. the file you opened nvim with)
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].filetype ~= '' then
                attach_buffer(buf)
            end
        end
    end

    -- Defer the heavy setup/install call off the critical startup path
    vim.schedule(setup_treesitter)
end
