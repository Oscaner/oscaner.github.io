# System PATH
PATH="${PATH}:/usr/local/bin:/usr/local/sbin:~/bin"

## Openjdk
PATH="/usr/local/opt/openjdk/bin:$PATH"

## PHP
PHP72="/usr/local/opt/php@7.2"
PHP73="/usr/local/opt/php@7.3"

PATH="${PATH}:${PHP72}/bin:${PHP72}/sbin"
PATH="${PATH}:${PHP73}/bin:${PHP73}/sbin"

## Composer packages
PATH="${PATH}:/Users/oscaner/.composer/vendor/bin"

## Unzip
PATH="${PATH}:/usr/local/opt/unzip/bin"

## Boost

export PATH
export PATH="/usr/local/opt/ncurses/bin:$PATH"
export LC_ALL="en_US.UTF-8"

# alias
alias composer="COMPOSER_MEMORY_LIMIT=-1 composer"
alias php="${PHP73}/bin/php"
alias vscode="open -a /Applications/Visual\ Studio\ Code.app"
alias sublime="open -a /Applications/Sublime\ Text.app"
alias md="open -a /Applications/Typora.app"
alias python="python3"

alias cit-proxy="export all_proxy=socks5://192.168.3.106:10808"
alias lt-http-proxy="export all_proxy=https://127.0.0.1:49830"
alias lt-socks-proxy="export all_proxy=socks://127.0.0.1:49829"
alias unproxy="unset all_proxy"

alias p10kup="git -C ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k pull"
alias zshup="omz update"

# youtube-dl folder.
alias youtube-dl-folder-setup="export YOUTUBE_DL_FOLDER=\$(pwd | xargs -I '{}' echo '{}'/%\(playlist_index\)s - %\(title\)s.%\(ext\)s)"

unsetopt nomatch

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# brew install bash-completion.
# [[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"
# completion autoload.
# autoload -Uz compinit && compinit

