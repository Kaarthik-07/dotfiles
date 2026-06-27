local wezterm = require 'wezterm'
local commands = require 'commands'
local constants = require 'constants'

local config = wezterm.config_builder()

-- font
config.font_size   = 13
config.line_height = 1.2
config.font = wezterm.font_with_fallback {
  { family = 'JetBrainsMono Nerd Font', weight = 'Medium' },
  { family = 'Symbols Nerd Font Mono' },
}
config.font_rules = {
  {
    intensity = 'Bold',
    font      = wezterm.font('JetBrainsMono Nerd Font', { weight = 'Bold' }),
  },
  {
    italic = true,
    font   = wezterm.font('JetBrainsMono Nerd Font', { italic = true }),
  },
}

-- colors
config.color_scheme = 'Catppuccin Mocha'

-- CRT effect (blur handled by picom on Linux)
config.window_background_opacity = 0.88
config.foreground_text_hsb = {
  hue        = 1.0,
  saturation = 1.2,
  brightness = 1.5,
}

-- background image (only if asset exists — macOS with custom wallpaper)
local bg = constants.bg_image
local f  = io.open(bg, 'r')
if f then
  f:close()
  config.background = {
    { source = { File = bg }, opacity = 0.9, hsb = { brightness = 0.4 } },
  }
end

-- appearance
config.default_cursor_style        = 'BlinkingBar'
config.cursor_blink_rate           = 600
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar           = false
config.window_padding              = { left = 8, right = 8, top = 8, bottom = 0 }
config.window_decorations          = 'RESIZE'

-- perf
config.max_fps    = 120
config.prefer_egl = true

-- commands palette
wezterm.on('augment-command-palette', function()
  return commands
end)

return config
