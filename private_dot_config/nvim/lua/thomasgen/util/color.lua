local M = {}

-- Convert hex color to RGB values
local function hex_to_rgb(hex)
	hex = hex:gsub("#", "")
	return tonumber("0x" .. hex:sub(1, 2)), tonumber("0x" .. hex:sub(3, 4)), tonumber("0x" .. hex:sub(5, 6))
end

-- Convert RGB values to hex color
local function rgb_to_hex(r, g, b)
	return string.format("#%02X%02X%02X", r, g, b)
end

-- Clamp a value between min and max
local function clamp(value, min, max)
	return math.min(math.max(value, min), max)
end

-- Darken a color by a percentage (0-100)
function M.darken(hex, percent)
	if not hex or not percent then
		return hex
	end

	local r, g, b = hex_to_rgb(hex)
	local factor = (100 - percent) / 100

	r = clamp(math.floor(r * factor), 0, 255)
	g = clamp(math.floor(g * factor), 0, 255)
	b = clamp(math.floor(b * factor), 0, 255)

	return rgb_to_hex(r, g, b)
end

-- Lighten a color by a percentage (0-100)
function M.lighten(hex, percent)
	if not hex or not percent then
		return hex
	end

	local r, g, b = hex_to_rgb(hex)
	local factor = 1 + (percent / 100)

	r = clamp(math.floor(r * factor), 0, 255)
	g = clamp(math.floor(g * factor), 0, 255)
	b = clamp(math.floor(b * factor), 0, 255)

	return rgb_to_hex(r, g, b)
end

-- Blend two colors with a given weight (0-1)
function M.blend(color1, color2, weight)
	weight = weight or 0.5
	local r1, g1, b1 = hex_to_rgb(color1)
	local r2, g2, b2 = hex_to_rgb(color2)

	local r = math.floor(r1 * (1 - weight) + r2 * weight)
	local g = math.floor(g1 * (1 - weight) + g2 * weight)
	local b = math.floor(b1 * (1 - weight) + b2 * weight)

	return rgb_to_hex(r, g, b)
end

-- Check if a color is light or dark
function M.is_light(hex)
	local r, g, b = hex_to_rgb(hex)
	-- Using relative luminance formula
	local luminance = (0.299 * r + 0.587 * g + 0.114 * b) / 255
	return luminance > 0.5
end

return M
