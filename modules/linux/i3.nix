{ pkgs, ... }:
let
  vol-up = pkgs.writeShellScript "vol-up" ''
    pamixer --increase 5
    VOL=$(pamixer --get-volume)
    notify-send -h string:synchronous:volume -h int:value:"$VOL" " Volume" "$VOL%"
  '';

  vol-down = pkgs.writeShellScript "vol-down" ''
    pamixer --decrease 5
    VOL=$(pamixer --get-volume)
    notify-send -h string:synchronous:volume -h int:value:"$VOL" " Volume" "$VOL%"
  '';

  vol-mute = pkgs.writeShellScript "vol-mute" ''
    pamixer --toggle-mute
    if pamixer --get-mute | grep -q true; then
      notify-send -h string:synchronous:volume " Volume" "Muted"
    else
      VOL=$(pamixer --get-volume)
      notify-send -h string:synchronous:volume -h int:value:"$VOL" " Volume" "$VOL%"
    fi
  '';

  bri-up = pkgs.writeShellScript "bri-up" ''
    brightnessctl set +10%
    BRI=$(( $(brightnessctl get) * 100 / $(brightnessctl max) ))
    notify-send -h string:synchronous:brightness -h int:value:"$BRI" " Brightness" "$BRI%"
  '';

  bri-down = pkgs.writeShellScript "bri-down" ''
    brightnessctl set 10%-
    BRI=$(( $(brightnessctl get) * 100 / $(brightnessctl max) ))
    notify-send -h string:synchronous:brightness -h int:value:"$BRI" " Brightness" "$BRI%"
  '';

  ss-full = pkgs.writeShellScript "ss-full" ''
    maim | xclip -selection clipboard -t image/png
    notify-send " Screenshot" "Copied to clipboard"
  '';

  ss-area = pkgs.writeShellScript "ss-area" ''
    sleep 0.2
    maim -s | xclip -selection clipboard -t image/png
    notify-send " Screenshot" "Area copied to clipboard"
  '';

  ss-save = pkgs.writeShellScript "ss-save" ''
    mkdir -p "$HOME/Pictures"
    F="$HOME/Pictures/ss_$(date +%Y%m%d_%H%M%S).png"
    maim "$F"
    xclip -selection clipboard -t image/png < "$F"
    notify-send " Screenshot" "Saved & copied: $F"
  '';

  wezterm-bin   = "${pkgs.wezterm}/bin/wezterm";
  thunar-bin    = "${pkgs.xfce.thunar}/bin/thunar";
  copyq-bin     = "${pkgs.copyq}/bin/copyq";
  nm-applet-bin = "${pkgs.networkmanagerapplet}/bin/nm-applet";

in
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

  xdg.configFile."dunst/dunstrc".text = ''
    [global]
        monitor                = 0
        follow                 = mouse
        width                  = 320
        height                 = 300
        origin                 = top-right
        offset                 = 12x48
        scale                  = 0
        notification_limit     = 5
        progress_bar           = true
        progress_bar_height    = 8
        progress_bar_frame_width = 1
        progress_bar_min_width = 150
        progress_bar_max_width = 300
        indicate_hidden        = yes
        transparency           = 10
        separator_height       = 2
        padding                = 12
        horizontal_padding     = 14
        text_icon_padding      = 0
        frame_width            = 2
        frame_color            = "#89b4fa"
        separator_color        = frame
        sort                   = yes
        font                   = JetBrainsMono Nerd Font 10
        line_height            = 0
        markup                 = full
        format                 = "<b>%s</b>\n%b"
        alignment              = left
        vertical_alignment     = center
        show_age_threshold     = 60
        ellipsize              = middle
        ignore_newline         = no
        stack_duplicates       = true
        hide_duplicate_count   = false
        show_indicators        = yes
        sticky_history         = yes
        history_length         = 20
        corner_radius          = 8
        mouse_left_click       = close_current
        mouse_middle_click     = do_action, close_current
        mouse_right_click      = close_all

    [urgency_low]
        background  = "#1e1e2e"
        foreground  = "#cdd6f4"
        frame_color = "#585b70"
        timeout     = 3

    [urgency_normal]
        background  = "#1e1e2e"
        foreground  = "#cdd6f4"
        frame_color = "#89b4fa"
        timeout     = 5

    [urgency_critical]
        background  = "#1e1e2e"
        foreground  = "#f38ba8"
        frame_color = "#f38ba8"
        timeout     = 0
  '';

  xdg.configFile."rofi/config.rasi".text = ''
    configuration {
      modi: "drun,run";
      show-icons: true;
      drun-display-format: "{name}";
    }

    * {
      background-color: #1e1e2e;
      text-color:       #cdd6f4;
      border-color:     #89b4fa;
    }

    window {
      width:         600px;
      location:      north;
      anchor:        north;
      y-offset:      25px;
      border:        2px solid;
      border-radius: 8px;
    }

    listview {
      lines: 6;
    }

    inputbar {
      padding: 8px 12px;
    }

    element selected {
      background-color: #89b4fa;
      text-color:       #1e1e2e;
    }
  '';
  xdg.configFile."i3/config".text = ''
    set $mod Mod4
    set $term ${wezterm-bin}

    font pango:JetBrainsMono Nerd Font 11

    gaps inner 8
    gaps outer 4
    default_border pixel 2
    hide_edge_borders smart

    # launch
    bindsym $mod+Return exec $term
    bindsym $mod+d exec --no-startup-id dmenu_run -fn 'monospace:size=10'
    bindsym $mod+n      exec ${thunar-bin}
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

    # lock screen
    bindsym $mod+Shift+x exec i3lock -c 1e1e2e

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

    # volume
    bindsym XF86AudioRaiseVolume exec --no-startup-id ${vol-up}
    bindsym XF86AudioLowerVolume exec --no-startup-id ${vol-down}
    bindsym XF86AudioMute        exec --no-startup-id ${vol-mute}
    bindsym XF86AudioMicMute     exec --no-startup-id pamixer --default-source --toggle-mute

    # brightness
    bindsym XF86MonBrightnessUp   exec --no-startup-id ${bri-up}
    bindsym XF86MonBrightnessDown exec --no-startup-id ${bri-down}

    # screenshots
    bindsym Print       exec --no-startup-id ${ss-full}
    bindsym Shift+Print exec --no-startup-id ${ss-area}
    bindsym ctrl+Print  exec --no-startup-id ${ss-save}

    # clipboard history
    bindsym $mod+Shift+v exec --no-startup-id ${copyq-bin} toggle
    for_window [class="copyq"] floating enable
    for_window [class="copyq"] resize set 520 380
    for_window [class="copyq"] border pixel 2

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
      position top
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

    exec --no-startup-id feh --bg-fill /home/mikey/Downloads/linux.jpeg
    exec --no-startup-id picom --daemon --backend glx --blur-method dual_kawase --blur-strength 8 --shadow --shadow-radius 12 --corner-radius 8
    exec --no-startup-id ${nm-applet-bin}
    exec --no-startup-id dunst
    exec --no-startup-id ${copyq-bin} --start-server
    exec --no-startup-id xautolock -time 5 -locker "i3lock -c 1e1e2e"
  '';
}
