local wezterm = require 'wezterm'

return {
    font = wezterm.font 'Source Code Pro Medium',
    font_size = 15,
    color_scheme = 'My Material',
    hide_tab_bar_if_only_one_tab = true,
    scrollback_lines = 3500,
    enable_wayland = true,
}
