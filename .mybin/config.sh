#!/bin/bash
fishconfig() {
echo "正在配置fish"
myalias=\
'alias j "autojump"
alias c "clear"
alias s "screenfetch"
alias r "ranger"
alias vim "nvim"'
myexport=\
'export PATH="~/.mybin:$PATH" '
echo $myalias >> ~/.config/fish/config.fish
echo $export >> ~/.config/fish/config.fish

#autojump
echo "正在安装autojump.fish"
git clone https://github.com/wting/autojump.git
cd autojump
./install.py
echo "source /data/data/com.termux/files/home/.autojump/share/autojump/autojump.fish" >> ~/.config/fish/config.fish
source ~/.config/fish/config.fish
}

nvimconfig(){
    if [ ! -d ~/.config/nvim ]; then
        mkdir ~/.config/nvim
    fi
echo "正在配置neovim"
config=\
'set number                 "显示行号
set ignorecase             "不区分大小写
set list                   "开启空格字符
set path+=**               "find 子目录
set clipboard+=unnamedplus "直接复制剪切板'
    echo $config >> ~/.config/nvim/init.vim
}

case i in $i
    fish* ) fishconfig;;
    nvim* ) nvimconfig;;
esac
