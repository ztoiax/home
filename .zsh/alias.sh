#!/bin/zsh
# Alias bin
alias a="aric2"
alias sudo="sudo "
alias mv="advmv -g"
alias cp="advcp -gr"
alias rm="rm -i"
alias type="type -a"
alias free="free -hw"
alias df="df -Th"
alias c="curl -LO"
alias w="watch -d -n 1"
alias ifconfig="ifconfig -a"
alias clip="xclip -selection c"
alias cat="bat --style=plain --pager 'less -RF'"
alias getclip="xclip -selection c -o"
alias cplast="history | tail -n 1 | cut -c8- | clip"
alias grep="egrep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn}"
alias error="journalctl -fp err"
alias backup-rsync='sudo rsync -aAXv / --exclude={"/dev/*","/proc/*","/sys/*","/tmp/*","/run/*","/mnt/*","/media/*","/lost+found"} /mnt/Z/linux/arch$(date +"%Y-%m-%d")'

# alias restore-rsync='sudo rsync -aAXv --delete --exclude="lost+found" /backup /system'
# alias restore-dd='pigz -dc $(ls $backup | sort -r | head -n 1) | dd of=/dev/nvme0n1p5 bs=64K status=progress'

# external
alias weather="ansiweather -l guangzhou -u metric -s true -f 2"
alias share="python3 -m http.server 8080"
# alias share="sauth admin 12345" # password
alias macchanger="sudo macchanger -r enp27s0"
alias v="nvim"
alias chrome="google-chrome-stable"
alias earth="zh-on;google-earth-pro"
alias e="nautilus"
alias r="ranger"
alias br="broot -sdpw"
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

# instead
alias ,curl='http'
alias ,ping='nping'
alias ,,ping='gping'
alias ,,,ping='prettyping'
alias ,du='ncdu'
alias ,df='dfc'
alias ,find='fd'             # instead find
alias ,man='cheat'
alias ,git='bit'
alias ,diff='icdiff'
alias ,traceroute='paris-traceroute'

alias ,sed='perl -pie'

# cool
alias hack="cmatrix"
alias s="neofetch"

# systemctl
alias sl="systemctl"
alias sls="systemctl status"
alias slr="systemctl restart"
alias sle="systemctl enable"
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

elif which zypper &> /dev/null;then
    alias pi="zypper install"

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
    alias pd='pactree'
    alias pr='sudo pacman -Rns'
    alias plo="sudo pacman-disowned.sh > /tmp/other-soft-file && cat /tmp/other-soft-file"
    alias pf='sudo pacman -F'
    alias pu='sudo pacman -Syyu && yay -Syyu'
    alias pk='sudo pacman-key --refresh-keys'
    # gpg-insertkey
    alias gpg-insertkey='gpg --keyserver pool.sks-keyservers.net --recv-keys '

elif which pkg &> /dev/null;then
    install="pkg"
    check="pkg show"
fi

# Pip
alias ppi='pip3 install'
alias ppr='pip3 uninstall'
alias ppq='pip3 list | grep '
alias ppu="pip3 list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1 | xargs -n1 pip3 install -U "

alias mykill='mykill.py'
alias tmp='tmp.sh'
alias clean='a-c && \
    tmp /home/tz/.cache/netease-cloud-music/CachedSongs/*'

alias mi10='ssh tz@192.168.1.111 -p 9022'
# alias mi10-on='sudo simple-mtpfs --device 1 -o allow_other -o atomic_o_trunc -o big_writes /mnt/android/'
alias mi10-on='sudo go-mtpfs -allow-other /mnt/android &'

alias mi10-off='sudo fusermount -u /mnt/android'

# exa
alias ls='exa'                                                         # ls
alias l='exa -lbgHF --git --icons'                                     # long list,icons
alias ll='exa -lbgHF --git'                                            # long list
alias llm='exa -lbgHF --git --sort=modified'                           # long list, modified date sort
alias la='exa -a --git'
alias lx='exa -lbhHigUmuSa@ --time-style=long-iso --git --color-scale' # all + extended list
alias lS='exa -1'			                                           # one column, just names
alias lt='exa --tree --level=2'                                        # tree
alias lat='exa -a --tree --level=2'                                    # tree hide

# git

alias gc='git clone'
alias gl='git log'
alias gr='git rm'
alias gm='git commit -m '
alias gp='git push'
alias gb='git branch'
alias gs='git status'

# alias grh="git reset --hard $(git log | grep commit | awk 'NR==2{print $2}')"
alias grs="git reset --soft $(git log | grep commit | awk 'NR==2{print $2}')"


# btrfs
alias bfls='sudo btrfs subvolume get-default'
alias bfll='sudo btrfs subvolume list'

alias bfdu='sudo btrfs filesystem du'
alias bfdf='sudo btrfs filesystem df'

alias bfsync='sudo btrfs filesystem sync'
alias bfrsync='sudo btrfs subvolume snapshot'

# 对现有文件进行压缩
alias bfzstd='btrfs filesystem defragment -r -v -czstd'

# nginx
alias ng='sudo nginx'
alias ngr='sudo nginx -s reload'
alias ngq='sudo nginx -s quit'

# kvm
alias vm='virsh -c qemu:///system'
alias vmls='vm list --all'
alias vmgui='virt-manager -c qemu:///system'

# docker
alias dil='docker image ls'
alias dila='docker image ls --all'
alias dip='docker image pull'
alias dir='docker image rm -f'
alias dis='docker search '

alias dc='docker container'
alias dcl='dc ls'
alias dcla='dc ls -a'
alias dcrun='dc run'
alias dcr='dc rm -v'
alias dccp='dc cp'
alias dck='dc kill'
alias dcs='dc stop'

alias dexec='docker exec -it'

# iptables
alias ipt="sudo iptables -nvL"

# fzf
alias tt='fzf --preview '"'"'[[ $(file --mime {}) =~ binary ]] && echo {} is a binary file || (rougify {}  || highlight -O ansi -l {} || coderay {} || cat {}) 2> /dev/null | head -500'"'"

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
abbrev-alias -g G="| grep -i"
abbrev-alias -g A="| ag"
abbrev-alias -g P="| awk '{ print $}'"
abbrev-alias -g SS="| sort | uniq -c | sort -n"
