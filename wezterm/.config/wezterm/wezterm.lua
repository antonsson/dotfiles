local wezterm = require 'wezterm'

return {
    font =  wezterm.font {
        family = 'FiraCode Nerd Font Ret',
        harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }
    },
    font_size = 14,
    color_scheme = 'Tokyo Night Storm',
    hide_tab_bar_if_only_one_tab = true,
    scrollback_lines = 3500,
    enable_wayland = true,
    keys = {
        {
            key = 'H',
            mods = 'CTRL',
            action = wezterm.action.QuickSelectArgs {
                label = 'open url',
                patterns = {'https?://\\S+'},
                action = wezterm.action_callback(
                    function(window, pane)
                        local url = window:get_selection_text_for_pane(pane)
                        wezterm.log_info('opening: ' .. url)
                        wezterm.open_with(url)
                    end)
            }
        }
    }
}
