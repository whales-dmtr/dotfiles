vim.o.number = true
vim.o.relativenumber = true
vim.g.mapleader = " "
vim.o.signcolumn = "yes"
vim.o.cursorline = true
vim.o.showmode = true
vim.o.wrap = false
vim.o.winborder = "double"
vim.o.breakindent = false
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.guicursor = ""

-- Paste but don't put what was just replaced to register
vim.keymap.set("v", "<leader>p", '"_dP')

-- Keep cursor on the same place while searching
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Transparent background
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
vim.api.nvim_set_hl(0, "Pmenu", { bg = "none" })

vim.o.ignorecase = true
vim.o.smartcase = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.o.scrolloff = 10
vim.o.confirm = true

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Basic diagnostics keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Clipboard copy/cut/paste
vim.keymap.set({ "n", "v" }, "<leader>cy", '"+y')
vim.keymap.set({ "n", "v" }, "<leader>cd", '"+d')
vim.keymap.set({ "n", "v" }, "<leader>cp", '"+p')

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

vim.keymap.set("n", "<leader>lz", "<cmd>Lazy<CR>")

require("lazy").setup({
	"ThePrimeagen/vim-be-good",
	{ -- Adds git related signs to the gutter, as well as utilities for managing changes
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
	-- More git commands
	{
		"tpope/vim-fugitive",
		opts = {},
		config = function()
			vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
			vim.keymap.set("n", "<leader>gl", "<cmd>Git log<CR>")
		end,
	},
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
	-- Undotree
	{
		"mbbill/undotree",
		opts = {},
		config = function()
			vim.keymap.set("n", "<leader>u", function()
				vim.cmd.UndotreeToggle()
				vim.cmd.UndotreeFocus()
			end)

			-- Swap < Undotree
			vim.o.swapfile = false
			vim.o.backup = false
			vim.o.undodir = "~/.local/share/nvim/undotree"
			vim.o.undofile = true
		end,
	},
	-- Colorscheme
	{
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			require("rose-pine").setup({
				variant = "moon",
				styles = {
					bold = true,
					italic = false,
					transparency = true,
				},
			})
			vim.cmd("colorscheme rose-pine")
		end,
	},
	-- fzf
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
	-- Fix Lua global variables warnings in NeoVim config
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	-- Main LSP Config 🙏
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Automatically install LSPs and related tools to stdpath for Neovim
			-- Mason must be loaded before its dependents so we need to set it up here.
			-- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
			{ "mason-org/mason.nvim", opts = {} },
			"mason-org/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",

			-- Useful status updates for LSP.
			{ "j-hui/fidget.nvim", opts = {} },

			-- Allows extra capabilities provided by blink.cmp
			"saghen/blink.cmp",
		},
		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(event)
					local map = function(keys, func, desc, mode)
						mode = mode or "n"
						vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					map("gd", require("telescope.builtin").lsp_definitions, "[G]o to [R]eferences")
					map("gr", require("telescope.builtin").lsp_references, "[G]o to [R]eferences")
					map("K", vim.lsp.buf.hover, "Hover Documentation")

					map("grn", vim.lsp.buf.rename, "[R]e[n]ame")

					-- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
					---@param client vim.lsp.Client
					---@param method vim.lsp.protocol.Method
					---@param bufnr? integer some lsp support methods only in specific files
					---@return boolean
					local function client_supports_method(client, method, bufnr)
						if vim.fn.has("nvim-0.11") == 1 then
							return client:supports_method(method, bufnr)
						else
							return client.supports_method(method, { bufnr = bufnr })
						end
					end
				end,
			})

			-- Diagnostic Config
			-- See :help vim.diagnostic.Opts
			vim.diagnostic.config({
				severity_sort = true,
				float = { border = "rounded", source = "if_many" },
				underline = { severity = vim.diagnostic.severity.ERROR },
				signs = vim.g.have_nerd_font and {
					text = {
						[vim.diagnostic.severity.ERROR] = "󰅚 ",
						[vim.diagnostic.severity.WARN] = "󰀪 ",
						[vim.diagnostic.severity.INFO] = "󰋽 ",
						[vim.diagnostic.severity.HINT] = "󰌶 ",
					},
				} or {},
				virtual_text = {
					source = "if_many",
					spacing = 2,
					format = function(diagnostic)
						local diagnostic_message = {
							[vim.diagnostic.severity.ERROR] = diagnostic.message,
							[vim.diagnostic.severity.WARN] = diagnostic.message,
							[vim.diagnostic.severity.INFO] = diagnostic.message,
							[vim.diagnostic.severity.HINT] = diagnostic.message,
						}
						return diagnostic_message[diagnostic.severity]
					end,
				},
			})

			local servers = {
				clangd = {},
				gopls = {},

				pyright = {},

				html = {},
				cssls = {},
				jsonls = {},
				tsgo = {},

				bashls = {},

				lua_ls = {
					-- cmd = { ... },
					-- filetypes = { ... },
					-- capabilities = {},
					settings = {
						Lua = {
							completion = {
								callSnippet = "Replace",
							},
							-- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
							-- diagnostics = { disable = { 'missing-fields' } },
						},
					},
				},
			}

			-- From this to the line 226 is my way to load language servers
			-- And its just a spare way to do it

			-- local servers = {
			--     {
			--         "lua_ls",
			--         {
			--             -- Command and arguments to start the server.
			--             cmd = { 'lua-language-server' },
			--             -- Filetypes to automatically attach to.
			--             filetypes = { 'lua' },
			--             -- Sets the "workspace" to the directory where any of these files is found.
			--             -- Files that share a root directory will reuse the LSP server connection.
			--             -- Nested lists indicate equal priority, see |vim.lsp.Config|.
			--             root_markers = { { '.luarc.json', '.luarc.jsonc' }, '.git' },
			--             -- Specific settings to send to the server. The schema is server-defined.
			--             -- Example: https://raw.githubusercontent.com/LuaLS/vscode-lua/master/setting/schema.json
			--             settings = {
			--                 Lua = {
			--                     runtime = {
			--                         version = 'LuaJIT',
			--                     }
			--                 }
			--             }
			--         }
			--     },
			--     {
			--         "pyright",
			--         {}
			--     }
			-- }

			-- for i = 1, #servers do
			--     local server_name = servers[i][1]  -- { {"lua_lsp", ...}, {"pyright", ...} }
			--     local opts = servers[i][2]  -- { { ..., { cmd = { 'lua-language-server' } }, { ..., { cmd = ...} } }
			--
			--     vim.lsp.config[server_name] = opts
			--     vim.lsp.enable(server_name)
			-- end

			local capabilities = require("blink.cmp").get_lsp_capabilities()

			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				"stylua", -- Used to format Lua code
			})
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			require("mason-lspconfig").setup({
				ensure_installed = {}, -- explicitly set to an empty table (Kickstart populates installs via mason-tool-installer)
				automatic_installation = false,
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						-- This handles overriding only values explicitly passed
						-- by the server configuration above. Useful when disabling
						-- certain features of an LSP (for example, turning off formatting for ts_ls)
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})
		end,
	},
	-- Autocompletion
	{
		"saghen/blink.cmp",
		event = "VimEnter",
		version = "1.*",
		dependencies = {
			-- Snippet Engine
			{
				"L3MON4D3/LuaSnip",
				version = "2.*",
				build = (function()
					-- Build Step is needed for regex support in snippets.
					-- This step is not supported in many windows environments.
					-- Remove the below condition to re-enable on windows.
					if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
						return
					end
					return "make install_jsregexp"
				end)(),
				dependencies = {
					-- `friendly-snippets` contains a variety of premade snippets.
					--    See the README about individual language/framework/plugin snippets:
					--    https://github.com/rafamadriz/friendly-snippets
					-- {
					--   'rafamadriz/friendly-snippets',
					--   config = function()
					--     require('luasnip.loaders.from_vscode').lazy_load()
					--   end,
					-- },
				},
				opts = {},
			},
			"folke/lazydev.nvim",
		},
		--- @module 'blink.cmp'
		--- @type blink.cmp.Config
		opts = {
			keymap = {
				preset = "default",
			},

			appearance = {
				nerd_font_variant = "mono",
			},

			completion = {
				-- By default, you may press `<c-space>` to show the documentation.
				-- Optionally, set `auto_show = true` to show the documentation after a delay.
				documentation = { auto_show = false, auto_show_delay_ms = 500 },
			},

			sources = {
				default = { "lsp", "path", "snippets", "lazydev" },
				providers = {
					lazydev = { module = "lazydev.integrations.blink", score_offset = 100 },
				},
			},

			snippets = { preset = "luasnip" },

			-- Blink.cmp includes an optional, recommended rust fuzzy matcher,
			-- which automatically downloads a prebuilt binary when enabled.
			--
			-- By default, we use the Lua implementation instead, but you may enable
			-- the rust implementation via `'prefer_rust_with_warning'`
			--
			-- See :h blink-cmp-config-fuzzy for more information
			fuzzy = { implementation = "lua" },

			-- Shows a signature help window while you type arguments for a function
			signature = { enabled = true },
		},
	},
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>lf",
				function()
					require("conform").format({ async = true, lsp_format = "fallback" })
				end,
				mode = "",
				desc = "[F]ormat buffer",
			},
		},
		opts = {
			notify_on_error = false,
			-- format_on_save = function(bufnr)
			-- 	-- Disable "format_on_save lsp_fallback" for languages that don't
			-- 	-- have a well standardized coding style. You can add additional
			-- 	-- languages here or re-enable it for the disabled ones.
			-- 	local disable_filetypes = { c = true, cpp = true }
			-- 	if disable_filetypes[vim.bo[bufnr].filetype] then
			-- 		return nil
			-- 	else
			-- 		return {
			-- 			timeout_ms = 500,
			-- 			lsp_format = "fallback",
			-- 		}
			-- 	end
			-- end,
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "isort", "black" },
				javascript = { "prettierd", "prettier" },
			},
		},
	},
	{
		"stevearc/oil.nvim",
		---@module 'oil'
		---@type oil.SetupOpts
		opts = {},
		-- Optional dependencies
		dependencies = { { "nvim-mini/mini.icons", opts = {} } },
		-- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
		-- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
		lazy = false,
		config = function()
			require("oil").setup({
				use_default_keymaps = false,
				keymaps = {
					["<CR>"] = "actions.select",
					["g?"] = { "actions.show_help", mode = "n" },
					["<C-p>"] = "actions.preview",
					["g."] = { "actions.toggle_hidden", mode = "n" },
					["-"] = { "actions.parent", mode = "n" },
				},
			})
			-- g.  toggle hidden files
			vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
		end,
	},
	{
		"ThePrimeagen/harpoon",
		opts = {},
		config = function()
			local mark = require("harpoon.mark")
			local ui = require("harpoon.ui")

			vim.keymap.set("n", "<leader>a", mark.add_file)
			vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

			vim.keymap.set({ "n", "i" }, "<C-h>", function()
				ui.nav_file(1)
			end)
			vim.keymap.set({ "n", "i" }, "<C-j>", function()
				ui.nav_file(2)
			end)
			vim.keymap.set({ "n", "i" }, "<C-k>", function()
				ui.nav_file(3)
			end)
			vim.keymap.set({ "n", "i" }, "<C-l>", function()
				ui.nav_file(4)
			end)
		end,
	},
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
			-- Треба підібрати правильний івент щоб трісітер лоадився коли треба
			vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPost" }, {
				callback = function()
					vim.treesitter.start()
				end,
			})
		end,
	},
})
