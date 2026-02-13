local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

wezterm.add_to_config_reload_watch_list(wezterm.config_dir .. "/colors/dank-theme.toml")

config.color_scheme = "dank-theme"
config.window_background_opacity = 0.9
config.automatically_reload_config = true

return config
