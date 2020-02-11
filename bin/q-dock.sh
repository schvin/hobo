#!/bin/sh

sudo pkill vpnc
xrandr --auto
sudo nmcli c down visitor
sudo nmcli c down PURPLE
xrandr | grep DP-1.connected && xrandr --output eDP-1 --below DP-1
xrandr | grep DP-2.connected && xrandr --output eDP-1 --below DP-2
