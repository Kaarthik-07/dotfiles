{ ... }:
{
  # wezterm config lives in dots/wezterm — symlinked to ~/.config/wezterm
  xdg.configFile."wezterm" = {
    source    = ../../dots/wezterm;
    recursive = true;
  };
}
