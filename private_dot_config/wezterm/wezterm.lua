local wezterm = require("wezterm")
local act = wezterm.action

-- This will hold the configuration.
local config = wezterm.config_builder()

-- for theming
wezterm.add_to_config_reload_watch_list(wezterm.config_dir .. "/colors/dank-theme.toml")
config.color_scheme = "dank-theme"
config.window_background_opacity = 0.9
config.automatically_reload_config = true

-- for niri compat
config.window_decorations = "RESIZE"
config.use_resize_increments = false
config.enable_wayland = true

-- keybinds
config.keys = {
	{ key = "PageDown", mods = "CTRL|SHIFT", action = act.MoveTabRelative(1) },
	{ key = "PageUp", mods = "CTRL|SHIFT", action = act.MoveTabRelative(-1) },
	-- unbind
	{ key = "LeftArrow", mods = "CTRL|SHIFT", action = act.DisableDefaultAssignment },
	{ key = "RightArrow", mods = "CTRL|SHIFT", action = act.DisableDefaultAssignment },
	{ key = "UpArrow", mods = "CTRL|SHIFT", action = act.DisableDefaultAssignment },
	{ key = "DownArrow", mods = "CTRL|SHIFT", action = act.DisableDefaultAssignment },
}

return config
