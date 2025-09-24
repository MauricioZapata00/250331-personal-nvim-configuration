return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls", "bashls", "dockerls", "docker_compose_language_service",
					"gopls", "jdtls", "ts_ls", "eslint", "jsonls", "pyright",
					"ruff", "rust_analyzer", "sqlls", "terraformls", "taplo",
					"lemminx", "yamlls",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- Use the new vim.lsp.config syntax (Neovim 0.11+)
			local servers = {
				"lua_ls", "bashls", "dockerls", "docker_compose_language_service",
				"gopls", "jdtls", "ts_ls", "eslint", "jsonls", "pyright",
				"ruff", "rust_analyzer", "sqlls", "terraformls", "taplo",
				"lemminx", "yamlls"
			}

			for _, server in ipairs(servers) do
				vim.lsp.config[server] = {
					capabilities = capabilities,
				}
			end

			-- Custom configuration for lua_ls
			vim.lsp.config.lua_ls = {
				capabilities = capabilities,
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			}

			-- Global mappings for diagnostics
			vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
			vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)

			-- LSP keymaps when server attaches
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

					-- Buffer-local keymaps
					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = ev.buf })
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = ev.buf })
					vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = ev.buf })
					vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = ev.buf })
					vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, { buffer = ev.buf })
					vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, { buffer = ev.buf })
					vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, { buffer = ev.buf })
					vim.keymap.set("n", "<leader>wl", function()
						print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
					end, { buffer = ev.buf })
					vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, { buffer = ev.buf })
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = ev.buf })
					vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { buffer = ev.buf })
					vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = ev.buf })
					vim.keymap.set("n", "<leader>f", function()
						vim.lsp.buf.format({ async = true })
					end, { buffer = ev.buf })
				end,
			})
		end,
	},
}
