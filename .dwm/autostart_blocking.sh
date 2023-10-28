#!/bin/bash
# ~/.mybin/v2.sh
compton -b
redshift -l 23.6980:133.8807 -t 6300:4000 &
keynav "loadconfig ~/.config/keynav/keynavrc" &
fcitx5 &
qv2ray &
syncthing &
# ~/.mybin/1s.sh &
# ~/.mybin/dwm-status-refresh.py &
~/.mybin/onehour.sh &
# dwmblocks &
