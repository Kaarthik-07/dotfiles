{ lib, pkgs, ... }:

let
  # catppuccin mocha
  base   = "#1e1e2e";
  text   = "#cdd6f4";
  blue   = "#89b4fa";
  red    = "#f38ba8";
  muted  = "#585b70";
  surface = "#313244";
in
{
  xsession.windowManager.i3 = {
    enable = true;
    config = rec {
      modifier = "Mod4";   # Super
      terminal = "wezterm";
      menu     = "rofi -show drun";

      fonts = {
        names = [ "DankMono Nerd Font Mono" "monospace" ];
        size  = 12.0;
      };

      # disable all default keybindings so we control everything
      keybindings = lib.mkOptionDefault {
        # focus
        "${modifier}+h" = "focus left";
        "${modifier}+j" = "focus down";
        "${modifier}+k" = "focus up";
        "${modifier}+l" = "focus right";

        # move
        "${modifier}+shift+h" = "move left";
        "${modifier}+shift+j" = "move down";
        "${modifier}+shift+k" = "move up";
        "${modifier}+shift+l" = "move right";

        # layout
        "${modifier}+f"         = "fullscreen toggle";
        "${modifier}+s"         = "layout stacking";
        "${modifier}+w"         = "layout tabbed";
        "${modifier}+e"         = "layout toggle split";
        "${modifier}+shift+space" = "floating toggle";
        "${modifier}+space"     = "focus mode_toggle";

        # resize mode
        "${modifier}+r" = "mode resize";

        # workspaces
        "${modifier}+1" = "workspace number 1";
        "${modifier}+2" = "workspace number 2";
        "${modifier}+3" = "workspace number 3";
        "${modifier}+4" = "workspace number 4";
        "${modifier}+5" = "workspace number 5";
        "${modifier}+shift+1" = "move container to workspace number 1";
        "${modifier}+shift+2" = "move container to workspace number 2";
        "${modifier}+shift+3" = "move container to workspace number 3";
        "${modifier}+shift+4" = "move container to workspace number 4";
        "${modifier}+shift+5" = "move container to workspace number 5";

        # kill / reload
        "${modifier}+shift+q"      = "kill";
        "${modifier}+shift+c"      = "reload";
        "${modifier}+shift+r"      = "restart";
        "${modifier}+shift+e"      = "exec i3-nagbar -t warning -m 'Exit i3?' -B 'Yes' 'i3-msg exit'";
      };

      modes.resize = {
        h     = "resize shrink width  20 px";
        l     = "resize grow   width  20 px";
        k     = "resize shrink height 20 px";
        j     = "resize grow   height 20 px";
        Return = "mode default";
        Escape = "mode default";
      };

      gaps = {
        inner = 8;
        outer = 4;
      };

      bars = [{
        statusCommand = "${pkgs.i3status}/bin/i3status";
        fonts = { names = [ "monospace" ]; size = 11.0; };
        colors = {
          background        = base;
          statusline        = text;
          separator         = muted;
          focusedWorkspace  = { border = blue;    background = blue;    text = base; };
          activeWorkspace   = { border = surface; background = surface; text = text; };
          inactiveWorkspace = { border = base;    background = base;    text = muted; };
          urgentWorkspace   = { border = red;     background = red;     text = base; };
        };
      }];

      colors = {
        focused         = { border = blue;    background = blue;    text = base;    indicator = blue;    childBorder = blue; };
        unfocused       = { border = surface; background = base;    text = muted;   indicator = surface; childBorder = surface; };
        focusedInactive = { border = surface; background = surface; text = text;    indicator = surface; childBorder = surface; };
        urgent          = { border = red;     background = red;     text = base;    indicator = red;     childBorder = red; };
      };

      startup = [
        { command = "${pkgs.picom}/bin/picom --daemon"; notification = false; }
      ];
    };
  };
}
