#!/bin/zsh
# custom function and bindkey

##### base ######
function ,for(){
  # 第一个参数为执行的次数，之后的参数就是命令。如执行两次ls-l：,for 2 ls -l
  max=$1
  shift
  for ((i=0; i<$max; i=i+1));do
    $@
  done
}

function ,ls(){
    # fselect $@ depth 1
    fselect $@ from . depth 1
}

# 相当于在线tldr
function ,,,man(){
    curl https://cheat.sh/$1
}

function vmip(){
    if [ $# -eq 0 ];then
        vm net-dhcp-leases --network default
    else
        for i in $@;do
            vm domifaddr $i
        done
    fi
}

function drun (){
 go clean --modcache   sudo docker run --rm -it $(sudo docker image ls | awk 'NR==2 {print $3}')
}

function mystrace (){
     strace $1 2>&1 | awk -F "(" '{ print $1}' | awk '{ print $1}' | sort | uniq -c | sort -n
}

function f(){
    find . -newerct "$1 minute ago" -print
}

function ff(){
    sudo find . \( -path "./mnt/*" -o -path "./proc/*" -o -path "./sys/*" \) -prune -o -type f -iname '$1' -print
}

function after(){
    dir=/proc/$(pgrep -of $1)
    shift
    if ! [[ "$dir" == "/proc/" ]]; then
        while [[ -d $dir ]]; do echo $dir; sleep 1; done; $@
    fi
}

function n(){
    command="sudo ss -tuanp"
    # command="sudo netstat -tuanp"
    if [ $# -eq 0 ];then
        $(echo $command)
    else
        for i in $@;do
            $(echo $command) | head -n 1
            $(echo $command) | grep -i $i
        done
    fi
}
# easy ps auxf
function p(){
    if [ $# -eq 0 ];then
        ps auxf
    else
        # print first row
        ps auxf | head -n 1
        for i in $@;do
            ps auxf | grep -i $i | grep -v grep
        done
    fi
}

# go to /proc/process
function pp(){
    cd /proc/$(pgrep -of $1)
}

# view thread
function pt(){
    pt="ps -eLo ruser,pid,ppid,lwp,psr,args"
    number='^[0-9]+$'

    eval "$pt" | awk 'NR==1'
    for i in $@;do
        if [[ $i =~ $number ]];then
            eval "$pt" | awk -v i="$i" '{if($5==i) print $0}'
        else
            eval "$pt" | grep -i $i
        fi
    done
}

# monitor cpu/mem usage of single process
function pm(){
    pidstat --human -udr -t -C $1 1
}

function pmio(){
    pidstat --human -dt -C $1 1
}

function pmm(){
    pidstat --human -rt -C $1 1
}

function pm1(){
    while true;do
         # ps -p $(pgrep -of $1) -o %cpu,%mem,cmd
         pgrep -P $(pgrep -of $1) | xargs ps -o %mem,%cpu,cmd -p |\
             awk '{memory+=$1;cpu+=$2} END {print memory,cpu}'
    done
}

# enable webui-aria2
function aria2-boot(){
    if aria2c --enable-rpc --rpc-listen-all &;then
        node /home/tz/Downloads/Programs/webui-aria2/node-server.js &
    fi
}

##### pacman ######

# paru -G 下载PKGBUILD
# paru -Ui 安装PKGBUILD

if which pacman &> /dev/null;then

# install packages
function pi {
    for i in $@;do
        if ! sudo pacman -S $i;then
            paru -S $i
        fi
        pss $i
    done
}

# search local packages
function pl(){
    if [ $# -eq 0 ];then
        pacman -Qq | fzf --preview 'pacman -Qil {}' --layout=reverse --bind 'enter:execute(pacman -Qil {} | less)'
    else
        for i in $@;do
            pacman -Qil $i | more
        done
    fi
}

function pll(){
    for i in $@;do
        pacman -Qs $i
    done
}

function pq(){
    if [ $# -eq 0 ];then
        pacman -Slq | fzf --preview 'pacman -Si {}' --layout=reverse
        # paru -Slq | fzf --preview 'paru -Si {}' --layout=reverse
    else
        pacman -Ss $1; paru -Ss $1
    fi
}

function ppl(){
    if [ $# -eq 0 ];then
        pip3 list |  awk 'NR > 2 {print $1}' | fzf --preview 'pip3 show {}' --layout=reverse
    else
        pip3 show $@
    fi
}

function pb(){
    notify-send "backup $i"
    dir=$(ls /var/lib/pacman/local | fzf)
    tar -I zstd -cf ~/.config/pacman_backup/$dir.tar.zst /var/lib/pacman/local/$dir
}

function pU () {
  paru -Syyu
  # nvim
  proxychains4 nvim --headless -c 'Lazy sync'
  # yazi
  proxychains4 ya pack -u
  # hyprland
  hyprpm update
  # zinit
  zinit update
}

function pc(){
    sudo pacman -Scc && sudo pacman -Rns $(pacman -Qdtq) && paru -Sc
    # rm -rf /var/cache/debtap
    notify-send "pacman and paru depends"


    # ~/.npm/_cacache
    notify-send "npm"
    npm cache clean --force

    # /root/.npm/_cacache
    notify-send "root npm"
    sudo npm cache clean --force

    # ~/.cache/uv
    notify-send "uv"
    uv cache clean

    # ~/.rustup/toolchains
    notify-send "rustup"
    rustup toolchain remove nightly

    notify-send "yarn"
    yarn cache clean

    notify-send "pnpm"
    pnpm store prune

    notify-send "pip3"
    pip3 cache purge

    notify-send "cargo"
    cargo cache -a

    notify-send "paru cache"
    rm -rf /home/tz/.cache/paru

    # notify-send "ranger cache"
    # rm -rf /home/tz/.cache/ranger

    notify-send "netease-cloud-music cache"
    rm -rf /home/tz/.cache/netease-cloud-music/CachedSongs

    # notify-send "chrome cache"
    # rm -rf /home/tz/.cache/google-chrome/Default

    notify-send "earth cache"
    rm -rf /home/tz/.googleearth/Cache

    notify-send "perf debug cache"
    rm -rf /home/tz/.debug

    notify-send "go mod cache, go-build"
    go clean --modcache
    go clean -cache

    # 需要安装cargo install cargo-cache
    notify-send "rust cargo cache"
    cargo-cache -a

    notify-send "yarn cache"
    yarn cache clean

    notify-send "journalctl cache"
    sudo journalctl --vacuum-size=200M
    journalctl --disk-usage

    notify-send "wechat cache"
    rm -rf /home/tz/.config/微信.bak/GPUCache

    notify-send "trash cache"
    trash-rm \*

    # notify-send "docker cache"
    # # overlay2
    # sudo docker system prune -a -f

    # # volume
    # sudo docker volume prune -f
}

# list size of package depends
function psl(){
    sudo pacman -Qlq | grep -v '/$' | xargs -r du -h | sort -h
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

# 查询当前文件来至哪个包
function po(){
  sudo pacman -Qo
}

##### backup ######
function backup-dd(){
    if [ $# -eq 0 ];then
        # remount dev read only
        # sudo mount -o remount,ro /dev/nvme0n1p3

        # sudo dd if=/dev/nvme0n1p3 | pv | pigz > $backup/arch-$(date +"%Y-%m-%d:%H:%M:%S").gz
        echo "backup '/'"
        sudo dd if=$(df / | awk 'NR == 2{ print $1}')  conv=sync,noerror status=progress bs=64K | pigz > $backup/arch-$(date +"%Y-%m-%d:%H:%M:%S").gz
        notify-send "backup-dd '/' finish"

        # sudo fsarchiver savefs -Z22 -j12 -v $backup/arch-$(date +"%Y-%m-%d").fsa /dev/nvme0n1p5
    else;
        echo 'backup home'
        sudo dd if=$(df /home | awk 'NR == 2{ print $1}')  conv=sync,noerror status=progress bs=64K | pigz > $backup/home-$(date +"%Y-%m-%d:%H:%M:%S").gz
        notify-send "backup-dd 'home' finish"
    fi
}

# recovery-dd
# sudo pigz -dc /mnt/Z/linux/arch.gz | pv | sudo dd of=/dev/nvme0n1p3 status=progress bs=64K

##### web ######
# 测试是否支持https
function hs (){
    for i in $@;do
        if nc -w1 $i.com 443;then
            echo -e "\033[32m $i support https \033[0m"
        else
            echo -e "\033[31m $i nosupport https \033[0m"
        fi
    done
}

# 测试是否支持http2
function h2 (){
    for i in $@;do
        v=$(nghttp -n -t 1 https://www.$i.com 2>&1)
        if [ $v ];then
            echo -e "\033[31m $i nosupport http2 \033[0m"
        else
            echo -e "\033[32m $i support http2 \033[0m"
        fi
    done
}

function ,h2 (){
    nghttp -nva https://www.$1.com
}

##### benchmark ######

function flamegraph(){
    # 生成堆栈火焰图
    perf record -F 99 -g $@
    perf script | stackcollapse-perf.pl | flamegraph.pl > /tmp/$1.svg
    xdg-open /tmp/$1.svg
    rm perf.data
}

##### redis ######
function redis(){
    if redis-server /var/lib/redis/redis.conf &;then
        iredis
    fi
}

# scp
scppush() {
    prsync -h /etc/pssh/hosts -l opsuser -a -r $1 $2
}

scppull() {
    pslurp -h /etc/pssh/hosts -r -L ~ $1 $2
}

function centos(){
    sudo virsh start centos7-2
    sudo virsh start centos7-3
    sudo virsh start centos7-4
    sudo virsh start centos7-5
}

function centos7(){
    dir=/mnt/centos/
    sudo virsh start centos7;

    while true;do
        ssh -q $centos7 exit && break
    done
        sudo sshfs -o allow_other,default_permissions -o IdentityFile=/home/tz/.ssh/id_rsa  $centos7:/ $dir
        ssh $centos7
}

function opensuse(){
    dir=/mnt/opensuse/
    sudo virsh start opensuse15.2;

    while true;do
        ssh -q $opensuse exit && break
    done
        sudo sshfs -o allow_other,default_permissions -o IdentityFile=/home/tz/.ssh/id_rsa  $opensuse:/ $dir
        ssh $opensuse
}


# adb
function scpmi10(){
    adb push $1 /sdcard/download
}

function brightscreen(){
    adb shell input keyevent 26
}

# 将notes等文件，同步到手机
function sync-phone {
    # 删除目标目录的多余文件 adb-sync --delete
    # 手机同步到电脑         adb-sync --reverse /sdcard/Download/ ~/Downloads
    adb-sync -d ~/mind /sdcard/github/ && n="mind OK"
    adb-sync -d ~/notes /sdcard/github/ && n="notes OK"
    adb-sync -d ~/python /sdcard/github/ && n="python OK"
    adb-sync -d ~/database /sdcard/github/ && n="notes OK"

    adb-sync -d ~/jianli /sdcard/ && nn="jianli OK"

    adb-sync -d ~/.mybin /sdcard/github/
    adb-sync -d ~/.zsh /sdcard/github/
    adb-sync -d ~/.zshrc /sdcard/github/ && nnn="zsh OK"

    adb-sync -d /home/tz/Downloads/1136453598_破晓后的天照/books /sdcard/syncthing && nnnn="books OK"

    # 写入日志后通知
    echo "$(date +"%Y-%m-%d_%H:%M:%S") adb-sync:$n,$nn,$nnn,$nnnn" >> /var/log/adb-sync.log \
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
    export HTTP_PROXY="$host"
    export HTTPS_PROXY="$host"
    export NO_PROXY="127.0.0.1,localhost,mirrors.aliyun.com,taobao.org,npm.taobao.org,docker.mirrors.ustc.edu.cn,mirrors.aliyuncs.com,mirrors.cloud.aliyuncs.com,tsinghua.edu.cn,pee6w651.mirror.aliyuncs.com,youdao.com,bing.com,translate.googleapis.com,translate.google.cn"
}

function proxy-on-http {
    host="http://127.0.0.1:10809"
    export ALL_PROXY="$host"
    export HTTP_PROXY="$host"
    export HTTPS_PROXY="$host"
    export NO_PROXY="127.0.0.1,localhost,mirrors.aliyun.com,taobao.org,npm.taobao.org,docker.mirrors.ustc.edu.cn,mirrors.aliyuncs.com,mirrors.cloud.aliyuncs.com,tsinghua.edu.cn,pee6w651.mirror.aliyuncs.com,youdao.com,bing.com,translate.googleapis.com,translate.google.cn"
}

function proxy-off {
    unset ALL_PROXY
    unset HTTP_PROXY
    unset HTTPS_PROXY
    unset NO_PROXY
}

function sed-i {
    sed -i "s/$1/$2/g" $3
}

function sed-c {
    sed -i "/$1/c$2" $3
}


function col {
    perl -lane "print @F[$1]" $2
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

fzf-dir(){
    find . -type d | fzf
}

fzf-rga(){
    RG_PREFIX="rga --column --line-number --no-heading --color=always --smart-case"
    INITIAL_QUERY=""
    FZF_DEFAULT_COMMAND="$RG_PREFIX '$INITIAL_QUERY'" \
        # || true 不报错退出
      fzf --bind "change:reload:$RG_PREFIX {q} || true" \
          --ansi --phony --query "$INITIAL_QUERY"
}

fzf-rga-file(){
	RG_PREFIX="rga --files-with-matches . *"
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

# ranger
# function r {
#     local IFS=$'\t\n'
#     local tempfile="$(mktemp -t tmp.XXXXXX)"
#     local ranger_cmd=(
#         command
#         ranger
#         --cmd="map Q chain shell echo %d > "$tempfile"; quitall"
#     )
#
#     ${ranger_cmd[@]} "$@"
#     if [[ -f "$tempfile" ]] && [[ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]]; then
#         cd -- "$(cat "$tempfile")" || return
#     fi
#     command rm -f -- "$tempfile" 2>/dev/null
# }

# yazi
function r() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

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

##### pet ######

function pet-exec {
    pet exec
}

function prev() {
  PREV=$(fc -lrn | head -n 1)
  sh -c "pet new `printf %q "$PREV"`"
}

##### github ######

function github-init(){
    gh repo create $1
    cd $1
    git branch -M main
    git remote add origin "https://github.com/ztoiax/$1.git"
}

##### nvim ######

alias nvim-lazy="NVIM_APPNAME=LazyVim nvim"
alias nvim-kick="NVIM_APPNAME=kickstart nvim"
alias nvim-chad="NVIM_APPNAME=NvChad nvim"
alias nvim-astro="NVIM_APPNAME=AstroNvim nvim"
alias nvim-ayamir="NVIM_APPNAME=ayamir nvim"

function nvims() {
    items=("default" "kickstart" "LazyVim" "NvChad" "AstroNvim" "ayamir" "Bekaboo")

    # 不同nvim配置文件的目录
    config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config  " --height=~50% --layout=reverse --border --exit-0)
    if [[ -z $config ]]; then
        echo "Nothing selected"
        return 0
    elif [[ $config == "default" ]]; then
        config=""
    fi

    NVIM_APPNAME=$config nvim $@
}

##### bindkey ######
# bindkey "^j" forward-word
# bindkey "^k" backward-word
bindkey "^u" backward-kill-line
bindkey "^k" kill-line
bindkey "^f" forward-char
bindkey "^b" backward-char
bindkey "^o" accept-and-hold
bindkey "[[^a" screen
# zsh-history-substring-search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

pb-yank () {
  CUTBUFFER=$(pbpaste)
  zle yank
}
zle -N pb-yank
# bindkey '^v'   paste-insert

# ctrl-v编辑器编辑当前文件
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^v' edit-command-line

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
bindkey '^[H' cpcommand
bindkey '^[h' cphistory
bindkey '^[l' cpline
bindkey '^[L' cpdir
bindkey '^[U' cpurl

# pet
# zle -N pet-exec
# alt + <tab>
# bindkey '^[\t' pet-exec

# ctrl + <enter>
zle -N brightscreen
bindkey '^[[^M' brightscreen

# fzf
zle -N fzf-dir
bindkey '^[x' fzf-dir
