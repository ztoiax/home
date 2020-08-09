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

# fzf
zle -N fzf-history-widget-accept
bindkey '^r' fzf-history-widget-accept

# dmenu
zle -N cpcommand
zle -N cphistory
zle -N cpline
bindkey "^[o" cpcommand
bindkey "^[h" cphistory
bindkey "^[l" cpline
