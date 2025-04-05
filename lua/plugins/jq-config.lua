return {
	"gennaro-tedesco/nvim-jqx",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		-- You can configure keymaps here if you want
		vim.keymap.set("n", "<leader>jq", ":JqxList<CR>", { silent = true })
		vim.keymap.set("n", "<leader>jqq", ":JqxQuery<CR>", { silent = true })
	end,
	init = function()
		local jqx = require("nvim-jqx.config")
		jqx.geometry.width = 0.7
	end,
	event = { "BufReadPost" },
	ft = { "json" },
}
