local wezterm = require 'wezterm'
local constants = require 'constants'

local OPAQUE = 1.0
local TRANSPARENT = 0.8

local command = {
  brief = 'Toggle terminal transparency',
  icon = 'md_circle_opacity',
  action = wezterm.action_callback(function(window)
    local overrides = window:get_config_overrides() or {}
    local current = overrides.window_background_opacity

    if current == nil or current >= OPAQUE then
      overrides.window_background_opacity = TRANSPARENT
      overrides.background = {
        {
          source = { File = constants.bg_image },
          opacity = 0.9,
          hsb = { brightness = 0.4 },
        },
      }
    else
      overrides.window_background_opacity = OPAQUE
      overrides.background = {}
    end

    window:set_config_overrides(overrides)
  end),
}

return command
