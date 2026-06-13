{ pkgs, ... }:
{
  xdg.configFile."i3status/config".text = ''
    general {
      colors      = true
      interval    = 5
      color_good     = "#a6e3a1"
      color_degraded = "#f9e2af"
      color_bad      = "#f38ba8"
    }

    order += "wireless _first_"
    order += "battery all"
    order += "cpu_usage"
    order += "memory"
    order += "tztime local"

    wireless _first_ {
      format_up   = "  %essid"
      format_down = "  down"
    }

    battery all {
      format       = "%status %percentage"
      format_down  = "no battery"
      status_chr   = " "
      status_bat   = " "
      status_full  = " "
      status_unk   = "?"
      low_threshold = 20
    }

    cpu_usage {
      format = "  %usage"
    }

    memory {
      format             = "  %used"
      threshold_degraded = "10%"
      threshold_critical = "5%"
    }

    tztime local {
      format = "  %d %b %Y  %H:%M"
    }
  '';

  xdg.configFile."i3/config".text = ''
    set $mod Mod4
    set $term wezterm

    font pango:monospace 12

    gaps inner 8
    gaps outer 4
    default_border pixel 2
    hide_edge_borders smart

    # launch
    bindsym $mod+Return exec $term
    bindsym $mod+d      exec rofi -show drun
    bindsym $mod+q      kill

    # focus
    bindsym $mod+h focus left
    bindsym $mod+j focus down
    bindsym $mod+k focus up
    bindsym $mod+l focus right

    # move
    bindsym $mod+Shift+h move left
    bindsym $mod+Shift+j move down
    bindsym $mod+Shift+k move up
    bindsym $mod+Shift+l move right

    # split
    bindsym $mod+b split h
    bindsym $mod+v split v

    # layout
    bindsym $mod+f            fullscreen toggle
    bindsym $mod+s            layout stacking
    bindsym $mod+w            layout tabbed
    bindsym $mod+e            layout toggle split
    bindsym $mod+Shift+space  floating toggle
    bindsym $mod+space        focus mode_toggle

    # workspaces
    bindsym $mod+1 workspace number 1
    bindsym $mod+2 workspace number 2
    bindsym $mod+3 workspace number 3
    bindsym $mod+4 workspace number 4
    bindsym $mod+5 workspace number 5
    bindsym $mod+Shift+1 move container to workspace number 1
    bindsym $mod+Shift+2 move container to workspace number 2
    bindsym $mod+Shift+3 move container to workspace number 3
    bindsym $mod+Shift+4 move container to workspace number 4
    bindsym $mod+Shift+5 move container to workspace number 5

    # system
    bindsym $mod+Shift+c reload
    bindsym $mod+Shift+r restart
    bindsym $mod+Shift+e exec i3-nagbar -t warning -m 'Exit i3?' -B 'Yes' 'i3-msg exit'

    # resize
    bindsym $mod+r mode "resize"
    mode "resize" {
      bindsym h resize shrink width  20 px or 20 ppt
      bindsym l resize grow   width  20 px or 20 ppt
      bindsym k resize shrink height 20 px or 20 ppt
      bindsym j resize grow   height 20 px or 20 ppt
      bindsym Return mode "default"
      bindsym Escape mode "default"
    }

    # catppuccin mocha
    set $base    #1e1e2e
    set $text    #cdd6f4
    set $blue    #89b4fa
    set $red     #f38ba8
    set $muted   #585b70
    set $surface #313244

    client.focused          $blue    $blue    $base    $blue    $blue
    client.unfocused        $surface $base    $muted   $surface $surface
    client.focused_inactive $surface $surface $text    $surface $surface
    client.urgent           $red     $red     $base    $red     $red

    bar {
      status_command i3status
      colors {
        background $base
        statusline $text
        separator  $muted
        focused_workspace  $blue    $blue    $base
        active_workspace   $surface $surface $text
        inactive_workspace $base    $base    $muted
        urgent_workspace   $red     $red     $base
      }
    }

    # set solid catppuccin bg so transparency has something to show through
    exec --no-startup-id feh --bg-fill /home/mikey/Downloads/linux.jpeg
    exec --no-startup-id picom --daemon --backend glx --blur-method dual_kawase --blur-strength 8
    exec --no-startup-id nm-applet
  '';
}
