return {
	"Exafunction/codeium.nvim",
	enabled = false,
	commit = "937667b2cadc7905e6b9ba18ecf84694cf227567",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"hrsh7th/nvim-cmp",
	},
	config = function()
		require("codeium").setup({
			enable_cmp_source = true,
			virtual_text = {
				enabled = false,
			},
		})

		local map = function(keys, func, desc, mode)
			mode = mode or "n"
			vim.keymap.set(mode, keys, func, { desc = desc })
		end

		map("<leader>cd", function()
			vim.cmd("CodeiumDisable")
			vim.notify("Codeium disabled", vim.log.levels.INFO, { title = "Codeium" })
		end, "Disable Codeium")

		map("<leader>ce", function()
			vim.cmd("CodeiumEnable")
			vim.notify("Codeium enabled", vim.log.levels.INFO, { title = "Codeium" })
		end, "Enable Codeium")

		map("<leader>ct", function()
			vim.cmd("CodeiumToggle")
			vim.notify("Codeium toggled", vim.log.levels.INFO, { title = "Codeium" })
		end, "Toggle Codeium")
	end,
}
