-- Matugen-generated palette for use by other plugins
_G.matugen_palette = {
	color0 = "{{dank16.color0.default.hex}}",
	color1 = "{{dank16.color1.default.hex}}",
	color2 = "{{dank16.color2.default.hex}}",
	color3 = "{{dank16.color3.default.hex}}",
	color4 = "{{dank16.color4.default.hex}}",
	color5 = "{{dank16.color5.default.hex}}",
	color6 = "{{dank16.color6.default.hex}}",
	color7 = "{{dank16.color7.default.hex}}",
	color8 = "{{dank16.color8.default.hex}}",
	color9 = "{{dank16.color9.default.hex}}",
	color10 = "{{dank16.color10.default.hex}}",
	color11 = "{{dank16.color11.default.hex}}",
	color12 = "{{dank16.color12.default.hex}}",
	color13 = "{{dank16.color13.default.hex}}",
	color14 = "{{dank16.color14.default.hex}}",
	color15 = "{{dank16.color15.default.hex}}",
}

return {
	{
		"RRethy/base16-nvim",
		priority = 1000,
		config = function()
			require("base16-colorscheme").setup({
				base00 = "{{dank16.color0.default.hex}}",
				base01 = "{{dank16.color0.default.hex}}",
				base02 = "{{dank16.color8.default.hex}}",
				base03 = "{{dank16.color8.default.hex}}",
				base04 = "{{dank16.color7.default.hex}}",
				base05 = "{{dank16.color15.default.hex}}",
				base06 = "{{dank16.color15.default.hex}}",
				base07 = "{{dank16.color15.default.hex}}",
				base08 = "{{dank16.color9.default.hex}}",
				base09 = "{{dank16.color9.default.hex}}",
				base0A = "{{dank16.color12.default.hex}}",
				base0B = "{{dank16.color10.default.hex}}",
				base0C = "{{dank16.color14.default.hex}}",
				base0D = "{{dank16.color12.default.hex}}",
				base0E = "{{dank16.color13.default.hex}}",
				base0F = "{{dank16.color13.default.hex}}",
			})

			vim.api.nvim_set_hl(0, "Visual", {
				bg = "{{dank16.color8.default.hex}}",
				fg = "{{dank16.color15.default.hex}}",
				bold = true,
			})
			vim.api.nvim_set_hl(0, "Statusline", {
				bg = "{{dank16.color12.default.hex}}",
				fg = "{{dank16.color0.default.hex}}",
			})
			vim.api.nvim_set_hl(0, "LineNr", { fg = "{{dank16.color8.default.hex}}" })
			vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "{{dank16.color14.default.hex}}", bold = true })

			vim.api.nvim_set_hl(0, "Statement", {
				fg = "{{dank16.color13.default.hex}}",
				bold = true,
			})
			vim.api.nvim_set_hl(0, "Keyword", { link = "Statement" })
			vim.api.nvim_set_hl(0, "Repeat", { link = "Statement" })
			vim.api.nvim_set_hl(0, "Conditional", { link = "Statement" })

			vim.api.nvim_set_hl(0, "Function", {
				fg = "{{dank16.color12.default.hex}}",
				bold = true,
			})
			vim.api.nvim_set_hl(0, "Macro", {
				fg = "{{dank16.color12.default.hex}}",
				italic = true,
			})
			vim.api.nvim_set_hl(0, "@function.macro", { link = "Macro" })

			vim.api.nvim_set_hl(0, "Type", {
				fg = "{{dank16.color14.default.hex}}",
				bold = true,
				italic = true,
			})
			vim.api.nvim_set_hl(0, "Structure", { link = "Type" })

			vim.api.nvim_set_hl(0, "String", {
				fg = "{{dank16.color10.default.hex}}",
				italic = true,
			})

			vim.api.nvim_set_hl(0, "Operator", { fg = "{{dank16.color7.default.hex}}" })
			vim.api.nvim_set_hl(0, "Delimiter", { fg = "{{dank16.color7.default.hex}}" })
			vim.api.nvim_set_hl(0, "@punctuation.bracket", { link = "Delimiter" })
			vim.api.nvim_set_hl(0, "@punctuation.delimiter", { link = "Delimiter" })

			vim.api.nvim_set_hl(0, "Comment", {
				fg = "{{dank16.color8.default.hex}}",
				italic = true,
			})

			-- Transparent background
			vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
			vim.api.nvim_set_hl(0, "NormalNC", { bg = "NONE" })
			vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
			vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" })
			vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "NONE" })

			-- Emit event for other plugins to react to theme changes
			vim.api.nvim_exec_autocmds("User", { pattern = "MatugenReload" })

			local current_file_path = vim.fn.stdpath("config") .. "/lua/plugins/dankcolors.lua"
			if not _G._matugen_theme_watcher then
				local uv = vim.uv or vim.loop
				_G._matugen_theme_watcher = uv.new_fs_event()
				_G._matugen_theme_watcher:start(
					current_file_path,
					{},
					vim.schedule_wrap(function()
						local new_spec = dofile(current_file_path)
						if new_spec and new_spec[1] and new_spec[1].config then
							new_spec[1].config()
						end
					end)
				)
			end
		end,
	},
}
