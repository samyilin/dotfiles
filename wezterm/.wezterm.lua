-- Pull in the wezterm API
local wezterm = require("wezterm")
local mux = wezterm.mux

-- This will hold the configuration.
local config = wezterm.config_builder()

config.color_scheme = "tokyonight"
config.font = wezterm.font_with_fallback({
	"JetBrains Mono",
	{ family = "Symbols Nerd Font Mono", scale = 0.75 },
})
-- MacOS fullscreen defaults to not-so-fullscreen, so this
if wezterm.target_triple == "x86_64-apple-darwin" or wezterm.target_triple == "x86_64-pc-windows-msvc" then
	config.native_macos_fullscreen_mode = true
	config.front_end = "WebGpu"
end
wezterm.on("gui-startup", function()
	local _, _, window = mux.spawn_window({})
	window:gui_window():toggle_fullscreen()
end)

-- config.hide_tab_bar_if_only_one_tab = true
config.window_frame = {
	inactive_titlebar_bg = "#353535",
	active_titlebar_bg = "#2b2042",
	inactive_titlebar_fg = "#cccccc",
	active_titlebar_fg = "#ffffff",
	inactive_titlebar_border_bottom = "#2b2042",
	active_titlebar_border_bottom = "#2b2042",
	button_fg = "#cccccc",
	button_bg = "#2b2042",
	button_hover_fg = "#ffffff",
	button_hover_bg = "#3b3052",
}
-- I hate padding
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}
config.term = "wezterm"
-- and finally, return the configuration to wezterm
return config
