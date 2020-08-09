#!/bin/zsh
# Alias bin
alias rm="rm -i"
alias "type"="type -a"
alias grep="egrep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn}"
alias free="free -h"
alias df="df -h"
alias c="clear"
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
alias share="python3 -m http.server 8080"

# Apt
alias a-u='sudo apt-get update && sudo apt-get upgrade'
alias a-i='sudo apt-get install'
alias a-r='sudo apt-get remove'
alias a-c='sudo apt-get autoclean && sudo apt-get clean && sudo apt-get autoremove'
alias p-i='sudo pip3 install'
alias p-r='sudo pip3 uninstall'
# Pacman
alias p-i='sudo pacman -Sy'
# del denpends and config
alias p-r='sudo pacman -Rns'
alias p-q='sudo pacman -Qs'
alias p-u='sudo pacman -Syu'
alias p-s='sudo pacman -Ss'
# del zomble denpends
alias p-c='sudo pacman -Sc && sudo pacman -R $(pacman -Qdtq)'

alias mykill='mykill.py'
alias mydu='mydu.py'
alias tmp='tmp.py'
alias clean='a-c && \
    tmp /home/tz/.cache/netease-cloud-music/CachedSongs/*'

alias centos7='virsh start centos7.0; while true;do ssh $centos7 && break;done'
alias mi10='ssh u0_a369@192.168.1.111 -p 8022'
# exa
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

#X
alias n='feh --bg-fill --randomize ~/Pictures/wallpaper/*'
alias makedwm='cd ~/dwm; sudo make clean install && sudo pkill Xorg'
# abbrev-alias
abbrev-alias -g G="| grep"
abbrev-alias -g A="| ag"
abbrev-alias -g P="| awk '{ print $}'"
abbrev-alias -g US="| uniq | sort"
# abbrev-alias -g D="sudo docker container "

abbrev-alias -g GC="git check "
abbrev-alias -g GM='git commit -m ""'
abbrev-alias -g GB="git branch "

abbrev-alias -g DI="source /dev/stdin"
