#!/bin/zsh
# Alias bin
alias a="aric2"
alias sudo="sudo "
alias mv="advmv -g"
alias cp="advcp -g"
alias rm="rm -i"
alias type="type -a"
alias free="free -hw"
alias df="df -h"
alias c="curl -LO"
alias w="watch -d -n 2"
alias ifconfig="ifconfig -a"
alias clip="xclip -selection c"
alias getclip="xclip -selection c -o"
alias cplast="history | tail -n 1 | cut -c8- | clip"
alias grep="egrep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn}"

alias backup='sudo rsync -aAXv / --exclude={"/dev/*","/proc/*","/sys/*","/tmp/*","/run/*","/mnt/*","/media/*","/lost+found"} /mnt/Z/arch/arch$(date +"%Y-%m-%d")'
alias restore='sudo rsync -aAXv --delete --exclude="lost+found" /backup /system'

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
alias md="glow"
alias record="asciinema rec" # 终端屏幕录制
alias play="asciinema play"  # 播放录制文件
alias baidu="baidupcs"
alias screen="scrcpy"
alias mysql-tui='mitzasql'   # mysql tui
alias redis-tui='cd ~/redis-tui/ && go run main.go && cd -' #redis tui
alias ssl='siteciphers'

# localjs
alias httpmethod="cd $programs/hoppscotch && npm run dev && xdg-open http://192.168.1.221:3000"

# adb
alias ai="adb shell input keyevent"
alias as="adb shell svc"
alias adbscreen='adb exec-out screencap -p >  ~/$(date +"%Y-%m-%d_%H:%M:%S").png'

# cumstomization
alias ,ping='gping'
alias ,,ping='prettyping'
alias ,du='ncdu'
alias ,df='dfc'
alias ,find='fd'             # instead find
alias ,ls='lsd'              # instead find
alias ,ll='lsd -l'           # instead find
alias ,man='cheat'
alias ,git='bit'

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
if which apt-get &> /dev/null ; then
    #Apt-get
    alias pi="sudo apt-get install"
    alias pr="sudo apt-get remove"
    alias pu='sudo apt-get update && sudo apt-get upgrade'
    alias pc='sudo apt-get autoclean && sudo apt-get clean && sudo apt-get autoremove'
    alias pq="dpkg -l"

elif which yum &> /dev/null;then
    #Yum
    alias pi="yum install"
    alias pr="yum remove"
    alias pu="yum update"
    alias pq="rpm -q"
    alias pf="yum list | grep -i"

elif which pacman &> /dev/null;then
    # https://wiki.archlinux.org/index.php/Pacman_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87)/Tips_and_tricks_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87)

    # del denpends and config
    alias pr='sudo pacman -Rns'
    alias plo="sudo pacman-disowned.sh > /tmp/other-soft-file && cat /tmp/other-soft-file"
    alias pf='sudo pacman -F'
    alias pu='sudo pacman -Syyu && yay -Syyu'
    alias pk='sudo pacman-key --refresh-keys'
    # del zomble denpends
    alias pc='sudo pacman -Sc && sudo pacman -Rns $(pacman -Qdtq) && yay -Sc'
    # gpg-insertkey
    alias gpg-insertkey='gpg --keyserver pool.sks-keyservers.net --recv-keys '

elif which pkg &> /dev/null;then
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
alias tmp='tmp.sh'
alias clean='a-c && \
    tmp /home/tz/.cache/netease-cloud-music/CachedSongs/*'

alias centos7='sudo virsh start centos7; while true;do ssh $centos7 && break;done'
alias mi10='ssh u0_a369@192.168.1.111 -p 8022'
alias mi10-on='sudo simple-mtpfs --device 1 -o allow_other /mnt/android/'
alias mi10-off='sudo fusermount -u /mnt/android'

# exa
alias ls='exa'                                                         # ls
alias l='exa -lbgF --git --icons'                                      # long list,icons
alias ll='exa -lbgF --git'                                             # long list
alias llm='exa -lbgF --git --sort=modified'                            # long list, modified date sort
alias la='exa -a --git'
alias lx='exa -lbhHigUmuSa@ --time-style=long-iso --git --color-scale' # all + extended list
alias lS='exa -1'			                                           # one column, just names
alias lt='exa --tree --level=2'                                        # tree
alias lat='exa -a --tree --level=2'                                    # tree hide

# git
alias lg='lazygit'
alias gc='git clone'
alias ga='git add'
alias gr='git rm'
alias gm='git commit -m '
alias gp='git push'
alias gl='git log'
alias gb='git branch'
alias gs='git status'

# alias grh="git reset --hard $(git log | grep commit | awk 'NR==2{print $2}')"
alias grs="git reset --soft $(git log | grep commit | awk 'NR==2{print $2}')"

# nginx
alias ng='sudo nginx'
alias ngr='sudo nginx -s reload'
alias ngq='sudo nginx -s quit'

# docker
alias dil='sudo docker image ls'
alias dip='sudo docker image pull'
alias dir='sudo docker image rm -f'
alias dis='sudo docker search '

alias dc='sudo docker container'
alias dcl='sudo docker container ls'
alias dcla='sudo docker container ls -a'
alias dcrun='sudo docker container run'
alias dcr='sudo docker container rm'
alias dce='sudo docker exec -it'
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
