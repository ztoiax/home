#!/bin/zsh
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
    export NO_PROXY="mirrors.aliyun.com,registry.npm.taobao.org,npm.taobao.org,docker.mirrors.ustc.edu.cn,mirrors.aliyuncs.com,mirrors.cloud.aliyuncs.com"
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

function fzf-history-widget-accept() {
  fzf-history-widget
  zle accept-line
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

# dmenu
function cpline {
    command=$(history | tail -n 1)
    $(echo $command | awk '{$1="";print $0}') | dmenu -p "copy line" -l 10 | xclip -selection clipboard
}

function cphistory {
    hs=$(history)
    echo $hs | awk '{$1="";print $0}' | dmenu -p "copy history" -l 10 | xclip -selection clipboard
}

function cpcommand {
    hs=$(history)
    content=$(echo $hs | awk '{$1="";print $0}' | dmenu -p "copy content" -l 10)
    $(echo $content) | xclip -selection clipboard
}

function checkfile {
    grep '^#' /usr/include/X11/keysymdef.h | dmenu -p "XK" -l 15 | awk '{ print $2 }' | xclip -selection clipboard
}

function cpurl {
    command=$(history | tail -n 1)
    $(echo $command | awk '{$1="";print $0}') | egrep -o '((http|https)://|www\.)[a-zA-Z1-9.+-/]*' | dmenu -p "copy url" -l 10 | xclip -selection clipboard
}

function cpdir {
    command=$(history | tail -n 1)
    dir="bin|boot|dev|etc|home|lib|lib64|lost+found|mnt|opt|proc|root|run|sbin|srv|sys|tmp|usr|var"
    $(echo $command | awk '{$1="";print $0}') | egrep -o "/($dir)/[a-zA-Z0-9/.]*" | dmenu -p "copy url" -l 10 | xclip -selection clipboard
}

function searchurl {
    command=$(history | tail -n 1)
    $(echo $command | awk '{$1="";print $0}') | egrep -o '((http|https)://|www\.)[a-zA-Z1-9.+-/]*' | dmenu -p "search url" -l 10 | xargs xdg-open &> /dev/null
}

# bingkey
bindkey "^j" forward-word
bindkey "^k" backward-word
bindkey "^u" backward-kill-line
bindkey "^d" kill-line
bindkey "^f" forward-char
bindkey "^b" backward-char

vi-append-x-selection () { RBUFFER=$(xsel -o -p </dev/null)$RBUFFER; }
zle -N vi-append-x-selection
bindkey -a '^x' vi-append-x-selection
vi-yank-x-selection () { print -rn -- $CUTBUFFER | xsel -i -p; }
zle -N vi-yank-x-selection
bindkey -a '^y' vi-yank-x-selection

# software
bindkey "^[^z" deepin-screen-recorder

# fzf
zle -N fzf-history-widget-accept
bindkey '^r' fzf-history-widget-accept

# feh
zle -N nextwallpaper
bindkey "^[^n" nextwallpaper

# dmenu
zle -N cpcommand
zle -N cphistory
zle -N cpline
zle -N cpurl
zle -N cpdir
zle -N searchurl
bindkey "^[o" cpcommand
bindkey "^[h" cphistory
bindkey "^[l" cpline
bindkey "^[U" searchurl
bindkey "^[L" cpdir
