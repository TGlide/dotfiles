return {
	"ecthelionvi/NeoComposer.nvim",
	enabled = false,
	dependencies = { "kkharji/sqlite.lua" },
	config = function()
		require("telescope").load_extension("macros")
	end,
	opts = {},
}
