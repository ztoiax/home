#!/bin/zsh
# variable
nvim="~/.config/nvim"
enp="enp27s0"
termux="/data/data/com.termux/files/home"
backup="/mnt/Z/linux/"
programs="~/Downloads/Programs"

centos7="root@192.168.100.208"
opensuse="root@192.168.100.71"
mi10="u0_a369@192.168.1.111 "

desktop="/mnt/C/Users/ztoia/Desktop"
share="/mnt/C/Users/ztoia/Desktop/share"
C="/mnt/C"
E="/mnt/E"
Z="/mnt/Z"

# mysql
mydir="/var/lib/mysql"
mylog="/var/log/mysql"

# export
export BROWSER="google-chrome-stable"
export TERM="st-256color"
export EDITOR="nvim"
export GIT_EDITOR="nvim"
export REACT_EDITOR="nvim"
export NVIM_LISTEN_ADDRESS="/tmp/nvimsocket"
export GENCOMPL_FPATH=$HOME/.zsh/complete

# fzf
export FZF_COMPLETION_TRIGGER=',,'

export FZF_DEFAULT_COMMAND='find . -type f -not -path "*/.git*"'
export FZF_DEFAULT_OPTS="--height 70% --layout=reverse"
# export FZF_DEFAULT_OPTS="--height 70% --layout=reverse --preview '(highlight -O ansi {} ||cat {}) 2> /dev/null | head -500'"
# export FZF_DEFAULT_OPTS="--height 70% --layout=reverse --preview 'bat --style=numbers --color=always --line-range :500 {}'"

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--height 70% --layout=reverse --preview 'bat --style=numbers --color=always --line-range :500 {}'"

export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"

# PATH
# export CDPATH='/home/tz:/home/tz/.config:/etc'

export JAVA_HOME="/usr/lib/jvm/default-runtime"
export GOPATH=$HOME/go
export PATH="$JAVA_HOME:$PATH"
export PATH="/usr/share/bcc/tools:$PATH"
export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin
export PATH="/home/tz/.mybin:$PATH"
export PATH="/home/tz/.bin:$PATH"
export PATH="/home/tz/FlameGraph:$PATH"
export PATH="/home/tz/.local/bin:$PATH"

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

# xdg
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

export XDG_DATA_DIRS="/usr/local/share"
export XDG_CONFIG_DIR="/etc/xdg"

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
function fcitx5-on {
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
