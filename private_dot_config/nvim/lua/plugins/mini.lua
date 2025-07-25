return {
	"echasnovski/mini.nvim",
	version = false,
	config = function()
		require("mini.ai").setup({
			-- Table with textobject id as fields, textobject specification as values.
			-- Also use this to disable builtin textobjects. See |MiniAi.config|.
			custom_textobjects = nil,

			-- Module mappings. Use `''` (empty string) to disable one.
			mappings = {
				-- Main textobject prefixes
				around = "a",
				inside = "i",

				-- Next/last variants
				around_next = "an",
				inside_next = "in",
				around_last = "al",
				inside_last = "il",

				-- Move cursor to corresponding edge of `a` textobject
				goto_left = "g[",
				goto_right = "g]",
			},

			-- Number of lines within which textobject is searched
			n_lines = 1000,

			-- How to search for object (first inside current line, then inside
			-- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
			-- 'cover_or_nearest', 'next', 'previous', 'nearest'.
			search_method = "cover_or_next",

			-- Whether to disable showing non-error feedback
			-- This also affects (purely informational) helper messages shown after
			-- idle time if user input is required.
			silent = false,
		})

		require("mini.surround").setup(
			-- No need to copy this inside `setup()`. Will be used automatically.
			{
				-- Add custom surroundings to be used on top of builtin ones. For more
				-- information with examples, see `:h MiniSurround.config`.
				custom_surroundings = nil,

				-- Duration (in ms) of highlight when calling `MiniSurround.highlight()`
				highlight_duration = 500,

				-- Module mappings. Use `''` (empty string) to disable one.
				mappings = {
					add = "sa", -- Add surrounding in Normal and Visual modes
					delete = "sd", -- Delete surrounding
					find = "sf", -- Find surrounding (to the right)
					find_left = "sF", -- Find surrounding (to the left)
					highlight = "sh", -- Highlight surrounding
					replace = "sr", -- Replace surrounding
					update_n_lines = "sn", -- Update `n_lines`

					suffix_last = "l", -- Suffix to search with "prev" method
					suffix_next = "n", -- Suffix to search with "next" method
				},

				-- Number of lines within which surrounding is searched
				n_lines = 1000,

				-- Whether to respect selection type:
				-- - Place surroundings on separate lines in linewise mode.
				-- - Place surroundings on each line in blockwise mode.
				respect_selection_type = false,

				-- How to search for surrounding (first inside current line, then inside
				-- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
				-- 'cover_or_nearest', 'next', 'prev', 'nearest'. For more details,
				-- see `:h MiniSurround.config`.
				search_method = "cover",

				-- Whether to disable showing non-error feedback
				-- This also affects (purely informational) helper messages shown after
				-- idle time if user input is required.
				silent = false,
			}
		)

		-- Create a custom command to wrap double quotes with {[]} at cursor position
		vim.api.nvim_create_user_command("WrapQuotesWithBrackets", function()
			-- Get cursor position (1-indexed for line, 0-indexed for column)
			local cursor = vim.api.nvim_win_get_cursor(0)
			local line_num = cursor[1]
			local col_num = cursor[2] + 1 -- Convert to 1-indexed for string operations

			-- Get the current line
			local line = vim.api.nvim_get_current_line()

			-- Find all quote pairs in the line
			local quote_start, quote_end = nil, nil
			local pos = 1

			while pos <= #line do
				local start_pos = line:find('"', pos)
				if not start_pos then
					break
				end

				local end_pos = line:find('"', start_pos + 1)
				if not end_pos then
					break
				end

				-- Check if cursor is within or on this quote pair
				if col_num >= start_pos and col_num <= end_pos then
					quote_start = start_pos
					quote_end = end_pos
					break
				end

				pos = end_pos + 1
			end

			-- If we found quotes surrounding the cursor, wrap them
			if quote_start and quote_end then
				local before = line:sub(1, quote_start - 1)
				local quoted_content = line:sub(quote_start, quote_end)
				local after = line:sub(quote_end + 1)

				local new_line = before .. "{[" .. quoted_content .. "]}" .. after

				-- Replace the line
				vim.api.nvim_set_current_line(new_line)

				-- Adjust cursor position (move it after the inserted characters)
				local new_col = col_num + 2 -- Account for the added '{[' characters
				vim.api.nvim_win_set_cursor(0, { line_num, new_col - 1 }) -- Convert back to 0-indexed
			else
				print("No quotes found at cursor position")
			end
		end, {
			desc = "Wrap double quotes at cursor with {[]}",
		})

		-- require("mini.pairs").setup({
		-- 	-- In which modes mappings from this `config` should be created
		-- 	modes = { insert = true, command = false, terminal = false },
		--
		-- 	-- Global mappings. Each right hand side should be a pair information, a
		-- 	-- table with at least these fields (see more in |MiniPairs.map|):
		-- 	-- - <action> - one of 'open', 'close', 'closeopen'.
		-- 	-- - <pair> - two character string for pair to be used.
		-- 	-- By default pair is not inserted after `\`, quotes are not recognized by
		-- 	-- `<CR>`, `'` does not insert pair after a letter.
		-- 	-- Only parts of tables can be tweaked (others will use these defaults).
		-- 	mappings = {
		-- 		["("] = { action = "open", pair = "()", neigh_pattern = "[^\\]." },
		-- 		["["] = { action = "open", pair = "[]", neigh_pattern = "[^\\]." },
		-- 		["{"] = { action = "open", pair = "{}", neigh_pattern = "[^\\]." },
		-- 		["<"] = { action = "open", pair = "<>", neigh_pattern = "[^\\]." },
		--
		-- 		[")"] = { action = "close", pair = "()", neigh_pattern = "[^\\]." },
		-- 		["]"] = { action = "close", pair = "[]", neigh_pattern = "[^\\]." },
		-- 		["}"] = { action = "close", pair = "{}", neigh_pattern = "[^\\]." },
		-- 		[">"] = { action = "close", pair = "<>", neigh_pattern = "[^\\]." },
		--
		-- 		['"'] = { action = "closeopen", pair = '""', neigh_pattern = "[^\\].", register = { cr = false } },
		-- 		["'"] = { action = "closeopen", pair = "''", neigh_pattern = "[^%a\\].", register = { cr = false } },
		-- 		["`"] = { action = "closeopen", pair = "``", neigh_pattern = "[^\\].", register = { cr = false } },
		-- 	},
		-- })

		require("mini.comment").setup({
			-- Options which control module behavior
			options = {
				-- Function to compute custom 'commentstring' (optional)
				custom_commentstring = nil,

				-- Whether to ignore blank lines when commenting
				ignore_blank_line = false,

				-- Whether to recognize as comment only lines without indent
				start_of_line = false,

				-- Whether to force single space inner padding for comment parts
				pad_comment_parts = true,
			},

			-- Module mappings. Use `''` (empty string) to disable one.
			mappings = {
				-- Toggle comment (like `gcip` - comment inner paragraph) for both
				-- Normal and Visual modes
				comment = "gc",

				-- Toggle comment on current line
				comment_line = "gcc",

				-- Toggle comment on visual selection
				comment_visual = "gc",

				-- Define 'comment' textobject (like `dgc` - delete whole comment block)
				-- Works also in Visual mode if mapping differs from `comment_visual`
				textobject = "gc",
			},

			-- Hook functions to be executed at certain stage of commenting
			hooks = {
				-- Before successful commenting. Does nothing by default.
				pre = function() end,
				-- After successful commenting. Does nothing by default.
				post = function() end,
			},
		})

		local miniclue = require("mini.clue")
		miniclue.setup({
			triggers = {
				-- Leader triggers
				{ mode = "n", keys = "<Leader>" },
				{ mode = "x", keys = "<Leader>" },

				-- Built-in completion
				{ mode = "i", keys = "<C-x>" },

				-- `g` key
				{ mode = "n", keys = "g" },
				{ mode = "x", keys = "g" },

				-- Marks
				{ mode = "n", keys = "'" },
				{ mode = "n", keys = "`" },
				{ mode = "x", keys = "'" },
				{ mode = "x", keys = "`" },

				-- Registers
				{ mode = "n", keys = '"' },
				{ mode = "x", keys = '"' },
				{ mode = "i", keys = "<C-r>" },
				{ mode = "c", keys = "<C-r>" },

				-- Window commands
				{ mode = "n", keys = "<C-w>" },

				-- `z` key
				{ mode = "n", keys = "z" },
				{ mode = "x", keys = "z" },
			},

			clues = {
				-- Enhance this by adding descriptions for <Leader> mapping groups
				miniclue.gen_clues.builtin_completion(),
				miniclue.gen_clues.g(),
				miniclue.gen_clues.marks(),
				miniclue.gen_clues.registers(),
				miniclue.gen_clues.windows(),
				miniclue.gen_clues.z(),
			},
		})

		-- local starter = require("mini.starter")
		-- starter.setup({
		-- 	evaluate_single = true,
		-- 	header = "hi",
		-- 	items = {
		-- 		starter.sections.builtin_actions(),
		-- 		starter.sections.telescope(),
		-- 		starter.sections.sessions(5, true),
		-- 	},
		-- })

		-- local sessions = require("mini.sessions")
		-- sessions.setup({
		-- 	autoread = true,
		-- })

		require("mini.move").setup({
			-- Module mappings. Use `''` (empty string) to disable one.
			mappings = {
				-- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
				left = "<M-left>",
				right = "<M-right>",
				down = "<M-down>",
				up = "<M-up>",

				-- Move current line in Normal mode
				line_left = "<M-left>",
				line_right = "<M-right>",
				line_down = "<M-down>",
				line_up = "<M-up>",
			},

			-- Options which control moving behavior
			options = {
				-- Automatically reindent selection during linewise vertical move
				reindent_linewise = true,
			},
		})

		require("mini.icons").setup({
			extension = {
				["spec.ts"] = { glyph = "", hl = "MiniIconsAzure" },
				["test.ts"] = { glyph = "", hl = "MiniIconsAzure" },
				["spec.svelte.ts"] = { glyph = "", hl = "MiniIconsAzure" },
				["test.svelte.ts"] = { glyph = "", hl = "MiniIconsAzure" },
				["svelte.ts"] = { glyph = "", hl = "MiniIconsAzure" },
			},
		})
	end,
}
