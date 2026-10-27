#!/bin/sh

sudo pkill -9 vpnc
xrandr --auto
sudo nmcli c up visitor
sudo vpnc
