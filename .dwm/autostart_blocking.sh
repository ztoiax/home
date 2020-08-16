#下面这个方法适用于 dmenu 和 dwm 状态栏总是出现在屏幕顶端（从左上角顶点起绘制）的情况：
compton -b --focus-exclude "x = 0 && y = 0 && override_redirect = true"
# compton -b
redshift -l 23.6980:133.8807 -t 5300:4000 &
~/.mybin/onehour.sh &
~/.mybin/1s.sh &
netease-cloud-music &
fcitx &
xdman &
st &
st -e nvim &
google-chrome-stable &
# ibus-daemon -d -x -r &
# variety &
# (conky | while read LINE; do xsetroot -name “$LINE”; done) &
