return { -- Fuzzy Finder (files, lsp, etc)
	"nvim-telescope/telescope.nvim",
	event = "VimEnter",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ -- If encountering errors, see telescope-fzf-native README for installation instructions
			"nvim-telescope/telescope-fzf-native.nvim",

			-- `build` is used to run some command when the plugin is installed/updated.
			-- This is only run then, not every time Neovim starts up.
			build = "make",

			-- `cond` is a condition used to determine whether this plugin should be
			-- installed and loaded.
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
		{ "nvim-telescope/telescope-ui-select.nvim" },

		-- Useful for getting pretty icons, but requires a Nerd Font.
		{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
	},
	config = function()
		-- Telescope is a fuzzy finder that comes with a lot of different things that
		-- it can fuzzy find! It's more than just a "file finder", it can search
		-- many different aspects of Neovim, your workspace, LSP, and more!
		--
		-- The easiest way to use Telescope, is to start by doing something like:
		--  :Telescope help_tags
		--
		-- After running this command, a window will open up and you're able to
		-- type in the prompt window. You'll see a list of `help_tags` options and
		-- a corresponding preview of the help.
		--
		-- Two important keymaps to use while in Telescope are:
		--  - Insert mode: <c-/>
		--  - Normal mode: ?
		--
		-- This opens a window that shows you all of the keymaps for the current
		-- Telescope picker. This is really useful to discover what Telescope can
		-- do as well as how to actually do it!

		-- [[ Configure Telescope ]]
		-- See `:help telescope` and `:help telescope.setup()`
		require("telescope").setup({
			-- You can put your default mappings / updates / etc. in here
			--  All the info you're looking for is in `:help telescope.setup()`
			--
			-- defaults = {
			--   mappings = {
			--     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
			--   },
			-- },
			defaults = {
				file_ignore_patterns = { "node_modules", ".git" },
			},
			pickers = {
				find_files = {
					hidden = true,
					find_command = {
						"fd",
						"--type",
						"f",
						"--strip-cwd-prefix",
						"--follow",
						"--hidden",
						"--exclude",
						".git",
					},
				},
			},
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown(),
				},
				fzf = {
					fuzzy = true,
					override_generic_sorter = true,
					override_file_sorter = true,
					case_mode = "smart_case",
				},
			},
		})

		-- Enable Telescope extensions if they are installed
		pcall(require("telescope").load_extension, "fzf")
		pcall(require("telescope").load_extension, "ui-select")

		-- See `:help telescope.builtin`
		local builtin = require("telescope.builtin")
		-- vim.keymap.set("n", "<leader>t", ":Telescope<CR>", {})
		-- vim.keymap.set("n", "<leader>pf", function()
		-- 	builtin.find_files({
		-- 		file_ignore_patterns = { "node%_modules/.*", ".git/.*" },
		-- 	})
		-- end, { desc = "Find [F]iles" })
		-- vim.keymap.set("n", "<leader>ph", builtin.help_tags, { desc = "Search [H]elp" })
		-- vim.keymap.set("n", "<leader>pk", builtin.keymaps, { desc = "Search [K]eymaps" })
		-- vim.keymap.set("n", "<leader>ps", builtin.builtin, { desc = "Search [S]elect Telescope" })
		-- vim.keymap.set("n", "<leader>ps", function()
		-- 	-- builtin.live_grep()
		-- 	builtin.grep_string({ search = vim.fn.input("Grep > ") })
		-- end, { desc = "[P]roject [S]earch" })
		-- vim.keymap.set("n", "<leader>pw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
		-- vim.keymap.set("n", "<leader>pg", builtin.live_grep, { desc = "Search by [G]rep" })
		-- vim.keymap.set("n", "<leader>pd", builtin.diagnostics, { desc = "Search [D]iagnostics" })
		-- vim.keymap.set("n", "<leader>pr", builtin.resume, { desc = "Search [R]esume" })
		-- vim.keymap.set("n", "<leader>p.", builtin.oldfiles, { desc = 'Search Recent Files ("." for repeat)' })
		-- vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

		-- Slightly advanced example of overriding default behavior and theme
		-- vim.keymap.set("n", "<leader>/", function()
		-- 	-- You can pass additional configuration to Telescope to change the theme, layout, etc.
		-- 	builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		-- 		winblend = 10,
		-- 		previewer = false,
		-- 	}))
		-- end, { desc = "[/] Fuzzily search in current buffer" })
		--
		-- vim.keymap.set("n", "<leader>ch", builtin.command_history, { desc = "[C]ommand [H]istory" })
		-- vim.keymap.set("n", "<leader>cc", builtin.commands, { desc = "[C]ommands" })
	end,
}
