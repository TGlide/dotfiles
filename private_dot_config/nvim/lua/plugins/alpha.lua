return {
	"goolord/alpha-nvim",
	dependencies = {
		{
			"catppuccin/nvim",
			name = "catppuccin",
			priority = 1000, -- Load colorscheme before other plugins
		},
		"echasnovski/mini.icons",
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local alpha_c = function()
			local alpha = require("alpha")
			local dashboard = require("alpha.themes.dashboard")
			local scan = require("plenary.scandir")

			-- Get the runtime path where your headers are stored
			local runtime_path = vim.fn.stdpath("config") .. "/lua/plugins/alpha_headers"

			-- Scan for all Lua files in the headers directory
			local headers = {}
			for _, file in ipairs(scan.scan_dir(runtime_path, { search_pattern = "%.lua$" })) do
				-- Extract just the filename without extension and path
				local header_name = vim.fn.fnamemodify(file, ":t:r")
				table.insert(headers, header_name)
			end

			-- Randomly select a header
			math.randomseed(os.time()) -- Initialize random seed
			local random_header = headers[math.random(#headers)]
			local random_header = "bee"

			-- Construct the full path and require the header
			local header = "plugins.alpha_headers." .. random_header
			require(header).setup(dashboard)

			dashboard.section.buttons.val = {
				dashboard.button("n", "  New file", "<Cmd>ene <CR>"),
				dashboard.button("SPC p f", "  Find file"),
				dashboard.button("SPC p v", "  Open Oil"),
				dashboard.button("SPC w q", "  Quit"),
			}
			for _, a in ipairs(dashboard.section.buttons.val) do
				a.opts.width = 49
				a.opts.cursor = -2
			end

			alpha.setup(dashboard.config)
		end

		alpha_c()
	end,
}
