local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.color_scheme = "Github Light (Gogh)"
-- config.color_scheme = "Everforest Light Soft (Gogh)"
config.font = wezterm.font("Hack Nerd Font")
config.automatically_reload_config = true
config.font_size = 14.0
config.use_ime = true
config.window_background_opacity = 0.75
config.macos_window_background_blur = 20

----------------------------------------------------
-- Tab
----------------------------------------------------
-- タイトルバーを非表示
config.window_decorations = "RESIZE"
-- タブバーの表示
config.show_tabs_in_tab_bar = true
-- タブが一つの時は非表示
config.hide_tab_bar_if_only_one_tab = true
-- falseにするとタブバーの透過が効かなくなる
-- config.use_fancy_tab_bar = false

-- タブバーの透過
config.window_frame = {
  inactive_titlebar_bg = "none",
  active_titlebar_bg = "none",
}

-- タブバーを背景色に合わせる
config.window_background_gradient = {
  -- NOTE: github-light
  colors = { "#f6f8fa" },
  -- NOTE: everforest
  -- colors = { "#F3EAD3" },
}

-- タブの追加ボタンを非表示
config.show_new_tab_button_in_tab_bar = false
-- nightlyのみ使用可能
-- タブの閉じるボタンを非表示
config.show_close_tab_button_in_tabs = false

-- タブ同士の境界線を非表示
config.colors = {
  tab_bar = {
    inactive_tab_edge = "none",
  },
}

-- タブの形をカスタマイズ
-- タブの左側の装飾
local SOLID_LEFT_ARROW = wezterm.nerdfonts.ple_lower_right_triangle
-- タブの右側の装飾
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.ple_upper_left_triangle

-- フルスクリーンで起動
local mux = wezterm.mux
wezterm.on("gui-startup", function(cmd)
  local tab, pane, window = mux.spawn_window(cmd or {})
  window:gui_window():toggle_fullscreen()
end)

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local background = "#5c6d74"
  local foreground = "#DFDDC8"
  local edge_background = "none"
  if tab.is_active then
    background = "#8DA101"
    foreground = "#DFDDC8"
  end
  local edge_foreground = background

  local title = tab.active_pane.title

  local function get_last_n_chars(str, n)
    if #str <= n then
      return str
    else
      return "…" .. string.sub(str, -n + 1)
    end
  end

  local function get_process_name(pane)
    local process_name = pane.foreground_process_name

    return process_name:match("([^/]+)$") or ""
  end

  local function get_custom_title(pane)
    local process_name = get_process_name(pane)
    return get_last_n_chars(title, 23)
  end

  local custom_title = get_custom_title(tab.active_pane)

  return {
    { Background = { Color = edge_background } },
    { Foreground = { Color = edge_foreground } },
    { Text = SOLID_LEFT_ARROW },
    { Background = { Color = background } },
    { Foreground = { Color = foreground } },
    { Text = " " .. custom_title .. " " },
    { Background = { Color = edge_background } },
    { Foreground = { Color = edge_foreground } },
    { Text = SOLID_RIGHT_ARROW },
  }
end)

----------------------------------------------------
-- keybind
----------------------------------------------------
config.disable_default_key_bindings = true
config.keys = require("keybind").keys
config.key_tables = require("keybind").key_tables
config.leader = { key = "q", mods = "CTRL", timeout_milliseconds = 2000 }

return config
