-- ~/.config/wezterm/wezterm.lua
local wezterm = require 'wezterm'
local act = wezterm.action
local mux = wezterm.mux


local default_width = 160
local default_height = 50
local position = '950,450'

--==Workspaces==

wezterm.on('mux-startup', function()
    -- allow `wezterm start -- something` to affect what we spawn
    -- in our initial window
    --local args = {}
    --if cmd then
    --    args = cmd.args
    --end
    --
    -- A workspace for interacting with a local machine that
    -- runs some docker containers for home automation
    local tab, pane, window = mux.spawn_window {
        --workspace = 'main',
        width = default_width,
        height = default_height,
        position = {
            x = 10,
            y = 0,
            origin = "MainScreen",
        }
    }

    --you can also set the positions after spawn.
    --https://github.com/wezterm/wezterm/issues/3299
    --window:gui_window():set_position(10, 0)
    --window:gui_window():set_inner_size(default_width, default_height)

    -- We want to startup in the coding workspace
    --mux.set_active_workspace 'coding'

    return {
        unix_domains = {
            { name = 'unix' },
        },
    }
end)

--wezterm.on('gui-attached', function(domain)
--    -- maximize all displayed windows on startup
--    local workspace = mux.get_active_workspace()
--    for _, window in ipairs(mux.all_windows()) do
--        if window:get_workspace() == workspace then
--            --window:gui_window():maximize()
--        end
--    end
--end)

-- === config == --
local config = {
  default_gui_startup_args = { 'connect', 'unix', '--position', position},
  status_update_interval = 1000,
  front_end = "WebGpu",
  max_fps = 120,
  webgpu_power_preference = "HighPerformance",
  -- cursor_style
  default_cursor_style = 'SteadyBlock',
  -- === Font Settings ===
  -- Recommend using Nerd Font to support icons
  font = wezterm.font_with_fallback {
      {family= 'FiraCode Nerd Font',weight='Bold'},
      'Apple Color Emoji',
      'Noto Sans CJK SC',
  },
  font_size = 18.0,
  foreground_text_hsb = {
      hue = 1.0,
      saturation = 1.0,
      brightness = 1.2,
  },
  -- === Color Scheme ===
  -- You can import themes from wezterm.colors module, or define manually
  -- Reference: https://wezterm.org/docs/colors.html
  color_scheme = 'Dracula (Official)', -- Built-in theme
  --color_scheme = 'Catppuccin Mocha', -- Built-in theme
  --color_scheme = 'tokyonight', -- Built-in theme
  -- === Tab Settings ===
  use_fancy_tab_bar = true, -- Set below near window_decorations for INTEGRATED_BUTTONS
  hide_tab_bar_if_only_one_tab = false,
  tab_bar_at_bottom = false, -- INTEGRATED_BUTTONS requires tab bar at top
  tab_max_width = 25,
  window_frame = {
    font_size = 16.0, -- Tab bar font size
  },
  --tab_bar_style = {
  --    window_maximize = wezterm.format {
  --        { Foreground = { Color = '#7dbefe' } },
  --        { Text = 'sdfsdf' } },
  --window_close = wezterm.format { { Text = '󰖯 ' } },
  --},
  -- === Window Settings ===
  window_background_opacity = 0.85, -- Background opacity
  macos_window_background_blur = 25, -- Glass blur effect
  text_background_opacity = 1.0,    -- Text background opaque
  initial_cols = default_width,
  initial_rows = default_height,
  native_macos_fullscreen_mode = false,
  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  },

  --window_decorations = 'TITLE | RESIZE | MACOS_USE_BACKGROUND_COLOR_AS_TITLEBAR_COLOR', -- 'NONE', 'RESIZE', 'INTEGRATED_BUTTONS', 'TITLE'
  window_decorations = 'INTEGRATED_BUTTONS | RESIZE', -- 'NONE', 'RESIZE', 'INTEGRATED_BUTTONS', 'TITLE'
  use_fancy_tab_bar = true, -- Required for INTEGRATED_BUTTONS
  -- === 键盘快捷键 ===
  quick_select_patterns = {
      -- match things that look like sha1 hashes
      -- (this is actually one of the default patterns)
      --'[0-9a-f]{7,40}',
      --'^[\\w \\/\\_\\-\\.\\[\\]\\{\\}\\p{Han}]*+$',
      --'(?<=:\\d\\d\\s).*$',
      --'[\'\"].*[\'\"]',
      --'(?<=\\s).*?(?=\\s)',
  },
}
-- === 键盘快捷键 ===
  -- SUPER, CMD, WIN - these are all equivalent: on macOS the Command key, on Windows the Windows key, on Linux this can also be the Super or Hyper key. Left and right are equivalent.
