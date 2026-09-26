-- Pick any bundled color scheme directly, instead of cycling blindly.
local wezterm = require 'wezterm'

local schemes = {
  { name = 'Catppuccin Mocha', label = 'Catppuccin Mocha' },
  { name = 'Catppuccin Latte', label = 'Catppuccin Latte' },
  { name = 'nightwolf', label = 'NightWolf' },
  { name = 'cyberdream', label = 'CyberDream' },
  { name = 'cyberdream-light', label = 'CyberDream Light' },
}

local command = {
  brief = 'Select terminal color scheme',
  icon = 'md_palette',
  action = wezterm.action_callback(function(window, pane, _, _, _, prompt)
    wezterm
      .format_items(wezterm.default_list_choices(schemes, 'Color scheme: ', nil))
      :prompt(prompt, 'Color scheme: ', function(_, choice)
        if choice then
          window:set_config_overrides { color_scheme = choice.name }
        end
      end)
  end),
}

return command
