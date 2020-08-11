# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-rust \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node

### End of Zinit's installer chunk

# Plugins
zinit light-mode for \
     wfxr/forgit \
     Aloxaf/fzf-tab \
     zpm-zsh/colors \
     momo-lab/zsh-abbrev-alias \
     xav-b/zsh-extend-history \
     hlissner/zsh-autopair \
     zsh-users/zsh-autosuggestions \
     zdharma/fast-syntax-highlighting \
     zdharma/zui \
     zdharma/zplugin-crasis \
     # rupa/z \

zinit ice blockf
zinit light zsh-users/zsh-completions
# Themes
zinit ice depth=1; zinit light romkatv/powerlevel10k
# zinit ice pick"async.zsh" src"pure.zsh"
# zinit light sindresorhus/pure

# Oh-my-zsh
# Load OMZ library
zinit snippet http://github.com/ohmyzsh/ohmyzsh/raw/master/lib/git.zsh
zinit snippet http://github.com/ohmyzsh/ohmyzsh/raw/master/lib/nvm.zsh
zinit snippet http://github.com/ohmyzsh/ohmyzsh/raw/master/lib/grep.zsh
zinit snippet http://github.com/ohmyzsh/ohmyzsh/raw/master/lib/history.zsh
zinit snippet http://github.com/ohmyzsh/ohmyzsh/raw/master/lib/completion.zsh
zinit snippet http://github.com/ohmyzsh/ohmyzsh/blob/master/lib/clipboard.zsh
zinit snippet http://github.com/ohmyzsh/ohmyzsh/raw/master/lib/termsupport.zsh
zinit snippet OMZL::git.zsh
zinit snippet OMZL::nvm.zsh
zinit snippet OMZL::grep.zsh
zinit snippet OMZL::history.zsh
zinit snippet OMZL::completion.zsh
zinit snippet OMZL::clipboard.zsh
zinit snippet OMZL::termsupport.zsh
# Load OMZ plugin
zinit snippet 'https://github.com/robbyrussell/oh-my-zsh/raw/master/plugins/git/git.plugin.zsh'
zinit snippet 'https://github.com/robbyrussell/oh-my-zsh/raw/master/plugins/fzf/fzf.plugin.zsh'
zinit snippet 'https://github.com/robbyrussell/oh-my-zsh/raw/master/plugins/docker/_docker'
zinit snippet 'https://github.com/robbyrussell/oh-my-zsh/raw/master/plugins/extract/extract.plugin.zsh'
zinit snippet 'https://github.com/robbyrussell/oh-my-zsh/raw/master/plugins/vi-mode/vi-mode.plugin.zsh'
zinit snippet 'https://github.com/robbyrussell/oh-my-zsh/raw/master/plugins/autojump/autojump.plugin.zsh'
zinit snippet 'https://github.com/robbyrussell/oh-my-zsh/raw/master/plugins/history-substring-search/history-substring-search.zsh'
zinit snippet OMZP::plugins/git/git.plugin.zsh
zinit snippet OMZP::plugins/fzf/fzf.plugin.zsh
zinit snippet OMZP::plugins/extract/extract.plugin.zsh
zinit snippet OMZP::plugins/vi-mode/vi-mode.plugin.zsh
zinit snippet OMZP::plugins/autojump/autojump.plugin.zsh
zinit snippet OMZP::plugins/docker/_docker
zinit snippet OMZP::plugins/history-substring-search/history-substring-search.zsh

# source
source /home/tz/.zsh/alias.sh
source /home/tz/.zsh/function.sh
source /home/tz/.zsh/variable.sh
source /home/tz/.zsh/fzf-tab.sh

# nvm
# export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

proxy-on
### End of Zinit's installer chunk

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
