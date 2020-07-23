#!/bin/bash
#换源
aptsource(){
qinghua(){
    sed -i 's@^\(deb.*stable main\)$@#\1\ndeb https://mirrors.tuna.tsinghua.edu.cn/termux/termux-packages-24 stable main@' $PREFIX/etc/apt/sources.list
    sed -i 's@^\(deb.*games stable\)$@#\1\ndeb https://mirrors.tuna.tsinghua.edu.cn/termux/game-packages-24 games stable@' $PREFIX/etc/apt/sources.list.d/game.list
    sed -i 's@^\(deb.*science stable\)$@#\1\ndeb https://mirrors.tuna.tsinghua.edu.cn/termux/science-packages-24 science stable@' $PREFIX/etc/apt/sources.list.d/science.list
}
zhongkeda(){
    sed -i 's@^\(deb.*stable main\)$@#\1\ndeb https://mirrors.ustc.edu.cn/termux/ stable main@' $PREFIX/etc/apt/sources.list
}
echo "[1] 清华源"
echo "[2] 中科大"
read -p "请输入源" n
case n in
    1 ) qinghua;;
    2 ) zhongkeda;;
    * ) echo "输入错误";return 1;;
esac
apt update && apt upgrade
}

#install
pkg install neovim wget git tree tsu openssl -y
pkg install python -y
pkg install ranger -y
pkg install fish -y

#config
nvimconfig
fishconfig
