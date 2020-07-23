# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/.zplug/init.zsh				h
# If you come from bash you might have to change your $PATH.  export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
  export ZSH="/home/tz/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="agnoster"
#ZSH_THEME="spaceship"
ZSH_THEME=powerlevel10k/powerlevel10k
#pure
#autoload -U promptinit; promptinit
#
## optionally define some options
#PURE_CMD_MAX_EXEC_TIME=10
#
## change the path color
#zstyle :prompt:pure:path color white
#
## change the color for both `prompt:success` and `prompt:error`
#zstyle ':prompt:pure:prompt:*' color cyan
#
#prompt pure
#/pure

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"


plugins=(
  git
  extract                   #x解压
  z
  autojump
  zsh-autosuggestions
  vi-mode
  tmux
  colors
  fzf
  zsh-abbrev-alias
  fast-syntax-highlighting
  docker
  history-substring-search
  # ls
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
#percol
#function exists { which $1 &> /dev/null }
#
#if exists percol; then
#    function percol_select_history() {
#        local tac
#        exists gtac && tac="gtac" || { exists tac && tac="tac" || { tac="tail -r" } }
#        BUFFER=$(fc -l -n 1 | eval $tac | percol --query "$LBUFFER")
#        CURSOR=$#BUFFER         # move cursor
#        zle -R -c               # refresh
#    }
#
#    zle -N percol_select_history
#    bindkey '^m' percol_select_history
#fi
#python 补全
# pip zsh completion start
function _pip_completion {
  local words cword
  read -Ac words
  read -cn cword
  reply=( $( COMP_WORDS="$words[*]" \
             COMP_CWORD=$(( cword-1 )) \
             PIP_AUTO_COMPLETE=1 $words[1] ) )
}
compctl -K _pip_completion pip
# pip zsh completion end

function proxy {
    export ALL_PROXY=socks5://127.0.0.1:10808
    export http_proxy=socks5://127.0.0.1:10808
    export https_proxy=socks5://127.0.0.1:10808
    export NO_PROXY="mirrors.aliyun.com,registry.npm.taobao.org,npm.taobao.org,docker.mirrors.ustc.edu.cn,mirrors.aliyuncs.com,mirrors.cloud.aliyuncs.com"
}

function sed-s {
    sed -i "s/$1/" $2
}

function sed-i {
    sed -i "/$1" $2
}
#export
export EDITOR=vim
#fzf
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --preview '(highlight -O ansi {} ||cat {}) 2> /dev/null | head -500'"
export FZF_COMPLETION_TRIGGER='**'
export GOPATH=$HOME/go
export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin

export PATH="/home/tz/.bin:$PATH"
export PATH="/home/tz/.mybin:$PATH"
#Alias bin
alias apt="sudo apt-get install"
alias rm="rm -i"
alias "type"="type -a"
alias grep="egrep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn}"
alias free="free -h"
alias df="df -h"
alias c="clear"
alias cat="bat"
alias hack="cmatrix"
alias vi="/usr/bin/vim"
alias vim="nvim"
alias w="watch -d -n 2"
alias v2="sudo cat /var/log/v2ray/access.log"
alias ifconfig="ifconfig -a"

alias macchanger="sudo macchanger -r enp27s0"
alias clip="xclip -selection c"
alias getclip="xclip -selection c -o"
alias cplast="history | tail -n 1 | cut -c8- | clip"
alias s="screenfetch"
alias r="ranger"
alias e="nautilus"
alias netdata="http://localhost:19999"
alias weather="ansiweather -l guangzhou -u metric -s true -f 2"

alias a-u='sudo apt-get update && sudo apt-get upgrade'
alias a-i='sudo apt-get install'
alias a-r='sudo apt-get remove'
alias a-c='sudo apt-get autoclean && sudo apt-get clean && sudo apt-get autoremove'
alias p-i='sudo pip3 install'
alias p-r='sudo pip3 uninstall'


alias mykill='mykill.py'
alias mydu='mydu.py'
alias tmp='tmp.py'
alias clean='a-c && \
    tmp /home/tz/.cache/netease-cloud-music/CachedSongs/*'

alias centos7='virsh start centos7.0; while true;do ssh $centos7 && break;done'
#exa
alias ls='exa'                                                         # ls
alias l='exa -lbF --git'                                               # list, size, type, git
alias ll='exa -lbGF --git'                                             # long list
alias llm='exa -lbGF --git --sort=modified'                            # long list, modified date sort
alias la='exa -a --git'
alias lx='exa -lbhHigUmuSa@ --time-style=long-iso --git --color-scale' # all + extended list

# speciality views
alias lS='exa -1'			                                           # one column, just names
alias lt='exa --tree --level=2'                                        # tree
alias lat='exa -a --tree --level=2'                                    # tree hide

#fzf
alias tt='fzf --preview '"'"'[[ $(file --mime {}) =~ binary ]] && echo {} is a binary file || (rougify {}  || highlight -O ansi -l {} || coderay {} || cat {}) 2> /dev/null | head -500'"'"
alias sdir='cd $(find . -type d | fzf)'
alias ff="find . -type f -ls"

#python
alias pydash='source /home/tz/pydash/pydashtest/bin/activate && \
    python ~/pydash/manage.py runserver'

alias studio='/home/tz/Android/android-studio/bin/studio.sh &'
#abbrev-alias
abbrev-alias -g G="| grep"
abbrev-alias -g A="| ag"
abbrev-alias -g P="| awk '{ print $}'"
abbrev-alias -g US="| uniq | sort"
# abbrev-alias -g D="sudo docker container "

abbrev-alias -g GC="git check "
abbrev-alias -g GM='git commit -m ""'
abbrev-alias -g GB="git branch "

abbrev-alias -g DI="source /dev/stdin"

#bingkey
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
#变量
nvim="~/.config/nvim"
enp="enp27s0"
termux="/data/data/com.termux/files/home"

centos8="root@192.168.100.165"
centos7="root@192.168.100.212"
mi10="u0_a369@192.168.1.111 "

share="/mnt/C/Users/ztoia/Desktop/share"
m="/mnt/E/迅雷下载/.m"
E="/mnt/E"
Z="/mnt/Z"

#自动启动
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
#broot
source /home/tz/.config/broot/launcher/bash/br
