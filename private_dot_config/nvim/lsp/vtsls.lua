return {
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
}
