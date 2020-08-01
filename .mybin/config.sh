#!/bin/bash
fishconfig() {
echo "正在配置fish"
myalias=\
'alias j "autojump"\n
alias c "clear"\n
alias s "screenfetch"\n
alias r "ranger"\n
alias vim "nvim"'
myexport=\
'export PATH="~/.mybin:$PATH" '
echo -e $myalias >> ~/.config/fish/config.fish
echo -e $export >> ~/.config/fish/config.fish

#autojump
echo "正在安装autojump.fish"
git clone https://github.com/wting/autojump.git
cd autojump
./install.py
echo "source ~/.autojump/share/autojump/autojump.fish" >> ~/.config/fish/config.fish
source ~/.config/fish/config.fish
}

nvimconfig(){
    if [ ! -d ~/.config/nvim ]; then
        mkdir ~/.config/nvim
    fi
echo "正在配置neovim"
config=\
'syntax on
set number                 "显示行号\n
set ignorecase             "不区分大小写\n
set list                   "开启空格字符\n
set path+=**               "find 子目录\n
set clipboard+=unnamedplus "直接复制剪切板'

    echo -e $config >> ~/.config/nvim/init.vim
}

case $1 in
    fish* ) fishconfig;;
    nvim* ) nvimconfig;;
    * ) echo "$i还有收录";;
esac
