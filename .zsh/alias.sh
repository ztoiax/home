#!/bin/zsh
# Alias bin
alias mv="advmv -g"
alias cp="advcp -g"
alias rm="rm -i"
alias type="type -a"
alias free="free -h"
alias df="df -h"
alias c="clear"
alias w="watch -d -n 2"
alias ifconfig="ifconfig -a"
alias clip="xclip -selection c"
alias getclip="xclip -selection c -o"
alias cplast="history | tail -n 1 | cut -c8- | clip"
alias grep="egrep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn}"

# external
alias netdata="http://localhost:19999"
alias weather="ansiweather -l guangzhou -u metric -s true -f 2"
alias share="python3 -m http.server 8080"
alias macchanger="sudo macchanger -r enp27s0"
alias v="nvim"
alias chrome="google-chrome-stable"
alias e="nautilus"
alias r="ranger"
alias br="broot -sdpw"
alias n="nnn -d"

# cumstomization
alias ,ping='prettyping'
alias ,du='ncdu'
alias ,df='dfc'
alias ,find='fd'                # instead find
alias ,ls='lsd'                # instead find

# cool
alias hack="cmatrix"
alias s="neofetch"

# systemctl
alias sl="systemctl"
alias sls="systemctl status"
alias slr="systemctl restart"
alias sle="systemctl enbale"
alias sld="systemctl stop"
alias jl="journalctl"

# 不同发行版的包管理
if [ -f /usr/bin/lsb_release ]; then
    #Apt-get
    alias pi="sudo apt-get install"
    alias pr="sudo apt-get remove"
    alias pu='sudo apt-get update && sudo apt-get upgrade'
    alias pc='sudo apt-get autoclean && sudo apt-get clean && sudo apt-get autoremove'
    alias pq="dpkg -l"
elif [ -f /etc/redhat-release ];then
    #Yum
    alias pi="yum install"
    alias pr="yum remove"
    alias pu="yum update"
    alias pq="rpm -q"
    alias pf="yum list | grep -i"
elif uname -a | grep -i arch;then
    # Pacman
    # del denpends and config
    alias pr='sudo pacman -Rns'
    alias pl='sudo pacman -Qs'
    alias pq='sudo pacman -Qs | grep'
    alias pu='sudo pacman -Syu && yay -Syu'
    alias pl='sudo pacman -Ss'
    alias pk='sudo pacman-key --refresh-keys'
    # del zomble denpends
    alias pc='sudo pacman -Sc && sudo pacman -R $(pacman -Qdtq)'
elif uname -a | grep Android;then
    install="pkg"
    check="pkg show"
fi

# Pip
alias ppi='sudo pip3 install'
alias ppr='sudo pip3 uninstall'
alias ppl='sudo pip3 list'
alias ppq='sudo pip3 list | grep '

alias mykill='mykill.py'
alias mydu='mydu.py'
alias tmp='tmp.py'
alias clean='a-c && \
    tmp /home/tz/.cache/netease-cloud-music/CachedSongs/*'

alias centos7='sudo virsh start centos7; while true;do ssh $centos7 && break;done'
alias mi10='ssh u0_a369@192.168.1.111 -p 8022'
alias mi10-on='sudo simple-mtpfs --device 1 -o allow_other /mnt/android/'
alias mi10-off='sudo fusermount -u /mnt/android'

# exa
alias ls='exa'                                                         # ls
alias l='exa -lbF --git'                                               # list, size, type, git
alias ll='exa -lbGF --git'                                             # long list
alias llm='exa -lbGF --git --sort=modified'                            # long list, modified date sort
alias la='exa -a --git'
alias lx='exa -lbhHigUmuSa@ --time-style=long-iso --git --color-scale' # all + extended list
alias lS='exa -1'			                                           # one column, just names
alias lt='exa --tree --level=2'                                        # tree
alias lat='exa -a --tree --level=2'                                    # tree hide

# git
alias lg='lazygit'
alias gc='git clone'
alias ga='git add --all'
alias gm='git commit -m '
alias gp='git push'
alias gl='git log'
alias gb='git branch'
alias gs='git status'

alias grhh="git reset --hard $(git log | awk 'NR==1{print $2}')"

# docker
alias dil='sudo docker image ls'
alias dip='sudo docker image pull'
alias dir='sudo docker image rm'
alias dcl='sudo docker container ls'
alias dcrun='sudo docker container run'
alias dccp='sudo docker container cp'
alias dck='sudo docker container kill'
alias dcs='sudo docker container stop'


# fzf
alias tt='fzf --preview '"'"'[[ $(file --mime {}) =~ binary ]] && echo {} is a binary file || (rougify {}  || highlight -O ansi -l {} || coderay {} || cat {}) 2> /dev/null | head -500'"'"
alias sdir='cd $(find . -type d | fzf)'
alias ff="find . -type f -ls"

# zui
alias zui='crasis'

# python
alias pydash='source /home/tz/pydash/pydashtest/bin/activate && \
    python ~/pydash/manage.py runserver'

alias studio='/home/tz/Android/android-studio/bin/studio.sh &'

#Xorg
alias nw='feh --bg-fill --randomize ~/Pictures/wallpaper/*'
alias makedwm='cd ~/dwm; sudo make clean install && sudo pkill Xorg'
alias makedmenu='cd ~/dmenu; sudo make clean install && sudo pkill Xorg'
alias makest='cd ~/st; sudo make clean install && sudo pkill Xorg'

# abbrev-alias
abbrev-alias -g G="| grep"
abbrev-alias -g A="| ag"
abbrev-alias -g P="| awk '{ print $}'"
abbrev-alias -g US="| uniq | sort"
# abbrev-alias -g D="sudo docker container "
abbrev-alias -g DI="source /dev/stdin"
