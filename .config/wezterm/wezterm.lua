-- Pull in the wezterm API
local wezterm = require 'wezterm'
local act = wezterm.action
local mux = wezterm.mux

local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end

config.font = wezterm.font('Roboto Mono')
config.unicode_version = 14
config.font_size = 16
config.color_scheme = 'OneDark (base16)'
config.line_height = 1
config.initial_cols = 250
config.initial_rows = 60
config.audible_bell = 'Disabled'
config.use_fancy_tab_bar = false
config.show_new_tab_button_in_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
config.tab_max_width = 32
config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
}
config.colors = {
    tab_bar = {
        background = '#282c34',
        active_tab = {
            bg_color = '#979eac',
            fg_color = '#282c34',
        },
        inactive_tab = {
            bg_color = '#282c34',
            fg_color = '#abb2bf',
        },
    },
    scrollbar_thumb = '#282c34',
}

-- Override for colorblindness
-- See:
-- https://jeffkreeftmeijer.com/vim-16-color/
-- https://www.rapidtables.com/web/color/RGB_Color.html
-- https://www.ditig.com/publications/256-colors-cheat-sheet
local scheme = wezterm.color.get_builtin_schemes()[config.color_scheme]
scheme.ansi[4] = '#c0c03a'    -- yellow
scheme.brights[2] = '#ff6c6c' -- red
scheme.brights[3] = '#68c068' -- green
scheme.brights[4] = '#c0c03a' -- yellow
config.color_schemes = { [config.color_scheme] = scheme }

-- Fixes key combos like C-Enter in tmux
config.enable_csi_u_key_encoding = true

config.keys = {
    -- Map command key shortcuts to option for vim
    { key = 'f', mods = 'SUPER', action = act.SendString 'ƒ' },
    { key = 's', mods = 'SUPER', action = act.SendString 'ß' },
    { key = 'a', mods = 'SUPER', action = act.SendString 'å' },
    { key = 'w', mods = 'SUPER', action = act.SendString '∑' },

    -- Map cmd+arrow keys to vimux tmux/vim window switching
    -- cmd+left -> ctrl+h
    { key = 'LeftArrow', mods = 'SUPER', action = act.SendString '\x08' },
    -- cmd+down -> ctrl+j
    { key = 'DownArrow', mods = 'SUPER', action = act.SendString '\x0A' },
    -- cmd+up -> ctrl+k
    { key = 'UpArrow', mods = 'SUPER', action = act.SendString '\x0B' },
    -- cmd+right -> ctrl+l
    { key = 'RightArrow', mods = 'SUPER', action = act.SendString '\x0C' },
    -- cmd+\ -> ctrl+\
    { key = '\\', mods = 'SUPER', action = act.SendString '\x1C' },
}

wezterm.on('window-config-reloaded', function(window, _pane)
    local id = tostring(window:window_id())
    local seen = wezterm.GLOBAL.seen_windows or {}
    local is_new_window = not seen[id]
    seen[id] = true
    wezterm.GLOBAL.seen_windows = seen
    if is_new_window then
        window:maximize()
    end
end)

function tab_title(tab_info)
    local title = tab_info.tab_title
    -- if the tab title is explicitly set, take that
    if title and #title > 0 then
        return title
    end
    -- Otherwise, use the title from the active pane
    -- in that tab
    return tab_info.active_pane.title
end

wezterm.on(
    'format-tab-title',
    function(tab, tabs, panes, config, hover, max_width)
        return {
            { Text = '  ' .. tab_title(tab) .. '  ' },
        }
    end
)

return config
