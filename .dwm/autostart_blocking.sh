#下面这个方法适用于 dmenu 和 dwm 状态栏总是出现在屏幕顶端（从左上角顶点起绘制）的情况：
# compton -b --focus-exclude "x = 0 && y = 0 && override_redirect = true"
~/.mybin/onehour.sh &
# ~/.mybin/1s.sh &
# ~/.mybin/dwm-status-refresh.py &
compton -b
redshift -l 23.6980:133.8807 -t 6300:4000 &
netease-cloud-music &
qbittorrent &
# yesplaymusic &
xdman &
xunlei &
google-chrome-stable &
fcitx5 &
~/.mybin/v2.sh
# st -e nvim &
scrcpy --max-fps 120 --bit-rate 10M &
# dwmblocks &
