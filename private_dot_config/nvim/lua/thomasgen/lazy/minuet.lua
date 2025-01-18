return {
	{
		"milanglacier/minuet-ai.nvim",
		config = function()
			require("minuet").setup({
				provider = "codestral",
				codestral = {
					model = "codestral-latest",
					end_point = "https://codestral.mistral.ai/v1/fim/completions",
					api_key = "CODESTRAL_API_KEY",
					stream = true,
					optional = {
						max_tokens = 256,
						stop = { "\n\n" },
					},
				},
				virtualtext = {
					auto_trigger_ft = { "typescript", "svelte", "lua", "html", "astro" },
					keymap = {
						accept = "<A-A>",
						accept_line = "<A-a>",
						-- Cycle to prev completion item, or manually invoke completion
						prev = "<A-[>",
						-- Cycle to next completion item, or manually invoke completion
						next = "<A-]>",
						dismiss = "<A-e>",
					},
				},
			})
		end,
	},
	{ "nvim-lua/plenary.nvim" },
}
