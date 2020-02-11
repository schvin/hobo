#!/bin/sh

xrandr --auto
sudo nmcli c down visitor
sudo nmcli c down PURPLE
xrandr --output eDP-1 --below DP-2
