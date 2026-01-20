local function getLen(str, start_pos)
	local byte = string.byte(str, start_pos)
	if not byte then
		return nil
	end

	return (byte < 0x80 and 1) or (byte < 0xE0 and 2) or (byte < 0xF0 and 3) or (byte < 0xF8 and 4) or 1
end

local function colorize(header, header_color_map, colors)
	for letter, color in pairs(colors) do
		local color_name = "AlphaJemuelKwelKwelWalangTatay" .. letter
		vim.api.nvim_set_hl(0, color_name, color)
		colors[letter] = color_name
	end

	local colorized = {}

	for i, line in ipairs(header_color_map) do
		local colorized_line = {}
		local pos = 0

		for j = 1, #line do
			local start = pos
			pos = pos + getLen(header[i], start + 1)

			local color_name = colors[line:sub(j, j)]
			if color_name then
				table.insert(colorized_line, { color_name, start, pos })
			end
		end

		table.insert(colorized, colorized_line)
	end

	return colorized
end

local M = {}

M.setup = function(dashboard)
	local header = {
		[[ ██████████████████████████████████████████████████████████████████████████████████████████████████████                                   ]],
		[[ ██████████████████████████████████████████████████████████████████████████████████████████████████████ ]],
		[[ ██████████████████████████████████████████████████████████████████████████████████████████████████████ ]],
		[[ ██████████████████████████████████████████████████████████████████████████████████████████████████████ ]],
		[[ ██████████████████████████████████████████████████████████████████████████████████████████████████████ ]],
		[[ ██████████████████████████████████████████████████████████████████████████████████████████████████████ ]],
		[[ ██████████████████████████████████████████████████████████████████████████████████████████████████████ ]],
		[[ ██████████████████████████████████████████████████████████████████████████████████████████████████████ ]],
		[[ ██████████████████████████████████████████████████████████████████████████████████████████████████████ ]],
		[[ ██████████████████████████████████████████████████████████████████████████████████████████████████████ ]],
		[[ ██████████████████████████████████████████████████████████████████████████████████████████████████████ ]],
		[[ ██████████████████████████████████████████████████████████████████████████████████████████████████████ ]],
		[[ ██████████████████████████████████████████████████████████████████████████████████████████████████████ ]],
		[[ ██████████████████████████████████████████████████████████████████████████████████████████████████████ ]],
		[[ ██████████████████████████████████████████████████████████████████████████████████████████████████████ ]],
		[[ ██████████████████████████████████████████████████████████████████████████████████████████████████████ ]],
		[[ ██████████████████████████████████████████████████████████████████████████████████████████████████████ ]],
		[[ ██████████████████████████████████████████████████████████████████████████████████████████████████████ ]],
		[[ ██████████████████████████████████████████████████████████████████████████████████████████████████████ ]],
		[[ ██████████████████████████████████████████████████████████████████████████████████████████████████████ ]],
	}

	local color_map = {
		[[ WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBWWWWWWWWWWWWWW ]],
		[[ RRRRWWWWWWWWWWWWWWWWRRRRRRRRRRRRRRRRWWWWWWWWWWWWWWWWBBPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPBBWWWWWWWWWWWW ]],
		[[ RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRBBPPPPPPHHHHHHHHHHHHHHHHHHHHHHHHHHPPPPPPBBWWWWWWWWWW ]],
		[[ RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRBBPPPPHHHHHHHHHHHHFFHHHHFFHHHHHHHHHHPPPPBBWWWWWWWWWW ]],
		[[ OOOORRRRRRRRRRRRRRRROOOOOOOOOOOOOOOORRRRRRRRRRRRRRBBPPHHHHFFHHHHHHHHHHHHHHHHHHHHHHHHHHHHPPBBWWWWWWWWWW ]],
		[[ OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOBBPPHHHHHHHHHHHHHHHHHHHHBBBBHHHHFFHHHHPPBBWWBBBBWWWW ]],
		[[ OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOBBPPHHHHHHHHHHHHHHHHHHBBMMMMBBHHHHHHHHPPBBBBMMMMBBWW ]],
		[[ YYYYOOOOOOOOOOOOOOOOYYYYYYYYYYYYYYYYOOBBBBBBBBOOOOBBPPHHHHHHHHHHHHFFHHHHBBMMMMMMBBHHHHHHPPBBMMMMMMBBWW ]],
		[[ YYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYBBMMMMBBBBOOBBPPHHHHHHHHHHHHHHHHHHBBMMMMMMMMBBBBBBBBMMMMMMMMBBWW ]],
		[[ YYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYBBBBMMMMBBBBBBPPHHHHHHFFHHHHHHHHHHBBMMMMMMMMMMMMMMMMMMMMMMMMBBWW ]],
		[[ GGGGYYYYYYYYYYYYYYYYGGGGGGGGGGGGGGGGYYYYBBBBMMMMBBBBPPHHHHHHHHHHHHHHFFBBMMMMMMMMMMMMMMMMMMMMMMMMMMMMBB ]],
		[[ GGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGBBBBMMMMBBPPHHFFHHHHHHHHHHHHBBMMMMMMCCBBMMMMMMMMMMCCBBMMMMBB ]],
		[[ GGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGBBBBBBBBPPHHHHHHHHHHHHHHHHBBMMMMMMBBBBMMMMMMBBMMBBBBMMMMBB ]],
		[[ UUUUGGGGGGGGGGGGGGGGUUUUUUUUUUUUUUUUGGGGGGGGGGGGBBBBPPHHHHHHHHHHFFHHHHBBMMRRRRMMMMMMMMMMMMMMMMMMRRRRBB ]],
		[[ UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUBBPPPPHHFFHHHHHHHHHHBBMMRRRRMMBBMMMMBBMMMMBBMMRRRRBB ]],
		[[ UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUBBPPPPPPHHHHHHHHHHHHHHBBMMMMMMBBBBBBBBBBBBBBMMMMBBWW ]],
		[[ VVVVUUUUUUUUUUUUUUUUVVVVVVVVVVVVVVVVUUUUUUUUUUUUBBBBBBPPPPPPPPPPPPPPPPPPPPBBMMMMMMMMMMMMMMMMMMMMBBWWWW ]],
		[[ VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVBBMMMMMMBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBWWWWWW ]],
		[[ VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVBBMMMMBBBBWWBBMMMMBBWWWWWWWWWWBBMMMMBBWWBBMMMMBBWWWWWWWW ]],
		[[ WWWWVVVVVVVVVVVVVVVVWWWWWWWWWWWWWWWWVVVVVVVVVVBBBBBBBBWWWWBBBBBBWWWWWWWWWWWWWWBBBBBBWWWWBBBBWWWWWWWWWW ]],
	}

	local c = {
		color0 = "#191724",
		color1 = "#eb6f92",
		color2 = "#31748f",
		color3 = "#f6c177",
		color4 = "#9ccfd8",
		color5 = "#c4a7e7",
		color6 = "#ebbcba",
		color7 = "#908caa",
		color8 = "#26233a",
		color15 = "#e0def4",
	}

	local colors = {
		["W"] = { fg = c.color0 },
		["C"] = { fg = c.color15 },
		["B"] = { fg = c.color8 },
		["R"] = { fg = c.color1 },
		["O"] = { fg = c.color6 },
		["Y"] = { fg = c.color3 },
		["G"] = { fg = c.color4 },
		["U"] = { fg = c.color2 },
		["P"] = { fg = c.color3 },
		["H"] = { fg = c.color5 },
		["F"] = { fg = c.color1 },
		["M"] = { fg = c.color7 },
		["V"] = { fg = c.color5 },
	}

	dashboard.section.header.val = header
	dashboard.section.header.opts = {
		hl = colorize(header, color_map, colors),
		position = "center",
	}
end

return M