config.leader = { key = ' ', mods = 'SUPER', timeout_milliseconds = 2000 }

config.keys = {
    -- Prompt for a name to use for a new workspace and switch to it.
    {
        key = 'W',
        mods = 'CTRL|SHIFT',
        action = act.PromptInputLine {
            description = wezterm.format {
                { Attribute = { Intensity = 'Bold' } },
                { Foreground = { AnsiColor = 'Fuchsia' } },
                { Text = 'Enter name for new workspace' },
            },
            action = wezterm.action_callback(function(window, pane, line)
                -- line will be `nil` if they hit escape without entering anything
                -- An empty string if they just hit enter
                -- Or the actual line of text they wrote
                if line then
                    window:perform_action(
                        act.SwitchToWorkspace {
                            name = line,
                        },
                        pane
                    )
                end
            end),
        },
    },
    {
        key = ' ',
        mods = 'LEADER',
        action = act.ActivateKeyTable {
            name = 'move_pane',
            timeout_milliseconds = 600,
            one_shot = false,
        }
    },
    {
        key = 'r',
        mods = 'LEADER',
        action = act.ActivateKeyTable {
            name = 'resize_pane',
            timeout_milliseconds = 1000,
            one_shot = false,
        }
    },
    {
        key = 'f',
        mods = 'SHIFT|SUPER',
        action = act.Search {
            Regex = '\\w*@\\w+:|❯',
        },
    },
    { key = 'd', mods = 'SUPER', action = act.ScrollByPage(0.5) },
    { key = 'u', mods = 'SUPER', action = act.ScrollByPage(-0.5) },

    { key = 'c', mods = 'LEADER', action = act.ActivateCopyMode },
    { key = 'e', mods = 'LEADER', action = act.QuickSelect },

      -- Create a new workspace with a random name and switch to it
    { key = 'h', mods = 'CTRL|SHIFT', action = act.SwitchToWorkspace },
    { key = 'w', mods = 'LEADER', action = act.ShowLauncherArgs { flags = 'FUZZY|WORKSPACES', },
    },
    --{ key = 'l', mods = 'ALT', action = wezterm.action.ShowLauncher },
    --{ key = 'y', mods = 'ALT', action = wezterm.action.ShowTabNavigator },

    { key = '-', mods = 'CTRL', action = act.DisableDefaultAssignment },
    { key = '=', mods = 'CTRL', action = act.DisableDefaultAssignment },
    -- Pane navigation
    { key = 'h', mods = 'SUPER|SHIFT', action = wezterm.action.ActivatePaneDirection 'Left' },
    { key = 'l', mods = 'SUPER|SHIFT', action = wezterm.action.ActivatePaneDirection 'Right' },
    { key = 'k', mods = 'SUPER|SHIFT', action = wezterm.action.ActivatePaneDirection 'Up' },
    { key = 'j', mods = 'SUPER|SHIFT', action = wezterm.action.ActivatePaneDirection 'Down' },

    -- Copy and paste
    { key = 'c', mods = 'CTRL|SHIFT', action = wezterm.action.CopyTo 'Clipboard' },
    { key = 'v', mods = 'CTRL|SHIFT', action = wezterm.action.PasteFrom 'Clipboard' },
    -- Tab management
    { key = 't', mods = 'CTRL|SHIFT', action = wezterm.action.SpawnTab 'CurrentPaneDomain' }, -- New tab
    --{ key = 'w', mods = 'CTRL|SHIFT', action = wezterm.action.CloseCurrentTab { confirm = true } }, -- Close tab
    { key = 'LeftArrow', mods = 'CTRL|SHIFT', action = wezterm.action.ActivateTabRelative(-1) }, -- Previous tab
    { key = 'RightArrow', mods = 'CTRL|SHIFT', action = wezterm.action.ActivateTabRelative(1) },-- Next tab
    -- Pane management
    { key = 's', mods = 'LEADER', action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' } }, -- Vertical split
    { key = 'v', mods = 'LEADER', action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' } }, -- Horizontal split
    { key = 'x', mods = 'LEADER', action = act.CloseCurrentPane { confirm = false } }, -- Close pane
    -- { key = 'j', mods = 'LEADER', action = wezterm.action.ActivatePaneDirection 'Down' },
    { key = 'z', mods = 'LEADER', action = wezterm.action.TogglePaneZoomState }, -- Toggle pane zoom
    --{ key = 'f', mods = 'LEADER', action = wezterm.action.ToggleFullScreen }, -- Toggle fullscreen
    -- Built-in SSH client example
    -- { key = 'S', mods = 'CTRL|SHIFT', action = wezterm.action.SpawnCommandInNewTab { args = { 'wezterm', 'ssh', 'user@host' } } },
    -- === Shell Settings (Optional) ===
    -- default_prog = { '/bin/bash' },
    -- default_prog = { '/usr/bin/zsh' },

    -- === Event Handling (Power of Lua scripting) ===
    -- wezterm.on('user-var-changed', function(window, pane, var_name, var_value)
        --   -- Example: perform actions when user variable changes
        --   if var_name == 'MY_CUSTOM_VAR' then
        --     wezterm.log.info('MY_CUSTOM_VAR changed to:', var_value)
        --   end
        -- end),
}

-- Copy mode keybindings setup
local function set_copy_mode(mode, key_maps)
    for _, value in pairs(key_maps) do
        table.insert(
            mode,
            value
        )
    end
end

local copy_mode = nil
if wezterm.gui then
  copy_mode = wezterm.gui.default_key_tables().copy_mode
  set_copy_mode(copy_mode,
  {
      -- Copy mode keybindings
      {key="/", mods="NONE", action = act.Multiple({
          act.CopyMode("ClearPattern"),
          act.Search({ CaseInSensitiveString="" }),
      })},
      {key="L",     mods="NONE",  action=act.CopyMode("MoveToEndOfLineContent")},
      {key="H",     mods="NONE",  action=act.CopyMode("MoveToStartOfLineContent")},
  }
  )
end


-- Search mode keybindings setup
local search_mode = nil

if wezterm.gui then
  search_mode = wezterm.gui.default_key_tables().search_mode
  set_copy_mode(
      search_mode,
      {
          -- Search mode keybindings
          { key="Escape", mods="NONE", action = act.Multiple {
              act.CopyMode("ClearPattern"),
              act.CopyMode("Close"),
          }},
      }
  )
end

config.key_tables = {
    copy_mode = copy_mode,
    search_mode = search_mode,

    resize_pane = {
        { key = 'h', action = act.AdjustPaneSize { 'Left', 1 } },
        { key = 'l', action = act.AdjustPaneSize { 'Right', 1 } },
        { key = 'k', action = act.AdjustPaneSize { 'Up', 1 } },
        { key = 'j', action = act.AdjustPaneSize { 'Down', 1 } },
        { key = 'Escape', action = 'PopKeyTable' },
        -- Cancel the mode by pressing escape
        { key = ';', action = 'PopKeyTable' },
    },
    move_pane = {
        { key = 'h', action = wezterm.action.ActivatePaneDirection 'Left' },
        { key = 'l', action = wezterm.action.ActivatePaneDirection 'Right' },
        { key = 'k', action = wezterm.action.ActivatePaneDirection 'Up' },
        { key = 'j', action = wezterm.action.ActivatePaneDirection 'Down' },
        -- Cancel the mode by pressing escape
        { key = 'Escape', action = 'PopKeyTable' },
        -- Cancel the mode by pressing escape
        { key = ';', action = 'PopKeyTable' },
    }
}




--==plugin==--

--local modal = wezterm.plugin.require('https://github.com/MLFlexer/modal.wezterm')
--modal.enable_defaults("https://github.com/MLFlexer/modal.wezterm")
--modal.apply_to_config(config)
--modal.set_default_keys(config)
--local copy_key_table = require("ui_mode").key_table

--==Workspaces==

local function tab_title(tab_info, max_width)
  local title = tab_info.active_pane.title
  local title_num_text = tab_info.tab_index + 1 .. ': '
  local zoomed_flag = '[z]'
  title = wezterm.truncate_left(title, max_width - 5)
  if tab_info.active_pane.is_zoomed then
      title = title_num_text .. zoomed_flag .. title
  else
      title = title_num_text .. title
  end

  -- Otherwise, use the title from the active pane
  -- in that tab
  return title
end

local function tab_decorations(tab, title)
    local element = {}
    table.insert(element, 'ResetAttributes')
    table.insert(element, { Background = { Color = '#24252f' } })
    table.insert(element, { Foreground = { Color = '#b687f9' } })

    if tab.tab_index == 0 then -- first tab
        table.insert(element, { Text = ' ' })
    else
        table.insert(element, { Text = '' })
    end
    table.insert(element, 'ResetAttributes')
    table.insert(element, { Foreground = { Color = 'Black' } })
    table.insert(element, { Background = { Color = '#bd93f9' } })
    table.insert(element, { Text = title })
    table.insert(element, 'ResetAttributes')
    table.insert(element, { Background = { Color = '#24252f' } })
    table.insert(element, { Foreground = { Color = '#b687f9' } })
    table.insert(element, { Text = '' })
    return element
end

wezterm.on(
  'format-tab-title',
  function(tab, tabs, panes, conf, hover, max_width)
    local title = tab_title(tab, conf.tab_max_width)
    if tab.is_active then
        title = tab_decorations(tab, title)
    else
        title = ' ' .. title .. ' '
    end
    return title
  end
)

local function get_cpu_usage()
  local pcall_ok, success, output, _ = pcall(wezterm.run_child_process, {
      'top',
      '-l 1',
      '-s 0',
  })

  if not pcall_ok then
    return ''
  end

  if not success or not output or output == "" then
    return "N/A"
  end

  -- Trim whitespace from both ends
  --output = output:match('CPU usage:.*user')
  output = string.match(output, "CPU usage: %d.-sys")

  local cpu_sum = 0
  for part in output:gmatch('%d[^%%]+') do
      cpu_sum = cpu_sum + tonumber(part)
  end

  return math.floor(cpu_sum)
end

local function get_mem_usage()
  local pcall_ok, success, output, _ = pcall(wezterm.run_child_process, {
      'bash',
      wezterm.home_dir .. '/.config/wezterm/mem_usage.sh',
  })

  if not pcall_ok then
    return '40'
  end

  if not success or not output or output == "" then
    return "N/A"
  end

  -- Trim whitespace from both ends
  --output = output:match('CPU usage:.*user')
  --output = string.match(output, "CPU usage: %d.-sys")

  return output
end

wezterm.on('update-right-status', function(window, pane)
    window:set_right_status(wezterm.format {
        'ResetAttributes',
        { Foreground = { Color = '#F08D94' } },
        { Text = ''  },
        'ResetAttributes',
        { Foreground = { Color = 'Black' } },
        { Background = { Color = '#F89AA2' } },
        { Text = ': '.. get_mem_usage()},
        'ResetAttributes',
        --{ Foreground = { Color = '#7dbefe'} },
        { Foreground = { Color = '#F08D94' } },
        { Text = ' '  },
        'ResetAttributes',
        { Foreground = { Color = '#F2D188' } },
        { Text = ''  },
        'ResetAttributes',
        { Foreground = { Color = 'Black' } },
        { Background = { Color = '#FEE3A6' } },
        { Text = ': '.. get_cpu_usage() ..'%' },
        'ResetAttributes',
        --{ Foreground = { Color = '#7dbefe'} },
        { Foreground = { Color = '#F2D188' } },
        { Text = ' '  },
        'ResetAttributes',
        { Foreground = { Color = '#7dbefe' } },
        { Text = ''  },
        'ResetAttributes',
        { Foreground = { Color = 'Black' } },
        { Background = { Color = '#98cbfe' } },
        { Text = ' ' .. window:active_workspace()},
        'ResetAttributes',
        --{ Foreground = { Color = '#7dbefe'} },
        { Foreground = { Color = '#7dbefe' } },
        { Text = ' '  },
    })
end)

return config
