return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					-- Lua
					"lua_ls",

					-- Shell
					"bashls",

					-- Docker
					"dockerls",
					"docker_compose_language_service",

					-- Go
					"gopls",

					-- Java
					"jdtls",

					-- JavaScript/TypeScript
					"ts_ls", -- Main TypeScript/JavaScript server
					"eslint",

					-- JSON
					"jsonls",

					-- Python
					"pyright",
					"ruff", -- Linter for Python

					-- Rust
					"rust_analyzer",

					-- SQL
					"sqlls",

					-- Terraform
					"terraformls",

					-- TOML
					"taplo",

					-- XML
					"lemminx",

					-- YAML
					"yamlls",
				}
			})
		end
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")
			-- Global mappings.
			-- See `:help vim.diagnostic.*` for documentation on any of the below functions
			vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
			vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
			vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
			vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

			-- Use LspAttach autocommand to only map the following keys
			-- after the language server attaches to the current buffer
			vim.api.nvim_create_autocmd('LspAttach', {
				group = vim.api.nvim_create_augroup('UserLspConfig', {}),
				callback = function(ev)
					-- Enable completion triggered by <c-x><c-o>
					vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

					-- Buffer local mappings.
					-- See `:help vim.lsp.*` for documentation on any of the below functions

					-- Go to definition, declaration, implementation, etc.
					vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, {})
					vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
					vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
					vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {})
					vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, {})
					vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, {})
					vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, {})
					vim.keymap.set('n', '<leader>wl', function()
						print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
					end, {})
					vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, {})

					-- Renaming and code actions
					vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {})
					vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, {})

					-- References, formatting
					vim.keymap.set('n', 'gr', vim.lsp.buf.references, {})
					vim.keymap.set('n', '<leader>f', function()
						vim.lsp.buf.format { async = true }
					end, {})
				end,
			})

			-- Setup all servers from the list above
			lspconfig.lua_ls.setup({})
			lspconfig.bashls.setup({})
			lspconfig.dockerls.setup({})
			lspconfig.docker_compose_language_service.setup({})
			lspconfig.gopls.setup({})
			lspconfig.jdtls.setup({})
			lspconfig.ts_ls.setup({})
			lspconfig.eslint.setup({})
			lspconfig.jsonls.setup({})
			lspconfig.pyright.setup({})
			lspconfig.ruff.setup({})
			lspconfig.rust_analyzer.setup({})
			lspconfig.sqlls.setup({})
			lspconfig.terraformls.setup({})
			lspconfig.taplo.setup({})
			lspconfig.lemminx.setup({})
			lspconfig.yamlls.setup({})
		end
	}
}
