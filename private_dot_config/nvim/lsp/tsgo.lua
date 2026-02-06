return {
	cmd = { "tsgo", "--lsp", "--stdio" },
	filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
	-- Use .git to find monorepo root so vtsls indexes ALL packages
	root_markers = { ".git" },
	-- Reuse client across projects for cross-package references
	reuse_client = function(client, config)
		return client.name == config.name
	end,
	settings = {
		vtsls = {
			autoWorkspaceCache = true, -- Helps index the workspace in the background
			tsserver = {
				maxMemory = 8192, -- Give it 8GB of RAM for large projects
				globalPlugins = {
					{
						name = "typescript-svelte-plugin",
						location = vim.fn.stdpath("data")
							.. "/mason/packages/svelte-language-server/node_modules/typescript-svelte-plugin",
						enableForWorkspaceTypeScriptVersions = true,
					},
				},
			},
		},
		typescript = {
			tsserver = {
				maxTsServerMemory = 8192,
				maxMemory = 8192, -- Give it 8GB of RAM for large projects
			},
		},
	},
	commands = {
		-- Suppress "does not support command" notification for organize imports
		["_typescript.didOrganizeImports"] = function() end,
	},
}
