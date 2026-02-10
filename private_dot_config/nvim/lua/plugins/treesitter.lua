return {
	-- Highlight, edit, and navigate code
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter").setup({
			install_dir = vim.fn.stdpath("data") .. "/site",
		})

		-- Install parsers (async, no-op if already installed)
		require("nvim-treesitter").install({
			"vimdoc",
			"javascript",
			"typescript",
			"tsx",
			"ripple",
			"c",
			"lua",
			"rust",
			"jsdoc",
			"bash",
			"svelte",
			"astro",
			"vue",
			"css",
			"scss",
			"gdscript",
		})

		-- Enable treesitter highlighting and indentation
		vim.api.nvim_create_autocmd("FileType", {
			callback = function()
				pcall(vim.treesitter.start)
				vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})
	end,
}
