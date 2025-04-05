return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")
		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

		null_ls.setup({
			sources = {
				-- Lua
				null_ls.builtins.formatting.stylua,

				-- Python
				-- null_ls.builtins.diagnostics.ruff,
				null_ls.builtins.formatting.black,
				null_ls.builtins.formatting.isort,
				null_ls.builtins.diagnostics.pylint,
				null_ls.builtins.diagnostics.mypy,

				-- Go
				null_ls.builtins.diagnostics.golangci_lint,
				null_ls.builtins.diagnostics.staticcheck,

				-- TypeScript/JavaScript
				null_ls.builtins.formatting.biome,

				-- YAML
				null_ls.builtins.diagnostics.yamllint,

				-- HTML, XML, JSON formatting with Prettier
				null_ls.builtins.formatting.prettier.with({
					filetypes = { "html", "xml", "json", "yaml", "markdown" },
					prefer_local = "node_modules/.bin",
				}),

				-- Java
				null_ls.builtins.diagnostics.checkstyle.with({
					extra_args = { "-c", vim.fn.expand("~/.config/nvim/linter-configs/checkstyle.xml") },
				}),
				null_ls.builtins.diagnostics.pmd.with({
					extra_args = { "-R", vim.fn.expand("~/.config/nvim/linter-configs/ruleset.xml") },
				}),

				-- General
				null_ls.builtins.completion.spell,
			},
			-- Configure format on save
			on_attach = function(client, bufnr)
				if client.supports_method("textDocument/formatting") then
					vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = augroup,
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({ bufnr = bufnr })
						end,
					})
				end
			end,
		})
	end,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"gwinn/none-ls-jsonlint.nvim",
	},
}
