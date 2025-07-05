return {
	"nvim-treesitter/nvim-treesitter-context",
	config = function()
		local p = require("rose-pine.palette")
		vim.api.nvim_set_hl(0, "TreesitterContext", { bg = p.base, ctermbg = "blue" })
	end,
}
