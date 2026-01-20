local fallback_palette = {
	color0 = "#191724",
	color1 = "#eb6f92",
	color2 = "#31748f",
	color3 = "#f6c177",
	color4 = "#9ccfd8",
	color5 = "#c4a7e7",
	color6 = "#ebbcba",
	color7 = "#908caa",
	color8 = "#26233a",
	color9 = "#eb6f92",
	color10 = "#31748f",
	color11 = "#f6c177",
	color12 = "#9ccfd8",
	color13 = "#c4a7e7",
	color14 = "#ebbcba",
	color15 = "#e0def4",
}

local function build_theme()
	local c = _G.matugen_palette or fallback_palette
	local bg_base = "NONE"
	local dark = "#000000"
	local color = require("util.color")

	return {
		normal = {
			a = { bg = c.color4, fg = dark, gui = "bold" },
			b = { bg = color.darken(c.color4, 50), fg = c.color15 },
			c = { bg = c.color0, fg = c.color15 },
		},
		insert = {
			a = { bg = c.color2, fg = dark, gui = "bold" },
			b = { bg = color.darken(c.color2, 50), fg = c.color15 },
		},
		visual = {
			a = { bg = c.color5, fg = dark, gui = "bold" },
			b = { bg = color.darken(c.color5, 50), fg = c.color15 },
		},
		replace = {
			a = { bg = c.color3, fg = dark, gui = "bold" },
			b = { bg = color.darken(c.color3, 50), fg = c.color15 },
		},
		command = {
			a = { bg = c.color1, fg = dark, gui = "bold" },
			b = { bg = color.darken(c.color1, 50), fg = c.color15 },
		},
		inactive = {
			a = { bg = bg_base, fg = c.color7, gui = "bold" },
			b = { bg = bg_base, fg = c.color7 },
		},
	}
end

local function setup_macro_refresh(lualine)
	vim.api.nvim_create_autocmd("RecordingEnter", {
		callback = function()
			lualine.refresh({ place = { "statusline" } })
		end,
	})
	vim.api.nvim_create_autocmd("RecordingLeave", {
		callback = function()
			local timer = vim.loop.new_timer()
			timer:start(
				50,
				0,
				vim.schedule_wrap(function()
					lualine.refresh({ place = { "statusline" } })
				end)
			)
		end,
	})
end

local function macro_recording_status()
	return {
		"macro-recording",
		fmt = function()
			local register = vim.fn.reg_recording()
			return register == "" and "" or "RECORDING @" .. register
		end,
	}
end

local function heart()
	return [[♥ ]]
end

return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	init = function()
		vim.opt.laststatus = 0
	end,
	config = function()
		vim.opt.laststatus = 3

		local lualine = require("lualine")
		setup_macro_refresh(lualine)

		local function do_setup()
			lualine.setup({
				options = {
					theme = build_theme(),
					component_separators = "",
					section_separators = { left = "", right = "" },
					disabled_filetypes = { "alpha" },
				},
				sections = {
					lualine_a = {
						{ "mode", separator = { left = "", right = "" }, right_padding = 2 },
						macro_recording_status(),
					},
					lualine_b = { "diff", "diagnostics" },
					lualine_c = { { "filename", path = 1 } },
					lualine_x = { "filetype" },
					lualine_y = { "progress" },
					lualine_z = {
						{ "location", separator = { left = "" }, left_padding = 2 },
						{ heart, separator = { right = "" } },
					},
				},
				extensions = { "nvim-tree", "fzf" },
			})
		end

		do_setup()

		-- Re-setup lualine when matugen reloads theme
		vim.api.nvim_create_autocmd("User", {
			pattern = "MatugenReload",
			callback = do_setup,
		})
	end,
}
