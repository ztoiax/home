
# Startup before zinit
# host="socks5://127.0.0.1:10808"
# export ALL_PROXY="$host"

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# 取消alias zi=zinit
unalias zi

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

##### Plugins #####
zinit light-mode for \
     zpm-zsh/colors \
     momo-lab/zsh-abbrev-alias \
     hlissner/zsh-autopair \
     zsh-users/zsh-autosuggestions \
     zdharma-continuum/fast-syntax-highlighting \
     zdharma-continuum/zui \
     zdharma-continuum/zinit-crasis \
     peterhurford/git-it-on.zsh \
     zsh-users/zsh-history-substring-search \
     RobSis/zsh-completion-generator \
     zsh-users/zsh-completions \
     supercrabtree/k \
     MichaelAquilina/zsh-auto-notify
     # dim-an/cod  # 通过--help 生成补全
     # b4b4r07/enhancd \ # enhance cd command

# mcfly：ctrl-r shell历史搜索替换为智能搜索引擎。McFly的建议会通过一个小型神经网络实时排序。 https://github.com/cantino/mcfly
zinit ice lucid wait"0a" from"gh-r" as"program" atload'eval "$(mcfly init zsh)"'
zinit light cantino/mcfly

# 路径~/.local/share/mcfly/history.db

# export MCFLY_DISABLE_MENU=TRUE
# export MCFLY_KEY_SCHEME=vim
export MCFLY_KEY_SCHEME=emacs
export MCFLY_PROMPT="❯"
export MCFLY_FUZZY=2
export MCFLY_RESULTS=50
export MCFLY_RESULTS_SORT=LAST_RUN

# zoxide：z命令 https://github.com/ajeetdsouza/zoxide
zinit light ajeetdsouza/zoxide
eval "$(zoxide init zsh)"

# zsh脚本测试框架。类似于bash之于bats
zinit for \
as'command' \
	atclone'./build.zsh' \
	nocompile \
	pick'zunit' \
	@zdharma-continuum/zunit

##### completion #####
# zinit ice as"completion"
# zinit snippet 'OMZ::plugins/docker/_docker'
# zinit ice as"completion"
# zinit snippet 'OMZ::plugins/docker-compose/_docker-compose'

##### Oh-my-zsh #####
# Load OMZ library
zinit snippet http://github.com/ohmyzsh/ohmyzsh/raw/master/lib/git.zsh
zinit snippet http://github.com/ohmyzsh/ohmyzsh/raw/master/lib/nvm.zsh
zinit snippet http://github.com/ohmyzsh/ohmyzsh/raw/master/lib/grep.zsh
zinit snippet http://github.com/ohmyzsh/ohmyzsh/raw/master/lib/history.zsh
zinit snippet http://github.com/ohmyzsh/ohmyzsh/raw/master/lib/completion.zsh
zinit snippet http://github.com/ohmyzsh/ohmyzsh/blob/master/lib/clipboard.zsh
# zinit snippet http://github.com/ohmyzsh/ohmyzsh/raw/master/lib/termsupport.zsh
zinit snippet OMZL::git.zsh
zinit snippet OMZL::nvm.zsh
zinit snippet OMZL::grep.zsh
zinit snippet OMZL::history.zsh
zinit snippet OMZL::completion.zsh
zinit snippet OMZL::clipboard.zsh
# zinit snippet OMZL::termsupport.zsh

# Load OMZ plugin
# zinit snippet 'https://github.com/robbyrussell/oh-my-zsh/raw/master/plugins/git/git.plugin.zsh'
# zinit snippet 'https://github.com/robbyrussell/oh-my-zsh/raw/master/plugins/fzf/fzf.plugin.zsh'
# zinit snippet 'https://github.com/robbyrussell/oh-my-zsh/raw/master/plugins/extract/extract.plugin.zsh'
# zinit snippet 'https://github.com/robbyrussell/oh-my-zsh/raw/master/plugins/autojump/autojump.plugin.zsh'
# zinit snippet 'https://github.com/robbyrussell/oh-my-zsh/raw/master/plugins/history-substring-search/history-substring-search.zsh'
# zinit snippet 'https://github.com/robbyrussell/oh-my-zsh/raw/master/plugins/vi-mode/vi-mode.plugin.zsh'

zinit snippet OMZP::git/git.plugin.zsh
zinit snippet OMZP::fzf/fzf.plugin.zsh
zinit snippet OMZP::extract/extract.plugin.zsh
# zinit snippet OMZP::autojump/autojump.plugin.zsh
zinit snippet OMZP::history-substring-search/history-substring-search.zsh
# zinit snippet OMZP::vi-mode/vi-mode.plugin.zsh

# nvm
# export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# history
# zinit load ellie/atuin

##### fzf relate ######

# fzf-tab
zinit light Aloxaf/fzf-tab
zinit creinstall Aloxaf/fzf-tab

# fzf-git
zinit light wfxr/forgit

# 取消fzf-cd-widget函数的alt-c按键绑定
bindkey -r '\ec'
### End of Zinit's installer chunk

##### Themes #####
# zinit ice depth=1; zinit light romkatv/powerlevel10k
# zinit ice depth=1; zinit light denysdovhan/spaceship-prompt
eval "$(starship init zsh)"
# zinit ice pick"async.zsh" src"pure.zsh"
# zinit light sindresorhus/pure

##### spaceship ######
# SPACESHIP_PROMPT_ADD_NEWLINE=false

##### powerlevel10k ######

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.

# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.

# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
# typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
# typeset -g POWERLEVEL9K_INSTANT_PROMPT=off

# twf：vim模式的文件树 https://github.com/wvanlint/twf
twf-widget() {
  local selected=$(twf --height=0.5)
  BUFFER="$BUFFER$selected"
  zle reset-prompt
  zle end-of-line
  return $ret
}
zle -N twf-widget
bindkey '^T' twf-widget

##### source #####
source /home/tz/.zsh/alias.sh
source /home/tz/.zsh/function.sh
source /home/tz/.zsh/variable.sh
source /home/tz/.zsh/fzf-tab.sh

##### Startup #####
# share history between all sessions
setopt SHARE_HISTORY
# autocd
# setopt autocd autopushd

clear
# proxy-on
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

autoload -Uz compinit
zstyle ':completion:*' menu select
fpath+=~/.zfunc

if [ -e /home/tz/.nix-profile/etc/profile.d/nix.sh ]; then . /home/tz/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
. "$HOME/.cargo/env"
. "/home/tz/.acme.sh/acme.sh.env"

source /home/tz/.config/broot/launcher/bash/br
