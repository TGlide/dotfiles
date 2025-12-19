return {
	cmd = { "vtsls", "--stdio" },
	filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
	root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
	settings = {
		vtsls = {
			tsserver = {
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
	},
	commands = {
		-- Suppress "does not support command" notification for organize imports
		["_typescript.didOrganizeImports"] = function() end,
	},
}
