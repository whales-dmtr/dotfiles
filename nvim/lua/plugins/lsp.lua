return {
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
}
