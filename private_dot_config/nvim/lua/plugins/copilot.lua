return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	event = "InsertEnter",
	config = function()
		require("copilot").setup({
			panel = {
				enabled = true,
				auto_refresh = false,
				keymap = {
					jump_prev = "[[",
					jump_next = "]]",
					accept = "<CR>",
					refresh = "gr",
					open = "<M-CR>",
				},
				layout = {
					position = "bottom", -- | top | left | right | bottom |
					ratio = 0.4,
				},
			},
			suggestion = {
				enabled = true,
				auto_trigger = false,
				hide_during_completion = true,
				debounce = 75,
				trigger_on_accept = true,
				keymap = {
					accept = "<C-l>",
					accept_word = false,
					accept_line = false,
					next = "<C-k>",
					prev = "<C-j>",
					dismiss = "<C-/>",
				},
			},
			nes = {
				enabled = false, -- requires copilot-lsp as a dependency
				auto_trigger = false,
				keymap = {
					accept_and_goto = false,
					accept = false,
					dismiss = false,
				},
			},
		})
	end,
	-- opts = {
	-- 	suggestion = {
	-- 		enabled = true,
	-- 		auto_trigger = false, -- Don't show suggestions automatically
	-- 		keymap = {
	-- 			accept = "<C-y>",
	-- 			accept_word = "<C-w>",
	-- 			accept_line = "<C-l>",
	-- 			next = "<C-]>", -- Request/cycle suggestions
	-- 			prev = "<C-[>",
	-- 			dismiss = "<C-e>",
	-- 		},
	-- 	},
	-- 	panel = {
	-- 		enabled = true,
	-- 	},
	-- },
	-- keys = {
	-- 	{
	-- 		"<leader>ct",
	-- 		"<cmd>Copilot toggle<cr>",
	-- 		desc = "Copilot: Toggle auto-suggestions",
	-- 	},
	-- 	{
	-- 		"<leader>cp",
	-- 		"<cmd>Copilot panel<cr>",
	-- 		desc = "Copilot: Open panel",
	-- 	},
	-- },
}
