return {
	"nvim-treesitter/nvim-treesitter-context",
	enabled = false,
	config = function()
		local c = {
			color0 = "#191724",
			color1 = "#eb6f92",
			color2 = "#31748f",
			color3 = "#f6c177",
			color4 = "#9ccfd8",
			color5 = "#c4a7e7",
			color6 = "#ebbcba",
			color7 = "#908caa",
			color8 = "#26233a",
			color15 = "#e0def4",
		}
		local color = require("util.color")
		vim.api.nvim_set_hl(0, "TreesitterContext", {
			bg = color.blend(c.color15, c.color0, 0.8),
			ctermbg = "blue",
		})
	end,
}
