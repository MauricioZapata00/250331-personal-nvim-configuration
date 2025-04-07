return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"leoluz/nvim-dap-go",
	},
	config = function()
		require("dap-go").setup()
		require("dapui").setup()
		local dap, dapui = require("dap"), require("dapui")
		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end
		vim.keymap.set("n", "<leader>dc", function()
			dap.continue()
		end)
		vim.keymap.set("n", "<leader>dso", function()
			dap.step_over()
		end)
		vim.keymap.set("n", "<leader>di", function()
			dap.step_into()
		end)
		vim.keymap.set("n", "<leader>do", function()
			dap.step_out()
		end)
		vim.keymap.set("n", "<leader>b", function()
			dap.toggle_breakpoint()
		end)
		vim.keymap.set("n", "<leader>B", function()
			dap.set_breakpoint()
		end)
		vim.keymap.set("n", "<leader>dr", function()
			dap.repl.open()
		end)
		vim.keymap.set("n", "<leader>dl", function()
			dap.run_last()
		end)
	end,
}
