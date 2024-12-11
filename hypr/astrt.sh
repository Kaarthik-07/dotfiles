# ~/.config/hypr/waybar_start.sh
#!/bin/bash
dbus-update-activation-environment --all
spotifatius monitor &
sleep 2
waybar

