return {
	{
		"milanglacier/minuet-ai.nvim",
		enabled = false,
		config = function()
			require("minuet").setup({
				provider = "openai_fim_compatible",
				-- provider = "openai_compatible",
				request_timeout = 2.5,
				throttle = 1000, -- Increase to reduce costs and avoid rate limits
				debounce = 600, -- Increase to reduce costs and avoid rate limits
				provider_options = {
					openai_compatible = {
						api_key = "OPENROUTER_API_KEY",
						end_point = "https://openrouter.ai/api/v1/chat/completions",
						model = "openai/gpt-4o-mini",
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
					openai_fim_compatible = {
						-- For Windows users, TERM may not be present in environment variables.
						-- Consider using APPDATA instead.
						api_key = "TERM",
						name = "Ollama",
						end_point = "http://localhost:11434/v1/completions",
						-- model = "qwen3:14b",
						model = "qwen2.5-coder:7b",
						optional = {
							max_tokens = 56,
							top_p = 0.9,
						},
					},
				},
				virtualtext = {
					auto_trigger_ft = { "typescript", "svelte", "lua", "html", "astro" },
					keymap = {
						accept = "<A-a>",
						-- accept_line = "<A-a>",
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
