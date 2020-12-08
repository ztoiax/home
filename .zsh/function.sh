#!/bin/zsh
# custom function and bindkey

##### base ######

function af-shutdown(){
    # sudo su -c 'while [[ -d /proc/$(pgrep $1) ]]; do sleep 1; done; poweroff'
    sudo su -c '$(pgrep $1)'
}

function n(){
    if [ $# -eq 0 ];then
        ss -tlap
    else
        # print first row
        ss -tlap | head -n 1
        for i in $@;do
            ss -tlap | grep $i | grep -v grep
        done
    fi
}
# easy ps aux
function p(){
    if [ $# -eq 0 ];then
        ps aux
    else
        # print first row
        ps aux | head -n 1
        for i in $@;do
            ps aux | grep $i | grep -v grep
        done
    fi
}

# go to /proc/process
function pp(){
    cd /proc/$(pgrep $1)
}

# view thread
function pt(){
    number='^[0-9]+$'

    if [[ $1 =~ $number ]];then
        ps -T -p $1
    else
        ps -T -p $(pgrep $1)
    fi
}

# enable webui-aria2
function aria2-boot(){
    if aria2c --enable-rpc --rpc-listen-all &;then
        node /home/tz/Downloads/Programs/webui-aria2/node-server.js &
    fi
}

##### pacman ######
if which pacman &> /dev/null;then

# install packages
function pi {
    for i in $@;do
        if ! sudo pacman -S $i;then
            yay -S $i
        fi
    done
}

# search local packages
function pl(){
    if [ $# -eq 0 ];then
        sudo pacman -Qs
    else
        for i in $@;do
            sudo pacman -Qs | grep $i | grep -v grep
        done
    fi
}
# search remote packages
function pq(){
    if ! sudo pacman -Ss $1;then
        yay -Ss $1
    fi
}

# list size of package denpends
function psl(){
    pacman -Qlq $1 | grep -v '/$' | xargs -r du -h | sort -h
}

# list size of packages or package
function pss(){
    if [ $1 ];then
        LANG=C pacman -Qi | sed -n '/^Name[^:]*: \(.*\)/{s//\1 /;x};/^Installed[^:]*: \(.*\)/{s//\1/;H;x;s/\n//;p}' | sort -nk2 | grep $1
    else;
        LANG=C pacman -Qi | sed -n '/^Name[^:]*: \(.*\)/{s//\1 /;x};/^Installed[^:]*: \(.*\)/{s//\1/;H;x;s/\n//;p}' | sort -nk2
    fi
    # human size
    # LC_ALL=C pacman -Qi | awk '/^Name/{name=$3} /^Installed Size/{print $4$5, name}' | sort -h
}
fi

function backup-dd(){
    # remount dev read only
    sudo mount -o remount,ro /dev/nvme0n1p5
    sudo dd if=/dev/nvme0n1p5 | pv | gzip > $backup/arch-$(date +"%Y-%m-%d").gz
    # sudo fsarchiver savefs -Z22 -j12 -v $backup/arch-$(date +"%Y-%m-%d").fsa /dev/nvme0n1p5
}
##### redis ######
function redis(){
    if redis-server /var/lib/redis/redis.conf &;then
        iredis
    fi
}

# scp
function scpcentos7(){
    rsync -r $1 "root@192.168.100.208:/root"
}

# adb
function scpmi10(){
    adb push $1 /sdcard/download
}

function brightscreen(){
    adb shell input keyevent 26
}

# 将notes等文件，同步到手机
function sync-notes {
    # 删除目标目录的多余文件 adb-sync --delete
    # 手机同步到电脑         adb-sync --reverse /sdcard/Download/ ~/Downloads
    adb-sync ~/notes /sdcard/github/ && n="notes OK"
    adb-sync ~/jianli /sdcard/github/ && nn="jianli OK"

    adb-sync ~/.mybin /sdcard/github/
    adb-sync ~/.zsh /sdcard/github/
    adb-sync ~/.zshrc /sdcard/github/ && nnn="zsh OK"

    adb-sync /home/tz/Downloads/1136453598_破晓后的天照/books /sdcard/ && nnnn="books OK"

    # 写入日志后通知
    echo "$(date +"%Y-%m-%d_%H:%M:%S") adb-sync:$n,$nn,$nnn,$nnnn" >> /var/log/adb-sync \
        && \
        notify-send "adb-sync:" "$n\n$nn\n$nnn\n$nnnn"
}

# python 补全
function _pip_completion {
  local words cword
  read -Ac words
  read -cn cword
  reply=( $( COMP_WORDS="$words[*]" \
             COMP_CWORD=$(( cword-1 )) \
             PIP_AUTO_COMPLETE=1 $words[1] ) )
}
compctl -K _pip_completion pip

function proxy-on {
    host="socks5://127.0.0.1:10808"
    export ALL_PROXY="$host"
    export http_proxy="$host"
    export https_proxy="$host"
    export NO_PROXY="mirrors.aliyun.com,taobao.org,npm.taobao.org,docker.mirrors.ustc.edu.cn,mirrors.aliyuncs.com,mirrors.cloud.aliyuncs.com,tsinghua.edu.cn,pee6w651.mirror.aliyuncs.com"
}

function proxy-on-http {
    host="http://127.0.0.1:10809"
    export ALL_PROXY="$host"
    export http_proxy="$host"
    export https_proxy="$host"
    export NO_PROXY="mirrors.aliyun.com,registry.npm.taobao.org,npm.taobao.org,docker.mirrors.ustc.edu.cn,mirrors.aliyuncs.com,mirrors.cloud.aliyuncs.com,tsinghua.edu.cn"
}

function proxy-off {
    unset ALL_PROXY
    unset http_proxy
    unset https_proxy
    unset NO_PROXY
}

function sed-s {
    sed -i "s/$1/" $2
}

function sed-i {
    sed -i "/$1" $2
}

# function ranger {
#     tempfile=$(mktemp)
#     trap 'rm -f "$tempfile"' EXIT
#     ranger_cmd=(
#         command
#         ranger --cmd="map q chain shell echo %d > "$tempfile"; quitall"
#     )
#     ${ranger_cmd[@]}
#     cd "$(cat "$tempfile")"
#     rm -f "$tempfile" 2>/dev/null
# }

rga-fzf() {
	RG_PREFIX="rga --files-with-matches"
	local file
	file="$(
		FZF_DEFAULT_COMMAND="$RG_PREFIX '$1'" \
			fzf --sort --preview="[[ ! -z {} ]] && rga --pretty --context 5 {q} {}" \
				--phony -q "$1" \
				--bind "change:reload:$RG_PREFIX {q}" \
				--preview-window="70%:wrap"
	)" &&
	echo "opening $file" &&
	xdg-open "$file"
}

# feh
function nextwallpaper {
    feh --bg-fill --randomize ~/Pictures/wallpaper/*
}
# xdg-open
# function xdg-open() {
#     echo $1
#     char="http*"
#     if [[ $1 =~ $char ]];then
#         xdg-open $1
#     else
#         xdg-open "http://$1"
#     fi
# }

##### dmenu ######
function cpline {
    $(history | tail -n 1 | awk '{$1="";print $0}') | dmenu -p "copy line" -l 10 | xclip -selection clipboard
}

function cphistory {
    history | sort -nr | awk '{$1="";print $0}' | dmenu -p "copy history" -l 10 | xclip -selection clipboard
}

function cpcommand {
    $(history | sort -nr | awk '{$1="";print $0}' | dmenu -p "copy content" -l 10) | xclip -selection clipboard
}

function checkfile {
    choices="XK\nport"
    chosen=$(echo -e "$choices" | dmenu -p "输入你的查找什么")

    case "$chosen" in
        XK) grep '^#' /usr/include/X11/keysymdef.h | dmenu -p "XK" -l 15 | awk '{ print $2 }' | xclip -selection clipboard ;;
        port) grep -v '^#' /etc/services | dmenu -p "port" -l 15 | awk '{ print $1 }' | xclip -selection clipboard;;
    esac
}

function cpurl {
    $(history | tail -n 1 | awk '{$1="";print $0}') | egrep -o '((http|https)://|www\.)[a-zA-Z1-9.+-/]*' | dmenu -p "copy url" -l 10 | xclip -selection clipboard
}

function cpdir {
    dir="bin|boot|dev|etc|home|lib|lib64|lost+found|mnt|opt|proc|root|run|sbin|srv|sys|tmp|usr|var"
    $(history | tail -n 1 | awk '{$1="";print $0}') | egrep -o "/($dir)/[a-zA-Z0-9/.]*" | dmenu -p "copy dir" -l 10 | xclip -selection clipboard
}

function searchurl {
    $(history | tail -n 1 | awk '{$1="";print $0}') | egrep -o '((http|https)://|www\.)[a-zA-Z1-9.+-/]*' | dmenu -p "search url" -l 10 | xargs xdg-open &> /dev/null
}

function pet-exec {
    pet exec
}

##### bindkey ######
# bindkey "^j" forward-word
# bindkey "^k" backward-word
bindkey "^u" backward-kill-line
bindkey "^k" kill-line
bindkey "^f" forward-char
bindkey "^b" backward-char
bindkey "^o" accept-and-hold
# zsh-history-substring-search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

pb-yank () {
  CUTBUFFER=$(pbpaste)
  zle yank
}
zle -N pb-yank
bindkey '^v'   paste-insert

vi-append-x-selection () { RBUFFER=$(xsel -o -p </dev/null)$RBUFFER; }
zle -N vi-append-x-selection
bindkey -a '^x' vi-append-x-selection
vi-yank-x-selection () { print -rn -- $CUTBUFFER | xsel -i -p; }
zle -N vi-yank-x-selection
bindkey -a '^y' vi-yank-x-selection

# dmenu
zle -N cpcommand
zle -N cphistory
zle -N cpline
zle -N cpurl
zle -N cpdir
zle -N searchurl
bindkey '^[h' cpcommand
bindkey '^[H' cphistory
bindkey '^[l' cpline
bindkey '^[L' cpdir
bindkey '^[U' searchurl

# pet
zle -N pet-exec
# alt + <tab>
bindkey '^[\t' pet-exec

# alt + <enter>
zle -N brightscreen
bindkey '^[^M' brightscreen
