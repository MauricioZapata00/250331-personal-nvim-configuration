return {
	"navarasu/onedark.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require('onedark').setup {
			style = 'darker', -- 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light'
			transparent = false,
			term_colors = true,
			ending_tildes = false,
			diagnostics = {
				darker = true,
				undercurl = true,
				background = true,
			},
		}
		require('onedark').load()
	end
}
