-- Pull in the wezterm API
local w = require("wezterm")
local act = w.action

local config = {}

if w.config_builder then
  config = w.config_builder()
end

-- Machine specific settings
local hostname = "unknown"
local hostname_file = io.open("/etc/hostname", "r")
if hostname_file then
  hostname = hostname_file:read("*l")
  hostname_file:close()
end
local top_padding = 0
if hostname == "valhalla" then
  top_padding = 20
elseif hostname == "asgard" then
  top_padding = 5
end

config.default_prog = { "nu" }
config.font = w.font_with_fallback({
  "Roboto Mono",
  "Font Awesome 6 Free Regular",
  "Font Awesome 6 Free Solid",
})
config.unicode_version = 14
config.font_size = 10
config.color_scheme = "Bamboo"
-- config.color_scheme = "OceanicMaterial"
config.line_height = 1
config.audible_bell = "Disabled"
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.show_new_tab_button_in_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.tab_max_width = 32
config.window_padding = {
  left = 0,
  right = 0,
  top = top_padding,
  bottom = 0,
}
-- config.enable_scroll_bar = true
-- Fixes key combos like C-Enter in tmux
config.enable_csi_u_key_encoding = true

local bg_color = "#2d3139"
local fg_color = "#d5d7dd"
local fg_color2 = "#979eac"
-- local fg_color2 = "#abb2bf"
config.colors = {
  tab_bar = {
    background = bg_color,
    active_tab = {
      bg_color = bg_color,
      fg_color = fg_color,
    },
    inactive_tab = {
      bg_color = bg_color,
      fg_color = fg_color2,
    },
  },
  scrollbar_thumb = "#282c34",
}

-- w.on("update-status", function(window, pane)
--   window:set_left_status(w.format({
--     { Background = { Color = bg_color } },
--     { Foreground = { Color = fg_color } },
--     { Text = "[" .. window:active_workspace() .. "] " },
--   }))
-- end)
--
-- -- Format the nu shell title, removing the cwd
-- local function nu_tab_title(original_title)
--   local has_command = string.find(original_title, "> ")
--   if has_command then
--     local _, end_pos = string.find(original_title, "> ")
--     local command = string.sub(original_title, end_pos + 1)
--     return command
--   else
--     return "nu"
--   end
-- end
--
-- local function tab_title(tab)
--   local orig_title = tab.tab_title
--   local title
--   if orig_title and #orig_title > 0 then
--     title = orig_title
--   else
--     title = nu_tab_title(tab.active_pane.title)
--   end
--
--   if tab.active_pane.is_zoomed then
--     title = title .. "-Z"
--   end
--
--   if tab.is_active then
--     return "*" .. title
--   end
--
--   local tab_index = tab.tab_index + 1
--   return string.format("%d:%s", tab_index, title)
-- end
--
-- w.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
--   return {
--     { Text = " " .. tab_title(tab) .. " " },
--   }
-- end)
--
-- config.leader = {
--   key = "`",
--   timeout_milliseconds = 10000,
-- }
--
-- local function tab_binding(tab_number)
--   return {
--     key = tostring(tab_number),
--     mods = "LEADER",
--     action = act.ActivateTab(tab_number - 1),
--   }
-- end
--
-- local function toggle_terminal(window, pane)
--   local panes = window:active_tab():panes()
--   if #panes == 1 then
--     window:perform_action(
--       act.SplitPane({
--         direction = "Down",
--         size = { Percent = 33 },
--       }),
--       pane
--     )
--   else
--     window:perform_action(act.ActivatePaneByIndex(0), pane)
--     window:perform_action(act.TogglePaneZoomState, pane)
--     window:perform_action(act.ActivatePaneByIndex(1), pane)
--   end
-- end
--
-- -- Seamlessly navigate between neovim and wezterm
-- local function is_vim(pane)
--   -- this is set by the plugin, and unset on ExitPre in Neovim
--   return pane:get_user_vars().IS_NVIM == "true"
-- end
--
-- local direction_keys = {
--   h = "Left",
--   j = "Down",
--   k = "Up",
--   l = "Right",
-- }
--
-- local function split_nav(resize_or_move, key)
--   return {
--     key = key,
--     mods = resize_or_move == "resize" and "META" or "CTRL",
--     action = w.action_callback(function(win, pane)
--       if is_vim(pane) then
--         -- pass the keys through to vim/nvim
--         win:perform_action({
--           SendKey = { key = key, mods = resize_or_move == "resize" and "META" or "CTRL" },
--         }, pane)
--       else
--         if resize_or_move == "resize" then
--           win:perform_action({ AdjustPaneSize = { direction_keys[key], 3 } }, pane)
--         else
--           win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
--         end
--       end
--     end),
--   }
-- end

config.keys = {
  -- -- Leader binds
  -- {
  --   key = "`",
  --   mods = "LEADER",
  --   action = act.SendKey({ key = "`" }),
  -- },
  -- {
  --   key = "\\",
  --   mods = "LEADER",
  --   action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
  -- },
  -- {
  --   key = "-",
  --   mods = "LEADER",
  --   action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
  -- },
  -- {
  --   key = "c",
  --   mods = "LEADER",
  --   action = act.SpawnTab("CurrentPaneDomain"),
  -- },
  -- {
  --   key = "l",
  --   mods = "LEADER",
  --   action = act.ActivateLastTab,
  -- },
  -- {
  --   key = "z",
  --   mods = "LEADER",
  --   action = act.TogglePaneZoomState,
  -- },
  -- {
  --   key = "Enter",
  --   mods = "LEADER",
  --   action = w.action_callback(toggle_terminal),
  -- },
  --
  -- tab_binding(1),
  -- tab_binding(2),
  -- tab_binding(3),
  -- tab_binding(4),
  -- tab_binding(5),
  -- tab_binding(6),
  -- tab_binding(7),
  -- tab_binding(8),
  -- tab_binding(9),
  --
  -- -- move between split panes
  -- split_nav("move", "h"),
  -- split_nav("move", "j"),
  -- split_nav("move", "k"),
  -- split_nav("move", "l"),
  -- -- resize panes
  -- split_nav("resize", "h"),
  -- split_nav("resize", "j"),
  -- split_nav("resize", "k"),
  -- split_nav("resize", "l"),

  -- Bind some super combos to alt for passthru to neovim, etc
  {
    key = "a",
    mods = "SUPER",
    action = act.SendKey({
      key = "a",
      mods = "ALT",
    }),
  },
  {
    key = "f",
    mods = "SUPER",
    action = act.SendKey({
      key = "f",
      mods = "ALT",
    }),
  },
  {
    key = "s",
    mods = "SUPER",
    action = act.SendKey({
      key = "s",
      mods = "ALT",
    }),
  },
}

return config
