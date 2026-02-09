return {
	cmd = { "biome", "lsp-proxy" },
	filetypes = {
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"json",
		"jsonc",
		"astro",
		"css",
		"graphql",
		"vue",
		"svelte",
	},
	root_markers = { "biome.json", "biome.jsonc" },
	on_attach = function(client, bufnr)
		vim.api.nvim_create_autocmd("BufWritePre", {
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.format({ bufnr = bufnr, id = client.id })
			end,
		})
	end,
}
