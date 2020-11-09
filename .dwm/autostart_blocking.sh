#下面这个方法适用于 dmenu 和 dwm 状态栏总是出现在屏幕顶端（从左上角顶点起绘制）的情况：
# compton -b --focus-exclude "x = 0 && y = 0 && override_redirect = true"
~/.mybin/onehour.sh &
~/.mybin/1s.sh &
compton -b
redshift -l 23.6980:133.8807 -t 5300:3300 &
netease-cloud-music &
xdman &
# qbittorrent &
# st &
# st -e nvim &
# st -e speedometer -rx enp27s0 &
# st -e htop &
google-chrome-stable &
fcitx5 &
# ~/.mybin/adb.sh &
# dwmblocks &

# 开启虚拟机
virsh start centos7 &
