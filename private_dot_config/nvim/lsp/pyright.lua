return {
	cmd = { "pyright-langserver", "--stdio" },
	filetypes = { "python" },
	root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" },
	on_new_config = function(new_config, root_dir)
		local resolved_root = vim.fs.normalize(vim.fn.expand(root_dir))
		local venv_python = resolved_root .. "/.venv/bin/python"
		if vim.uv.fs_stat(venv_python) then
			new_config.settings = new_config.settings or {}
			new_config.settings.python = new_config.settings.python or {}
			new_config.settings.python.pythonPath = venv_python
		end
	end,
	on_init = function(client)
		local root_dir = client.config.root_dir
		if not root_dir then
			return
		end

		local resolved_root = vim.fs.normalize(vim.fn.expand(root_dir))
		local venv_python = resolved_root .. "/.venv/bin/python"
		if vim.uv.fs_stat(venv_python) then
			client.config.settings = client.config.settings or {}
			client.config.settings.python = client.config.settings.python or {}
			client.config.settings.python.pythonPath = venv_python
			client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
		end
	end,
	settings = {
		python = {
			analysis = {
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
				diagnosticMode = "openFilesOnly",
			},
		},
	},
}
