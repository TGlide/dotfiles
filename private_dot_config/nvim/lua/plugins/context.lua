return {
	"nvim-treesitter/nvim-treesitter-context",
	config = function()
		local c = _G.matugen_palette or { color0 = "#191724" }
		vim.api.nvim_set_hl(0, "TreesitterContext", { bg = c.color0, ctermbg = "blue" })
	end,
}
