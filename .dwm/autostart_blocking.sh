#下面这个方法适用于 dmenu 和 dwm 状态栏总是出现在屏幕顶端（从左上角顶点起绘制）的情况：
compton -b --focus-exclude "x = 0 && y = 0 && override_redirect = true"
netease-cloud-music &
~/.mybin/onehour.sh &
~/.mybin/2s.sh &
# variety &
# ibus-daemon -d -x -r &
# (conky | while read LINE; do xsetroot -name “$LINE”; done) &
