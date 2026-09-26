-- Cycles through the color schemes that ship in this config dir.
-- WezTerm auto-loads `<config_dir>/<name>.lua` for `color_scheme = <name>`,
-- so these resolve without any registration step.
local wezterm = require 'wezterm'

-- Order matters: the first entry is the default set in wezterm.lua.
local schemes = {
  { name = 'Catppuccin Mocha', label = 'Mocha' },
  { name = 'nightwolf', label = 'NightWolf' },
  { name = 'cyberdream', label = 'CyberDream' },
  { name = 'cyberdream-light', label = 'CyberDream Light' },
}

local command = {
  brief = 'Cycle terminal color scheme',
  icon = 'md_theme_light_dark',
  action = wezterm.action_callback(function(window)
    local current = window:effective_config().color_scheme

    local idx = 1
    for i, scheme in ipairs(schemes) do
      if scheme.name == current then
        idx = i
        break
      end
    end

    local next_scheme = schemes[(idx % #schemes) + 1]
    window:set_config_overrides { color_scheme = next_scheme.name }
    window:toast_notification('Theme', next_scheme.label, nil, 1500)
  end),
}

return command
