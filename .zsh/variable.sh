#!/bin/zsh
# variable
nvim="~/.config/nvim"
enp="enp27s0"
termux="/data/data/com.termux/files/home"
backup="/mnt/Z/linux/"
programs="~/Downloads/Programs"

centos8="root@192.168.100.165"
centos7="root@192.168.100.208"
mi10="u0_a369@192.168.1.111 "

share="/mnt/C/Users/ztoia/Desktop/share"
m="/mnt/E/迅雷下载/.m"
E="/mnt/E"
Z="/mnt/Z"

# mysql
mydir="/var/lib/mysql"
mylog="/var/log/mysql"

# export
export TERM="st-256color"
export EDITOR="nvim"
export GIT_EDITOR="nvim"
export REACT_EDITOR="nvim"

# fzf
export FZF_COMPLETION_TRIGGER=','

# export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_DEFAULT_COMMAND='find . -type f'
export FZF_DEFAULT_OPTS="--height 70% --layout=reverse"
# export FZF_DEFAULT_OPTS="--height 70% --layout=reverse --preview '(highlight -O ansi {} ||cat {}) 2> /dev/null | head -500'"
# export FZF_DEFAULT_OPTS="--height 70% --layout=reverse --preview 'bat --style=numbers --color=always --line-range :500 {}'"

export FZF_CTRL_T_COMMAND='find . -type f'
export FZF_CTRL_T_OPTS="--height 70% --layout=reverse --preview 'bat --style=numbers --color=always --line-range :500 {}'"

export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"

# PATH
export CDPATH='/home/tz:/home/tz/.config:/etc'

export GOPATH=$HOME/go
export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin
export PATH="/home/tz/.mybin:$PATH"
export PATH="/home/tz/.bin:$PATH"
export PATH="/home/tz/.mybin/statusbar:$PATH"
export PATH="/home/tz/.mybin/wjscripts:$PATH"

# nnn
export NNN_BMS='m:/mnt;h:~;M:/mnt/E/迅雷下载;c:~/.config;m:/mnt;p:~/Pictures'
export NNN_FIFO=/tmp/nnn.fifo
export NNN_PLUG='f:fzopen;t:preview-tabbed;p:preview-tui;i:imgview;v:vidthumb;'

# forgit
FORGIT_STASH_FZF_OPTS='--bind="ctrl-d:reload(git stash drop $(cut -d: -f1 <<<{}) 1>/dev/null && git stash list)"'
FORGIT_FZF_DEFAULT_OPTS="
--exact
--border
--cycle
--reverse
--height '80%'
"

# fcitx
function fcitx-on {
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"

export QT4_IM_MODULE=fcitx
export QT5_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
}

# fcitx5
function fcitx-on {
export GTK_IM_MODULE=fcitx5
export XMODIFIERS="@im=fcitx"

export QT4_IM_MODULE=fcitx5
export QT5_IM_MODULE=fcitx5
export QT_IM_MODULE=fcitx5
}
# ibus
function ibus-on {
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus
}
# zh
function zh-on {
export LANG=zh_CN.UTF-8
export LANGUAGE=zh_CN:en_US
}
# en
function en-on {
    export LANG=en_US.UTF-8
    export LANGUAGE=en_US.UTF-8
}
