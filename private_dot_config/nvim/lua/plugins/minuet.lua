return {
	{
		"milanglacier/minuet-ai.nvim",
		priority = 1000,
		config = function()
			require("minuet").setup({
				provider = "openai_compatible",
				request_timeout = 2.5,
				throttle = 1500, -- Increase to reduce costs and avoid rate limits
				debounce = 600, -- Increase to reduce costs and avoid rate limits
				provider_options = {
					openai_compatible = {
						api_key = "OPENROUTER_API_KEY",
						end_point = "https://openrouter.ai/api/v1/chat/completions",
						model = "google/gemini-3-flash-preview",
						name = "Openrouter",
						optional = {
							max_tokens = 56,
							top_p = 0.9,
							provider = {
								-- Prioritize throughput for faster completion
								sort = "throughput",
							},
						},
					},
				},
			})
		end,
	},
	{ "nvim-lua/plenary.nvim" },
	-- optional, if you are using virtual-text frontend, blink is not required.
	{
		"Saghen/blink.cmp",
		config = function()
			require("blink-cmp").setup({
				keymap = {
					-- Manually invoke minuet completion.
					["<A-y>"] = require("minuet").make_blink_map(),
				},
				sources = {
					-- Enable minuet for autocomplete
					default = { "lsp", "path", "buffer", "snippets", "minuet" },
					-- For manual completion only, remove 'minuet' from default
					providers = {
						minuet = {
							name = "minuet",
							module = "minuet.blink",
							async = true,
							-- Should match minuet.config.request_timeout * 1000,
							-- since minuet.config.request_timeout is in seconds
							timeout_ms = 3000,
							score_offset = 50, -- Gives minuet higher priority among suggestions
						},
					},
				},
				-- Recommended to avoid unnecessary request
				completion = { trigger = { prefetch_on_insert = false } },
			})
		end,
	},
}
